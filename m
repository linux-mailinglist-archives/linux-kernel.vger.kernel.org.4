Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740A6DD44E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjDKHdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:33:36 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387F1734;
        Tue, 11 Apr 2023 00:33:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D3F95C00D4;
        Tue, 11 Apr 2023 03:33:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 03:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681198413; x=1681284813; bh=X4
        vFSoqy0z0ajTuhuTZo3O3BR+PJhFn0c0EBeaLNQMM=; b=RDaptidWqQdgfTCSoX
        GBVot7dZQRGSl78+taVd1AEGguBkbbax+WgrWH2Uds8O0obI21bwZoTO8ol1hFPM
        e3bh+aXN/h0X18PtA2GZybFkz4R59IQoJOMCqfbPyJUyrD6OY1ykVNS+otTFa9fM
        +7F1pt02fKp3+W1A5b3u7W5OTOl/cjtBDMRm9lQYqXe+KsMddyF1yEbrlnqBADoW
        jbvLPgVUFxCYnV0HzpzxVdBn7bypq202j7BLQpkwa98XZXJrW8jDKcHxdjf3uzWP
        oy1OQGaQe+Zq6vXR8ITA0Bumj4zYdmoz3gH3+vEvtavlRirXNoOFJ9y0puy8rdcJ
        cHrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681198413; x=1681284813; bh=X4vFSoqy0z0aj
        TuhuTZo3O3BR+PJhFn0c0EBeaLNQMM=; b=NQnty+W1btVshIWNUGoVOUcUcvNbx
        xq1+yRIC2WrsUMg6JgFYdUCiGrm3oVB2MhZQ8jg50KJXk+28JWn4P6TYTGsK2U2S
        KyjbBQU6IojKgA3YEEDiN208VdpV2YGSdGr81THW0oDa+FIwt0cz/fMUryz29yXp
        /OdvcL98ihnbuE/qc0Kki0E+GEvjj74Kv/sipxc8vYbI9dN8AxDKPFKQF13M9ogx
        +txITUCYpfGzKZpYubkF4N0lem7z5F7+RFsIGTOCGNgYPtJVF/XvgkW5l7pNbkMi
        TX/nsXpxu+L9bgTytCziMldIfJ/YTNOtltyeVSTw3CZvrmH+3bOTT3MCw==
X-ME-Sender: <xms:TQ01ZKjhvFnjWd4aAYL_q6KWnaN5y-09hVUyooDn63MnnbQ5Be2nng>
    <xme:TQ01ZLAg_-YQuCwZy56vNB2N8p3n9Nek-CPISNfEslbF341ZqjSozEAS3IH3dqeTU
    R6CftQ9k50JRQ>
X-ME-Received: <xmr:TQ01ZCFjn0vjFapARaZmv0c3vzddJH5lboSYSap9FfZOMI65WxSYPlxHBm7ekn4h1phb4Xp-TAfaKkU04EgsEqbxpCkfmPvTTJ3Ung>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:TQ01ZDRHPKuQdFeknyUeN5jcoPpfUTyhpGaKCei9K1c1yTSnoha1qw>
    <xmx:TQ01ZHzN1gjmkD5GJybhsjIQ7rrmPODBIg5dIwogdUm1vv86f04a5Q>
    <xmx:TQ01ZB6CSTe-VyNDb1cPDOy5j5ElSXZWpO0pQ9aI2oRB12JQSdGcGA>
    <xmx:TQ01ZMK8NnhvRMeqdnvP4Ev8t7yKGNSWXlLkWisQHRD5MCe55Dbyjg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 03:33:32 -0400 (EDT)
Date:   Tue, 11 Apr 2023 09:33:30 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 devicetree tree
Message-ID: <2023041121-hazily-dedicator-f7b4@gregkh>
References: <20230411135728.07539d81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411135728.07539d81@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:57:28PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/of/Makefile
> 
> between commit:
> 
>   bac06718990c ("of: Move CPU node related functions to their own file")
> 
> from the devicetree tree and commit:
> 
>   bd7a7ed774af ("of: Move of_modalias() to module.c")
> 
> from the char-misc tree.
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
> diff --cc drivers/of/Makefile
> index 10f704592561,ae9923fd2940..000000000000
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@@ -1,5 -1,5 +1,5 @@@
>   # SPDX-License-Identifier: GPL-2.0
> - obj-y = base.o cpu.o device.o platform.o property.o
>  -obj-y = base.o device.o module.o platform.o property.o
> ++obj-y = base.o cpu.o device.o module.o platform.o property.o
>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>   obj-$(CONFIG_OF_FLATTREE) += fdt.o


Merge looks good to me, thanks!

greg k-h
