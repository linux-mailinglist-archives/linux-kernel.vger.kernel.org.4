Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46D363EAE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLAIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:16:16 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A25A6C6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:16:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 13C5F20002;
        Thu,  1 Dec 2022 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669882573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4MkZ3sR/CieRO5Y5T285rm+ZZ3CxzFEax+W5AvLe8o=;
        b=OG2i/MW1w6OfsxAC0zu1BkQwIE6Lf3XuECRvvwM9341jJC4kAKLifUdmWGWZwCJmGcCCIk
        2WHMHLp0Zd4hmoE9ZrKyKx6gbIXEzbILEacZzqmw85hh2rfmzG1ViUu0wyagxHgkWUv5+u
        XfJR46d/Iv7J02srCdTlKnTOgrFcPTdTfiFtB3tUTfyvlJscn0vGiRJox2AQCg8jPXYWZN
        /zn4mHcScygqZ0QpsDa5FzHSye6tFxnF6v9P8icmJsLMLZ7N2tcKPgWqbTklb+Al+orMy9
        bW5S8sJB0tBC1WQ8hJAmNoMqvmf7Yg5hT2+TjJMrpghBsgyiWR1PZcPUDXdoDg==
Date:   Thu, 1 Dec 2022 09:16:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __udivdi3
Message-ID: <20221201091610.524f7786@xps-13>
In-Reply-To: <202212010140.pIueEBNb-lkp@intel.com>
References: <202212010140.pIueEBNb-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail, Hiroshi,

lkp@intel.com wrote on Thu, 1 Dec 2022 01:46:36 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   01f856ae6d0ca5ad0505b79bf2d22d7ca439b2a1
> commit: 9b78ef0c7997052e9eaa0f7a4513d546fa17358c mtd: parsers: add suppor=
t for Sercomm partitions
> date:   6 months ago
> config: mips-randconfig-r033-20221128
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4c=
ea55f0d1104408b26ac574566a0e4de48036)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D9b78ef0c7997052e9eaa0f7a4513d546fa17358c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9b78ef0c7997052e9eaa0f7a4513d546fa17358c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> ld.lld: error: undefined symbol: __udivdi3 =20
>    >>> referenced by scpart.c
>    >>>               mtd/parsers/scpart.o:(scpart_parse) in archive drive=
rs/built-in.a =20
>=20

Can you please try to reproduce this with a mips toolchain as advised
and send a fix?

Thanks,
Miqu=C3=A8l
