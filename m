Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CB6BCB06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCPJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCPJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:37:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCEDB79D3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:36:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pck2V-0005ee-ST; Thu, 16 Mar 2023 10:36:51 +0100
Message-ID: <cf688390-8b70-1367-eb8e-48a2fee1a1d5@leemhuis.info>
Date:   Thu, 16 Mar 2023 10:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 217063 - Commit 2232b2d breaks microphone on
 Lenovo "82SJ" Ideapad 14ARH7
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Joseph R <prosenfeld@Yuhsbstudents.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <698e7bfa-09dc-ad74-3eba-ceacd7a29f18@leemhuis.info>
In-Reply-To: <698e7bfa-09dc-ad74-3eba-ceacd7a29f18@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678959417;261b5c04;
X-HE-SMSGID: 1pck2V-0005ee-ST
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 21.02.23 13:44, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217063 :

#regzbot resolve: no longer happens with the latest kernels
#regzbot ignore-activity

For details see https://bugzilla.kernel.org/show_bug.cgi?id=217063#c4


Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



