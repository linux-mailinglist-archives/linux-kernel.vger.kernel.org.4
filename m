Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463865AE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjABIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjABIWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:22:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89726E2;
        Mon,  2 Jan 2023 00:21:45 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCG4f-00088y-RF; Mon, 02 Jan 2023 09:21:37 +0100
Message-ID: <e780abc0-f8e6-5dd2-0926-05d54d85ccd7@leemhuis.info>
Date:   Mon, 2 Jan 2023 09:21:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel
 6.1
Content-Language: en-US, de-DE
To:     Aditya Garg <gargaditya08@live.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "ranky.lin@broadcom.com" <ranky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "marcan@marcan.st" <marcan@marcan.st>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
From:   "Linux kernel regression tracking (#info)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672647705;d7e964bf;
X-HE-SMSGID: 1pCG4f-00088y-RF
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

On 02.01.23 08:46, Aditya Garg wrote:
> Since kernel 6.1, Wi-Fi is failing to work on Macs with the BCM4364 rev 3 chips and journalctl reports that the firmware has crashed.
> 
> The complete journalctl is given here :- https://gist.github.com/AdityaGarg8/a25b187e7f1462798de87e048f4840db
> 
> This bug has been reported by users of iMac19,1 as well as Macmini8,1.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.0..v6.1
#regzbot title net: brcmfmac: Wi-Fi is failing to work on Macs with the
BCM4364 rev 3 chips
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
-- 
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr

Annoyed by mails like this? Feel free to send them to /dev/null:
https://linux-regtracking.leemhuis.info/about/#infomails
