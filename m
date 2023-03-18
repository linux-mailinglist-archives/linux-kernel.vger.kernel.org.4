Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464516BF8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCRIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCRIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:05:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45D11B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:04:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pdRYO-0003hE-Mv; Sat, 18 Mar 2023 09:04:40 +0100
Message-ID: <9a174e48-5cd6-535f-4f01-4e81398e772f@leemhuis.info>
Date:   Sat, 18 Mar 2023 09:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [FIRMWARE] Regression on rtw89/rtw8852b_fw.bin by the latest
 update
Content-Language: en-US, de-DE
To:     Takashi Iwai <tiwai@suse.de>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-firmware@kernel.org, linux-kernel@vger.kernel.org,
        Josh Boyer <jwboyer@kernel.org>
References: <878rfuo67a.wl-tiwai@suse.de>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <878rfuo67a.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679126684;3a5205e8;
X-HE-SMSGID: 1pdRYO-0003hE-Mv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.03.23 08:43, Takashi Iwai wrote:
> 
> we've received a regression report on openSUSE Tumbleweed about the
> Realtek WiFi, and the culprit was spotted to be the latest firmware
> update of rtw89/rtw8852b_fw.bin.  The former working linux-firmware
> tree was at the commit 5c11a3742947, while broken at 5bc279fb161d.
> 
> The details are found in:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1209449
> 
> Could you check the problem?
> (Or feel free to join to the bugzilla entry above.)

FWIW, I already CCed Josh on the following bug yesterday in a comment
where I suggested the updated firmware should be reverted:

https://bugzilla.kernel.org/show_bug.cgi?id=217207

But it's likely a good idea to write a normal mail, so thx for that!

FWIW, the issue is also discussed here:

https://lore.kernel.org/all/df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com/#t

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
