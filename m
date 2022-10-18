Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B3D602570
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJRHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJRHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:18:50 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED919C32
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:18:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BAB043200918;
        Tue, 18 Oct 2022 03:18:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 03:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666077528; x=1666163928; bh=aitxup8K/Y
        Z1XXuNLQpLGuiCQL0WdKiCm4vvciVjJ7c=; b=Bw2G/y+sn547ODQ7NTQq/l3EDO
        +H9XEfRwxdTKLxIDbPe8PuQnwZhd2o7SK/A1klFZbgtsXRlSpY+eLhTVuKi7PWZe
        RIzXBme8RHntl8xeq2Y6BlgN4r9ah99aaWhtJRPkjbRO6ivy/3SptPpA7NBvDESb
        CbKLE7mDMcF1OBQgOVpEOLhMLbf05uu3EPHneKuk6UB11d55Vh6G8+uuFSkigxdm
        ryUh5j/5Jol9T4Ju1o5ZfJCgAPgyjS50kf8UqWUdq04kGyBhYZOgeUawA7btCe1p
        z4NTu4M+wmM6WbDAMTrNZrME4TXpktJnOJa8/mN6WkuLOUG4DIfm1prwFK+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666077528; x=1666163928; bh=aitxup8K/YZ1XXuNLQpLGuiCQL0W
        dKiCm4vvciVjJ7c=; b=ZtzSUvrIgkhVd0OEQxDkKJm1NPs9bomDv/sp3jEP+00o
        fiWloIt06yvpQOffI+gxU9hiu4jU6sU7AQ1c4/+SxMCCqT59CU4CgmOCdl6wvylt
        XqYb83fC0pVu666xvydCXRrM258ITDmyZgUpDTpLI72G+tigTWeNZCByErIOvb6P
        EgJBYTuDxLagBUqUh6Cak1fuJmeAN///W89s/yRpb/1fFaKPfKNgss/6uzGiuW6o
        fQUIyuCuZ35OrMg1+Dl5lw6EkTjqMzWp1YyJKKd0cR0Wbre3PXltfMCVE6y31U20
        qEXgFlBZ/tkvTj3eJpdXoaTEiyMHNAjWJg8/jNZ3eQ==
X-ME-Sender: <xms:WFNOY4M6il5Pbdpj8eOj_cqNLhhxCJIjzIUic-o7xnPP87Z3pER7wg>
    <xme:WFNOY--3JkSFX0T-N5kRCRdc1E3xek-MyaUV4SwsU5ZJPyF1QwofrkkKAYtMJ6ZHS
    TDyL8cMQ7HT8j1r5Bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WFNOY_RicZfy4LU_VYtZDf8Ki31WbreCKkjJGVVrRn8gTEHPkZ9s0Q>
    <xmx:WFNOYwvGAXB4kSxNXxZQneOq4aR3vJ67XfS2Eq1wH44JZSH_vYgoKQ>
    <xmx:WFNOYwf5FqH4P29IvgYwB3BIHG3gGBqdRX9cWQCpiyUx40dr9huxVg>
    <xmx:WFNOY47wh_ueaK5cQw7Gwnxum3v4mS7l8X3blH9MPVzYmvAONJpQfQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1F10CB60086; Tue, 18 Oct 2022 03:18:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <0991a91e-384b-4be1-ab41-e29f8ad88d84@app.fastmail.com>
In-Reply-To: <79d9b77f-f7e1-61d9-2e86-301f07a03721@linaro.org>
References: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
 <79d9b77f-f7e1-61d9-2e86-301f07a03721@linaro.org>
Date:   Tue, 18 Oct 2022 09:18:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Olof Johansson" <olof@lixom.net>, arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Krzysztof Kozlowski" <krzk@kernel.org>
Subject: Re: [GIT PULL] memory: late (3rd) for v6.1
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022, at 11:51 PM, Krzysztof Kozlowski wrote:
> On 03/10/2022 03:32, Krzysztof Kozlowski wrote:
>
> This was a late pull and missed the merge window. It was based on
> previous pulls. Shall I rebase on 6.1-rc1 and resubmit?

I'd prefer a rebase to -rc1 before you resubmit, but sending the
same pull request again would work as well.

     Arnd
