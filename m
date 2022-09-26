Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30675E9E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiIZJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiIZJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:40:26 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10071.outbound.protection.outlook.com [40.107.1.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540E46DA4;
        Mon, 26 Sep 2022 02:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyoPUzaSrD6zqRQOb9+dNTWrC2EVrYK8Pi8kYw2PymmC74VMtyvRv3b1Tr1q32EzhJgHZkoSaT2eAVT/Y3mloqaNv8R3hNe42lfaPZAJKA5Q8XHxp2GgC9ifGiU1Snv/aejh0YuwRKoVzHPFEiRwNHLyegjJWo0r4rWtyM8/GvBK476TtRJxeT++3Ca/gF+XHQPBKClzc5Hqd5md08xA6GzMC/SjKUZSxwSWnsDoxgCIpzZwx/f+merqk2rQTfa1co6SVI6nrTzyNbwTJtttmfOxzbIp+IvcPNY3VzP33qps325Pbyo7XZlEXT1TLDiJ3MC/5M1nTFlBNy7BIzAzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uP81slpwwQYd3sBkznfh9OBoGxg5txOXoaQsv4Er+8=;
 b=ZPFzBrKhvOS8K8TvIPIY6oY9dvft+K/w8zROBgp3LrBNkeyb0xdLSnlGe3BZhVb+Pb1WiiLfGMCrIf+LRX79zibsA/72zqmclGve1uKl84ahym3L9ghKkQi/YVxU/UVCvcVvb9ZPLjDfdsl3X6LPfibpHrnrUFTu0/KRN5CfAIEvkfu/vOVtdfpBS70rtoUdbMSNdgSWDTftkQe82k+L014dJRRNJTHw+3mL/ONU4peZhC5Zj8WmpJUcFfkBtg15Moz96Cb9tObFZRP/k+b/WAWYonMDu3DbQiNbd9N3kNXzH4ITZKF2UzR0TNN3bBgNa/Nj/rbGna5ffIKw43rJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uP81slpwwQYd3sBkznfh9OBoGxg5txOXoaQsv4Er+8=;
 b=H5dmM6wwQqqUH0yQyMdm8XlGQiB6f/VbHF6Ogzy9aWq36XnGqYyqATzlnf+AdNQ0qv37uIgeeLrFFlqE0Px/dRiD4AHHwF+1iwy1jaSLq2gUvJQ+5djoRO5XQsLo9aRnFwJPMNuFauJU3o8t/aKmM2mmFGXF7nqSmxrca/Z1oXgzRcFMCx0mMLztNHGWhR5j7HUJLfWy53DA0G/friMDVqCEge2aqfB0Pw7FOFyZFatBg6JTGKfkQBZ3NSCblTtZ0sqkbRy4NUzkw/RXDnEH0v1y+vhYkOTxwgtqjWizv28NNSvlaB8hnzIK79ytQppPLfzp8LBy27jNefP0ZFivvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7748.eurprd04.prod.outlook.com (2603:10a6:20b:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:37:47 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:37:47 +0000
Message-ID: <953e4d00-110e-b337-3c6c-af008c843046@theobroma-systems.com>
Date:   Mon, 26 Sep 2022 11:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        dmitry.torokhov@gmail.com, klaus.goger@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net> <YyyZRt5j180KzGqc@nixie71>
 <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
 <Yy3qj432McMJ/5rl@nixie71>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <Yy3qj432McMJ/5rl@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a27c9fa-ee6f-443d-2d31-08da9fa2c53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYJcguX0bj07uu8rl3TUrgO52rNUp3vBqR8kJM2mNSAToPZY6TglnVj2I2rbtQqLEdmPEzD/J3x7fW9kCsDqs5l3Sx+jytifXl1AXjx+sVSAppsIfcQg8j+2P7mvZJRkSazHQSUjnK2xV5IJ6XKauvDmav8Cm+qEGN7IvqkILSN3kpepO3VWSNR9aZpLBYwhrfwluUwQo+jE+xYPKobtMj3lcHzmIgCmCdMlph+JV5xS0jhSSOAFFR2v2b+1oPmSB7PX3PFqGT0xxb+ePTCKeoNAqRGVwRvkPvuegCJI4zfYcICX+uUUvR6h0ZMt44PAOm6ojeI2Wc1EDFYmtb3ojyDnLylpYCK0zNtPA+cRfukfVBMbssS19lS9rnGbQK7poMQ/CnLx7pDgPnC47j8wFxkK0w/P9kIqSMcEiIwTwCXv6zlkHLvf4Ci5BiT0bguckME0l1Nf2d9E4kS8xwZhxtF7yggbVEgLJ2Ju42oa5Ag+a2+gQvTQ7xqJWh6MYiWQwml13Q3JqAfHxrUVaY51mQtOv3QCQ+eT718ckPYf86CP7DihbWmHDSC1obOlJ0qm58LtKu6KKELWQtOpwAiVPkcilENi/wRH3OtfpnTJgTV20nPd/0Cq89LcE2bV1FykIdfvoHnfhxLnKD5o7uf/g/0saGLj2wSh1Ccz70ZXBmsf51kbj5t6Gu2IAbCmW4OrwFT5yaeRPsLTrBQp9GmUcnHWy6alo4p16DDC1eGDuhZ0yLOqA98eCJJ8cTWdl/LXISdpe0TtlSK8QSLWDE8R5P1anG99dvh5f0kPPa2e+Lj/swSYQARd0caUuoe6Aiaaj8E5T7VFvf6EI7Oc4xk75g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(39850400004)(346002)(451199015)(6916009)(966005)(316002)(6486002)(31686004)(478600001)(66946007)(66556008)(8676002)(4326008)(66476007)(41300700001)(6506007)(36756003)(5660300002)(44832011)(53546011)(7416002)(6512007)(26005)(2906002)(2616005)(8936002)(186003)(38100700002)(86362001)(31696002)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTk2UzZ0c1dCbGxVc2FFbGdXL1pOUWtuRHYzWUxWbVUrMnB5OExLaG11a0Rp?=
 =?utf-8?B?NkdoakxNYzQvRzQ1TmRBTG9lREVqV2FHdDM1eUhyZFVlWFNMWXlqVmFwakJQ?=
 =?utf-8?B?YVNyVHljQmJRUEo5bDBxdEtmRVJ2Wm44RmpBZlNFWitJMEtabnZHbUJjbTkw?=
 =?utf-8?B?aU9zVFUzMWRQcFc2dllrb2dQWHBZOEV4SVNudEpNSVI4ZjJmMCtxR2NqTmps?=
 =?utf-8?B?a1IzblhkQWhEVkZ3aU52WjlTWHVJeU9tNU0vMDB6R01PNkRWbDJoSkpBWTVy?=
 =?utf-8?B?NTA2c2FOdHdISnZIeHFRODU3UlJENktnakpWNGZ0UjVPajBTY0pUNkJReHZu?=
 =?utf-8?B?ZXJUdUk0aU5FbXoySGNBYklIcmpyb3p4dUNEbllVb2Ivbis4YXk0R1NvUUpL?=
 =?utf-8?B?OUZWMWIzSEpNWHJibkhWcnh6Rm9nZEVCSUs1Z05uMXJUZHRKWG1WS0JXQWcw?=
 =?utf-8?B?eldIWDFVSi9BRlNBSGxqTFF4WWx6TUVxbHFVNHlGWDVIbU9SZnYzdk1mamQ0?=
 =?utf-8?B?dlB6dVVPYnZFWlcraXpRWVgvU2dJcjlHdVlWbW83MGlYRkVwdUNlblRLekI0?=
 =?utf-8?B?WVRWUW1jaG9KVnNDU1ByaHV0Q3FtZXJKT1VNSko2ZXRHRTJldmR5cXNTS0ZN?=
 =?utf-8?B?eS9vZEx6R0FPUjVEZ0U2VkdRZWtLU0psUDhUM3lGU0JieGJzL1lJbTdsbXhG?=
 =?utf-8?B?a1AwRzRGZ1BHZTlhbG51Rkg3RkUyWnNvRWZWVHkvd1FXL3FqdDBRakRvVzli?=
 =?utf-8?B?dTE4NjM0aklKQUFEdEkyZzhvaE9vQ3RjYmdwbUFiM3lKSFV4QWRCZFVjNC91?=
 =?utf-8?B?Mm1JT01DM3lFam8vUWRDNzlvTi9qYVJWa0dVOWdlN0g0cUoyclhBeGlGdmF2?=
 =?utf-8?B?a244K0F0SmFYVWdxVEhyczJwK0QvOWxYVU03YW1nNEg3eit6R1dtZkpPSk11?=
 =?utf-8?B?Y2oyaFh0MVRoMkY3aUUwTTRVREtaQmJZUTFVQWhvb1pwM1drWHRHYXZuNUdu?=
 =?utf-8?B?Q3RtbG1ES2Y4bEo1SDQvUkk0SE9ZZkozRXJmMXFpQ3FZbkJXZlhxZ1BsWThJ?=
 =?utf-8?B?bmhCU3FyUGRwMFBKYkFFNzJ0QjF2anBPT1ZrTnBLaDlHVUxCWURNY3lwbTlv?=
 =?utf-8?B?K2x4YjVHMzNPZ1hMcDlzT3BialQxUi9ENWNNbWtxT1M2N21uK0pXL0doWTVJ?=
 =?utf-8?B?YjQyM01kS2xRZzBCOUczWFIySlJFKy9vamVDL1hLaTlhOTJHa3NBRERJS3VQ?=
 =?utf-8?B?UjR2bW15ODRjdUl5YnpVcFlRZHRUNGpUZ2dTZnR0d2M3N0MxSXkzV3NuZkhK?=
 =?utf-8?B?YmRJcFRzSWpBM0ZzMGsvRFN4NVpvZzg2L244VFR1dDQxejMyZ0ltcUd2OXJa?=
 =?utf-8?B?UlZCQ2htc2R4RnpyUFViRFdvSGw2YlI1TFk4ZVNQdm51dXgrNnhVeklnM2Vw?=
 =?utf-8?B?dDZsYytuSEYxZy9EUUUyS1p2TVl2WkFzMUkvbkVzeWwraGVrc0RnZ2JjaDFt?=
 =?utf-8?B?enVvTzBySFJrRzk3ZU12b1BhNWdLMmhSTkRIRHhxTElEVHNPMTVJSmh1aVNV?=
 =?utf-8?B?cDRVc0lNbHdXQXF0ZkZERlRYV3g2bzVUenozQ2U2ZlFJTlBIUlBlbDNRREly?=
 =?utf-8?B?clYxTWx5SDhwVWtDaklYcEpBNTloVkFHVlVITUJVanpSOXhXd3A5VFBOUEJC?=
 =?utf-8?B?eWJyc3ZPSFBuaHYxT0ptaGJHYzlrZDJCTWZjWmgzdTdsOHFQYmxTUmUxU1Ur?=
 =?utf-8?B?clBMSno4ajEwSStORFJSQVJSUjlIUE9yZHBuNHlCTmhpNGVpYTRsaThIRmxY?=
 =?utf-8?B?cjJwQ0p3ajc3QjR3OHpjdzRaT3ZoL3N2QVUzRFpWU1VEYUJuMEJ0cUptWEdz?=
 =?utf-8?B?ZExiWGlleEZNUkh3S1FKaVRGSWhpb0JJaXFQK29qd3VIL3VnMUo5SXJKTm4x?=
 =?utf-8?B?ZUorTmNPcmo5cUprcngzRnd0Z01vNUZheVRteXQyZkpsT25ha0ovVWk3ejRO?=
 =?utf-8?B?dGJBeHlGWjNyM3NMdmFjSkppVHNBWkRQbHFyN0lPeHd6QnVnb29vNE1WL1R2?=
 =?utf-8?B?WWhIeVo4dHhWR1hyNEdoSFcxNkxTdHQ1T2ZCaFNKRVRCSy9IWUJMcVhtdis1?=
 =?utf-8?B?bjBCaTNxU3BkT2JSbkE2aWpOK1ovd0JjMjRnalBqSmU1a2E2RVZrNnBPSndG?=
 =?utf-8?Q?y9nQskWMn7XsLwForAm43l8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a27c9fa-ee6f-443d-2d31-08da9fa2c53d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:37:47.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNCKKrbvc7unmKOhrC/jb9RDnWPxA9rfeiMzEHmoQiK+6Io4s/7o5XtkyhZP69jwXP6mtMA9x5pgiqYNHunE9+Y0bDMUOt/sS1eiVIefQx7SZt2u1ZouVGFHMI64wu2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7748
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 9/23/22 19:19, Jeff LaBundy wrote:
[...]
>>
>> I have this switch on the board and I want to expose its state to the user,
>> if this new event code is not possible/a good idea what would you suggest we
>> could use?
>>
>> Note that we already support the same switch but in a different way: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_arch_arm64_boot_dts_rockchip_rk3399-2Dpuma-2Dhaikou.dts-23n167&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=vObtDja6hUlL_kVvKRILCvaQfklw1gl7TAW7cm5_9H_Yi00zkzGV6-D3yzazR2gU&s=0Xo-7CDmMoriaTNn_hJdMwftLlcY-tgopPcgzXfQtJE&e=
>> We are just configuring the GPIOs into the GPIO mode with a pull-up, and
>> then it's up to the user to use gpiod or gpio-sysfs to check the state of
>> the GPIO used for this switch. I don't like this, very not user-friendly and
>> was looking for something better :)
> 
> Actually, that's exactly what I was going to suggest. What in particular
> is not user-friendly about it?
> 

The implementation we currently have in place for Puma Haikou is just 
muxing the pins in their GPIO function with a pull-up. Nothing else. 
This means the user still needs to know exactly which GPIO number is for 
which signal/event. Not that great. Also does not allow for a consistent 
user "experience" across modules on the same devkit (different GPIOs 
depending on the SoM).

I had hoped gpio-hog in input mode would expose it to userspace but it 
does not seem to?

Anything to recommend so that we can export a GPIO line for a specific 
function to usersapce without needing the user to know which GPIO number 
they should look at?

While I have your attention, I was wondering about the BATTERY event. We 
have a BATLOW button, following the Q7 standard:
"""
Battery low input. This signal may be driven active low by external
circuitry to signal that the system battery is low or may be used to
signal some other external battery management event.
"""

Oddly vague, but the EV_BATTERY event is not really more precise though 
(at least didn't find more precise information and the introducing 
commit is a bit vague too on the usage). Was just wondering if there was 
any specific usage for this event or if I'm using it correctly here?

Cheers,
Quentin
