Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F54726188
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjFGNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjFGNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:41:20 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66A1993;
        Wed,  7 Jun 2023 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=weTsNa/aQfsqyuD7bkRBH5TGRyXwe4FROvXAAHBykPY=; b=1lHRuvHhjAdpmqwGzMJFu4g1ST
        tYCdOkFASsKT9rMkvbCJHAnM3La4FjLd01aW8JVAjqCdKFVOcu+N3MFM5ZYCOad0erWU8vPyOMTIi
        0UMrX09ofC04RtI1AmlyoffTP4vG1JCG9364cpbMEh0LuAjCB/hoezpoYoJF+y9XSmPk+4xiitFZo
        eEMyxfajUBGJ+jvzJT0QZHNFQAeoRo/e6uXaLM13IWwvjg0/oqLi1XG7GYE93G1aTV30lNgAXn2Nz
        bn119o2jqiEh1t3T79DmkeE5L5JwhmRRIdgEMVS5olm2+nI6SDyvPHu3Ynw1HygVKwFTjm1onwblb
        Z9W/1scg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35120)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q6tPR-0007XX-3W; Wed, 07 Jun 2023 14:41:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q6tPK-0008H4-Cs; Wed, 07 Jun 2023 14:41:02 +0100
Date:   Wed, 7 Jun 2023 14:41:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Aithal, Srikanth" <sraithal@amd.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        maxime.chevallier@bootlin.com, joyce.ooi@intel.com
Subject: Re: arm: shmobile_defconfig: ld.lld: error: undefined symbol:
 lynx_pcs_destroy
Message-ID: <ZICI7oSeEfB8TbKV@shell.armlinux.org.uk>
References: <CA+G9fYv0a-XxXfG6bNuPZGT=fzjtEfRGEYwk3n6M1WhEHUPo9g@mail.gmail.com>
 <CA+G9fYueN0xti1SDtYVZstPt104sUj06GfOzyqDNrd3s3xXBkA@mail.gmail.com>
 <CAMuHMdX7hqipiMCF9uxpU+_RbLmzyHeo-D0tCE_Hx8eTqQ7Pig@mail.gmail.com>
 <9fc1d064-7b97-9c1a-f76a-7be467994693@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fc1d064-7b97-9c1a-f76a-7be467994693@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:57:17PM +0530, Aithal, Srikanth wrote:
> On 6/6/2023 2:31 PM, Geert Uytterhoeven wrote:
> > Hi Naresh,
> > 
> > On Tue, Jun 6, 2023 at 10:53 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > > On Tue, 6 Jun 2023 at 14:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > Following build regressions found while building arm shmobile_defconfig on
> > > > Linux next-20230606.
> > > > 
> > > > Regressions found on arm:
> > > > 
> > > >   - build/clang-16-shmobile_defconfig
> > > >   - build/gcc-8-shmobile_defconfig
> > > >   - build/gcc-12-shmobile_defconfig
> > > >   - build/clang-nightly-shmobile_defconfig
> > > 
> > > And mips defconfig builds failed.
> > > Regressions found on mips:
> > > 
> > >    - build/clang-16-defconfig
> > >    - build/gcc-12-defconfig
> > >    - build/gcc-8-defconfig
> > >    - build/clang-nightly-defconfig
> > 
> > Please give my fix a try:
> > https://lore.kernel.org/linux-renesas-soc/7b36ac43778b41831debd5c30b5b37d268512195.1686039915.git.geert+renesas@glider.be
> On x86 as well seeing couple of issues related to same, not on defconfig
> though..
> 
> ERROR: modpost: "lynx_pcs_destroy"
> [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!
> ERROR: modpost: "lynx_pcs_destroy"
> [drivers/net/ethernet/altera/altera_tse.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> make: *** [Makefile:1984: modpost] Error 2
> 
> Among above issues stmmac issue would be resolved with above mentioned fix.

Patches are in progress to resolve this issue (on netdev), please be
patient.

Even better would be to check netdev for the patches, review them, and
give them a test, and provide feedback, which will help get them
merged.

Latest version can be found here:

https://lore.kernel.org/netdev/20230607135941.407054-1-maxime.chevallier@bootlin.com/T/#t

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
