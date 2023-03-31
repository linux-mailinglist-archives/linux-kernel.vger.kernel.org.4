Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0B6D1909
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCaHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCaHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:53:03 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6B1B7E5;
        Fri, 31 Mar 2023 00:52:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9FDDC3200893;
        Fri, 31 Mar 2023 03:52:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 31 Mar 2023 03:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680249135; x=1680335535; bh=Ks
        vbGlp6O7ZgT74trKBEeabFrQEUJq5unbKXi23ARQ0=; b=buBtjzatT0kD1METZS
        IBtDACOuNKluJNtIfmPR8yieP4d1v0oEAgUaApF99INgb/VHjQJy89n1NFv6qfAI
        Ooq4vPFxLgETCRa+qEaASosbGtVyCtBW2DaLycfGTtOgUMC1vv0E9vIYDsDCtYMW
        piHfWCcVWAzbrxiDMFe/38yriNITtw6g2q4AaAwfjTJj0CVJjKrDHmb7IW32fmdr
        dGq6N1Iyz0aXF+/LAQ4NEWQgclW4Vk+scC5NqxBoyLEoA62zSVqE+U8n8uWWRqrr
        PJn33wshlbvT9d5rDwzZpTYiG42iP79sAU3OhrBJ63pFHG2js0Tm4h7sfHtdGFOB
        boTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680249135; x=1680335535; bh=KsvbGlp6O7ZgT
        74trKBEeabFrQEUJq5unbKXi23ARQ0=; b=ijM0oPie2tMXoyk3zlUg0l0HjozxD
        J6wMFRdJUyIGtXkYQe3ihGBymasjdXqF77zsIxbRmPmtDeszqMQctJabhEZ3B/1+
        yDmjiATiDgyxNpnm43lyvkSsZ0jIGbTz8uE489zhb5cGqiR1PH9wyG0DkPAHo+XY
        kY5eOnPJaEV6Fu+CN76G7HWZ3Umh63Q1uQOm9y5/M3H/1VQQJyvyNx/+zn2ZdcjX
        QZCCGEzY3yUkt7cd95GAlFgCuGDUcSVo0cxDfi2jMr2aWTQ8FaD3E1jpbxtStn8s
        hlI7wNpMKXj20nqR31bAiGC6D0zu86TpzuxbaGCiImMRE0kQmdfraHv7g==
X-ME-Sender: <xms:LpEmZLWUFJJZFj6H0c0xkarO87tQ-5-4e_0XoTiPzf2PK9FsWV-OYw>
    <xme:LpEmZDkLMAXvutSaT4tVQPrpvViw1AV6KwIsvsXTemRWDCstbp4mKT4s89PXr_xmK
    kd8LcggvxbjYQ>
X-ME-Received: <xmr:LpEmZHZVdh3Zue_DbPxCCg9KT8MyH4LzeWF7qWFkH7IPu4sBzCit9txV-xCbAFSkIZSu9TLdVo31qCgbPOX6jv84PWlyDGgOpeoi8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:LpEmZGXT1T2thfvXA7J6j1gG4CKSYGWGyuflE3AwcP7fq1kcAQ5MjQ>
    <xmx:LpEmZFmEVyOrurjB9RJ7Epn_9jFABr-1-Qy_jSp2U-PX9OwmEVQIxw>
    <xmx:LpEmZDfsHV47PH0Ouy-69eJ5thiBF7DXnm-ctdBwMnXklEpwvbcOag>
    <xmx:L5EmZH6H3ZjVB3UrpXUf_AmzZLe78B2X2u7LEl3pOKoNTgM4ev4Yjw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:52:13 -0400 (EDT)
Date:   Fri, 31 Mar 2023 09:52:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <ZCaRKtj9eIs1HcpF@kroah.com>
References: <20230331140150.597576b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331140150.597576b2@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:01:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/host/xhci-pci.c
> 
> between commit:
> 
>   8e77d3d59d7b ("Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"")
> 
> from the usb.current tree and commit:
> 
>   130eac417085 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals")
> 
> from the usb tree.
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
> diff --cc drivers/usb/host/xhci-pci.c
> index 6db07ca419c3,bbbb01282038..000000000000
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@@ -771,11 -967,10 +967,9 @@@ static struct pci_driver xhci_pci_drive
>   	/* suspend and resume implemented later */
>   
>   	.shutdown = 	usb_hcd_pci_shutdown,
> - #ifdef CONFIG_PM
>   	.driver = {
> - 		.pm = &usb_hcd_pci_pm_ops
> + 		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
>  -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
> - #endif
>   };
>   
>   static int __init xhci_pci_init(void)



Thanks, this looks good.  I'll resolve it this way when I send the
usb-linus branch to Linus this weekend.

greg k-h
