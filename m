Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF76E721EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFEHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFEHH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:07:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097B100;
        Mon,  5 Jun 2023 00:07:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DCD45C0657;
        Mon,  5 Jun 2023 03:05:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Jun 2023 03:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685948722; x=1686035122; bh=gs
        KN8dIcfggLrGiSRwQVvzTjCP6B3J5Ixb0bZBrlg+0=; b=MPaEU2cKz91/xCyCUT
        sM+QSVlQJOSE7vBaGjzNvFGY3SJTsXotuLd/3MIKxfI5ORmaxlWwgJc7Trrj9Rtx
        QM8bQguiUIt9K2yDhd8hxY8ult49MTYG2PfAEhtghBdFBdth3GFZHc70Lw5x9u9v
        Eq5VLOfe9u0+lAaiVGAZwaOEN/4Hvum5OD+c0FfQfTbjVoOQoTCQCZ/kizUhjHl5
        Y2ISX2zhbgPHwzIIgje8dLXxoV/EEz4jXpfsLhFq66Uhc2dMIVMpudVU/u/9RUnc
        3OZWub2Gh45QTbUEOCRl49zPHRO0pArT0JnRI4C2eDhUHemKIAIyrtg8tkAGSmJW
        ncXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685948722; x=1686035122; bh=gsKN8dIcfggLr
        GiSRwQVvzTjCP6B3J5Ixb0bZBrlg+0=; b=df1wPh9bY/YVM/75YiQ5JJFe8Cv1q
        4bV/lL7S18+aIE1EAcx6FUCIOpsJGn1i0RxoyiWHJ5IEBi5o6qtq6rWVGxqiE9cS
        AvrSyKp0bI3EsejQshoILUlmvckyt4oW6hCAa942fDGJtCH0mmTz5HXMRT7y9gjf
        CBfAdB5SD1MZDeaEE7ganhcuq4d0+rD5RFpFf25AFbVZQAoc+w3NSa72D8Gd2bD4
        wpvuAaVaFcFAyerX0XR46GnoBgA4/ZvojIZoQphsQdkmsv5UI5+0qMUw0mwclO5D
        pXMjYR485Ey0BpX3zwEAhCdmoh0qG02mFQ1swkZuXubWZ/RkoRck5hXXA==
X-ME-Sender: <xms:MYl9ZCmvmOyWiCUy3GIRxw167ZbhhM-ZjEBX_x4Oa0EfaVXAciVslw>
    <xme:MYl9ZJ2GIzo7AzhqEuFkDSbt-IbBHqGM3ASk2erq6nGKQMKvYPoRuRfNLifmN7ML3
    Yu2B7oPy_p1rQ>
X-ME-Received: <xmr:MYl9ZAq3LeIyUWQUQQ0i5nW3ewvaZjvAHLrauVw_W4HGtctLjhrBdZw9q_6CEtZDTrfoAaIo2rjIYVrndugGdwAAD2ws609cbwvQTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:MYl9ZGlXBQ4Q9kjJrSqzVVbwQe9a6LKIPjokpF_kQvG8pPNBcB4cNA>
    <xmx:MYl9ZA1S3qPQJlGRD6557P9Jb7OMXGjMULi82Sj-ThB3w6EcWxXD3w>
    <xmx:MYl9ZNs5Q-6OmrQEmHHoimNEKzmu34mnSHSYeBA45kQZCuwrhEmjTw>
    <xmx:Mol9ZLU5Hl1MOQ2CsyFxFg6HF9_nTw-fpx4gTukmQzBIdMqiieANzw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 03:05:20 -0400 (EDT)
Date:   Mon, 5 Jun 2023 09:05:18 +0200
From:   Greg KH <greg@kroah.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, stable@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix ready/busy command
Message-ID: <2023060556-monetary-browsing-536b@gregkh>
References: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:10:48AM +0300, Arseniy Krasnov wrote:
> Fix the ready/busy command value.

"Fix" it in what way?  Please provide more information, this does not
explain what is happening here at all.

greg k-h
