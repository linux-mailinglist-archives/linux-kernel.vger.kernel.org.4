Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F955E80A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIWRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiIWRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:24:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B4148A34;
        Fri, 23 Sep 2022 10:24:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w10so759721pll.11;
        Fri, 23 Sep 2022 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xTYuVXV88Jq9ejH0VawRokchu21QkIYwoPcA6s17uZE=;
        b=kdYsPnOjS7++52BiayFILwNtWpd9oL6kJMfLDqXm/YLYohzKOo3hhMvrPhYHlFfkG+
         pQA6wBWu0GxJGXzOkZdmi8JEbsIEFVNHYiMworiL8hYkSw2Jy/3I4diDvaVHJA3zFBpD
         QFtBHLbzrvWtG+o472wzYC5KZbXFmLQah/ZJ1dc/PkyQ5FQaaATkOrvg6BHT0W8YLFTQ
         X/73lrhlgd5OSjSVmIbxT2tG1iwwb62GAzeP/Uc8mKWs9F632nbwZcOj1+pcmAQQRiod
         dFRJu9f9bfJYlsMyBJ2Obym3+btF7TJH3UFgLqPKh1g6i6vo8wmYaYNJ79DvFzr6Nq4r
         NnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xTYuVXV88Jq9ejH0VawRokchu21QkIYwoPcA6s17uZE=;
        b=OMXC+91UpE9Z241v7hEySkfAxVwVx4kQwJnK3EtwBa3RIpb+SnGt0CEd2D5KWi55yP
         D3Z0AHBPeyfnDGCoSgydXJGwOb3fKQU7ixDdHMpk99WyQtLodKc/yOPbP19aLl2FePz6
         FXeACko4NX761KdQap7ts/PacrU9RJpAqbCqx4DbHIqb1w+ur0AmRyGSXLGLR4hepu+W
         0PkgsjygMSu/xDj8JnykNFySu0DfHFxACwNO4LQObz14etOJN/LoUiH1qbEGybqNilh3
         WrrAibHsusehvliOIHf6qvHM7NrWvrutz2Np2OEbJGynS9gdgFNAh7Xo8bvXuN1d7ZdW
         an/Q==
X-Gm-Message-State: ACrzQf3088s/RMyW+gjF//1E5o3j6EH/UKBll5Qln+8q5LSYPU11ml8r
        lSIVkN45qHonuh573PgnkO4=
X-Google-Smtp-Source: AMsMyM7u6qs/ypTIsuDG6S4wht/tB4kVLXASTqOz/D3hpMJ7xIvfjWM2Srkl7PySgcpJVo+iUCv3hg==
X-Received: by 2002:a17:90b:164b:b0:202:d347:2512 with SMTP id il11-20020a17090b164b00b00202d3472512mr10713163pjb.185.1663953849226;
        Fri, 23 Sep 2022 10:24:09 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b00178650510f9sm6315838plg.160.2022.09.23.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:24:08 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:24:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Message-ID: <Yy3rtQxvOjWoKwry@google.com>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net>
 <YyyZRt5j180KzGqc@nixie71>
 <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
 <Yy3qj432McMJ/5rl@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3qj432McMJ/5rl@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:19:11PM -0500, Jeff LaBundy wrote:
> Hi Quentin,
> 
> On Fri, Sep 23, 2022 at 10:25:58AM +0200, Quentin Schulz wrote:
> > Hi Jeff,
> > 
> > On 9/22/22 19:20, Jeff LaBundy wrote:
> > > Hi Quentin,
> > > 
> > > On Thu, Sep 22, 2022 at 12:12:09PM +0200, Quentin Schulz wrote:
> > > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > 
> > > > This event code represents the firmware source to use at boot.
> > > > Value 0 means using "standard" firmware source, value 1 means using
> > > > "alternative" firmware source.
> > > > 
> > > > For example, some hardware has the ability to force the BOOTROM to load
> > > > the bootloader from a secondary firmware source (say SD card) instead of
> > > > trying with the standard first and then the secondary. This event allows
> > > > the userspace to know which firmware source was requested *in hardware*.
> > > > 
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > 
> > > This does not seem like the right approach, especially since the switch
> > > can easily be flipped after the state is already latched.
> > > 
> > > If the bootloader needs to pass information to the kernel (boot source or
> > > otherwise), a safer and more flexible approach is to share some variables
> > > in eMMC, or pass information using the kernel cmdline.
> > > 
> > 
> > I made a terrible job at explaining what this switch is for, sorry.
> > 
> > Obviously, the state of the switch cannot represent which firmware boot
> > source was used as only the bootloader will be able to tell (since it
> > usually tries storage media in a specific order and the primary boot source
> > could get corrupted at one point in time). Anyway, like you rightfully
> > stated, this is useless "info" and the important one would be passed by the
> > bootloader to the kernel (possibly via Device Tree fixup in case of
> > Aarch64). U-Boot does this to set the memory node so this could be done
> > again with a different property or something like that. Anyways, not
> > something I'm really interested in.
> > 
> > I have a switch on my devkit which implements the BOOT_ALT#/BIOS_DISABLE#
> > functionality from the Q7 standard, see section 3.1.17 Miscellaneous Signals
> > in the specs:
> > https://sget.org/wp-content/uploads/2018/09/Qseven-Spec_2.1.pdf
> > 
> > """
> > BIOS_DISABLE#
> > /BOOT_ALT#
> > Module BIOS disable input signal. Pull low to disable
> > module's on-board BIOS. Allows off-module BIOS
> > implementations. This signal can also be used to disable
> > standard boot firmware flash device and enable an alternative
> > boot firmware source, for example a boot loader.
> > """
> > 
> > This is basically the configuration of the firmware boot source to use for
> > *the next boot*. It does not represent which boot source was used, nor which
> > one will effectively be used.
> > 
> > In our case, this switch electrically disables eMMC and SPI flashes and only
> > allow to boot from SD card (this switch is then electrically overridden by
> > another GPIO at runtime by the bootloader/Linux kernel, but the state of the
> > switch is still available to the user via another GPIO).
> 
> Thanks for the additional detail and the use-case is quite clear; I just
> don't think input is the right home for this. Input makes more sense for
> switches that a user may change during runtime with the expectation that
> an event handler effects some sort of response.
> 
> Such is the case for lid open/close and headphone insertion, but here we
> are just interested in the state of a muxed GPIO.
> 
> > 
> > I have this switch on the board and I want to expose its state to the user,
> > if this new event code is not possible/a good idea what would you suggest we
> > could use?
> > 
> > Note that we already support the same switch but in a different way: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts#n167
> > We are just configuring the GPIOs into the GPIO mode with a pull-up, and
> > then it's up to the user to use gpiod or gpio-sysfs to check the state of
> > the GPIO used for this switch. I don't like this, very not user-friendly and
> > was looking for something better :)
> 
> Actually, that's exactly what I was going to suggest. What in particular
> is not user-friendly about it?
> 
> Of course, this is just my opinion as a fellow customer of input and it
> is ultimately up to Dmitry.

I agree with Jeff that input subsystem is not the right place for this
one-off platform feature. Just having userspace piece observing some
GPIO state should be fine for this. The layers dealing with it and
layers dealing with typical user interaction will be quite different,
so I do not see the reason for including the boot mode into the list
of input switches.

Thanks.

-- 
Dmitry
