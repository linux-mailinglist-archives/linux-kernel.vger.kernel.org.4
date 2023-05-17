Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35F7070AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEQSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEQSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:22:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93F7EC5;
        Wed, 17 May 2023 11:22:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 61F225C0046;
        Wed, 17 May 2023 14:22:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 14:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684347720; x=1684434120; bh=Dz
        JffaXEI8AFQEMUkaUG2Da+r+V+XolUqabCMS6PQ/s=; b=fy24rRFPgz2m8U6BRa
        s9V+MvrDPgmqKTYRKZqh3nBKFmbUj3/SXccdz2JhadmDZAXjviE7WJFQ4X9oZDoz
        8RdMu7J5+eI0gCKvrYE6khsOzQhsBiYC6hrHoPHsfssop1Oh6YFYvkmQWBVkoAuj
        /uT3f0B8mPwCu3Tv+fGBh8W2RdoDo9DTv9NjXELpS4vWitbCz+KCy6aTjCUINc17
        yw1F6O7DCacB3u2gF9KE+LlcwMhDbzJeA6LSVQgrANHLzc84s4bKLE2xCL6VRwDd
        XO9rf7NRCuI3veYFvhCrNKJxZskFhfGS5YrJxntqb85JZ9LDn0idYaiwPxkIyVmE
        peBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684347720; x=1684434120; bh=DzJffaXEI8AFQ
        EMUkaUG2Da+r+V+XolUqabCMS6PQ/s=; b=k0C0quzwNqx94l8fUwWgRfWd+jMOg
        hRDViSh1ZtrusuIBzxbdib5jRb4nBuPheDFOJRacx5BxGZfzO7/7JhUjU9pJ5sD/
        wzrRcRwb7V337TZasazDdNGwQ50OrIoid20oB6RxfSFCsjQCATbhu5br93H6IjXP
        bmRBsixoyr05HYLcL1SzhveidMG02rCLZMt4vjaYF5Tx2dDSwYqbnoKaNtH0ch1y
        KkeaW02PrkAqcmSiLucBLF9JnP7y2pnBHTMWjiYuV05JkNYZDNxSgXrfFixbMSgy
        2HzwJHnnHSUSUg0guLxMLI79hpyVJABnSKmU/YacPTTqbd/PWMGm62SqA==
X-ME-Sender: <xms:SBtlZG7gj_FLVD4wCY9fZlDf79slCM7cq1F1ONKERrwU-EFG87pXPg>
    <xme:SBtlZP5-Q68e0dK538Lz0HBIn889VWEHFAGVJ7GDw9QjvSn5WEp-CjOSRHb1FtoAr
    Hb0_qPe_CW0ktZgePY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SBtlZFeeXZF1F6hrUcDbAG2ygvAer8mT8csRuLvaTN4dgz_OjE2uFg>
    <xmx:SBtlZDIBNrBGKhmjLn5vA6I6C_G2uiWkq1nfASyP4RPJqcllHPdLJw>
    <xmx:SBtlZKIybT4vkWAMCc_mjrtE1sgpCvVg6t-t9DEVz1g9Tf_ci3mvGg>
    <xmx:SBtlZC89jhJBNeG7h2fKcNb2oFMLmyBiks6MrzFdb88cRUVLC7R2kw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EEFD6B60086; Wed, 17 May 2023 14:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <2a7c0d21-3dde-4c9c-94b9-3839282ecf18@app.fastmail.com>
In-Reply-To: <20230517153932.172081-1-martin@kaiser.cx>
References: <20220815190748.102664-1-martin@kaiser.cx>
 <20230517153932.172081-1-martin@kaiser.cx>
Date:   Wed, 17 May 2023 20:21:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Martin Kaiser" <martin@kaiser.cx>,
        "Abel Vesa" <abelvesa@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] ARM: imx25: print silicon revision at startup
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023, at 17:39, Martin Kaiser wrote:
> Resurrect the unused function to print the imx25 silicon revision at
> startup.
>
> This patchset has been mentioned in a discussion today. Let's bring it to the
> attention of the clk maintainers again. 

Looks good to me, and fixes the warning about the function having
no prototype, so

Acked-by: Arnd Bergmann <arnd@arndb.de>
