Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA95F3E43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJDI0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJDIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:25:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064E22B3D;
        Tue,  4 Oct 2022 01:25:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C09485C00B5;
        Tue,  4 Oct 2022 04:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Oct 2022 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664871953; x=1664958353; bh=cfKJdl0aC2
        1dvTA+ENwahYkyWS+OmPcDWCUiGDmZ3oY=; b=ZEC9Wsthqk06/Bp2HHpXByIncJ
        3I6xyapueu3moT6CngvkJatOmtCr27qZNNBR2O+MfsQyC570CRPI8H2BvwFtYSr+
        Y7KxErmI4YCmjAH3SaPXAiyeohFiy73fL7SYJRjgQgYW8UyAU0/TjOFXsbtawzpv
        dfrGIBvOqzGP0yXFtsNe+hA6q2Vqxkmtc1RcZabw3ejai6dw1twQo08uCjxTU8zW
        1cU1NB3Ox+TfQReraegDs85RYWznNtcXtA7q7i9NIfyHd8F0cIwqEW4sMHZ3a1Q2
        zVz+6UHEBijdM/4u/raBD7RVhUfMHbQOEkSfQIHWWE9Bky3gLZxlsBIRG11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664871953; x=1664958353; bh=cfKJdl0aC21dvTA+ENwahYkyWS+O
        mPcDWCUiGDmZ3oY=; b=eb3aj0QXM0wDht9wpF7HIitc8y0Ul4MwR1mkeXOeXEoY
        zNTySiX7TJpS6b+TytS6nQOYIkBUR79875BdhPBBHN2V62DF91DBEBbK3A8Yvqfs
        UKzaFVFUGERFSj4MM4789a/u8k2lT7JrzDi8IUyX/l9Ew41rZIrgFY5uLSM2v8Tw
        iH4qaeAeytnpLI/eJXl6tsQvVFtL8zSGLuZgv+XNWTLyWvNRE6bR298eQrDY/bgK
        iWBdcdbXyNByx/hQrGpmqE+GVVCSALDHSu0MAcga+naWuczfH9tFUYD/JL3qPK4w
        I0MK1zln4rxkEdy25Y8tu8NQwA6lXAgF+OU9KC/vWg==
X-ME-Sender: <xms:Ee47Y3f51AG1EDr53DfS7Pq1VH0N_0TPN-WyEnHm82OvR5X2rx-KHQ>
    <xme:Ee47Y9M9eZP86bZL-NNWnwNB58if_gRqQKVjcncaFxZOzeTw20UQtoXWpTpEKThgd
    MFLRILR7Ufjeg>
X-ME-Received: <xmr:Ee47Ywg9D6g4at07IAhJa9rS5Je2uVuaRwaNkl6W2rMjhzeJ3v6SgNEwWIod-ZA2dMe9BwvhPh6t1F3Rp4Y6LoNj3Y5MtBUF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Ee47Y4-YlbdTCt0OwVHeLIuH_FJEItlUbk2csADHeP9XMTFdLOkNkA>
    <xmx:Ee47Yzsz2nO9dT9GUyboFQ1l0hDNqUX9oHPijUS4vA_HpyVaWQBLng>
    <xmx:Ee47Y3FuOUMOdvphR_9mcPci9cH-ZmU7Be3uEjMCIueYWVyZswRpEg>
    <xmx:Ee47Y0kK8AUo3kFx4uUqJBl7eujfmd-WIjZvjm21X_Uc3xxzCWDI6A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Oct 2022 04:25:52 -0400 (EDT)
Date:   Tue, 4 Oct 2022 10:25:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: linux-next: manual merge of the staging tree with the clk tree
Message-ID: <YzvuDr3Z8wpGp5JH@kroah.com>
References: <20221004173125.4ba8d782@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004173125.4ba8d782@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:31:25PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got conflicts in:
> 
>   drivers/staging/Kconfig
>   drivers/staging/Makefile
> 
> between commit:
> 
>   c822490f52da ("clk: clocking-wizard: Move clocking-wizard out")
> 
> from the clk tree and commit:
> 
>   db65becab2a3 ("staging: fwserial: delete the driver.")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/staging/Kconfig
> index 211436b40c0a,64a531accd72..000000000000
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@@ -60,8 -60,8 +60,6 @@@ source "drivers/staging/board/Kconfig
>   
>   source "drivers/staging/gdm724x/Kconfig"
>   
> - source "drivers/staging/fwserial/Kconfig"
>  -source "drivers/staging/clocking-wizard/Kconfig"
> --
>   source "drivers/staging/fbtft/Kconfig"
>   
>   source "drivers/staging/most/Kconfig"
> diff --cc drivers/staging/Makefile
> index f1be26a5f222,6af299b9045b..000000000000
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@@ -20,7 -20,7 +20,6 @@@ obj-$(CONFIG_USB_EMXX)		+= emxx_udc
>   obj-$(CONFIG_MFD_NVEC)		+= nvec/
>   obj-$(CONFIG_STAGING_BOARD)	+= board/
>   obj-$(CONFIG_LTE_GDM724X)	+= gdm724x/
> - obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
>  -obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
>   obj-$(CONFIG_FB_TFT)		+= fbtft/
>   obj-$(CONFIG_MOST)		+= most/
>   obj-$(CONFIG_KS7010)		+= ks7010/



Fixup looks good to me, thanks!

greg k-h
