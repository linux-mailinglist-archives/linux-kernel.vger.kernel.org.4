Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682CE60C045
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJYA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiJYA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:57:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5F1958E6;
        Mon, 24 Oct 2022 16:47:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a5so20830738edb.11;
        Mon, 24 Oct 2022 16:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vv94IJw0kdIEEkWt8rQ9gH30jfzf13dqU9/U5kXWOvU=;
        b=E5kIV0DdN3kQo5cUxiC+zGK6FJkakAHZAXyVKHjDZLCxXz9aDth+XDxdWwK2T1AlTt
         XkK4PsSXmBTQz+rWBwsIusnRCoUNLMS+5VyHSr8g0o8hHA9Jq50GIvPT8F50TJKJ2A08
         /M5MDBDROiWUwsl/WF1RB5N/1JbUTMGZxXV0moLbI/YfHdskn15RH/x5FvxTI2wd5vpb
         dfovIJjpT7lJceN3bV26JBMJu3B0UW0XqXP9IR83ufguB/4gKwErk6R9nstNHx1aIsxV
         XRjPvvsbu1pDic0vQdtX7DPRS5C6FQhoFLUHopNLUlTm8//yAmgDTkHgzXNuULXQSKPB
         Sgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv94IJw0kdIEEkWt8rQ9gH30jfzf13dqU9/U5kXWOvU=;
        b=uhKRFYaBvi7YR/guFcgb0fMOSmYBuXk3OmaE5hbVjdtx4UcgQqETlDqx3X4PLo6XPh
         l5x8ZP+lOPtlUGO8ztYNtFgdUA3YmjL89EdEhlPNQhWR1Xfa30n8Hsw7SZkQTiGV4Pw1
         QmsJFUV0MUaTcwqXS5Wq+XPH6RG8B0amjXo4fcM2U6fvBfhmBV2V0xOXdY6Y8mNSkBxM
         /9ZpFLVaIqSwu04f5VT5GBD7YrCShotPdzutiCaA1I8/SV7xL5OUfhgHYRb5FCcXJaDy
         A8vzblx7UogLARMEu9oJtoTXIY3PxaEVAX9YekkJdSfuyCFffBHirTE+ijjzxQOqCGjE
         3Rig==
X-Gm-Message-State: ACrzQf2cP0UxHwppcdALNf460cANSFqoZZWucdkfpsB7SdJk4FdenTh6
        4m+rcNVcErkIWKV3oLvcgtg=
X-Google-Smtp-Source: AMsMyM5Jb1fSXTeyvNUJkf/S6DJvzmqZGtrY8OuJyVThC3sw0mQWs49D/+/9xmzn0XDBJyhPPNA+YQ==
X-Received: by 2002:a05:6402:1394:b0:456:97cd:e9d4 with SMTP id b20-20020a056402139400b0045697cde9d4mr34194745edv.174.1666655245296;
        Mon, 24 Oct 2022 16:47:25 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id a2-20020a170906468200b007417041fb2bsm505900ejr.116.2022.10.24.16.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 16:47:24 -0700 (PDT)
Message-ID: <6357240c.170a0220.999b2.23d6@mx.google.com>
X-Google-Original-Message-ID: <Y1buJ29mCdJXk3jZ@Ansuel-xps.>
Date:   Mon, 24 Oct 2022 21:57:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
References: <20221021181016.14740-1-ansuelsmth@gmail.com>
 <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com>
 <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 04:21:28PM +0200, Linus Walleij wrote:
> On Fri, Oct 21, 2022 at 11:55 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > On Fri, Oct 21, 2022 at 11:44:56PM +0200, Linus Walleij wrote:
> 
> > > Is it not possible to use Geert's linux,usable-memory-range in
> > > the chosen node to make the kernel stay off the memory?
> > > (See examples by grep usable-memory in the kernel.)
> > >
> >
> > Hi,
> > just to confirm this is one of the example you are suggesting?
> >
> > chosen {
> >                 bootargs = "console=ttyS0,115200 earlycon";
> >                 stdout-path = "serial0:115200n8";
> >                 linux,usable-memory-range = <0x80200000 0x1fe00000>;
> >         };
> 
> Yep that thing!
> 
> > Main problem here is that uboot in some case doesn't support dt and pass
> > wrong ATAGS (with the memory not reserved) and AUTO_ZRELADDR calculate
> > the wrong addr I assume?
> 
> You do have a DTB right, just that it is attached, and then the kernel
> uses the ATAGs to augment the memory?
> 
> In that case what about disabling ARM_ATAG_DTB_COMPAT
> and adding the actual valid memory to the top-level DTS
> file? Just like that:
> 
>       memory {
>                 device_type = "memory";
>                 reg = <0x42000000 0xnnnnnnnn>;
>         };
> 
> 
> > I will test the usable-memory-range but isn't the same of declaring
> > reserved space in the dts? Or the zimage decompressor checks
> > linux,usable-memory-range bypassing atags?
> 
> As long as it just pass "too much" memory it should do the job,
> I *think*.
> 
> Since I wrote this article:
> https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses
> Geert introduced some very elaborate low-level OF code and I
> do think it kicks in and makes sure to reserve this memory even
> before the decompressor goes to work (in difference from e.g.
> "reserved memory nodes" that are not inspected until later).
> 
> See:
> commit 48342ae751c797ac73ac9c894b3f312df18ffd21
> "ARM: 9124/1: uncompress: Parse "linux,usable-memory-range" DT property"
> 
> Then if the memory node is in the DTB originally or patched in
> by U-Boot shouldn't really matter, usable-memory-range should
> kick in in either case.
> 
> It is described as used for kexec (which I never use) but I think it can
> solve your problem too.
> 
> The DT property is (by agreement) an undocumented Linux extension,
> so Geert knows the intended usecases better :)
> 

Hi,
bad news... yesterday I tested this binding and it's problematic. It
does work and the router correctly boot... problem is that SMEM is
broken with such configuration... I assume with this binding, by the
system view ram starts from 0x42000000 instead of 0x40000000 and this
cause SMEM to fail probe with the error "SBL didn't init SMEM".

This is the location of SMEM entry in ram

		smem: smem@41000000 {
			compatible = "qcom,smem";
			reg = <0x41000000 0x200000>;
			no-map;

			hwlocks = <&sfpb_mutex 3>;
		};

On openwrt (kernel 5.10 and 5.15) we currently use a mix of the old Makefile.boot
infra and a patch to ignore atags. With the current configuration we can
correctly bootup the system by passing the load addr to the decompressor
to 0x42000000 (+TEXT_OFFEST) and also use SMEM as it gets correctly init
in the not mapped ram addr.

We are now working on adding 6.1 kernel support and since Makefile.boot
infra got dropped, I'm searching a better solution that can also be
upstreamed, for now PHY_OFFSET seems the only solution.

Wonder if you have other ideas about this.

-- 
	Ansuel
