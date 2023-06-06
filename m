Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17471723F50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjFFKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjFFKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:23:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875AE55;
        Tue,  6 Jun 2023 03:23:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 960E25C00D1;
        Tue,  6 Jun 2023 06:23:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 06:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686047036; x=1686133436; bh=IV
        nHRJ2xnPQEKReHByO5PzHk/GC9Q4kW/KN2ePpn5lo=; b=HhfUp8mGIm+6cqVzV9
        vMJv7emaBvWLeJLNLXL3Rvsm459tEb6GBttaLakEEouC6SBRH1bzpA7umFK+ekJv
        RdmY4UiE1SV/LT6UMobg2aev207mVOcqNBH8xs73BsWhgbkRArQVZ31kG6WVgUln
        huEUbe9Bs6ReHPwBoLbeUQ/DgFvX4633wjaVs6iPx5k5yXRF2VQvnRhg3vBV2rp6
        W2/VG0EXTa4uTZ3V/z4rYA0Qp2igBVgxd7oZVGkbcLxVwXxNrCwQf9tI5h9yf1xv
        owhG15maZoPVK5mf80AlKOBEJywOR0f3uYt9CuqEDE0CVOEi44X4lOmKDbCIg+j6
        ZpWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686047036; x=1686133436; bh=IVnHRJ2xnPQEK
        ReHByO5PzHk/GC9Q4kW/KN2ePpn5lo=; b=l2cxCNtaMtRUhvJJJ12FlLo7t15zK
        4Rd6CYcBI8MivJDENbPObrCPRJc8XFO6Zsp9WdyiA/MYu1wdVcQZWPbr9ZYE7Nu6
        7Po4XnSVRc4YGs5WfNsdXdFuH+nZaiwIdsqYkycNJOD1vHxYMRzTLkc4d2ZH/NQc
        +KaGjT8mTdNdVP00fXsRmEz1m23RyEGra3Nb1ResivBq4fHooIHCswzs1Oah3B0M
        lMEqDPVoCuH4wrjjdzSvE1FA0xiNLamXmFod6T+4jqo7YVQA5ufqi6rLeqL07CF0
        CcP9a1HYfOQCPxFaRmFc5WoklbIra9VRkx8SuLEuFJVMHGdRed0mXDugA==
X-ME-Sender: <xms:PAl_ZB9EPrudgevlnz4aaIxQzW8MImBM9bG7LWsb3i9bVAElr_79NQ>
    <xme:PAl_ZFv3QKGOwfMvJQiuCFTmxOGfy4KE4Cmqq1z9fWw5vZELNWbCtDwCuyWqetWhW
    CjY9pTDcURlnEYw2g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PAl_ZPBrKfD1ctrI_vnQS2aTYSHEnMLaiOeYBULYg71OenhRBhUnLg>
    <xmx:PAl_ZFcBwF7VEpPQZaFvo0N2-IFnyR1X0ShshEp0VuL026Yk2_aSTA>
    <xmx:PAl_ZGOAbMOBPgLiPL1mjkIucyzGRuOmc2Yj20btXYOdRx5dDj5row>
    <xmx:PAl_ZCks3-GENqmngUfXVrVuH5cd20AixeKaIOGz_gr0eisl7SDiwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EABDB60086; Tue,  6 Jun 2023 06:23:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <05c50d10-080b-43ab-9131-98f71508ac2d@app.fastmail.com>
In-Reply-To: <20230606-escapable-stuffed-7ca5033e7741@wendy>
References: <20230606-escapable-stuffed-7ca5033e7741@wendy>
Date:   Tue, 06 Jun 2023 12:23:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor.Dooley" <conor.dooley@microchip.com>, soc@kernel.org
Cc:     "Conor Dooley" <conor@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Olof Johansson" <olof@lixom.net>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] Documentation/process: add soc maintainer handbook
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023, at 10:27, Conor Dooley wrote:
> Arnd suggested that adding a maintainer handbook for the SoC "subsystem"
> would be helpful in trying to bring on board maintainers for the various
> new platforms cropping up in RISC-V land.
>
> Add a document briefly describing the role of the SoC subsystem and some
> basic advice for (new) platform maintainers.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v3:
> - sort out a rake of spelling/grammar bits spotted by Randy, apart from
>   the one noted as a suggestion
> - drop the refs for document filepaths

Thanks, I've applied this in the soc/newsoc branch of the soc tree
now, which is where I'm already queuing new platforms.

     Arnd
