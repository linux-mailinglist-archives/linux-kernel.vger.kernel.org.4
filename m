Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEB69190D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjBJHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjBJHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:18:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F738EAE;
        Thu,  9 Feb 2023 23:18:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A261F5C00DB;
        Fri, 10 Feb 2023 02:18:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 Feb 2023 02:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676013531; x=1676099931; bh=bOL96QWLcZ
        wI2shOC/MmIQiMA0z2IGE+mq551mYF7Mw=; b=Sv1/S3Ax/d5o82fsXTbxqxqFlB
        HmL0RV8Dg/8alj/HoHZ0H+d7EucHWWVkmUM/xT9VDASXpF2M+U3Kx98kgWpP22v6
        IRc8QKCJUytNFR36biuImhTpW4yJUU8S2TCykjmaaCWE1cr3QE+IZ5pQSB74KMWr
        hXymurXT9zBmcWoT/+xYtRpeVZnqtEYCZSTRpTf/ByCimNILYsuuPUWun9TLdXt5
        OfGpOUwkmbukdEB+bUoPtEAqYU+lpT62DzKaUZQKcMMCnFo6Ondc4/nezwvJR4ls
        h+EQW8LlvVilp6ZnhXqm9gi9xCr5xAdDGljomP9f1eqhvzhURLIEu3JOVCcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676013531; x=1676099931; bh=bOL96QWLcZwI2shOC/MmIQiMA0z2
        IGE+mq551mYF7Mw=; b=rGVftYffUwrosZWog9uFHYhmdx/JorNnbID9hNbJYtYw
        p0mifPkQhadRniTdTqfeXLXcH6Q4aKzVPTN2n9tIuoPYbgUoFoL4yny5j9/6PF79
        8SAYVmJ8vqUeXo+s8TgEy1L8Br69fu7EoTcjor3lrTr6YDli+Ry2J8es922hHLjl
        I1vd9c6+LbM89v80s5ulUsCm3saGSntT2F0hLWpJk6j8BwyuPcPe7/4NX4eZWxl9
        IqqINmlNWqZej8UhIec8MIThVcn5mXcRPi3OvhZRrE9pvWBN6vS/c1EgRG6uJwhC
        DMh+Q2r6az/Csr5jneu6sMnOnNoVQHZrjiOkoGA4Cw==
X-ME-Sender: <xms:2-_lY2VyvlTC1NUwLdZRBzlgh4YjDRpGoVQykmj0W_LUJzrzQHOYTA>
    <xme:2-_lYymP74IPRV_CtV6xAx5eCFxVByNbcqkSWW3vylYO5Bu4U4QFbne-y-bjLzIhU
    cxu7kDfnslJKw>
X-ME-Received: <xmr:2-_lY6Yiy3ltoZ0JkjyhlEaQnxO-5uVNWU6HYeBLupZeUKjwat4zK9Z-PSh_1wvX9sJK_wv_bS8lMZwIdXWH96mMIUkWP51b1bU4Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:2-_lY9VQioa14kMwdiRTrcSCrB0hgN3cuITTrgqAAZw8_MnHrYabtg>
    <xmx:2-_lYwmNIwSxthHMUAmDtc_qZXLRMN1mi4BfSY_lU3DVunoNfUmhAQ>
    <xmx:2-_lYye_CwdN4EPuJ0shoDi4rj6_e_XL5iXn3CEfCM3FePWdrMfLTA>
    <xmx:2-_lY64AwK3JE77ABN8BREhz96zU7VhEckwexP3gpvwmVtXJyvovRA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Feb 2023 02:18:50 -0500 (EST)
Date:   Fri, 10 Feb 2023 08:18:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the rcu
 tree
Message-ID: <Y+Xv17dLRGZoqUXr@kroah.com>
References: <20230210124818.2caaa77f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210124818.2caaa77f@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:48:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/base/core.c
> 
> between commit:
> 
>   dc7c31b07ade ("drivers/base: Remove CONFIG_SRCU")
> 
> from the rcu tree and commit:
> 
>   3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks good to me, thanks!

greg k-h
