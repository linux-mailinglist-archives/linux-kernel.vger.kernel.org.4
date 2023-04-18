Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7B6E595A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDRGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDRGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:22:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E96E93;
        Mon, 17 Apr 2023 23:21:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 71F05320095A;
        Tue, 18 Apr 2023 02:21:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 18 Apr 2023 02:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681798906; x=1681885306; bh=YT
        A83JB8NZJ0cEtw5geG3dWiLcQH0r4iV18W0+fd9HQ=; b=7j8LPbe6kwjAN3vbit
        veOsBwtLXEmetjTSRB3ZRSy6acPEpMIAyWSKzvA9BsNBBrUlxxJsJe2u79dY6ZLU
        QAosfOdJHlIsy9twndZFnOUdzocQ88055EP6+F0i1T48JmT+8Wv/KhEsEsxW+vUm
        lOgGAyC3wyrh+GB2iNLzcr8CCUMUs33JcqUidcJk+ded6nQa2eMXpkoW86SztTh4
        UTiebyOXtcyP8P78MZS8mpcVyKO5GLx4OawBpX7nZs7W9WiIN77A1Jc2k6aQ80zX
        i/PDp1MpoElyPEii3yRb8Z6gdI4nha3ljSElGkUHH3iWq4WWos8nEyV5X2U6lLIx
        5C/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681798906; x=1681885306; bh=YTA83JB8NZJ0c
        Etw5geG3dWiLcQH0r4iV18W0+fd9HQ=; b=ev5PtLbM9gGh8iCgRRNgHueYAxEEQ
        tS5uwEmqncZ1rsQp8h4JGI7wC6g8lFK4OBwpMqbjO/op8jZWGk5sLlC3F88zA0Bh
        8dCCmX7AAySYnRXBWt5DXCDbkbreNjXZdSoH1MVFwV3Ifgvig0QEmMO30Enlc2oA
        SMJ+FVnL2L0CuZjQsNavPkfqS0YeF4hN+Fv3Fh3XqnUyYAJwoaY5l1PSrQJeFy87
        YP/Nem4aGSYge7MD4Zkemhvp4DEJK95dt8IoQ/3JCacVic1LLg3dA2GOVYLFVBD9
        aiptO2l+B2F+tjt/PNGVtKJVu1l0+KTXdZBPCqM1bMxJuOr2161Iis9WQ==
X-ME-Sender: <xms:-TY-ZKtLnRfxm0QdulcXmHBNdx3Z_NnccWv6ZQNrVotdkqofParMGQ>
    <xme:-TY-ZPf1jrOENeWoqPQ2tB9X0Jz3r00WenkjkCu0e1YYXI_hA_KyCTkVNK72b5SyZ
    4VW66Rn2T1eyw>
X-ME-Received: <xmr:-TY-ZFz87s3y-k0OKUp79XL5gw3FS9WVp1-5GbeVWjllcHVNnPLlXsS30A6FXshTR9tfTBDqi6fXrNDbS8BBilKaeb6Vrd_1yYnuGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:-TY-ZFOHLxedCocud62sRdy39vG3TP_uGtQXUwFfxZJtIGqJWyVXBQ>
    <xmx:-TY-ZK_0mInvjfmi4TkDyGyMIpe2UjGUhagSOxdyfkdmAAUicHUd5w>
    <xmx:-TY-ZNUEMNatTmS_ZHDubcAh1kO1weHyldo5UFgsjQUl4OtDJicV1g>
    <xmx:-jY-ZL0QcjH5gd0HkypDCImFyboIJm9alm-WxqNdVxbySJOFoZK4lg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Apr 2023 02:21:44 -0400 (EDT)
Date:   Tue, 18 Apr 2023 08:21:41 +0200
From:   Greg KH <greg@kroah.com>
To:     broonie@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the driver-core tree with the iommu
 tree
Message-ID: <ZD429c4kpvU0AF9v@kroah.com>
References: <20230417160920.3387706-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417160920.3387706-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 05:09:20PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   include/linux/iommu.h
> 
> between commit:
> 
>   f7f9c054a227a ("iommu: Remove iommu_group_get_by_id()")
> 
> from the iommu tree and commit:
> 
>   b18d0a0f92a8f ("iommu: make the pointer to struct bus_type constant")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/linux/iommu.h
> index ad238d6e4677b,0fd4e6734d5b2..0000000000000
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@@ -455,11 -455,12 +455,11 @@@ static inline const struct iommu_ops *d
>   	return dev->iommu->iommu_dev->ops;
>   }
>   
> - extern int bus_iommu_probe(struct bus_type *bus);
> - extern bool iommu_present(struct bus_type *bus);
> + extern int bus_iommu_probe(const struct bus_type *bus);
> + extern bool iommu_present(const struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
> - extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
> + extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
>  -extern struct iommu_group *iommu_group_get_by_id(int id);
>   extern void iommu_domain_free(struct iommu_domain *domain);
>   extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);

Merge looks good to me, thanks!

greg k-h
