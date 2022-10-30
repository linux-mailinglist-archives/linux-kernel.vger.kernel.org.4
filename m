Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E4612D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ3Wj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Wjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:39:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886CC67;
        Sun, 30 Oct 2022 15:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A927DB81076;
        Sun, 30 Oct 2022 22:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7722FC433D6;
        Sun, 30 Oct 2022 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667169591;
        bh=fi2z2xdBZG+ZUhsFZgwdsYmEXIU71T3LaQVeEQbiMY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFYkSOB4+cqCBr4ZCjAsldhFCevfK7SLcO21fyHIB7T9Gc0zTrUK1m6fljfkLI9BZ
         tp4nArWbcQcsVL98IYR/6mRqaiIYdh86GMmwf7NrfpCD2DbxQkjtjrLysW8zSR5DdC
         EJLmL4fBIOEi3oM7+O5cjgN9xNjF+iCLi41Aopzw5B+P0Ot+rHSzS1l1f/HX9wp9pP
         bpqofbGEkee+Shkrwdc+y3nzdY/Ja2jvwhRQfF5Pt838BZfG7BN6TufWtuVXwAGK/D
         JyNxOovUYiZXujAW/pR16ZGoF1a2ldNHeq6lhGZFjM31wUiBUUAkBA5N7VXzc7cPHa
         Z9nR4bT2mdgQw==
Date:   Sun, 30 Oct 2022 22:39:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
Message-ID: <Y179MD6Jupj9n4NA@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
 <CA+V-a8vBkHhTtq6Veb2vn-6o4S5Ter==yN6TFhYQvxko_Bk2LQ@mail.gmail.com>
 <CAJF2gTSQH0q4PoucBgr3abWWA+XCdxm1tk1j8Sqydt_XyCq2RA@mail.gmail.com>
 <Y16/YQTOW3DuQvo9@spud>
 <CA+V-a8vCNx-bqjeOa13LewaEJOGW-0ypqJTvZo7om6XcM4T7UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vCNx-bqjeOa13LewaEJOGW-0ypqJTvZo7om6XcM4T7UA@mail.gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 10:27:17PM +0000, Lad, Prabhakar wrote:
> Hi Conor,

> > > You could just move the below part to the second dtsi patch. Then
> > > compile won't be broken.
> > >
> > >             clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
> > >             power-domains = <&cpg>;
> > >             resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
> >
> > The makefile for this directory is not added until the next patch right?
> > The compile shouldn't be broken here since it therefore cannot be
> > compiled?
> >
> These nodes are already present in the kernel [0]  so the makefile
> change in the next patch if made here still won't break the
> compilation alone of SoC DTSI (included in dts).

Yeah I know, I did actually build the dtb ;)
I was just confused as to how Guo Ren had found a build issue with this
patch that the follow on patch would fix, when this dtsi is not
buildable in this patch.

