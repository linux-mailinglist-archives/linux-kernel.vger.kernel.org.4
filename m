Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC764433E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiLFMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiLFMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:38:25 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBF14018;
        Tue,  6 Dec 2022 04:38:21 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 39F295C0120;
        Tue,  6 Dec 2022 07:38:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Dec 2022 07:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670330301; x=1670416701; bh=Sg9h2O0fRL
        SmYuFmWwgchKW3Z4xnc0iYBrezkhBe52Q=; b=XFynfqBVOXlCh7BufO9htO5/n4
        LocLfsqrAZsaemBmr6nzQbivKHS9Y7+GOEMHsMoO+fM0GIxgR/0TxrhErFI6TWXT
        qICEFxNNvAz1NkokGtXMbX2XpSPpeb2Nin2YFY8eEoSqzRW+cLiLqx4Hi+FihX7o
        nsIfv0EBD9dnz40BPbUSgjoNduXNHS0VG0IB2+8ysgqI5YLeI2W4oQI6JwDlajjc
        tFaD4qfWNpQbY4AfBuCwuW/vqRAcB83cuUqfOpapaMiaqjumBjFgs0b529LWWFCU
        o4szO5osDpxHYMMIHYy15TSU4gXrmSRqQql6YfkcAe+loY+02iIte7t/oLRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670330301; x=1670416701; bh=Sg9h2O0fRLSmYuFmWwgchKW3Z4xn
        c0iYBrezkhBe52Q=; b=CIrL1KHJwG/OMy/fQiLnJD/oTFDtlK34w0MVqqNGwFa1
        ZPl26Ehbd9FBBPGShGOURUT6G0FIoSq/I8RIaDS2F/kkrp3W7uJcRNP8o6joCL1a
        QmQ7S2mPVvjqkjAv0MwHQT6Ld3egW1c2aAW+eivoaCcah6k5qH0QUX76ARSfvPoV
        S4F9L/qlvllvUvlSn7jdhxgOJgJ40aeClaxnyhBjEr/bFqqRfVueTWUn5D9p5Bxr
        GtVEN+z6zQAnM5vkECaGtHssh0k21MJVJ7P0ZSEXWjGfiIa/QeTIpTrW9bkZoRLM
        c0v2m14e6vTWqhg7FH1nZelI8TIPoaqUTjEWA3b4/Q==
X-ME-Sender: <xms:vDePY8LM7f9iaYnc7fdrLxHzTZ0tXQN3zIzfSJw6KNwl9F62NWOdJQ>
    <xme:vDePY8KWBOVa4g9sXM3y3Jxl_XfUYt8H2jym4OToqF98473nxtSCGpqml8Or1R4LR
    KqlVaz5yWTzww>
X-ME-Received: <xmr:vDePY8vUntD0bvQCCzEe4WL4As4BrtaEYKfJODsQ_MuKJ_sNi6WSPnL5RPhh3ONMbxxaMQlSOJTtun6A27Afyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:vDePY5Zo1gDHf5GE-jBhrl598iEEBoHuhBjA3nV-6BRu-phxucU4Vg>
    <xmx:vDePYzYQzbcZwiJL5K5Re6DFtuk9xZ5cNYTqoKb0P_ziMhV00hCA8w>
    <xmx:vDePY1AHj8W8KMGvVlrmCzXtR46FEz2mD0WQ8Z-f1dxM800D-KOlzg>
    <xmx:vTePY3Rg-hFgoNWGTgYJz3vCCUfxnegSPulsAc2G86b6VwPOQHlRcA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Dec 2022 07:38:20 -0500 (EST)
Date:   Tue, 6 Dec 2022 13:38:13 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the
 driver-core, vfio trees
Message-ID: <Y483tcCqiLmmz/le@kroah.com>
References: <20221206132153.074fff0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206132153.074fff0c@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:21:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got a conflict in:
> 
>   drivers/vfio/vfio_main.c
> 
> between commits:
> 
>   ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
>   e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")
> 
> from the driver-core, vfio trees and commits:
> 
>   c2849d718d26 ("vfio: Move vfio group specific code into group.c")
>   f96dc03a8368 ("vfio: Wrap vfio group module init/clean code into helpers")
> 
> from the iommufd tree.
> 
> I fixed it up (I think - see below and I had to add the fix up patch as
> well) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Dec 2022 13:17:41 +1100
> Subject: [PATCH] vfio: fix up for "driver core: make struct class.devnode() take a const *"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/vfio/group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c5d8bf10495e..bb24b2f0271e 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -827,7 +827,7 @@ bool vfio_file_has_dev(struct file *file, struct vfio_device *device)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_has_dev);
>  
> -static char *vfio_devnode(struct device *dev, umode_t *mode)
> +static char *vfio_devnode(const struct device *dev, umode_t *mode)
>  {
>  	return kasprintf(GFP_KERNEL, "vfio/%s", dev_name(dev));
>  }
> 

Fix looks good to me, thanks!

greg k-h
