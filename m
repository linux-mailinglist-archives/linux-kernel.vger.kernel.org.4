Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7C73D008
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjFYKFs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFYKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:05:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2022.outbound.protection.outlook.com [40.92.65.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14441A1;
        Sun, 25 Jun 2023 03:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiCKR67K9f98W4Si0FBt4Yf0E9oeT7A7gL+bDGzV1xgQ9J1txaYZaJdGGcJcM7vPq8BBH3o0puCGAwxUYFc2vRrFEpdYBVyoQcEWKLhhnpt9Gwu7S97KMBwxSDOU7DkC3TeJPN9RvyFlQff0ITLbOKXAaI0TWNT6yM9c8YoHz4hH2q3SbT9JDF36kk9QZiwns6a3oQzHJvbQGKzolfK+Eu4Y6m9NKpy2clDL4gniyFLLqD1CX7txdllFbj4q0Xhmbqv7FtQujbPsl2dFrqrTkdo9ZGfhXw6D8wT3GWa+/l1f25EdTIocmByo8mzzAvMuSVMs8xIWS2dGLsCBNd9FhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJCw8ZWp+a89C1GmoYjFKGwBEv6w+605BFJW1FD7Asc=;
 b=H46/pOp9jY/TbGVooIeVT+blv1VW1bqO6Y8WvE1pVtFbfNYDAbXY1cfn+894BLWSPiX2FvkWGO4EbQRVIqWQlRjQBCqQqAdMHhK+eS4e7kPbL+kvncDCxXPPHHEh/YTx+uTf8yTvoip1tqYtOX3+dH9t93/3eEGs1xB0oIlnFzjp0jxOJx6tOOYOhADfGf7IX08f0iykwjNh7D1GVYCTjH4pyXvFDsmBPAayGzx6WdtuL9xb8ykQA9INOPSlGp5NxP52yJG/5WTtiWBRTPs0rHCOoUijbLc3gi5ilcYtTCz7x1shP0vyR2R20DMzecbI2znqY23MhTfIwD7dbBH2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PAXP190MB1631.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:1c0::8)
 by PAXP190MB1791.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:28d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 10:05:38 +0000
