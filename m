Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9169AB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:17:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9236780D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:16:46 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSzfM-0000my-46; Fri, 17 Feb 2023 13:16:40 +0100
Message-ID: <8a998aba-7e71-da0d-6167-304dea3f2077@leemhuis.info>
Date:   Fri, 17 Feb 2023 13:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216904_-_backlight_brighn?=
 =?UTF-8?Q?ess_control_with_video_missing_/sys/class/backlight_interface?=
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     walter59 <walter.moeller@moeller-it.net>,
        Adrien <kernel@asdrip.fr>, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <57e2f165-4d4a-d8bc-47c0-1b0609cd2147@leemhuis.info>
In-Reply-To: <57e2f165-4d4a-d8bc-47c0-1b0609cd2147@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676636206;c973afb2;
X-HE-SMSGID: 1pSzfM-0000my-46
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 12.01.23 15:14, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216904 :

#regzbot inconclusive: it appears that dropping acpi_backlight=vendor
solves this
#regzbot ignore-activity

(at least it did for somebody else that was affected by this; the
reporter did not respond in a while)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


