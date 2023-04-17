Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA106E4BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDQOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjDQOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:42:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895826A7C;
        Mon, 17 Apr 2023 07:42:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C15585C00D1;
        Mon, 17 Apr 2023 10:42:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 10:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681742560; x=1681828960; bh=fu
        bE93SP0lItcwGJQx6p+0xya3znlaaOwZS+MYhUJ8I=; b=L3Ir/DDuKNLFnnm1s6
        vhOv8M18cddFV1mi2u9ryYkb84UK3rvKQ5fhVcsVHd8lfoPU0jOu+Pfr9d/06q22
        CyBZ+Y0/Rbgv53SCfwulJ3KV5nBOSdEnZsxzKBl3HrzSF/oajLFwC2KXzkAYurxc
        AlI6PjhyobkSDNxhfGSC8tvGn7CXyCefR6Wm/04Pj52IP6/oFNQc+ZDBB6oknXP8
        tWAXMf4DwdhFoHOrxFh8fZO7N/SEUAJblax7ruwYPoI9OzBNH/CrMQCNgZn6QE3S
        RxPlswMt6gy6MrqtwSk43d1n7GB+4Kxgs+pYvugXKPbJlTcNuY1cG+K9p57ONiQa
        4kQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681742560; x=1681828960; bh=fubE93SP0lItc
        wGJQx6p+0xya3znlaaOwZS+MYhUJ8I=; b=fZZywwTz33JVETQZ4w8TsBjXpRomn
        Qryv4N0b98NUXuxR+9iaUOUtQpcfytCNm62OteiH2OUtA3Ut/EBkqRaYLfObTvK+
        4PrCsdGpwMs8enTdl/P+zdnzqit7clrToW3/pNteRruh8RUt1KEUF9ihTZLx4Y2U
        muLpmYZ544KJsDRKC+OS+DTSeu1HTKj20lpefJ+gVKgRELwASshgQybVHYfQBLyM
        1PemQeIJ+GJSdAT/JkUX0SOu7UxR7cZsrtq+Dxc7iBNR5akRqJEwwy2ALdJZGPiA
        kht7YO1Rc879lbZeSIBFAMSqc+rCxfINPC8Qb+B8aISi+rGBLaRWlmalw==
X-ME-Sender: <xms:4Fo9ZEUbTa9wZ8OLYI6wbO9pzxUAuHxg6yrrOtJwuyPfBbEl3Ea1-A>
    <xme:4Fo9ZIm25iuIFgVX_htc_ne7zhlz_ssq0rqgd8ClCDt2HJ-ghcTmDUy5-rLpqaseG
    HOaa2RwKku5g5RtjpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4Fo9ZIYm5wSafDgnPz381plm1Nz83TZ_e-h8l2OpwgzCPVrCee25Vw>
    <xmx:4Fo9ZDU3c7-s0ogGu4guOT3GOlYzYEjJGmOVX3I2P_UmvrMle_sxLg>
    <xmx:4Fo9ZOnjxx6gGcPb8k6F-U4rPP_d_yGAMxyU3F2u7wmchZQBdGQW2w>
    <xmx:4Fo9ZJ-j1W-CxQEOagM4xhHoHkAHU01HB0fz-sYVq_KEsHvhrj9-0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5E106B60086; Mon, 17 Apr 2023 10:42:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <1cef656e-abd4-406a-9b35-04825b292e05@app.fastmail.com>
In-Reply-To: <20230413131705.3073911-1-brgl@bgdev.pl>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
Date:   Mon, 17 Apr 2023 16:42:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/4] arm64: qcom: fix the reboot reason handling on sa8775p
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023, at 15:17, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> SA8775P uses nvmem to pass the reboot reason magic value to the bootloader.
> Remove the reboot modes from the PON node and introduce an SDAM node passed
> to the nvmem-reboot-mode driver. While at it: convert the bindings for
> nvmem-reboot-mode to YAML and enable it for arm64 in defconfig.
>
> Bartosz Golaszewski (2):
>   arm64: defconfig: enable building the nvmem-reboot-mode module
>   dt-bindings: power: reset: convert nvmem-reboot-mode bindings to YAML
>
> Parikshit Pareek (2):
>   arm64: dts: qcom: sa8775p: pmic: remove the PON modes
>   arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node

It looks like it's too late for the dts patches in v6.4, but I was
picking up defconfig patches from the list, and that one seems useful
regardless of the rest, so I added it to the soc/defconfig branch.

     Arnd