Received: from PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 ([fe80::b5b:4a3:830b:7a0e]) by PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 ([fe80::b5b:4a3:830b:7a0e%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:05:38 +0000
From:   =?utf-8?Q?Timo_Grautst=C3=BCck?= <timo.gr@hotmail.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
References: <PAXP190MB1631B7C90A99FCEBB1594AAE8B4DA@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
        <CANiq72kf=VktsDS6ctLxVt70EGtkSwfx+Z2=qNMdyQf81pQ3dA@mail.gmail.com>
Date:   Sun, 25 Jun 2023 12:05:32 +0200
In-Reply-To: <CANiq72kf=VktsDS6ctLxVt70EGtkSwfx+Z2=qNMdyQf81pQ3dA@mail.gmail.com>
        (Miguel Ojeda's message of "Fri, 16 Jun 2023 03:17:35 +0200")
Message-ID: <PAXP190MB16316300F2E89EC06A4E3AF78B21A@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TMN:  [DcT+g6/UxAYYQ/feOCwW+qlODaWBXO+JW5ZYN0KwkrBiJ/dH1E+OApD9+/rfGpD6]
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:1c0::8)
X-Microsoft-Original-Message-ID: <874jmvrh5f.fsf@fedora.fritz.box>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP190MB1631:EE_|PAXP190MB1791:EE_
X-MS-Office365-Filtering-Correlation-Id: 864e74f0-a335-4eb0-fd21-08db7563b9ea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPvQs+7YN5xYL5tnoLc0aCv9oNUDnr0iX74Fu9QPi6CaBpy9r87dUJoVpf1ZBOLXQryRXyO0bemFyZSvqOaCdKPtR7l8n6fkGLsDGrMuTbeTee66J+EqX7v0OgbZoAIQchI1Fot6WuWrCo8i+6TmDHcAy90No0vAxA/Thn9bNW83DGz/VfvHaH1Bq/KdWcCO0aHGJ+48S7I4PxpiVJJP2W1VxZmMIXMyrxulGPQmwDvpu0GhAWmnI4c/nwkXrFNvVIqbNeDnA4FWqNxDAfbgPO2VN8viyPiQnSw5JhzFHR/KnsjUQjEq8zbhykWDVOHSKO4XT4ncmTT44O60PRflSFnALRHRpB/84SbWAodJddfPwriv6KIeB5BJ+m/5Tfx3LuaG+fwETfHIE7M0NA5Q67MEE/frcktAPFK2yMkRn0lVFU5HZFT/jMaJ9S9y8xKVc7eT5aOPMzlG8UmwmwMRoAx2fG9j57EkAEuABGBTAzHfkTlPnfe2jkNHnx9HjOmnV1n4UC0K/GZoZfSSoR54mB3vIUocNFbFztEyLV/vK+E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhiTnRXa2dBYUUzVEdZT2xPbG1VL3NVaG9WVUp0ZEdTYUNXeCtzdGxxL0RR?=
 =?utf-8?B?Zlo4L01OODhUNGt1MzZHaXBQQUQvMjlwKytWV0s0TWM0eDNxckt6UG1ERkhP?=
 =?utf-8?B?RytoRGF4c3VKWnIwOE9MRWU3MFh3VzY5TEFBMTlGRW02VFcxNUJCS3MyOXd1?=
 =?utf-8?B?TjJ5YmJFaE1aTWpWV3pIUDgyZXRZMXdmM1RZa2dXSStPckJ6b0tMaTYweDV1?=
 =?utf-8?B?ZVlRVm11NDQ5U2x2emVPMzZoYTRna0JDUzl5QzdRMVhlandFT25LRTBLQkFy?=
 =?utf-8?B?b3hMWVhWQUk0UTAvZVU0NWF6RkNQQkZLazRPMHFwaXc0QktDODJzbUVrVGM3?=
 =?utf-8?B?R3MzMU9CWGpvN0ZKY0p0UGtkT21MZThuMWk1WVlzMThUeHpVSmVuQnV4c2dy?=
 =?utf-8?B?UkJDazM4cEhBNDU5RFlsT2FBTWZzSDBSZ0syalg3REViRFZmQkxkZnZlMVUr?=
 =?utf-8?B?S2J5SjZvVzZqRDZnUU5VV1pmNnUvZThWZVhrQ3NWdEpFd0FNcnJxZU82M0tt?=
 =?utf-8?B?dVRFMnVkVjB5YmZxY21YY0svV1dyOElxL1lYOHlkcGE2L0FqOUlsTXNWY29j?=
 =?utf-8?B?NlJsVC9jcW8yNWhJSG1oRUVqalkybFZmT0hScTR5Z3RXZzMwMkxRVHo5TmEy?=
 =?utf-8?B?aGkyRHZKWlBSU2p1NkhsZnVpUk1wdi9WSS9zM1BCSlQwWEo2cC9iN0s3OWNn?=
 =?utf-8?B?ZVlDMkppYU9EUEpTazB6QVZFQzlvUndoOXZKWFdFV3VmYWhqZ0kzdzlybytD?=
 =?utf-8?B?eEk2Qk9QS0FVUmJxUTFlei8yT3RzL2E5MU9BTi9qaTN0SXU2WUd5RDY5UHVy?=
 =?utf-8?B?WUxaUXpRMG0zbmp4NGFWUWM1cDFvMlQ1aVE0V2dNODRtUjVRbTZCcW13cWxG?=
 =?utf-8?B?cUFYZFJLVmxtSHVMTHMyVkxoM0V4YXlFUUlCS09QNTdBZ1hlYkNFTzNQaG80?=
 =?utf-8?B?Tm5BOGZTL1Mvc2d0U0x1UEtGeVU1MVlPaW11ME9IUkhHK0lmRU5zZXVyNU9Y?=
 =?utf-8?B?QzVBcE8ramM5QXdEOS9yZGxtb3dmd1hQb0xKT0tDU2FyMkk5U1ZHZngzL3dn?=
 =?utf-8?B?czNPblBuMVNubHVkRUFTeFJhUHVzZEl5bEZGNkk4eEN5Vlk3ZUFPSDdUZWFC?=
 =?utf-8?B?TnJZY2FZZ2FuNnRJQ0J4eUluQnJNZmNWVldnSUxYVUdpNlI0OW1JTktBTEVZ?=
 =?utf-8?B?WFdYSHFxSUJuYXRUVlJab1l6MWZGV0dlem84eW83dmhRNUVrM2IvM0pHMGE4?=
 =?utf-8?B?aVJiRG5jeHUrbjhDbDAzOFVpQXFVTk1VZkRVZEIwdUdvdmszQXdvQzFoQ2hF?=
 =?utf-8?B?Nk5Lcjg0VEwwUUNLZXhhbW1aNFlrc0FhQU1xZXlxaVdQUEhWdEhQRkhjWnY0?=
 =?utf-8?B?Ris1ejVPZ0pkdWNWMCt0eW4ya3hWUmpFU0ppcmROazBRd3ZpQTlBNmhIT1Y4?=
 =?utf-8?B?MEJUMHJBWm4zYWQ1Rmx2R1ptOXV2U0l6UjhkeDI1dlJpUC9qbzdYbWM4ZEZ1?=
 =?utf-8?B?QUxEYk96dVV1SW8rRHE2aVArQk83NnEweE95aERncjFPcUwyaHhocHc2L1k2?=
 =?utf-8?B?Zlc4WkQ5ZDlOOVdnTTZKcFc5SXNRUTVaWFl5bTUzdHRiaDgxamdjQWI0YXBr?=
 =?utf-8?B?L0JBbDBPREl3TS8xMFNzTWliQis1N0psMXZLQWlYOEltMkVjRlFJZ1hhNTdK?=
 =?utf-8?B?UzBQWSsyQ0VMd2o0a2NxcjdXKzd6MlFtMlZramlCaktJbWpjOGI3emxRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-91991.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 864e74f0-a335-4eb0-fd21-08db7563b9ea
X-MS-Exchange-CrossTenant-AuthSource: PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:05:38.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1791
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jun 5, 2023 at 6:12 PM <timo.gr@hotmail.de> wrote:
>>
>> From: Timgrau <timo.gr@hotmail.de>
>>
>> Just a grammar fix in lib/Kconfig.debug, under the config option RUST_BUILD_ASSERT_ALLOW.
>>
>> Signed-off-by: Timgrau <timo.gr@hotmail.de>
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1006#issue-1696318406
>> Closes: https://github.com/Rust-for-Linux/linux/issues/1006#issue-1696318406
>
> Thanks for the patch!
>
> A few notes:
>
>   - From a quick look, I think "Timgrau" is not a known identity to
> the kernel, right? (e.g. I couldn't find any other commit on that
> name). Assuming I am not mistaken, could you please instead your real
> name?

Right, I already thought so. My bad, will change it.
>
>   - When I wrote the report, I wrongly suggested `Suggested-by` +
> `Link` because I didn't consider this a "bug". But you are probably
> right that should be considered a fix anyway, so instead we should use
> `Reported-by` and `Closes`. So could you please remove the `Link` and
> change the `Suggested` to `Reported`?

Ahh ok, i also dont think you can call it a "bug". Is it not possible to
simply remove the `Closes:` tag from the patch and not categorize the
whole thing as a "bug"?
>
>   - Also, since this is now a fix, could you please also add the `Fixes:` tag?
>
>   - For the `Closes`, you can remove the URL fragment part, i.e.
> `#issue-1696318406`, since it is anyway the first comment.

In that case, these two points/notes above are not needet right?
>
> If you could change those bits and send a v2, that would be great. Thanks!
>
> Cheers,
> Miguel
