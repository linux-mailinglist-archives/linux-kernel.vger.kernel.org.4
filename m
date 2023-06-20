Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E27370BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFTPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFTPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:43:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2139.outbound.protection.outlook.com [40.107.21.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F81B0;
        Tue, 20 Jun 2023 08:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYEqMauLJzsEmr1BFr/zzQWIBAb7I9COAyiItFjoXTaEAj/1gWV45g6q+nrkxkx76SG5gtvvZoq6/1PuNQApav/F8uXQCXCUSRx0l4NwtehfhSGieWx5IY74npT/WzQrYmb9HWcqQB56NdsdzmIYhVCt8Yh51ZqvknOIDYaZk6c7DWFL3+Nf48D4UmzSX7tnUoZhGp8/V8bJUWljobaEKeu7Joxe44saoT71VZzCkFGTbPFa/4s6mg5nxvc2XKbfaqM91vNEW2D0yHwh0gd8oYJjLs9Nfl4q2FJnlTF1Cxs5Whlq/KjiuDtw9mekTNiarj6l6mJMJX2KjBZNNFnbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6cMxbE0Wzf5YWQCVQLUNgFxq5c68Wa2q5dhK45ANsI=;
 b=Amq5GiCSjapKDLoKZoFqwcBVgiAG4kDxPD+DAYBxjmzyW9sB/hB7qORhTMfLYZCDs8IaXBZKKxwz91vGs8uDHMOn0Vgzzu81Ox/ikBP9WEhY0Q98o2vmW5f1NlMh9AFV0ZhDzzB/4bacXFJt8nY4AQ16Cs/Fea5OPld7A1zIPNABZy/qy9+E9wpb3EXIPj8i1mVOz3MvI4jMd37XgZit0l1gJoORCy2vs8kd/znn+uZ/Anl5k0yBsSkR2PSdu8bxChz9X9TiWfApqdYPNR54y3Oru/FqN94We9V1ntqJTm0ESEh34RnLjc67T/af9+j2DtH1WDVGuCCHwoPN7j1G0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6cMxbE0Wzf5YWQCVQLUNgFxq5c68Wa2q5dhK45ANsI=;
 b=jL4W7PAhY1YJzB9KwLd+seFOYDPrvXr6gUAWjg9cAuRQMh6wKqnc8UUk/XSx8K1ZF3iFw7MoaEIeTTpfSy51Z291MEBBQmjnBmKTp8CU5sOvPlwoxDThXyAEJdPMbgpPHHGIQNZfhrp/vz7aYpGQFyONXhgBUGZuxCVVYK3NbYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR02MB5805.eurprd02.prod.outlook.com (2603:10a6:803:133::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:43:28 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:43:28 +0000
Message-ID: <b70c5798-399d-25f9-e8b0-85ba0bb13a7f@axentia.se>
Date:   Tue, 20 Jun 2023 17:43:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: sv-SE, en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <6c622fd7-d79b-b7f2-50ee-00a0ec95a11b@leemhuis.info>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <6c622fd7-d79b-b7f2-50ee-00a0ec95a11b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|VI1PR02MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0a6099-ec34-408b-7761-08db71a51782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwYL8d97mOgO7U9CgWAHPzQWAbU/Cl4VMRFreqOCBWg+/BkxB7oxxPwXWdmC//cvpMrYdVGpMihj2LVk7VWpwtUPkHq7hSbiCxTJBq+4EnCWNRj+d4afJ9rkUQBnMgBJbnFNyxZa11Z8aB1h9+UA/cMs/I94xT7O271QKN/6H2C1g15+cV1DRpKJvFnN9kKiTxw5Va+ARfMogW8bLNbkbzHN0XoQGXcPfGSOIPhtTua1teAe7xxvjcfiMrw0zvJGf1HkUqQ8uEPdEbbifJkQEf3RnD2/x+YgzQkbm3nkY/ONmJsfNuPS74McdcTDxUnZojD9dL/499dbPzzvxnPlU9FNUIEfsFqBoiuzINs/RkfJVZLobXytrCj+s39M63SwWi+xpXoNj69xxrxkTuUw+IcLS5htTHC7Ig5z2syRgKuNOhXqtO3mTOnL1KiKPXSlcMxbC9ISUYHDtqomZ0pcWX3rgmT5gcB/jwelLvjN9YupG4gv0cDUHPVfu7HgBAUXeN3yBgmWmU0AhIBBp8vaZuCIdpaSEzOvy6UfRVhbI0ruh4/5RakDYmDt46ltPddFBhzxeQGc/CF5c0C5WjnYq6MNxRE17LCkXppasWwuV0jfz/sjUGQ2XhzeptvTbJ6Mr3uwPZmS54R9RraimSG0Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(346002)(366004)(396003)(136003)(376002)(451199021)(478600001)(83380400001)(31696002)(86362001)(6666004)(6486002)(38100700002)(316002)(4326008)(66946007)(66476007)(66556008)(6512007)(6506007)(53546011)(2616005)(186003)(26005)(110136005)(31686004)(54906003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2x0QnFDcExHbkVycVozTUtWeFRmOXhFVjF5MmZqWnlEMnZ2VzV4bzVUZzhh?=
 =?utf-8?B?RUtKOThQRlpWd2VJK1draSt4RXZmZDRNbk43aTVGOVBnVXVPR0dLWDFHQ25S?=
 =?utf-8?B?WmZvbFc1Tlk0ZFI4YWZlV3dsLzRzTEhjZ2JqMGJlTDdMNG0va2NmMWZlOVdr?=
 =?utf-8?B?OXh6Ykp2WTN1TG5ZZ2VNS0ZkbUM2NHdjQTBQR2wvZmY4Zml2VXpmeS9jK0cr?=
 =?utf-8?B?Mk42eGMvUi8rNlRGdjV3T2RPZERxbW5qOU0wRmhYeTkwQ3BYdWhSUGx4Qlcv?=
 =?utf-8?B?ZEIwM3VuRlhiMWU2WnI3RVdWVUh1alBVemlOWXM5TDVrdUY2QWV0RnQ1ZmFy?=
 =?utf-8?B?aGpXY3ZzNWpRZ0k4bWZLeGpnZGwzY0RqNkxUdlNxbjRzR1dFci8wcTlUdDB1?=
 =?utf-8?B?YUxSaGJ0S1Zqc3lOcmZQT1lvWU9taEtqOU1aSmJwRGVncnMwWWpTc1B5NXl6?=
 =?utf-8?B?UmxMekNhQzgwdjBJVzlDc2NrU2cwTExZZmVlQmxnR25GTTR0TnFGVDN1dzky?=
 =?utf-8?B?OXQzemkrTTVEU0hOOWxOY2M5ZHhSK0pqT2RId2dIQ1ZLZ0x2VUppUEU2VFBJ?=
 =?utf-8?B?ZGw3UlZqYjBtRGZrU0NXRzdpY3g2TS9lSUxuODBYbGZGWE9udDdlZmVlNmRS?=
 =?utf-8?B?R2VRZ0p5cXllWHgzMGNiVEVMT2FRS0RscXB0UXp2UWE0bldzbGNkdnl5bGVI?=
 =?utf-8?B?WExkSXlIUWJGeVdRSjNkNFN0VjdKY1l4UGVXREZtZ3FCdkhjZDFvd2JRbkVp?=
 =?utf-8?B?R3dIS0loc3cyeVZjWkM2WFB4ODNIK0hxanptWGZsN2YrSmptTm1SZkJFcnhQ?=
 =?utf-8?B?YjhQK0d5c2FEMVNpMCtCb0NyZzgyazBpMmJNeEpUNVhFRGFZNjVRUHVEanMw?=
 =?utf-8?B?TkJwWmZYOXdiNDdTMVJteDl1VXl1RHgzSXJQUzYwMm5PVjVFaGtEcHV5bkpP?=
 =?utf-8?B?a252TG1TbFA2b3lIMXhBODdvbjJFeTgvNi9KeEtRNDMyQ09qUjZ0UzltN1JQ?=
 =?utf-8?B?bGJnRm1JY2MvSVdZN3BITHJXZnhtbHRzY3R0QklYcVc5aE92UGxPWHdIa3B2?=
 =?utf-8?B?OE01MzEzUjZ2b2MvR1BmWm1LWDVHVzlVVGZObUVXS092MGQ2RFBkQ1huNVN0?=
 =?utf-8?B?UHBiMnRLRlViRUR5UWs1RE9xTzNXYnY4a1EwLzA4d28rdWllcThmdnJWQnQ4?=
 =?utf-8?B?eEpLUFdvZi8zalZJUUwrMWcybXRzOFNkZm5DZGx5eThabzZxTmNoeDZPd1ZI?=
 =?utf-8?B?aWpzck5QVU5CVno4Y1VjSU5tUm1nZnpCNEZqQnZsU24rTkNJOWVVUGdFZkZ2?=
 =?utf-8?B?MzFyVHp0Q0NMdDJ5bUNiT09MNW1iUEpEbXhURUxKT0dCMVgvY1hZVkc0cWdV?=
 =?utf-8?B?bG5UakJKUHdnWkF0QXkvaURpa3VKYjlWN0ZHZ3pEeTNCbGRxMHNxWWE3TTZs?=
 =?utf-8?B?OXZ2NmptajNkSVBwL0VHRGdMY1JuV0pxRFNzYmFwT0ZkeXVjaGdaV1JNRDMz?=
 =?utf-8?B?N0xhaGVMNmxRTU1PVEtzKzNlQy92UFo1QmFQb3ptTUZKMXFxcUVCMmdpcVBN?=
 =?utf-8?B?SWRQUCt1bkhVNUoyb0lHdkpidDVxNktUVDl0dnRBa0NiSDhaZTkzN0ExSlY2?=
 =?utf-8?B?N0NWSlhJMFVpeXhBMERCMjhUbWhxelhrRFpLZVQ0RnFNTzc3bWxScFdORGZy?=
 =?utf-8?B?WnlidlAxbjNQYlQ4YmFIT05QMlBHOG5TWDVHV1BaWGV5R1RrSFFoVmIrRTlo?=
 =?utf-8?B?UTVHK25GR3JhZE90WGRTbWFWeFR0anZGV28xUG5Pd0h0bnltSmp3L0dweEhY?=
 =?utf-8?B?QzVQd3E5YmFxdXB5S1Z3RFRnQ0JDdlJjcDNoM3dsMGlXelE0NHJuWUZVZ2hq?=
 =?utf-8?B?bisrVFh2ODFGMDJzNVBObWtHOXQvRk9XTVo2Z2l2QW13emk1RUphZmxoOTVE?=
 =?utf-8?B?aWJON2F2OEZuY1YyVW8xTjVCTm5FYnhqRWVJMzdWVHR4YldzNjFxQ3NBL1J3?=
 =?utf-8?B?YmttZzAxeTdrZEM5SndGS3Rrc3BpaWFWTzQwdjkxdVByeW1ZMTlObVZtVHpX?=
 =?utf-8?B?YVBQUnM1eVhXRCtpSUtyc3c4ZVZzcEJIaThrYVZ5RzFWTjhtaEVmV0g2OFZJ?=
 =?utf-8?Q?pFNsaKHkTZLsrWovKySjUzCVH?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0a6099-ec34-408b-7761-08db71a51782
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:43:28.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDutmvixPWcWGIuTPnSHs5ILpKODr1e4Z/H0CHT5oMWF23dis5Z6A1IP6mTvnPIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5805
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-06-20 at 16:24, Thorsten Leemhuis wrote:
> On 22.05.23 17:19, Peter Rosin wrote:
>>
>> I have a device with a "sound card" that has an amplifier that needs
>> an extra boost when high amplification is requested. This extra
>> boost is controlled with a pwm-regulator.
>>
>> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
>> device no longer works. I have tracked the problem to an unfortunate
>> interaction between the underlying PWM driver and the PWM core.
>> [...]>
>> Approach 1. will maybe clobber the saved pwm->state such that
>> it no longer works to get the period/duty_cycle if/when the
>> PWM is disabled? Maybe only for some corner case? But that might
>> be a significant corner case?
>>
>> Approach 2. will maybe mess up some unrelated functionality?
>>
>> Approach 3. is ugly, intrusive and is in all likelihood
>> incomplete. It also needs a rebase from the culprit commit.
>>
>> #regzbot introduced c73a3107624d
> 
> What happened to this? There was quite a bit of discussion, but then
> nothing happened anymore.

I was seriously confused by another regression that caused my
user space to fail similarly (The sound driver didn't behave, but
for vastly different reasons). My bad, I should have made more
thorough checks before crying wolf.

So, this regression had already been fixed when I reported it.
For the curious, the other regression has also been fixed, merged
and picked up by stable. For the really curious, 2a6c7e8cc74e
("dmaengine: at_hdmac: Repair bitfield macros for peripheral ID
handling")

All in all, please close this one.

Cheers,
Peter
