Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F516080F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJUVzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJUVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:55:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CF5125036;
        Fri, 21 Oct 2022 14:55:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a3so7149208wrt.0;
        Fri, 21 Oct 2022 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uywRKkGBOBzaRpAeKnVzx5xH6NmY5amHDeoPWUqrzj4=;
        b=obZPWL4hwjCx5D18OHcuK4+/lvgCkHJOTkz7r2RXH1oV+8ut6II7Dl8Ih48l7WzHtE
         2FqsaH+FBrdORZ8E/hQC9qDozE92aWbtncThnynxxzCCd62XnRS9a/TnECJBzKNdVu6n
         M8Due3bQKWefFH5YkkyjB7Z9P2PhEgbmXpPJ6o7Dmg9JjNjCj46+E1Bb1oo1CQ7XShgh
         kphPLzJ/iIBiEuNOLfu1whjwuuB0DaazLRhfkZSEUvu+VKfwFTSlCDY8TttZFxKG4xsZ
         71PATjaDxtUslEVEY0r/gdNR7sa8jsJfQp9kzUDeRxBlGrh//8j6Wn+/6C8YOIxSSHD8
         dtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uywRKkGBOBzaRpAeKnVzx5xH6NmY5amHDeoPWUqrzj4=;
        b=KaNM34wZYLaoSxVp1ejcTf7Kba+oyfN5czDLmzC6SCYIRvU0KVbFd9DT/dEUBD7DXn
         tvkEAc1cwsELTEyXOfsaRW6yOW9RE8noOUa19DA0PD7XHRAdhaHe7WbG0Apzg2cwG8UT
         A+vcB2GNA03RtlrxLrCruj6Saz1aRRb9PbQEAVVpiszPwaPK//c6fnNShg71rDGJ6fUL
         xy1MBCzcUjSSuR9qf0ty8vKxg7DRdFk4qt5PCUI2GjA9iFIBi8FlSbV0DHAQJnGKMw1d
         AzDomwpKYC7q2TNhtEF0alspdey/qvGsXzgZAE36qLWPuL49iCiaASIrbu0AtXhrQHrq
         cEDA==
X-Gm-Message-State: ACrzQf3P7pfLjQg2d1tJUJBK4+KLpNPOdDc/XgBny4QkUbOOl2LjeGjV
        XJjRTREcUsjtjUrDsxWZrSE=
X-Google-Smtp-Source: AMsMyM5uO/Cq/xpoxJsZqWshH6/XzN1MINSem+X1Eg/d08U/P7gOiM/jicaRCqTzSbJaTlGTOEy32Q==
X-Received: by 2002:a5d:6c62:0:b0:230:55fc:748a with SMTP id r2-20020a5d6c62000000b0023055fc748amr14091890wrz.15.1666389315677;
        Fri, 21 Oct 2022 14:55:15 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003b4ac05a8a4sm897677wmq.27.2022.10.21.14.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:55:15 -0700 (PDT)
Message-ID: <63531543.050a0220.b6bf5.284d@mx.google.com>
X-Google-Original-Message-ID: <Y1MVO0Z+StlGDrIR@Ansuel-xps.>
Date:   Fri, 21 Oct 2022 23:55:07 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:44:56PM +0200, Linus Walleij wrote:
> On Fri, Oct 21, 2022 at 8:10 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add a specific config flag for Qcom IPQ806x as this SoC can't use
> > AUTO_ZRELADDR and require the PHYS_OFFSET set to 0x42000000.
> >
> > This is needed as some legacy board (or some wrongly configured
> > bootloader) pass the wrong memory map and doesn't exclude the first
> > ~20MB of RAM reserved for the hardware network accellerators.
> >
> > With this change we can correctly support each board and prevent any
> > kind of misconfiguration done by the OEM.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> I had exactly this problem with the APQ8060 as well, then my problem
> went away. I was under the impression that this was solved.
> 
> Is it not possible to use Geert's linux,usable-memory-range in
> the chosen node to make the kernel stay off the memory?
> (See examples by grep usable-memory in the kernel.)
> 

Hi,
just to confirm this is one of the example you are suggesting?

chosen {
		bootargs = "console=ttyS0,115200 earlycon";
		stdout-path = "serial0:115200n8";
		linux,usable-memory-range = <0x80200000 0x1fe00000>;
	};

Main problem here is that uboot in some case doesn't support dt and pass
wrong ATAGS (with the memory not reserved) and AUTO_ZRELADDR calculate
the wrong addr I assume?

I will test the usable-memory-range but isn't the same of declaring
reserved space in the dts? Or the zimage decompressor checks
linux,usable-memory-range bypassing atags?

-- 
	Ansuel
