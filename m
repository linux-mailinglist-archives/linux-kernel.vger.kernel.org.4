Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600F631750
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKTX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:27:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719417A92;
        Sun, 20 Nov 2022 15:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB0CACE0CE4;
        Sun, 20 Nov 2022 23:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C15C433C1;
        Sun, 20 Nov 2022 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668986866;
        bh=Tx2o5MRqUNtnBVS6RiWQrUpDRS8DDJptpeqkVFtVZs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSCAd1e5FUaX1dHMO4y/QlWqswsoYkS0YQBgWsZaDFmG/ac/I3eFNPweZ5y0PDY+L
         Kvupz26elOUQKjIQjPjsZZFLB6Vt0ItQgJXGkmCMjDPcxHsjlKmyOxapyI4NbxFC3F
         i92x549nfRwy3GQ69bV8FrUOrGnWDASjy9ON6hCg6FgpS8M+QtdoFknSx+MAXKRQYE
         tnDqT5dDmIY1eawQdflEc0J5UpTSbL4y0/Dyu8cfzmgAHg7Ny7O3SJHlbv5FTxjB3U
         LbyskcaAYdYQJhVtpRJkVJaKNa/49i/epE0RQkpAGTDgnMwOCU6SuZiix4uCHe55N4
         +0gE0RgwrzLdA==
Date:   Sun, 20 Nov 2022 23:27:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: linux-next: manual merge of the riscv-dt tree with the renesas
 tree
Message-ID: <Y3q37h2NkupDFL+E@spud>
References: <20221121102318.40c58114@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121102318.40c58114@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:23:18AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the riscv-dt tree got a conflict in:
> 
>   Documentation/devicetree/bindings/riscv/cpus.yaml
> 
> between commit:
> 
>   57e1b873c2f5 ("dt-bindings: riscv: Sort the CPU core list alphabetically")
> 
> from the renesas tree and commit:
> 
>   41adc2fbad8b ("dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles")
> 
> from the riscv-dt tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fixup looks good to me Stephen, thanks!

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/devicetree/bindings/riscv/cpus.yaml
> index 2bf91829c8de,e98a716c6f18..000000000000
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@@ -34,12 -33,14 +34,14 @@@ properties
>                 - sifive,e5
>                 - sifive,e7
>                 - sifive,e71
>  -              - sifive,u74-mc
>  -              - sifive,u54
>  -              - sifive,u74
>  +              - sifive,rocket0
>                 - sifive,u5
>  +              - sifive,u54
>                 - sifive,u7
>  -              - canaan,k210
>  +              - sifive,u74
>  +              - sifive,u74-mc
> +               - thead,c906
> +               - thead,c910
>             - const: riscv
>         - items:
>             - enum:


