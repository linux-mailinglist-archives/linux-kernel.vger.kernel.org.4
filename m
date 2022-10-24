Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97210609A96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJXGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJXGeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:34:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030015A09;
        Sun, 23 Oct 2022 23:34:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 98D2B5C0074;
        Mon, 24 Oct 2022 02:34:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 02:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666593280; x=1666679680; bh=Xwh4kNbLJ+
        gA+QPsTv2FFt38/vG6iHGKt/O7ACFaLXM=; b=mJWxbDjBEdl1s4qlB2bAwt0uVD
        YHioV04aaWGWWNHxkJ8MJ7x2LGt0t3vzFSSiiSJO8aQbmmJdm8XxTuglo+S1/uuq
        n5h0hzsWevkxFrbwIcpcNt2yr02epGLr1DjeWJ/i3VoebEuRusQqYaChlIKCSkRy
        VZhsrg3Dqp4mlIHRTskvWFvD6VCh8gE+S0Xw3uE6AwP4ws3YbZYnm0f5pV72fxxN
        7s2zwW8V7AvYgrjn4jNWAtKORArmlLQyc/rzy9mth+Lo9PJNPz725NzBBqeVpquY
        SaJ60QNHbnNgdkci+BwhuPvZNqfRQvfQpv3pFTyaFioNUIx3E8hqnlJapQng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666593280; x=1666679680; bh=Xwh4kNbLJ+gA+QPsTv2FFt38/vG6
        iHGKt/O7ACFaLXM=; b=fsY09+t9P4Xr4ihTo8rtbNjjkAwKuBbNtR6yK03KJ/z5
        VMDeft5/NgjiHqQPHeqzQj5oSiJB0OjAhYs4La1M9lFRh6N6UU4h3NtVTtdNWWoS
        bxwUQqMwMWvBEFqqvA1lJHzQvOqiYPSOz0Yh7gl9bbNDxeroM4pxlrKA5wf5FqIi
        8OVnThfE81JdbP0SC1xLrFJxTS0HBKO/HHyTDpQPiI2tsCNK0LjKayI0RpvcuBCT
        yCuzVb9Mcps3HPugouB4wUvyZmZ+qyqzxJR/yfb1g6oozF6Y9IFXBTruFxgM4nk1
        6p4KSxokKLPfQm/VZa9IluzFA2FPNB6J4nNEITbZrQ==
X-ME-Sender: <xms:ADJWYxg3SSstexo5LDZ0FQyw-yq8P9oabAwniKHjXqdJh6qoSMERmA>
    <xme:ADJWY2AhwhfYKPk6q1c32HnguPirUljQI_gVZmKM-GTI6tBicaAewfMIpbji7WogS
    QnlcPUMvSDauw>
X-ME-Received: <xmr:ADJWYxHOhINomZgpCT4BKPFz2dLN8SN-4FSB9D_PNigbPvo5akoUDakIruqiImedWAkpGbXM7Egv0OO6HDPrW07cWfFkI3OP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:ADJWY2RvPku-y2WX2oUfJGj3kzAZoL7GxtnbRylDbs9pjnDKZIP4nw>
    <xmx:ADJWY-wJHcZ4DtJueJg4nxcm57WT5zJbZHaJlf9NQBaCmguEzi2l4A>
    <xmx:ADJWY87dvb-Nc9r6pSeX1IFLEBRGZ8iMkJwcI2CACzYk6IbzaPpZKQ>
    <xmx:ADJWYzrvyRZbntiVPtGEvYKJHk9CTWFnXJo-AkkEZlGWjJanJfFtOw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 02:34:39 -0400 (EDT)
Date:   Mon, 24 Oct 2022 08:34:38 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the char-misc.current
 tree
Message-ID: <Y1Yx/ioaPRA9YIzM@kroah.com>
References: <20221024135752.2b83af97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024135752.2b83af97@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:57:52PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the char-misc.current tree, today's linux-next build
> (arm64 defconfig) produced these warnings:
> 
> drivers/hwtracing/coresight/coresight-cti-core.c: In functio
> n 'cti_enable_hw':
> drivers/hwtracing/coresight/coresight-cti-core.c:93:24: warning: unused variable 'dev' [-Wunused-variable]
>    93 |         struct device *dev = &drvdata->csdev->dev;
>       |                        ^~~
> drivers/hwtracing/coresight/coresight-cti-core.c: In function 'cti_disable_hw':
> drivers/hwtracing/coresight/coresight-cti-core.c:154:24: warning: unused variable 'dev' [-Wunused-variable]
>   154 |         struct device *dev = &drvdata->csdev->dev;
>       |                        ^~~
> 
> Introduced by commit
> 
>   665c157e0204 ("coresight: cti: Fix hang in cti_disable_hw()")

Thanks for the report, I have now reverted this in my tree.

greg k-h
