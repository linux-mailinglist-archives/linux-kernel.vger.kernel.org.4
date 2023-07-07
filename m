Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC574B521
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGGQbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:31:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A8AA;
        Fri,  7 Jul 2023 09:31:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qHoMq-0000EY-1y; Fri, 07 Jul 2023 18:31:36 +0200
Message-ID: <7493c624-431c-a67d-3cbd-10f29a8c33dd@leemhuis.info>
Date:   Fri, 7 Jul 2023 18:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mainline build failure due to df8fc4e934c1 ("kbuild: Enable
 -fstrict-flex-arrays=3")
Content-Language: en-US, de-DE
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ZJ2M4yqnOCqqGWH0@debian>
 <c0db4c48-6090-5c72-b597-9d4146dbc26c@embeddedor.com>
 <423a78fe-ac40-9983-ff44-90b1759fc0b5@leemhuis.info>
 <1fb40135-2a4c-5d54-c5a1-db36244128aa@embeddedor.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1fb40135-2a4c-5d54-c5a1-db36244128aa@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688747501;6e956fb4;
X-HE-SMSGID: 1qHoMq-0000EY-1y
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 18:17, Gustavo A. R. Silva wrote:
> On 7/7/23 06:52, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> Are those fixes still on track? Looks like there was not much progress
>> since then, so I suspect this won't be fixed before -rc1? Or did miss
>> something?
> 
> The change is already in SCSI for them to send it to mainline when they
> see fit:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=6.5/scsi-staging&id=47699a2b63caaa0de4841d4402627c2fdf3452a6

Ahh, great. I had checked -next before writing my mail, but somehow
missed this one. Sorry. And thanks for your help.

This afaics was the last remaining issue of those reported in the
initial mail of this thread, hence telling regzbot to mark this as
resolved by that commit.

#regzbot fix: scsi: aacraid: Avoid -Warray-bounds warning

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
