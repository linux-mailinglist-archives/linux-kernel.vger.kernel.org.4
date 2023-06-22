Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FAE73A46B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjFVPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFVPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:12:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D757E9;
        Thu, 22 Jun 2023 08:12:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C8A4F32008FD;
        Thu, 22 Jun 2023 11:12:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687446722; x=1687533122; bh=NN
        vOUHSjaqLmtUgFUadtUhmHSkcJ8FzXyVY8vf77sLw=; b=ci1hRkXmVfrH4wvkyu
        j0Ar0uhOimBcCcOeNjnTHnKTzyO63ZvH0EOpDLF+OQf0AMWJnxKhSaYAWMeomqn+
        Me7qOXtAC1nXxk//fQGOJ1DT7DY8TkEdI7HD9S57V5Tk7fRipf6a+Ew7MJDeSAfv
        +oqYZ1VGv0FM6jbu2hcXhxHdiVrvMskVKh99DZckwzO+dRTc+7NMu7l9K48Ko0in
        EKAXruvMOymTn6QSaQ880n+Y+9ilYJd2TR8oVt2GqZw8mgWkJqD8Wa+MIrLy1kU+
        lElWMqqL343JyVEWxxskaZXWN1is4ogBPv/BoAcKnoFR5j8cXdOA8ucbwCo0b6NF
        FvLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687446722; x=1687533122; bh=NNvOUHSjaqLmt
        UgFUadtUhmHSkcJ8FzXyVY8vf77sLw=; b=nLcdwaLGaXDGqduuXR895u/ILk+Ya
        njKZH13FtM72vG1m6/ROS6129SYVWilArUFdDs3n2gAaOTvYEVJaPk9vT5EkLfd7
        s2DZOxefxaLazTMtk5H9ghR9Uy+f6nMVOI0Wa6JXmBAOw9Aa9tvsx/J/Zids3YFg
        7Rwj07Kv3qM4aAJaUPxq80ptBWXoOhEadNQYZcyanxF94F1c8kCUkiL6xMsJ/taD
        i91v0NVq8WOSngX8Ytexpy/OoK7QwGOAW4CPfdnZI8Q4rgcCap8pE68A0bbWF1zO
        jn9SrV+O/L0G+Z3FUvngvRsorXEk8Af9SEL/QCujJHF5OkVan9BY1/1ow==
X-ME-Sender: <xms:wWSUZI7I-AS9EIueaS4iNDiSLSEKbGvuOdJzV0fksHFBsmarmf_4vg>
    <xme:wWSUZJ4U-_BxPd7S4s1HDclxTdagd6JncmAgaUKymGzrLWfuQltztrihF828OZyRD
    gmP7BG42iWQFH9SFqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wWSUZHcTdizmzVQeG_yKSQFwwDWfYIeLX2sfNY8sZcWwWCTqToWuOA>
    <xmx:wWSUZNKfWmy7_85m1B6y2nbJ5LWEA5jXbAlku7hLoc5chr_4L1CbaA>
    <xmx:wWSUZMJ8CDwDmX2siHL4Uo4A_eOo4MSyWoQgpyYGkOi_MRUHF3Eu5w>
    <xmx:wmSUZL_HvN_TJVgPMo9rq_tjbLHapKCVrb6LeR9aUCrKI30jUC07lA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 31698B60086; Thu, 22 Jun 2023 11:12:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <93b13534-ecde-4dab-880f-a04662193cc4@app.fastmail.com>
In-Reply-To: <20230622141343.13595-1-ychuang570808@gmail.com>
References: <20230622141343.13595-1-ychuang570808@gmail.com>
Date:   Thu, 22 Jun 2023 17:11:40 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v3 0/3] clk: nuvoton: Use clk_parent_data instead and add a header
 file
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 16:13, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> This set of patches addresses some of the issues that were identified in
> the ma35d1 clock driver.
>

I've gone ahead and applied all three now, on top of the soc/newsoc
branch. If any other issues come up, please send patches relative
to that.

Thanks,

     Arnd
