Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B265B7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjABW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjABW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:57:00 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEBE2B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:56:59 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-142b72a728fso35058277fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5ZFrVz/+1XjInZUjv7Y6rmZIp9i9rvFxOt0jc6nX/4=;
        b=eXIe7vHJw4+FLbmQgrPgJvyiZcDTge2JG0j+ZJtloLYvAS/sbaYJurUmB1WcV846CD
         kwtyqxORtQyXi8LK9b6o5G9CGJqvuSTXG4cdrK171yVooIMvTl2bqfNsjOebNELBVjBr
         vvJaKEtLFq9+wrSDSWXGJZtAcx1fh/X0kucAtPoKJuFDVteYAG6vrayH2y/hNjgxQThP
         P3nvCCwnlXx1ONOsGQlyyl6HLEAm0ZgT14IYbXwwDdLGZloecT7zYNwQcjFhgMsQVPQJ
         vFQFBbkwxRt6ZbPV0MX2Rbta9u4hBfAXGPbzNiM4n3SdEyc6TIo+6HZSLgXRUB4lJawz
         5xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5ZFrVz/+1XjInZUjv7Y6rmZIp9i9rvFxOt0jc6nX/4=;
        b=PvSruB4ToZqbe3vHCvB+rAnkEtF6IRY5WrzrFaKnbq66Tne0eK7kW4hZOLnF4h+5px
         +lSeHTs95gJMdnqu+eW4K2UAFlJjU+b/rcKDpwvTNFUQmiuEkDHi9s04xum1XdT1UFHs
         pI+vUcdBp7pJEUFvxGRA+VgB6nYuHkSxuLWOow7v+vxiIranhDp4bX8J7o4gWOrCuyK9
         4+16tDkkQ9b8WdbkrCz5owDxujJF2vPIHH/zOLlJpd+xkITU9rUtZyhIORDKqDw7Z+lm
         KpaA/+QX5cNmKl+8zxxX+Ax/hPTtGLKyIn6zG1S5EKnKy3Gu+QOdBQQ2wUJLPZIzqW7B
         nkww==
X-Gm-Message-State: AFqh2kqgUj9xsomVepWLEkAGDWzVn/xpetQnaArx4AyTN7VjbHJEMg78
        bTAdIBuUJbO/yesCbKtODuYfoBjISBQ=
X-Google-Smtp-Source: AMrXdXuL60aHlFFXyJjJo1aFXXoVRnmIsdREy//M2NxFJ2/mKYxDTexwZZC8XN9UBLxAKob2aM85Ug==
X-Received: by 2002:a05:6871:112:b0:14f:c8ca:df03 with SMTP id y18-20020a056871011200b0014fc8cadf03mr18019710oab.44.1672700218585;
        Mon, 02 Jan 2023 14:56:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20-20020a056870631400b0014be94a12d0sm13518899oao.44.2023.01.02.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:56:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 Jan 2023 14:56:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc2
Message-ID: <20230102225656.GA3532398@roeck-us.net>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 02:01:04PM -0800, Linus Torvalds wrote:
> So the week started so slow due to the holidays that I thought I might
> not have any reason to do an rc2 at all, but by the end of the week I
> did end up getting a smattering of pull requests, so here we are. It's
> tiny, even smaller than usual for an rc2, and honestly, I'd expect
> that trend to continue for rc3. A lot of people are still off for
> another week on a well-deserved winter holiday, and so I suspect
> things will continue to be fairly quiet.
> 
> Anyway, last week saw mainly some nvme fixes, some i915 drm work, and
> some kvm fixes (and kvm testing fixes). See below for the full
> shortlog, and if you're not still in a food coma from the holidays,
> please do give this all a good testing.
> 

Build results:
	total: 155 pass: 151 fail: 4
Failed builds:
	powerpc:allmodconfig
	sh:defconfig
	sh:shx3_defconfig
	xtensa:allmodconfig
Qemu test results:
	total: 500 pass: 498 fail: 2
Failed tests:
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:zynq-zed:rootfs

Same as last week, so I won't go into details for the above failures.

One detail to mention, though, is that sh:rts7751r2dplus_defconfig
no longer builds with older versions of binutils (2.32). Trying to
do so results in the following build error.

`.exit.text' referenced in section `__bug_table' of drivers/char/hw_random/core.o:
	defined in discarded section `.exit.text' of drivers/char/hw_random/core.o

To make this more interesting, kernels older than v5.10 do not boot
(at least not in qemu) when images are built with binutils 2.27 or newer.
That is why I had used binutils 2.32 in the first place.

I didn't bother tracking this down but switched to binutils 2.39 when
building v5.10+ images.

Guenter
