Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC17027DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjEOJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjEOJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:08:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E1E73;
        Mon, 15 May 2023 02:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8R+DXHQxZul+SEQU9kpvXD3ySdEeqffeyWdjNgAS8zcDqQD3rSY/CjNNAdQy//AXuOxcFU8fkBBPZZwoJS0dNHtRRzBpdK+j3GStHdK6CYFJpqe4po3FLMBcswoYh2LuotOiCoPmfKf3r71BjKzoI9112Ma8AWcPbqs2RhpHCx05Nu1rLYKATJNZ1f7w1jCLR56jFsdroiQujGefrFcpix+GotOphOKRtmcUmJAbpApd1pN0kmrpfN0SiNJbgtX0P8gapybtvR6hQUjOCEbmXieMmaFgHfVqJtv1IE+lv6x3cK4xsRTlUIW7W6Jj6NXiHsn+xhXFtvjUm89pZpd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO9tMqtplzMNnIFF+6zGJbxL0qNYD7CM7Hu6rB5KBRU=;
 b=CmGKG/LAXRNr9csy0dkhFVGPiBwoGJpFY0vYLYNG06S8wsnzbeC7hBmEMuCeNvLPKHZ+E89jc/mZ/Lwu5tHO1RrTLbDBD4teJVtvIeZtZmukmQx5OQZSvOKlegv8guMU1rE8VCqIHCrMGeutukK8UibOBR4xBlDaBUapXQlYQQ7ySK5vm9NSB1vyU9KphISreoG/jTb9faT4PUUNcjvE6VwWw3teAIhwoQSJ3slfwj1YcjY4j6GXK1LAqZJSSdIKofrh0tD9Thla3wZGypRNymEg1fuj3EL5zAlfQkNVqjcI2Nxya5obLDQLf1nU3AC9EiOeyaxrRM5FBERkUWVucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO9tMqtplzMNnIFF+6zGJbxL0qNYD7CM7Hu6rB5KBRU=;
 b=T1/hOK7BoHvDKYVboFqs9b2G7f7c0opC70DJ0XwhwaaqwqBJ8WEUZ5gkGdrHg1HJw4TzObXkKNAjwrno3zl3NCmetmCbKbwYRIOnI4InPxtifxFernK+dsQxuVEbKl4X4QaJ/DcRJMOd5elNc9kPF7EjjVeSiOq15G+XJzpLqVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9599.eurprd08.prod.outlook.com (2603:10a6:20b:619::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 09:08:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 09:08:12 +0000
Message-ID: <6b8f6ac4-00b7-9fdb-126b-0874ac555afa@wolfvision.net>
Date:   Mon, 15 May 2023 11:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
 <202305140640.VLcvhR5G-lkp@intel.com>
 <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
 <40f4e8a3-bac7-f64f-161d-f863103f3aec@kernel.org>
 <e458d47e-e0da-c6a4-f91a-c44b3a66531b@wolfvision.net>
 <e1b34042-9de3-92cb-c04d-ba19e3e87f0f@kernel.org>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <e1b34042-9de3-92cb-c04d-ba19e3e87f0f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0901CA0100.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: a4daa038-3323-458a-49f0-08db5523e8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNstsUW3PVPGlVWgsbu/rDDDxoqLqrzCK5PXNj7gIzrX2RRliDGlHIZjtn4iCuY5UfrVtW20Bxtx0JqTkbGjicScg/N0pCgqXwZ/0iGPkWQgaYFrWn1bIxUaojp1CODafHF/2F6/CkNb44m2RbYhOPka6+kisI+xqeG9FX83g+AYHBogO4U3syawOfIIxgeVBn40xekthbQcFFhhhmWt8jWVxVC1p5pHyRnEzlQScLmYEhjLig3gxJ8yRgKyo/cbm0lWNQstOqloBylqKVbL2piNf7RJTD3j2Qp/NY0zVik5MCU44UTtIvu+tBTSRvqSE7NQOF/xVy+adpc1umXElt7qcIztVAwqNKut7R91NJ+NRm45B9jCLHq/zoLbUsegupCGZ7UbW1t0o5AzQEXgG3P72BmIyeSOdpz1tM+pARaWVXRhc6OPwe3C/Td/C2rqq/LbfTQKT/3pMUjS+1s2N1rq2CGW7EXkEBqyewVa217MZ6pXXcIB+6zoD9OCGcv8Fe44rw8CnPhMXrh19iU34qNZeSjwXc6yUnF0BTO6fmSt8YLpVVqfn40DQGVLItFB/UcAXPmAZzv5EYHlohGkVBgKFfCOzAzIAzw6DBNGIi2x4Z0Vu4EKIvrDBV0ui1u7J6nzw7EpaVBsxoKfmIheOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(346002)(366004)(376002)(396003)(451199021)(36756003)(86362001)(110136005)(316002)(66556008)(66946007)(6636002)(66476007)(4326008)(6486002)(478600001)(8936002)(8676002)(5660300002)(2906002)(44832011)(38100700002)(31696002)(41300700001)(6512007)(2616005)(26005)(186003)(53546011)(6506007)(83380400001)(66899021)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVQyMFVqeE9PRWJOUDB6N2dWWEFYWW5pcmVEK0ZFdThOcXhPYWgySTA4WXdy?=
 =?utf-8?B?dncrbWFHN1l4dVUreUtJUU5tS3JRQlUwSnhRM3RVcHpER29lV0o3UmxHSEdl?=
 =?utf-8?B?YjJEdjFzMkNDOGlTWWUzTDNMVVFUT0xJamNseWRmeUlOWVo1d0szaC9ieDlK?=
 =?utf-8?B?VERLTGNXNWk3dkszRjYxMkQ2QWFrTmZRL0NyVTZuK05ZTlBDeTBrY3ZOQ1lL?=
 =?utf-8?B?VFhLd25wWXJ6Q3UrM1diS0EzU0g0TXVJaldLTHc0NU1uMzNzT2JqNXpxVFlU?=
 =?utf-8?B?RVNiN2JaOXVKa3VoK0gwa3AzWG9xRndOVHJiRVIrb2Y2TnRCU1B3a1hJOWZ6?=
 =?utf-8?B?QU84SE5ic3BzK0JDZDM3eFkxeTd6MnFaOGw3YzBwVURWWGNrQkVMeUw1VWtt?=
 =?utf-8?B?b1N0U09kQ05VbWt4dS80Z3FHOGxSTjRydlVGZ2FBT1YrRTdBSFJ2bncyMndL?=
 =?utf-8?B?aDhIQlZDRU9UZW1JQ0VXdjJtakdTamIyL0hvVHVCODhOMFJIbUUwb0JPcVcz?=
 =?utf-8?B?SWN3dTJiMzRwWGF3WEVxcWRhUXllSmNVQjNlaWhQTEZMelQyelU1RXpCTHZZ?=
 =?utf-8?B?MkwvWmp3cXJXSFlJWWVCTnllME1MZWtMUlVSZEtRMEhraWlCQ1BhczdNREQ0?=
 =?utf-8?B?RHhaQWJ5QUx0T0Z1WE5HcG16WUZnYm5mUzBtTmxncE51alNyT3BvZmtVa29Y?=
 =?utf-8?B?T3BLKzFLcFhpSFFqYm1BaEZvVU1ZK3l6ZFJUSHM3MHhkendIeE5RTjZkOGJY?=
 =?utf-8?B?WUVRM1NaK0FBRzI4aUIzc2FDeEkvVU5EQmxtNFlIc1gxT0V0Y1VFMjZWeldQ?=
 =?utf-8?B?aUpGZU1CcjNRMU1OMnVYUE11TVNySkNISlU3cDRueEc2d2tJQ0VXcVA3aVV6?=
 =?utf-8?B?bElyU3F6Y3RhSDhwelNqcUlib0s3WlAxUHV0NnQ1VXpENVY0Snk5TExTZ1VW?=
 =?utf-8?B?YmUxa2dEa240QTZreDl4M2hhYXBUVVBQZXZSRkJ3NTExRWlPWlR1bmxtVjV3?=
 =?utf-8?B?eGhGdE9kL1VvVzZYZldpVDJESWNMZFUxRjh2TVZYV2pwRXM2dWk0VkNSQVdJ?=
 =?utf-8?B?bThKcVg2T2gzMVRkUzJuTkhBU3ZsVHA0YUtaS0xjdlovL1MyM0xKNTdYeDFo?=
 =?utf-8?B?MzlBRGduVzlORkdpVFIrcS9sV2dMdlBKNVRhc1BRN3dRZXJKOWtVb09jS3Iy?=
 =?utf-8?B?Rzl6TldDSkNONUM0ZVJINDlmelhnNk5MSXZsSGplSkwxRnhFU0J4cCsyMFR6?=
 =?utf-8?B?UEdXcldJdkFKMmZ0anl4NVpMbGYrb3JFNk5DU0xHZHhKR3dXbmRTYkZ3dXdQ?=
 =?utf-8?B?SHpjTUhDYmNYa2crTFp1a3JnRUNUbzZXNTVzVmVGakc2SUQxdHlqSGJ6elhr?=
 =?utf-8?B?WVAvVzRBNk93NDFDMnZFUkQ2SUdaS0piUEpYUGcxbC9KZU5HOUhpejRUdi9u?=
 =?utf-8?B?YzNxZitUWmtPUHBNM0dlTkcxUUhlK210Ni9ubVhGL2JOL2RHYTB0TUl6Yksy?=
 =?utf-8?B?VzV4Z250SFR3RnJDRjdoMWtSVzQ1Y3VHYnUzTm9qaU0wbEJxcEt2aW5zZldB?=
 =?utf-8?B?WmVuaU9nandNZnBUeE5HR1pLZ1RtNGFqTStuQXB2clU0QldTVFh4Vy9aVXAz?=
 =?utf-8?B?T09nZ1JLdHNGUmoxRWRVdWN1UGZWRkMzeHdYVitxYk96d3ZzbTRFc1hqaFVj?=
 =?utf-8?B?dE5IQ3lPMlJKL2NteWJOcml6bTRGMVFXRWROdFhEN09NMnRYbjZDZ3BDOTJ0?=
 =?utf-8?B?K1J5VUxCc2VEZUVESEVNcG1zQVlXVzNEL0xOa1UzaVRiejVyUlZIWGlQRkpo?=
 =?utf-8?B?ckxGSVdsa1JoRFVMSDRaWGE1MmZwMmFJZUc3YlJjU01IMGhNR1JVZlU3SS9M?=
 =?utf-8?B?ZUYrYi9uRnFPWGJzd29ucksrOGxxejZ4L1JOeTNSVzJrbzUzQmpxRkZnSWdP?=
 =?utf-8?B?RktrK3A1SzF2NkpJeFB6cDFPRG0vMm1hUzlkR21JOUI5MFcwR0gvNFN3em1C?=
 =?utf-8?B?S0J0VzcxdWJoQlg2Ulpqb2JQTm5Udm11K2FVVE16RW5FaEFQbkVzczJBaUcy?=
 =?utf-8?B?Y0VGM2RHc2hab0plNFlldzJCem0wR0thcG9ib1dCaEFFY3VLbEJ5emhhKzJQ?=
 =?utf-8?B?RzlEU1VIRys1Wkg1d3BEZHJzdlMzNDR1S3B4T1dFUFhsbmcyRWlmYlZrZGs2?=
 =?utf-8?Q?MztG2KICS99jpTGWpylJ+fk=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a4daa038-3323-458a-49f0-08db5523e8fd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 09:08:12.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bjWGT4p3OWkBpjiR//xHwp6ThAItItm65I86egcPVv2Z484BTC3iUkc65YkoHxnZSr/+jXMY+Lk6dEUhRwrCLvNSm/jMTE0lLYZtb2tdnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9599
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.23 10:41, Krzysztof Kozlowski wrote:
> On 15/05/2023 10:33, Javier Carrasco wrote:
>>>> All these functions are declared in the linux/input/ts-virtobj.h header
>>>> and also inline-defined there if ts-virtobj is not selected. If it is
>>>> selected (either y or M), the functions are exported from
>>>> driver/input/touchscreen/ts-virtobj.c. According to the error report,
>>>> ts-virtobj was selected as a module.
>>>>
>>>> I could build the kernel with the three possible configurations
>>>> (ts-virtobj y/n/M) for x86_64 as well as for arm64 with no errors or
>>>> warnings repeatedly, so I am a bit confused now. I am probably
>>>> missing something, but I do not know what.
>>>>
>>>> I wonder if the new file where the functions are defined (ts-virtobj.c)
>>>> could not be found by some reason or if the test build does not like the
>>>> way I handled the function declaration/definition. Any hint or advice
>>>> would be more than welcome.
>>>
>>> The report is correct. Build driver builtin and your virtual as module.
>>
>> You are right, that was the configuration I was missing, which I
>> honestly did not even consider when I tested this feature.
>>
>> The problem seems to be that I am using the IS_ENABLED macro which
>> returns true if selected as a module, but the define is in that case
>> CONFIG_TOUCHSCREEN_TS_VIRTOBJ_MODULE instead of
>> CONFIG_TOUCHSCREEN_TS_VIRTOBJ. As I am using the latter define in the
>> Makefile, it does not get compiled.
> 
> This could be proper solution for build failure but does not look like
> the proper solution for entire choice/design. The questions are: why
> TOUCHSCREEN_TS_VIRTOBJ should be selectable by user? How can user know
> that he needs a driver with VIRTOBJ?
> 
> I think he cannot and your config help option suggests that:
> "you are using a touchscreen driver that supports printed overlays".
> What driver supports or not, is a job for kernel developers. Not for
> kernel configurators or distros. User should never investigate whether
> his touchscreen driver support printed overlays. Why would user like to
> dig into kernel to know that? Thus either your driver should select
> VIRTOBJ or depend on it.
> 
I was thinking about the minimal savings (inline functions that just
return a value and the size of the ts-virtobj object itself) that could
be obtained if the touchscreen does not need the functionality at all.
But probably those savings are negligible and there will not be many
cases where the user will know if that applies.

I agree, the feature will be selected by drivers that support it. That
actually simplifies the code a little bit.

> Best regards,
> Krzysztof
> 
