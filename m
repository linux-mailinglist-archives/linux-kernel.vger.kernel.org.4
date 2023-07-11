Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ECB74EFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjGKNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGKNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:05:59 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918298;
        Tue, 11 Jul 2023 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689080757;
  x=1720616757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BVwKb4iqeUDCRhQCHyhOPXG3EtTCrFnNB28/XFBbOjg=;
  b=PabK0+doNFEkb0n9X8PiYhLSlGt9P6Ix7KNCGk8KBxTZA+8JDrLA5+8d
   hWCJNVsTPD+eiqakW9fMr1vYd781tgyWY9A4yzvFquesPMa9GD3MPonuB
   73ZVYCrVw64BKE1oBUuBrSbKHcwyojKGQAy96doSkW5bU3IOkgM50ADSX
   UZ1Q18ZAHYlGDXE2gHvChYoAgafvLNGcDveUyahLb8T4PspEsG4nBZtiR
   063PqE/lQvf/cRBCS13Jd9NCcXXiAHNHz/XxH9nH8P4amLMGiv2hhKub/
   Y+NZ14R2R9f0kKrjuBxyPNGDRhiLcHLLIvW0gWOGA+pVHo38X86BmJQr3
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRZycfcF/xyipn3Gt/0PhGqSaXYjebgeKQlFUidE6pFxt5e1M4phgBbNw1F3pivimmPrkdzIJ8vPZ688pAyAXkC0mK+5GR5/RdEP1erlWNTDChaJ5D1MJC0jK5puhN0XS+tAIKERB+KprHuDnvhPUDjtmNknwC+7+Zbsdv7CxMuY4Xbbet951I4vJlZGeTdrRJKef1xUPKAO5kKJs/TNp5W2yOzwHVEQ1ZpBEL6GnOoG9Q3f32A/eb4fKEGUeIR+9lj7grjYFR7pndEz4syr2mPSEKMrIIe6Y3tTFB0CL2Zc1+82HcFvXnocqdTskKJu4SAI+OjLdMofaEW0vLs28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVwKb4iqeUDCRhQCHyhOPXG3EtTCrFnNB28/XFBbOjg=;
 b=OPGFMda+CLbtBDbiGem3wO95GDSVQVVl10Ur6CWuNdm1IRgL+KnQiG5yT7b+nOaK3VOEMCFuz6CIQNqSVqvLNsg3DMY86Cuj5zHlTr+1X6iSjcs6YXS36j5lUlVfMcwrBGhCuv5xDRybF7pDIqfzgwo5E4lOeRXjOhvO3Lwt6K8JbPGDG3zP3HpU12oTN18AleHg5hVMU9WcVsNHOqLhpeSVgu/NwTOzM4Tjz9hKGAq/uokTMrkpsW5BV1noi+w0Egk9+DkyBHqD2JKbSQeVDxNuR9I4nUt6T7BVgCyS9oS+Hobv1o8uy3eto87rH/7BQhPC/eDX93ZtR5LiTSNa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVwKb4iqeUDCRhQCHyhOPXG3EtTCrFnNB28/XFBbOjg=;
 b=YPPnrNk4GMbc/RA2m6o9maN7GgvgrHz8LKWjoMSGvFSI6Spn0riLRXOwsEsoafdDtm6Gk1c8ZrtImEfPgom6Uc5qpO4iLbimvtYt09zdFSaYtoFUoY67fI/eEbLBg2kGdiUrwX4tBifjDmsQzdW/YL0STm7HK3zb0c1IY0Fpr4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <3b085b09-bff9-7b71-6984-3dfd27a235a6@axis.com>
Date:   Tue, 11 Jul 2023 15:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] Input: cap11xx - add advanced sensitivity settings
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
References: <20230627065316.1065911-1-jiriv@axis.com>
 <20230627065316.1065911-3-jiriv@axis.com> <ZJyEpuat1A8Z+Ft4@google.com>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <ZJyEpuat1A8Z+Ft4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|PAWPR02MB10165:EE_
X-MS-Office365-Filtering-Correlation-Id: 366858dc-d03f-46aa-f554-08db820f8e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayRKYm9+qSCkosWwnuhDJ9PR1n1KFK5CzdCogLpczIWw+JDbrH8te48XezXl024u+E7Af3vMbMNm0fr9Cs29V51NXpiVZjWRiXwMHjLPL6r1SGfmYFhSiBUvFSxAv6yqFuS/eaBzbshVcoM5O9DS/WTtw7qNv2aYP3Z/0g0HM2sK3Ep2uF5zZ0HV0nno/5NbaJ5vGFHgVeex8HWQy2bXRxHJIGTgHdt4eJRz7X2QjNHT6bA8NaLffC1StGcIv039eM8tTlew36njKkqu4umzlqOxd7vNP0eR53+g7H7Fh+OGeWrszSVWdGpAQD5Tv6lrmZQY5RCz8cOIrI12XHNj9y0MLOwNGESk2K+X4B3/xebWI7EhcJaTu5Xliuw063BNqhgsroqnC2YoyIFjbpCdRXbshv7bAeZtJXmXoui6pDEKUXASvXZmwc0OPGBirIQNxu30dqfX7fNgJrDq6taOjS908tli3FL6QChQeTQWfJtgOTq+HG0TMaTXoCFsmTke1y55UMjhwW0yMhqpaYGcyCHGhI4ZEDSoZHirwyEtUBkEnQD7S67hSIOkkoqWqLPNYaGAGvosJ+qUHJTzM403/idOsJCLJl7+qOscOxQqvZov7j7OlE8WckaDNOpIolVYfHlfQ/ypZPK/ka5SuJ2o5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(8936002)(31686004)(5660300002)(8676002)(38100700002)(83170400001)(41300700001)(2906002)(316002)(4326008)(66946007)(6916009)(66556008)(66476007)(31696002)(6506007)(83380400001)(478600001)(2616005)(42882007)(53546011)(186003)(6486002)(6512007)(36756003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdkM0dOR3JrN0hIRUxDd1hUQjNIMWRGWGdzMHlhbU9sak9ZK254WHViMWNY?=
 =?utf-8?B?a1BUa3c4MlRkZlk0S2ZSRHI5MElnc0JmK3FLSkxyVWgrWW53TCs2Skh4MkdH?=
 =?utf-8?B?aW9xUUY0VW9ZU2RTRnI1bjF1dE1PRHpoOVR2bU80RVFNVkJNTVByUGZDK21r?=
 =?utf-8?B?K2d0YVdHU0NhOENRbWRZR0JmZWh5MThJaXFUbWJxeVJLUlkvcm4zaDZmN21H?=
 =?utf-8?B?L3BpNHdia3pyOCtKMFNrdUhCNksxWS84ZjRmSlhMQjBWd3ZXK0NNSDFodTdw?=
 =?utf-8?B?VjhSVVBUMWdUcVk3RjR0SnFZcEdnQWVJVitJZjRsMjVIMHpLampzUDFBSHNT?=
 =?utf-8?B?cFgwMlZCUnpoV3htTFJUSWhLQ2U1a2dWMlIzWlNpMGJNVUJEZlZaWGs4cHR5?=
 =?utf-8?B?QkpXVVVPck55NnlUbVorYWJWQ21pQVc3UVd0NTVhcjhhZ1VMRStlOUJnQ1BF?=
 =?utf-8?B?NjlkZ1J1bC8wQ1ZzRHFZem5WQmZjaTBBVFk3bjQvdm1EWXlIWVdZbzJEVHJp?=
 =?utf-8?B?TGNCZkNQcGtPcThKR2hvbjRTOGlhSjVjSHFLYVBraTY2eXNSOTgrVitJNXpk?=
 =?utf-8?B?ckxKUFNmM1ZlaWZKUEFPakR5bHhNUm5RWEEzVGwxWVJoeURwdEJCZEg1OWVs?=
 =?utf-8?B?dWQxN2IxTVNBVXgxanpYVnJZNGpwcXpoYUl0OFA4MHFXTFNZa2dXa1lIOXFH?=
 =?utf-8?B?ODF4cUVKRVZ5alpmbjRzWW5zUG1jU1E4NWw4MHhaNDgza3QvNWFOSG1mU1lU?=
 =?utf-8?B?bG10MDRsUHl3QU5KT3pDK1pPZ3FNbm1DMTRzSnJ6K2RqbU5yd04zU1dRWGl4?=
 =?utf-8?B?NHRaVnk3U1NOSy9ueXNIZ1laSjZoOEtLZmFWcHpHQ3g4Q2NJTGFKV01RWlFW?=
 =?utf-8?B?N0NSc1d5SUwzVDNkZGpOYmVjcFJIbDFUZm5vekthSFZFSGpjbzZKMTlmM2Ji?=
 =?utf-8?B?UzczbXVLUUxqSHVsNWIvL1V2ZGVJSzdGSU9jRzFDcFllWGJlQkNpV0VYMkF5?=
 =?utf-8?B?enVBSENVR3VOeEZlR0dmUmdPUnJHMlg1NTBkODNYVlNBRlh6TkU0Mm5EaSt5?=
 =?utf-8?B?cGNIK0VtVWdDT1lZU25LZ1R0TWV0ejVKa3Iyc2hXNlVWYUNhZVl0QXc3NHkz?=
 =?utf-8?B?bzFIVytqTmtNTlAxRnI4NmFjY2syZ09KYW9mS2RmdzJCRWxLRzVabTdzcmtC?=
 =?utf-8?B?aGtkY3NncUVIYjNkL1crN25QVFJ3WlloZXkyMFVJZU5CWHZvR2l5NVQ3MWty?=
 =?utf-8?B?RnlHRW1laHREK0FvK0xwcC85OCswYzIwTCtob0g4ZERNL1RaaDdJcFNwaGQ5?=
 =?utf-8?B?U3VKdFI2WW96aFVZRVZqVVZWTzBJczg5d2h4OS9DcURNUFI4THlUdHhrR0Iz?=
 =?utf-8?B?NHIrblAvTnVqek9vN0tvVU5TcnYzcTdRQnQxcG1tZlpWSlpZR3YveVlxRGVj?=
 =?utf-8?B?VWluYzFwcWRlVnJEbzVmOEN2SThSSE9NUUhzVlZodXQ3WExBalByenZBUFdr?=
 =?utf-8?B?SUs4d2ltZVZrdThzZHFGUW1iSlMrR0JJa1hMV1lGL3B6SGhmS3N0bTdTLzVP?=
 =?utf-8?B?MDVGb09WSjZGanQ4QmtGUmFpZXhZdFBhRnMweWZ4ZkxMSnVzZ3did09zQjRx?=
 =?utf-8?B?R0wvUFRpREFFMkVBbXd4K2lGQ2tJYnppTmluSzhmR2xsQk8raTNadlFoNnpz?=
 =?utf-8?B?dmYwRzNWdTFEU2xyM0c3NHUwZmVmZW9yd2cxVHNEUGd3OXV0ZlQ1MVJxbFhL?=
 =?utf-8?B?NXI0REgwT1pkOWxRalNnVDRGc2hVMnlYUHZLN2MvTHZLNGE4T0Vhc2NiYStR?=
 =?utf-8?B?cm8rVzcyNHEyME0zTTcya2dLZnVOTnRHNEZHWHlEUWFhT1dwMi90MFAwUkVE?=
 =?utf-8?B?b2hWOEtWVVFMdXBpQk8zWlk4S1pxOFBCRUFjSzNKZ3NUM3JOWjY5bHlZdFBF?=
 =?utf-8?B?QkZBT2tnRUxsRFkvMkxwK3h0QTRWbWlCeGpHeWtBMlV5QXVGdHY2M1NFTC90?=
 =?utf-8?B?V3dUL2U5RXJtU3ZTK3FzVTNLYm0rdlBiZW1rbC9Bbng1bWNUSHhhWjRzaGt6?=
 =?utf-8?B?ZjhRNEFxV2RiS0pHRzlNL2lDVmZzblpCelhWdktUcVZMNzhBYVFKY1h5QlZV?=
 =?utf-8?Q?K5Rp/tAf4W4japsKXTkNOhaDu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 366858dc-d03f-46aa-f554-08db820f8e77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:05:53.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD8YNCP01XG1onPZPEytCbJR+j2ZSFmbEkGnCGWSNjjOGJWOy7tVAIR7WvjNRWUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 21:06, Dmitry Torokhov wrote:
> Hi Jiri,
> 
> On Tue, Jun 27, 2023 at 08:53:16AM +0200, Jiri Valek - 2N wrote:
>> @@ -439,7 +589,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>>  	priv->idev->id.bustype = BUS_I2C;
>>  	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
>>  
>> -	if (of_property_read_bool(node, "autorepeat"))
>> +	if (of_property_read_bool(dev->of_node, "autorepeat"))
> 
> It would be good to have this driver switched from of_property_*() to
> device_property_() API.

Yes, I do this after my changes.
> 
>>  		__set_bit(EV_REP, priv->idev->evbit);
>>  
>>  	for (i = 0; i < cap->num_channels; i++)
>> @@ -474,14 +624,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>>  	if (error)
>>  		return error;
>>  
>> -	irq = irq_of_parse_and_map(node, 0);
>> -	if (!irq) {
>> -		dev_err(dev, "Unable to parse or map IRQ\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
>> -					  IRQF_ONESHOT, dev_name(dev), priv);
>> +	error = devm_request_threaded_irq(dev, i2c_client->irq, NULL,
>> +					cap11xx_thread_func, IRQF_ONESHOT, dev_name(dev), priv);
> 
> I would prefer this change be a separate patch.

Agree, I will prepare separate patch

> 
> Thanks.
> 

BR
Jiri
