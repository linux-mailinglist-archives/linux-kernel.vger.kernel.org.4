Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7574B6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjGGTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGGTG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:06:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B9269E;
        Fri,  7 Jul 2023 12:05:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A795E5C00D6;
        Fri,  7 Jul 2023 15:05:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 07 Jul 2023 15:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688756711; x=1688843111; bh=S/
        sKC+j2TRg2RQQy0ZV7Lc1gET+LltLUonVflsJid7o=; b=XTjGP7IVmi6yN46O7T
        Ci0BcMSjK9Yl6Dg2Zk7MChMgoUHr/K+qhSkiY3sVhTmkintjM8rYAfWSFaEUaQym
        YyO6w1vcddODF6YxT47uEcJytirJE5F/fF85WomWpg6Cfzs7KQBpJSQxheMMVZ+H
        mZNoS0wcVu8cV5o85EcarTlsr/5Vqf9AY3sN6UcjP5h1DNcXXS2BGynAH6jWW8zy
        1B/fbQa60RxeeWnw5xnxnVJigIx94KNWqyAzXxrtgA16fHFn21wr+a7g91QlA8Fp
        fsHpG4VoxM07qRYJB4oIZ7fg+wlgYux+1wAAnLchrNfue0NzyM7SSN516V6Uv0WK
        LTLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688756711; x=1688843111; bh=S/sKC+j2TRg2R
        QQy0ZV7Lc1gET+LltLUonVflsJid7o=; b=hSforSkRer7o84ADH2YsHbx2ZAoPR
        wzMqmFd+sBroTfYKoJ3IUojG+foqlNogRBvDU+qi8p0vgZgmpvb5GqAbkAHIyNBH
        rtl6VhDDCGE0DBrddgzEmSCm0c508T5H5YdcLygSvuxdjS2ZZ6WZWF5R0fstlzbi
        wJd4RG+zxa50xaVHf6rx30nCC1akuW/56sYSNshEyYbfLVpaIglT/MxrNIpoTHlD
        3G/5FPp+TQihS2M12cV1SDdWFrXAQNmdui/hamqFoGXrS7Qv+cRoljNyXQ2XT0JJ
        VFmxT4rQp+dlQ6N7vI8zmkvmINwnVG4PFIC5dw44wduKY1krcY8UAXHHQ==
X-ME-Sender: <xms:5mGoZKwEcncMygIYkFErlDqR-j3pBWPufhGNzbVSgMnv-CuP0eVQmA>
    <xme:5mGoZGShRApNxSrKZcVFeulHfLzTKltiPr8f65iIvY_JHjolBfWi2ZaMSXYaRHc0v
    7VQSt5C6Ztau79D7KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5mGoZMXnyH8QeZquYT8O7HkU-OGrPIisdsi1IoHPE5cdlceknXAcvQ>
    <xmx:5mGoZAgZRa3xqgAgqD8BJS-S2srYocMIm-slw6Mght1ZIpcl7mAbMA>
    <xmx:5mGoZMCcjBoh6pCBUEaCWuDueyZyMRF1iZ-cM3LISDTvv9JwCXCXNQ>
    <xmx:52GoZKBMabj1UfKaCW41m2q7QGKftXrE7TEAp5dytvrK5JI_F3rFZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B6A7B60086; Fri,  7 Jul 2023 15:05:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <653aafb6-ddf5-496f-a780-6d5214a3bd00@app.fastmail.com>
In-Reply-To: <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org>
 <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
Date:   Fri, 07 Jul 2023 21:04:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>
Cc:     "Olof Johansson" <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the genpd dir
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

On Fri, Jul 7, 2023, at 16:54, Ulf Hansson wrote:
> On Fri, 7 Jul 2023 at 16:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:

>> > @@ -2,7 +2,4 @@
>> >   obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>> >   obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>> >   obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>> > -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>> >   obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> > -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>> > -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>>
>> I've a few changes for v6.6, how shall we handle that ?
>
> I think we should continue to use the soc tree until v6.6-rc1 (or if
> Arnd have some other ideas), there are some more thoughts around this
> in the cover letter.

Right, I think I can handle the merge conflicts as I add stuff
to the soc tree.

     Arnd
