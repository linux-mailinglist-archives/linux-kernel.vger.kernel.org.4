Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4141609AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJXG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXG6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:58:10 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Oct 2022 23:58:06 PDT
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1395EDE7;
        Sun, 23 Oct 2022 23:58:02 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id 74882B4357B;
        Mon, 24 Oct 2022 08:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1666594252;
        bh=3DmqS6uviGKDrbnLwBKbh5oj+ySmwKcSbnQtg2IBmBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OjYEM7mqjlZ7R3UD6qIqDUZ7wFi/IjeWGsso4J6ivIr/FHP65U1yfilwdGB1Vi2gL
         jcxbrYWnn6yKJlwXK5M1BtYToTgl1tM0nL2zc6Rbjro0rGxTKlqHdt0sghmiR4/Edp
         ZLzQ6mG2qAROWja3/SCtR9PiaaAwcnMapnlOfA456eufVxWV/2hrso0QaAZv2Q2kcm
         aBXOnBpf2muuOunNGkmD6neKVNM0en/QB7FBhJuJDMz4br4dIRFnQUp/tPcfDlW8PM
         bkiWFqGcAQE1Lanm4gol9Cy1u5OIn7XywTakSmxb2l7l9+cbohmJTdKu1pj6yMWh+o
         P6UaJrDrp4y3A==
Date:   Mon, 24 Oct 2022 08:50:47 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <Y1Y1x0heHVqIXjJ4@francesco-nb.int.toradex.com>
References: <20221024153720.5e387e34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024153720.5e387e34@canb.auug.org.au>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:37:20PM +1100, Stephen Rothwell wrote:
> In commit
> 
>   c9545754e9a7 ("arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci")
> 
> Fixes tag
> 
>   Fixes: 1d8df9c74bff ("arm64: dts: freescale: add initial support for verdin imx8m plus")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")
correct, sorry for the mistake :/

Shawn: I assume you can fix it, let me know otherwise.

Hopefully since commit  bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")
was merged these kind of mistakes should be less and less frequent.

Francesco
