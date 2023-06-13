Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5072E43B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbjFMNft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjFMNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:35:46 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEBE5;
        Tue, 13 Jun 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686663344;
  x=1718199344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9X1LVPKSkMPZErlcbEMfy+2TuN44oV6pjzZe524RYJ4=;
  b=Hb2d3stU48lYY58hcgrsN0RCaNyCWJeDqMaqkm0K/x2+mEprMV7Vv0gG
   c9bxmQMYTtEEtglqHWl+jxHtISSAAnIo5RdYyZ4NOEBLRFKgi+yLJmMC1
   MKJZVkNkBEQz3mkqUnXaJnv3kQod4q/xSVlaTIWd8DRVCgHl0+fIZw67u
   Xn3kMcNq1YDXUn5oLfW+MBE9ntk1rFPXSMlxwwO7QQ3TCpx8N5CB7nTNO
   w4OXLWwGI+iP2q4IFgpe8XnPwkhYiifyXnPvVHmrtUoT+4E//JPM/lXmA
   Y7WaB/H/NilNT/7v34YV/afqaegLzMOmq38auFIevMASt5qEXv/QX9wQp
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buk7TJmMgFjVbKc5Dk02YWPhorP0hf9o0AtP3x8o9e3unENWwjAwji15iuHDR0f6thMW9wpqS7g1WbQUJ5OEctnkYLEQxV/7D5cSLEK7YlbnsB7Kkhw1lUawiGf5f6wvIg51mB3n0oQWOQqpTLkhqVxDKZ3nzGVCQUgWXtpdgzx4PXXrUYbnGn0me8576wgOpvXgeOA2ePDIj77apIpGLcpWp4DwJbtrVgUEhrDyw2M285MX/cOZp5U0Qqrvjm9rL+CxTSZ+RtzTeGZztKlKoo+H9UgLIA1jaUR5NuijKtvpkUYfeti+pC/PJzNhyT5kYtGJovyh05ENsF6OkoPmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X1LVPKSkMPZErlcbEMfy+2TuN44oV6pjzZe524RYJ4=;
 b=bxO2Fh2uT2ilWbKXWA4FW+Gh9VYnwbod0VZPu/HAMZC8UTmJIvjlehXAKGnKRo3lbogyjzWoBDdU3nHAj8rPfDheU7qCZWDFPGQQeECGvnyrVONUKRwgiDfRNc34hlrJAfDPQa+XFITb5bK3tHVSdBqUS+TYr9Fhbq+R8l99eFuRip5z53qLyqzOZiBiPh90NCmR+zuggalq52dkR2T2pA6vs4hdK65pCZQmbOMikgRS79uapf6IHwnl6UTZINHPQJkNh6iw/eLTqZf5cJ8ZpZGWUs01fLAwyDCp7tQNafu9+QMyKWeOYzrHlc3f0d7SWq9Iiv6JqEm8MM7DZeVZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X1LVPKSkMPZErlcbEMfy+2TuN44oV6pjzZe524RYJ4=;
 b=Rg2HxKDkTaphTAddP2d1EhYvWbAPOBQyIrbr/u40quUnAA11a3O6oYlKUEyajvW6JfAIQ7Wd60hMlIuoMZ8Z8AiZQQOtTvWs82jC9pY97wyEeEqx8B0Wmfbk7+D8QFErzDaGhCofjyZ/ujag+qifxwkc5qvu6ht7Tqnq71iyGyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <99582640-7486-7771-9fd0-c417e283051e@axis.com>
