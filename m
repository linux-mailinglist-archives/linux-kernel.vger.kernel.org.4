Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813475EA07C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiIZKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiIZKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A051423
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F080560BB7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFA1C433C1;
        Mon, 26 Sep 2022 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664187719;
        bh=usr/WNutJ8gvA/9XeFhOAnzMol9l5z02yq/CCnGgKtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGQkjBtjpGO6NZkE/44YETSjRY1Z8vH+a2q7L0WOiK0/lgDbxo+a/1Jn33Pw0LTLN
         gEvhx+QRZeX/GVxP+vRApl94h9/B2I3MrHuH2c9zbReB8vi/9lfj2JlPyQdbjS3CHU
         E0N4xz4bTrhIcfJ1/RR/ojhtDevhTghfd0SxIcNq6NggYHxv3mBo4f+7AgyHaW2pPa
         ZBUSQiQr3Daswax26hZYTlXLA+U9WYNwf+MIwiiapustP0o17M0P0OyIfLh9F68FHD
         lFscCGX8p6ezElm9JgjHSN2vau5DWXydJkJCBwZwKE2etatqpUITyQlrrmyaR9E+Mw
         mfR/JSA5zXc3A==
Received: by pali.im (Postfix)
        id B5AD48A3; Mon, 26 Sep 2022 12:21:56 +0200 (CEST)
Date:   Mon, 26 Sep 2022 12:21:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC"
 compatible string
Message-ID: <20220926102156.y6lliukcswbrnanh@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-8-pali@kernel.org>
 <9436f041-ba6d-0297-4026-e281acc7dbad@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9436f041-ba6d-0297-4026-e281acc7dbad@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2022 10:10:19 Christophe Leroy wrote:
> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> > "fsl,P2020RDB-PC" compatible string was present in Turris 1.x DTS file just
> > because Linux kernel required it for proper detection of P2020 processor
> > during boot.
> > 
> > This was quite a hack as CZ,NIC Turris 1.x is not compatible with
> > Freescale P2020-RDB-PC board.
> > 
> > Now when kernel has generic unified support for boards with P2020
> > processors, there is no need to have this "hack" in turris1x.dts file.
> > 
> > So remove incorrect "fsl,P2020RDB-PC" compatible string from turris1x.dts.
> 
> Oh, I thought it was not possible to modify DTSes.

Boards which have hardcoded DTB binaries in bootloader or are
kernel out-of-tree, they obviously needs to be still supported by
kernel.

> If it is, can you have a common compatible to all p2020, for instance 
> "fsl,p2020', so that you can use it in patch 5 instead of 
> of_find_node_by_path("/cpus/PowerPC,P2020@0") ?

I can add fsl,p2020. But it does not solve issue for other boards.

This string fsl,p2020 is not used by any board (yet).

Also Turris 1.x boards have burned some older DTB file in Flash NOR.

So it is problematic.

> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >   arch/powerpc/boot/dts/turris1x.dts | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> > index 12e08271e61f..69c38ed8a3a5 100644
> > --- a/arch/powerpc/boot/dts/turris1x.dts
> > +++ b/arch/powerpc/boot/dts/turris1x.dts
> > @@ -15,7 +15,7 @@
> >   
> >   / {
> >   	model = "Turris 1.x";
> > -	compatible = "cznic,turris1x", "fsl,P2020RDB-PC"; /* fsl,P2020RDB-PC is required for booting Linux */
> > +	compatible = "cznic,turris1x";
> >   
> >   	aliases {
> >   		ethernet0 = &enet0;
