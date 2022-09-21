Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2695BF97C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIUIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIUIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAC3A48A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:40:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92580FF808;
        Wed, 21 Sep 2022 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663749607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH68prWr+K6M/+VJN9mzBk6EPAXOvKLVuiYE0zxGZhw=;
        b=Y/YVy0AYv5xSD1rLRsws62bKktXHFgH5j56412XfcXvwjPG+kKQGANrM/mpAYWax33jv2S
        vZzKtPKH1DKS811KpQ7LvZW+sO5WIuAp/JgtRkF1Orq00jY70w17oH9k8NT327PMHKLA0j
        1zPqh/K56pYtNqn0uaOOywpbBcTXbYam11imD4zg8DuRHTuPv8ZcSchelLO0MnkjrTwhgk
        5ewiaDtCC67j0mVFvU/LUhVqOAC851zBtzT1+IzluBFwpXbrNqZMaoE4iUZwI7z6IZBESm
        UCCyrMrOGXzC0KDXzr42t4rsLd0h3G9FAflmPwHC0xAMU9KdPmpGWGbovQINhA==
Date:   Wed, 21 Sep 2022 10:40:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Valentin Korenblit <vkorenblit@sequans.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <20220921104002.226ff3f6@xps-13>
In-Reply-To: <202209210641.MziHAbW7-lkp@intel.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

lkp@intel.com wrote on Wed, 21 Sep 2022 06:31:23 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nan=
d/next
> head:   63de24fccb6b831be1abfe07292449105b467731
> commit: 7e7dc04774b18c0e42ce74aa3357021cda979674 [11/31] mtd: rawnand: ca=
dence: support 64-bit slave dma interface
> config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/2=
0220921/202209210641.MziHAbW7-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c=
006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/c=
ommit/?id=3D7e7dc04774b18c0e42ce74aa3357021cda979674
>         git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/gi=
t/mtd/linux.git
>         git fetch --no-tags mtd nand/next
>         git checkout 7e7dc04774b18c0e42ce74aa3357021cda979674
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/mtd/nand/raw/
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit=
 declaration of function 'ioread64_rep' is invalid in C99 [-Werror,-Wimplic=
it-function-declaration] =20
>                            ioread64_rep(cdns_ctrl->io.virt, buf, len_in_w=
ords);
>                            ^
> >> drivers/mtd/nand/raw/cadence-nand-controller.c:1962:4: error: implicit=
 declaration of function 'iowrite64_rep' is invalid in C99 [-Werror,-Wimpli=
cit-function-declaration] =20
>                            iowrite64_rep(cdns_ctrl->io.virt, buf, len_in_=
words);
>                            ^
>    2 errors generated.

I've dropped your patch from nand/next, here you can check what's
missing in the configuration, should not be too hard to solve. Once
done, you can send a new version of the patch.

Thanks,
Miqu=C3=A8l
