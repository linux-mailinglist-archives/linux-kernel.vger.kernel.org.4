Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289D6C9C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC0HcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0HcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:32:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2F18E;
        Mon, 27 Mar 2023 00:32:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 27C025C00D0;
        Mon, 27 Mar 2023 03:32:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Mar 2023 03:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679902322; x=1679988722; bh=c/
        HaxWyw86j547jQKaoEdyL4jC6P7t6G+zYgRMa8KiI=; b=U8A/k8r2Qb+KoJpXHw
        7kat4kSE5Ejt542Ggw5z16637BeHoU39puVU5Yei+wDWla8VykjPs0xZdJPujix+
        yvVSdlo9YUIedfIUe87PQdpB/B5OXzXL73IcqOS5gP5C3X9F9tQPvUh0lzQ6bP/F
        4AVpGcIs3LuFXZohdewPl/em84obCN3UKdT9JvqMBp1L7fYfeIZynRpkDeQS8veg
        4sPd6lVOJytIs9NkiNO+eB/INCXkSB3ysR5HSLB1fM/nFkb7suibYf3tQVL/TVDQ
        imzI29icit0m3uCkXu66+SlmmmKC8C8PZPEgGEf32WOD9nEFWnR4o99HZ+nVcess
        PSRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679902322; x=1679988722; bh=c/HaxWyw86j54
        7jQKaoEdyL4jC6P7t6G+zYgRMa8KiI=; b=V2R8IRew5E4ozuynYtcrcRrSZG3tf
        uawaZD9EyW45ncgaovCP4Q/FjzgrrBMNwgEKxjnThXUbTO8SeDFkXWGXeZ26tQ2W
        TaSqNj5K1qH5POtkF8SKSeOMEiIl/G8yqUv8vN8erldKWlxKU//kPBWc/yqInbyR
        Rz21HFxcRFLc8Pzx1Vh0GOE6JSTRk7WsH129mF/K39N0ru0vvhCR92+Abqa0507n
        CxzOVSWCBEqqnY0mViI9R0Nc2BsdH5k6Rg84lS+O/bB4J4KH5sXs8eU75+nxmaaX
        JNgC42HZk+RKpz6/zHCUyT0zFzV2YZ5qPNNQuO+yqcOrkHbYPzE511jNg==
X-ME-Sender: <xms:cUYhZNOUURSnaFr7rS4_Y0mmLhgsSp416G1pavYUnQmCwaZ9QQMZIA>
    <xme:cUYhZP8L7GbJdwLW7cf6QUc6B9L49WmRtEHEHvi0YqDMgNLPW47As0G8LYSt7nDPr
    JbsMBe-t-jnQg>
X-ME-Received: <xmr:cUYhZMSNvA2alEI9dbIi_WPMjE5nVxryDx4_DndTn8ZEveUZ4CntwHonfWTR7WGG5E0P589FspeFrwAqUvZerVTnsmcyYauHeH1VBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:cUYhZJvgOS4W83wMyZkps7DvhUy5OoNfw-ke2z6WWoDsxDbqLtEb8A>
    <xmx:cUYhZFeol2MkUUrQfR3EOJKS3pxweuhIYwZQTFlCBkW1V7SU9Zt7rA>
    <xmx:cUYhZF1z68srdaDrmVN0_gDY5ApnFyjLr37C0rZUoOCfMkr3gEJyiw>
    <xmx:ckYhZM7RKI8kWjSFDJRKKHuANxJQnoFedur_K_vMWmpk_NxXbVSxuw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 03:32:01 -0400 (EDT)
Date:   Mon, 27 Mar 2023 09:31:58 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <ZCFGbm81KcfisWOR@kroah.com>
References: <20230327120346.0a357f86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327120346.0a357f86@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:03:46PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/base/class.c:237: warning: Excess function parameter 'key' description in 'class_create'
> 
> Introduced by commit
> 
>   dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")

Oops, forgot the documentation update, thanks, I'll go work on this
later today.

greg k-h
