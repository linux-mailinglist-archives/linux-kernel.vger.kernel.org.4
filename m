Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFA655919
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLXIQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLXIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:15:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF97B4AB;
        Sat, 24 Dec 2022 00:15:56 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p8zhC-0001iT-N5; Sat, 24 Dec 2022 09:15:54 +0100
Message-ID: <3ca60b3e-4f7e-5a31-b74e-e4f01e576430@leemhuis.info>
Date:   Sat, 24 Dec 2022 09:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [git pull] Input updates for v6.1-rc5
Content-Language: en-US, de-DE
To:     Aman Dhoot <amandhoot12@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <940462e95c8eea934b8823aa189dbddece6bee95.camel@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <940462e95c8eea934b8823aa189dbddece6bee95.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671869756;7a9c16e5;
X-HE-SMSGID: 1p8zhC-0001iT-N5
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Dmitry]

Hi, this is your Linux kernel regression tracker.

On 24.12.22 08:49, Aman Dhoot wrote:
> If I use synaptics touchpad in legacy PS/2 mode.keyboard and touchpad
> stop working randomly because of TLP, if I uninstall tlp it resolves
> the keyboard touchpad stops working randomly issue. But I see good
> battery life in my system using tlp by switching touchpad from legacy
> PS/2 mode to RMI mode resolves the problem. this way i can use tlp and
> keyboard touchpad works without any problem.
> 
> In my dmesg log I don't have msg "psmouse serio1: synaptics: SMbus
> companion is not ready yet".

Well, if I got this right the situation is like this: your change
ac5408991ea6 ("Input: synaptics - switch touchpad on HP Laptop
15-da3001TU to RMI mode") breaks things for some users and hence will be
reverted per the "no regressions rule" (
https://docs.kernel.org/process/handling-regressions.html ).

To get this reapplied someone needs to work with those people that are
affected by the regression to ensure this continue working if the
touchpad is in RMI mode (maybe it depends on the BIOS, the revsition,
the kernel config, or something else). IOW: a better change is needed
that doesn't break things for others. If that's not possible maybe there
is some other solution for you. Is there maybe a kernel parameter you
can apply to switch the device to RMI mode on your machine?

HTH, Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
