Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13936A2869
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBYJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBYJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:29:23 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E17FF03;
        Sat, 25 Feb 2023 01:29:20 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pVqrh-0000TL-HG; Sat, 25 Feb 2023 10:29:13 +0100
Message-ID: <1c222195-8fec-5067-c382-78dfd2505974@leemhuis.info>
Date:   Sat, 25 Feb 2023 10:29:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <Y/nSJvm6h4Sq5PR2@duo.ucw.cz>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
In-Reply-To: <Y/nSJvm6h4Sq5PR2@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1677317361;72dcdd09;
X-HE-SMSGID: 1pVqrh-0000TL-HG
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.23 10:17, Pavel Machek wrote:
>> +If your platform uses techniques like Secure Boot, prepare the system to permit
>> +starting self-compiled Linux kernels; install compilers and everything else
>> +needed for building Linux; make sure to have 15 Gigabyte free space in your home
>> +directory. Now run the following commands to download the sources of Linux,
>> +which you then use to configure, build and install your own
>> kernel::
> 
> 15GB is quite a lot. Maybe the shallow clone should be given another
> chance?

It got and made it, see v2:
https://lore.kernel.org/all/8cfcf069d48c1b8d7b83aafe0132f8dad0f1d0ea.1676400947.git.linux@leemhuis.info/

>> +       mkdir ~/linux/ ~/linux/sources ~/linux/build
>> +       git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
>> +         ~/linux/sources
>> +       cd ~/linux/sources/
>> +       # hint: if you don't want to build any stable or longterm kernels, skip the
>> +       #   next two commands
>> +       git remote add linux-stable \
>> +         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> +       git fetch --all
>> +       # hint: if you want to apply patches, do it at this point (see below for details)
>> +       # hint: at this point it's recommended to tag your build (see below for details)
>> +       yes "" | make O=~/linux/build/ localmodconfig
>> +       # hint: at this point you might want or have to adjust the build configuration
>> +       #  (see below for details)
>> +       # note: if you are running a Debian kernel, you'll have to adjust the configuration
>> +       #  at this point (see below)
>> +       make -j $(nproc --all) O=~/linux/build/
> 
> Is the complexity of using O= worth it for one-off kernel builds?

That is a good question. I seemed like the right thing to do when I
started writing this guide (maybe just because I've been doing it that
way for ages), but now that you ask I'm unsure myself.

/me wonders how others feel about it

Ciao, Thorsten
