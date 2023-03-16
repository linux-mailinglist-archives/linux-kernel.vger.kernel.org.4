Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3966BCC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCPKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCPKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:17:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC65B04AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:17:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so5350152edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678961828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svQbsr3A3CYV2L6LBjooIlbLV7d3XJgH49nuHc0ppU0=;
        b=i2wte9xzxQ86ewcPkIDTT5ACtyIwyNOZP+WRQ+EjTN8H4N+bqfaEis7dnb0MSVwwkf
         K5pXf7htoYR++j92MyaXDET+2noRGPf0wn8BrdPV1IHI0Lzbx23B/Qnrfs3WYAG3nZjN
         eKVy6uoRgnKCMD0+UODG+FLfPNLKoZcc4arkIO7q3RuwiZVNE5b9qFFieTtlfkw8CrGs
         SODC4TzI582YgFiXsP9tAxQHxBrij4dJ+CtvpKcEqvkd2QAJrCvjhXTwiL2Unsf06U5q
         D8zFU+s4F75GnvIZ2fM2VBiVkPCpne0hndyRTuvGVKoKO5uoRGpktIhpAvfkimRT+kK1
         gMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678961828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svQbsr3A3CYV2L6LBjooIlbLV7d3XJgH49nuHc0ppU0=;
        b=LqaOVbTFfYndIecFI7PoU5sh8M6vSzfBgeUSbhhb+zseLHMgzKPTiF8lCru0i94Rai
         TV0YMHNBng/bX1WrnPrUjvMl/onnV2R+yM8XQIvTNSzPlhD5gRPcCQDpzH8j2SDJukTJ
         KBzSRb8wVjpoXWCgWI20Jlcb/PoBG45yMkFbCuM8awobZ1awLDUFJwqZl40VYZ+exbcp
         rB5wDokcKGI2K2kxapOItWnvXfwTltURRqvJZZg9kjezCqd4URuhXRwD81HtYyD1ZlZ+
         ycXV5IBDDrcUkeZ5Q0kz01lXVX8o1/Vw8vCALX/BENZN2RDI27XESN/WpxgTnxznyTUi
         n4xA==
X-Gm-Message-State: AO0yUKW297Kjp7DRQn2QY3Ipl7dURpT34E6FbQ8RPd/ZhglCvyHpNdy6
        1N0I0Ax11oa220XZoFSZpgHPrf+6d+7wD1Cq
X-Google-Smtp-Source: AK7set/W6MqZIQ6MMxv6gQts4zaA93VWDjBldRawSxxrYtThX+ihUvriUisIZyEg8QI7Hz2zBhjmVQ==
X-Received: by 2002:a17:906:1410:b0:8b2:7567:9c30 with SMTP id p16-20020a170906141000b008b275679c30mr10922153ejc.59.1678961827817;
        Thu, 16 Mar 2023 03:17:07 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id r8-20020a170906c28800b00928e0ea53e5sm3653413ejz.84.2023.03.16.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:17:07 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:17:05 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBLsoTBeKbuYbhCi@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
 <20230315150656.GA2938956@dev-arch.thelio-3990X>
 <279821116.9N5E1g01tA@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <279821116.9N5E1g01tA@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 05:24:23PM +0100, Fabio M. De Francesco wrote:
> On mercoledì 15 marzo 2023 16:06:56 CET Nathan Chancellor wrote:
> > Hi Khadija,
> > 
> > On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > > > Aside from what I said and asked for with the other message of this same
> > > > thread, please take note that you can build a specific module if you
> > > > prefer
> > > > not to re-build the whole kernel and other modules at the same time.
> > > > 
> > > > I'm pretty sure that the instructions to do so are in the
> > > > OutreachyFirstPatch
> > > > tutorial.
> > > > 
> > > > If they are not there, please let us know.
> > > > 
> > > > Fabio
> > > 
> > > Hey Fabio!
> > > 
> > > In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> > > the kernel' section there are ways to compile only some part of the
> > > kernel.
> > > 
> > > I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> > > 'nothing to be done for'.
> > 
> > Is CONFIG_XIL_AXIS_FIFO enabled in your configuration?
> 
> @Khadija:
> 
> Maybe that you won't find CONFIG_XIL_AXIS_FIFO among the staging drivers 
> entries while using "make menuconfig" (or the other similar commands for 
> working with the configuration). 
> 
> In that case, first enable the CONFIG_OF option if disabled. 
> CONFIG_XIL_AXIS_FIFO depends on the former. 
> 
> For "CONFIG_XIL_AXIS_FIFO depends on CONFIG_OF" we mean that you can the 
> former if and only if the latter is already enabled. 
> 
> Actually, CONFIG_XIL_AXIS_FIFO depends also on two other options. However you 
> shouldn't worry about those others because they are commonly enabled in more 
> than 99% of PC distributions.
>

Hey Fabio!

I have checked in my .config file and both options are enabled. The file
says,
CONFIG_OF=y
CONFIG_HAS_IOMEM=y

The "make menuconfig" shows 'Xilinx AXI-Stream FIFO IP core driver' with
built-in selection [*].
The problem I am having here is that in the OutreachyFIrstPatch
tutorial, it asks you to change [*] -> [m], but I cannot change it.

Kindly help me with this!

Thank you!
Regards,
Khadija



> > > Should I start with the steps to reproduce? :'(
> > 
> > I did see a report of this same warning occurring with GCC but the
> > report I commented on cane from clang/LLVM; using that toolchain may
> > make it easier for you to reproduce this issue. The robot's reproduction
> > instructions are fine but I think doing it manually is actually simpler.
> > 
> > Ubuntu 22.04 should have a pretty modern version of clang/LLVM, which
> > you can install via 'sudo apt install clang lld llvm'.
> > https://apt.llvm.org is another resource.
> 
> @Nathan: Congratulations, you now have another clang/LLVM adept!
> (Obviously, I'm just kidding :-))
> 
> Fabio
> 
> 
> 
