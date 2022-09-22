Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C85E6305
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiIVM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiIVM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE927E62D1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C864B83646
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB745C433D6;
        Thu, 22 Sep 2022 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663851548;
        bh=kjCrlxn5MWJzNix0IkpTAY0rn59Ak576azpNmksfi9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5K9katgCOicYBFjYNqebhR/FBqYSAD39th+KVN+PAC9y+MQgzQIb/pQ7OwbHKmZQ
         GKvtor2+GsExawlb5oFBdRXWq2hSJaFE3d1Z/mfke4Jph8dkuhtX7d5g4qE8aH3AOY
         XsLtUtehEjdVUDHFJ20uz6ocsDlskarTs1Z1q4KwdqACwsfYqkcxIwA865Kx8KZofP
         C0kH3nhI7A8/K5JMYdRBai9wCFNMFIIKNbogbMPI8U9U/QuspT9IDwMTJYI19UHZwx
         jBUTojf5pqEKZmH17QHFH49t5K9q/0MO51PTxnQ8kXmKZF1Z3FlXUVyFpqzOjTbofu
         ZzCqAmCJROyag==
Received: by pali.im (Postfix)
        id CC26B858; Thu, 22 Sep 2022 14:59:05 +0200 (CEST)
Date:   Thu, 22 Sep 2022 14:59:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Fix labels in DSA cpu port
 nodes
Message-ID: <20220922125905.sk6e55r7eljohkld@pali>
References: <20220827131538.14577-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827131538.14577-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2022 15:15:38 Pali Rohár wrote:
> DSA cpu port node has to be marked with "cpu" label.
> So fix it for both cpu port nodes.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Signed-off-by: Pali Rohár <pali@kernel.org>

Ping?

> ---
>  arch/powerpc/boot/dts/turris1x.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> index 8277e0d7fd91..64c0dd733e40 100644
> --- a/arch/powerpc/boot/dts/turris1x.dts
> +++ b/arch/powerpc/boot/dts/turris1x.dts
> @@ -147,7 +147,7 @@
>  
>  					port@0 {
>  						reg = <0>;
> -						label = "cpu1";
> +						label = "cpu";
>  						ethernet = <&enet1>;
>  						phy-mode = "rgmii-id";
>  
> @@ -184,7 +184,7 @@
>  
>  					port@6 {
>  						reg = <6>;
> -						label = "cpu0";
> +						label = "cpu";
>  						ethernet = <&enet0>;
>  						phy-mode = "rgmii-id";
>  
> -- 
> 2.20.1
> 