Date:   Tue, 13 Jun 2023 15:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] Input: cap11xx - add advanced sensitivity settings
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
References: <20230414233815.4004526-1-jiriv@axis.com>
 <20230414233815.4004526-3-jiriv@axis.com> <ZF2A/STY66sqoOLX@google.com>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <ZF2A/STY66sqoOLX@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0043.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::32) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|AM7PR02MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: daba78ea-c6c3-44a2-520b-08db6c13147e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccLaw5PN9OsNgMfQQQamWyr7nS2+Tyl/eZJgmhNQBUmq82IhraQc6GtCAjPxeYrzlS1OPaLLBNoQmBo+xKslvlf4wOr3kB6bFbp2B8d2jtdLUdFkSouh5gr18ljc50PBFXHXyLGmLgkxZQhSg2doJ/89ra0uIZK4QaLk++E5jI5oeSdZQMnI9Qjc6JGoA9uoYBv4piw51BdGJGFOmQE4M84U9R3N8cEua/ltICVUE5EbNo6EicXNPSuHXLrUYEwWukxSD2JSWcn/U/UMrVtq5tjIs8fqI7MsmEoP8r41ZV+SJNBtEliPWrrKbN4GE1d5eF+f6XG6xuof5AbwuVif9w5qzYKOPGMEUu72HUZKGBSe7EILxDKdrcYCEYWHVImYUOAUKe/D0fodYRv56gVlsgyVy7LkaR9WLSu0m2bDhlcZmE8sKfTPcBzZM1u1L9ZTOfocv/FavLPNbgorMYxHcucu/i5siU4f3QKLtXqECrv/cJdZgXRl0seB4zvOOc3G0QyEBgVSBJEqikk8ZdiEy3VY+ybiE90L3CHEpgGOykP7FQUqawZ5mldf75LMEsLFaotrmHqE1NYKi58YBmEWpeerI5WEKhH9iEOpgGwazWDGuXfB9IV8ceJJP1e2K9O7xpJeNPRMlFrTuswS8Y4Zumsklj9qADK258GToUGQZtNs0m1yzMNW4JR1whYyipKpJHkHBtYemJf9cEYjUryXtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(451199021)(66476007)(66556008)(2906002)(6916009)(38100700002)(36756003)(41300700001)(4326008)(66946007)(4744005)(5660300002)(31696002)(316002)(8676002)(8936002)(6486002)(83170400001)(26005)(6512007)(53546011)(6506007)(186003)(478600001)(83380400001)(2616005)(42882007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVKdlBMT1d2d3UxYlhmKzBKemxxOWtBY0RUZFdwUlBMWkRUcStuM09Cekh3?=
 =?utf-8?B?cXpqVUhqalpkT0p0d0JtMTFNOTJQczJBc205d291VDJMZUNpVHhXdlk2bGZG?=
 =?utf-8?B?Ly9zNnRPRnlyQXhvSnloRG5zU0lzTytub0w1T2h5VVZ5dXZkVWVhUlZkSE4z?=
 =?utf-8?B?ZnR5ZjcxNytpNjIyem0wcHJxQTlYNUdMMDRxQlJ5SW1XNU1OQm5udG1uL0pQ?=
 =?utf-8?B?ZDE2QTVFU3BmbHdIZjNXK1dkT05UanhuSVRJU2dIUCttRGNoSGVVdUtycWhp?=
 =?utf-8?B?UkVPTUkvUGIwQi9oai8zbUhXSG5mT210bEJLdTJpb3hVV05MVVRVVEQ3V2Ju?=
 =?utf-8?B?a1ZWS1ZFTGQvS3doaWM1RTYyTjFJbXpGNVRsTlk5N2pxMUlhaTlLQUNWVVFW?=
 =?utf-8?B?REVMcnpTWFpMSG5jOHV3bG1ST1lZT3BmRnFiVW5yVjAwLy9VVWlXMnFFWVN6?=
 =?utf-8?B?VUV0WHhIbXpCU1V1ellIejdHYnhQWXdUdGdZb0xtd3hLc2tQRnZIcnhpUDln?=
 =?utf-8?B?ZnpITFJCVjlnY1FaRWYvaCs1WUt1Yk5WNnE1ZDUrejRhcmFvTU1GbkJpczJI?=
 =?utf-8?B?MUk0U2Y4Q1dORndzNkx4ZkdDU3h6QmQxWTd0UUpoMHdwYkRNRGhUWFRNWHQ5?=
 =?utf-8?B?YTFOcStWaW9xMm9VUDhlNVV4bXRNcFpBcmFIamJMYVhhVHBIVEZGenF4YVdw?=
 =?utf-8?B?Vzd2bktzanhibyt3WTBHVXJhOGwrSndYSmVKQVdCbzlQNWI2UUY4UG9JbTVF?=
 =?utf-8?B?ZkM5c0JKNnRYaExiazN2MDRYc0g2WlpWaEtKZlVEdXVjSVJ3Yy9Sa1FxV0tV?=
 =?utf-8?B?d000MEl4cW8wTytLc2JlOGNFSEM2NFJUYkhxSUx4TkYzbUUvRFJMd0pXQlNJ?=
 =?utf-8?B?bmVlV3JEbm4raWU4bjBhUVhkS1Bxa2h6UmFlTGlCckhwaWIvOTFEZW5mY0Mx?=
 =?utf-8?B?OEJ5bFE1bU5IZkdTVU0rK1RuYTVNbEtTSXg4SmczcXFmMzlIZzUwMG9Ccngv?=
 =?utf-8?B?c1d0S1QzeFNPUkM2eHhiT3ZCNzMxUENWdVRxWUJIaXp5djdxbjJBc3VHOUJu?=
 =?utf-8?B?WEJ6Rk9qeUxlWTNiSnhGdUlnOWlrY2RRdTN5M21Pc2pVNUFJTEFWc0JmNW9C?=
 =?utf-8?B?MTdCVjRkZk9OZS9pMVB3ZzdDSU9QS0RkaHFNM2JmMXJLbjZHN2FZaHRWY0t1?=
 =?utf-8?B?djVlUkpBYk9OV09odFZTQWNpQlFubkRVQ0RXTjBFOHpPZUlJU2hxN0dGRnI4?=
 =?utf-8?B?VEIzekpWdHpLV00rOTVkZnhiSFg4T295UDZqSVdLaW11UmF1V2pTVnI1MFRh?=
 =?utf-8?B?L04xbFVPK0JtRkFWajNuYVczT2ErbENneFJLZFhKdmsyQ1BhZmZNVlYrYnJV?=
 =?utf-8?B?dDdyWnFxUExqWVZaSjlmUy9nSE1ERzF0VEJOTURNQWt1OWpOT0h0RHpKS2Vm?=
 =?utf-8?B?ZTJoaGltMDgzMkwrU0xGcnI5bERDbVVjRzB1eUVTN2lBcXBtK3VSbE9BdVF1?=
 =?utf-8?B?akQ3T1dJY2ZFcllJMlJNdnovNjZlL3pxcmhrMXNJL0JqS1lPd1dLR0c3ZVRr?=
 =?utf-8?B?THIxVnRpanR3MTdtM0xmUktOWDJsMGFCcHJJMm9XVjB5V3lGZ0VtWmtSQ0Vo?=
 =?utf-8?B?NHUwZU1uZDk5L1VDZTYvcGExSDlMNWdnNlZtVVRFQ0pBYjFXRDBwZUcrcWVS?=
 =?utf-8?B?cisrdStsOW1JbUVhSWMvcWQ4bU45b2k3eUFJaWFhb0hhUVRQeldteDMvSitR?=
 =?utf-8?B?YnNUdGxqZTNCSllqazZndEttRS9lcHl6cjNTdm1CTTJ6RER0em10UXNlNFpq?=
 =?utf-8?B?c0dkd1RNLzcrQ3JSSTJjR0dkM2NrSFBWOXdSM2xQSUtDY2puUllwOVJja1di?=
 =?utf-8?B?WDRCZGhiRjkwQXVpMlh3N1g1ZWFBTkxEazZONDRkVEtBNjJ3UXo1VzVFVmty?=
 =?utf-8?B?ZXZMd1hBV3l4OUZlSUNQeGlkeUVVWkZER3YyMXBiZGJOU2tLcjYvdlVpdkZF?=
 =?utf-8?B?NW0wTzdWSDFNTG9VaWpRZE1Hd0NOTVQ5QTFteWFjK0lpQ1FXTDZOZGlCeWt0?=
 =?utf-8?B?cDFaL2cyWEllazJWY3hGVGh6WU1sWDJvTmZOaFlZRnQ1OXEzbEdxZW50NWpa?=
 =?utf-8?Q?JuFEg/SOfhCgkF3QKUjmfUoXv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: daba78ea-c6c3-44a2-520b-08db6c13147e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 13:35:40.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx3e/x10F20HEziKjdfB+q21VsXXp3UdNIojv5gTdvnuc9m1rV116lNcxj7AgDZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6386
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 5/12/23 01:57, Dmitry Torokhov wrote:
> Hi Jiri,
> 
> On Sat, Apr 15, 2023 at 01:38:15AM +0200, Jiri Valek - 2N wrote:
>> @@ -474,7 +645,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>>  	if (error)
>>  		return error;
>>  
>> -	irq = irq_of_parse_and_map(node, 0);
>> +	irq = irq_of_parse_and_map(dev->of_node, 0);
> 
> Do you know if this is actually needed or we can rely on I2C core to
> figure out the interrupt for us?

Agree and verified that's really not needed. I2C core do the job.
I will remove it.

> 
> Also, could I ask you to move the driver from of_property_*() to
> device_property_*() API?

And yes. I can move it to device_property API.

I prepare the changes as separate commits after I solve issues
with my "add advanced sensitivity settings" patch.

> 
> Thanks.
> 

BR,
Jiri Valek
