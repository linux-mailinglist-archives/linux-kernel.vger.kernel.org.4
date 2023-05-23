Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE670DAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjEWKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjEWKfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:35:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E2FE;
        Tue, 23 May 2023 03:35:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1PMI-0003Ci-MT; Tue, 23 May 2023 12:35:14 +0200
Message-ID: <0bef4bea-1404-061c-cbbf-e874302367f7@leemhuis.info>
Date:   Tue, 23 May 2023 12:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Content-Language: en-US, de-DE
To:     Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBHOMpWT2E4w+Zu=f8QCg+YiDU_9gY4bpJSGBLMnC8B9A@mail.gmail.com>
 <403ea30e55a9667684cd1f8d2d3a641efda9976f.camel@collabora.com>
 <4995215.LvFx2qVVIh@bagend>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <4995215.LvFx2qVVIh@bagend>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684838118;169df020;
X-HE-SMSGID: 1q1PMI-0003Ci-MT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 20.05.23 00:34, Diederik de Haas wrote:
> 
> On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
>> Le jeudi 13 avril 2023 à 10:10 -0300, Ezequiel Garcia a écrit :
> [....]
> 
> When I booted into my 6.4-rc1 (but also rc2) kernel on my
> Pine64 Quartz64 Model A, I noticed a crash which seems the same as
> above, but I didn't have such a crash with my 6.3 kernel.
> Searching for 'hantro' led me to this commit as the most likely culprit
> but when I build a new 6.4-rcX kernel with this commit reverted,
> I still had this crash.
> Do you have suggestions which commit would then be the likely culprit?
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced db6f68b51e5c
#regzbot title media: verisilicon: null pointer dereference in try_fmt
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
