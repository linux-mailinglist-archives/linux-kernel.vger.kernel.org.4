Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D501D7427FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF2OKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjF2OKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:10:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29826B6;
        Thu, 29 Jun 2023 07:10:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qEsLP-0000pI-R2; Thu, 29 Jun 2023 16:09:59 +0200
Message-ID: <13abe42f-2f5f-cbaf-21b8-baa4516963aa@leemhuis.info>
Date:   Thu, 29 Jun 2023 16:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor
 out a helper to submit normal write")
Content-Language: en-US, de-DE
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZJ2H5FWuo9oDMgPm@debian>
 <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688047803;35e158db;
X-HE-SMSGID: 1qEsLP-0000pI-R2
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.23 15:56, Yu Kuai wrote:
> 
> 在 2023/06/29 21:32, Sudip Mukherjee (Codethink) 写道:
>> The latest mainline kernel branch fails to build x86_64, arm64 and arm
>> allmodconfig

Thx for the report.

> Thanks for the testing, which branch are you testing?
> 
> This problem is already fixed in latest mainline kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b5a99602b74bbfa655be509c615181dd95b0719e

And thx for the reply. :-D

FWIW, that fix afaics is still in -next and hasn't reached mainline yet.
But I guess that will change within a few days.

>> #regzbot introduced: 8295efbe68c080047e98d9c0eb5cb933b238a8cb

#regzbot fix: b5a99602b74bbfa6
#regzbot dup-of: https://lore.kernel.org/all/ZJ2M4yqnOCqqGWH0@debian/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
