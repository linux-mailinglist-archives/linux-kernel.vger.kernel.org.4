Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4167D72A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjAZVDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjAZVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:03:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DF5A830;
        Thu, 26 Jan 2023 13:03:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1383C3200977;
        Thu, 26 Jan 2023 16:03:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 16:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674766984; x=1674853384; bh=WrcQCPREYu
        exE+bSRUWehMh+31rnbUdZUAUeCq+X5EQ=; b=FsgImuYqVdAY6hA4khfZyuZ588
        8+/NO5deukjqXQXbOT7+8WCd4SwSySkPxbHaDH5kExAs2qrlmzdD1ZcB6fKex2s1
        7j4tibaMvYpv7fWkOBhR/nZkP+a3paj2Jdm1kYrV2EtXN9VHlxWaGiEPsaDKgDzd
        K1vtAjdIDarLMQTBeucmnrIc6jTHBKOIZDRxcUglQqY/JsbzsCJ65KbVe7VJB4de
        9FP4NTnmOQpmQL/j73G+fcyM3ob71VCn13XQFtgf8NjfLhw1X4R5FvsLxfkFYhDc
        0o1LM0pUt5H6l+RseKQZ4PPc3cpYIwc9IUwyzqFDcm5WORvpj4o9dA2A3AKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674766984; x=1674853384; bh=WrcQCPREYuexE+bSRUWehMh+31rn
        bUdZUAUeCq+X5EQ=; b=o0V97d1b6TZ34cN2bFdVEmXD1wdcZShcPeWYGhhFF1Qw
        Uz5LKCbImuiwFOxbewUa24HMEJzTCf3Oysltsj0PHxO23gEAEbRb3IMIIAqdVEWI
        bEcMbS/AEOKVKoDkYDYEudwSOynHuxedcAwAxmhccVJXB521CLiMmn5PIhkt1OFz
        C6gZv5cIwaUajJEyuy/tcyfZZx88E72fONpBPFOhdERr3GpNCddGS5jNXRNOH9Uw
        pdgYHDdFwxp+zBsiRx2lWfPNeJL2rGMh3GA9uhogYirPFuGSkLbgv8nOxhgDE2bG
        eems64RMg6EGs+rfEgVXNelDzluPxoRlslp1/oWDHA==
X-ME-Sender: <xms:h-rSY2ZH66UQzp2syEzlZZW7gVCMlLeefnOgOCw9neuQNTFvAMy3hQ>
    <xme:h-rSY5YmUZWtyG3jGvHdcSgShcM4x743DrthUCVxB1-nO-5v0XgaqhnBk7wVld-iG
    6FpsI0D6JE1M2TIPUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:h-rSYw-K4BmPuY5VinRfLrf_w26fzNbzadaWJtf6UOnJSvAs_gBRcw>
    <xmx:h-rSY4quW02Gdbl6SAWwBuo0SuY9vdM15XKTbhXeuafY2KKjaFpwiQ>
    <xmx:h-rSYxoRVR4HnB4qg5uQCB9YH5MPAo8L_PiCQVzlhKCezvmyLXDehQ>
    <xmx:iOrSYyQ06xloNcfR-gcNTwLCXjWhOhtdosjUY9xSOKuotyjB4MFSPw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA682B60086; Thu, 26 Jan 2023 16:03:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <077f90df-0e0b-4844-8492-1d825262a0f6@app.fastmail.com>
In-Reply-To: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
References: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
Date:   Thu, 26 Jan 2023 22:02:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Patrick Delaunay" <patrick.delaunay@foss.st.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
Cc:     "Etienne CARRIERE" <etienne.carriere@linaro.org>,
        "Fabrice GASNIER" <fabrice.gasnier@foss.st.com>,
        "Amelie DELAUNAY" <amelie.delaunay@foss.st.com>,
        "Lionel DEBIEVE" <lionel.debieve@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v6 0/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023, at 18:29, Patrick Delaunay wrote:
> 
> +config NVMEM_STM32_BSEC_OPTEE_TA
> +	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
> +	depends on OPTEE
> +	help
> +	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
> +	  trusted application STM32MP BSEC.
> +
> +	  This library is a used by stm32-romem driver or included in the 
> module
> +	  called nvmem-stm32-romem.
> +
>  config NVMEM_STM32_ROMEM
>  	tristate "STMicroelectronics STM32 factory-programmed memory support"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	imply NVMEM_STM32_BSEC_OPTEE_TA
>  	help
>  	  Say y here to enable read-only access for STMicroelectronics STM32
>  	  factory-programmed memory area.

This is now causing a link failure with CONFIG_OPTEE=m if
NVMEM_STM32_ROMEM is built-in. My guess is that you saw something
like that earlier and someone recommended using the 'imply' keyword
without understanding what it does (no worries, nobody understands it).

I've prepared a patch now based on the most likely interpretation
of what you actually meant here:

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ed8ef7460be2..ae2c5257ed97 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -295,8 +295,7 @@ config NVMEM_SPRD_EFUSE
          will be called nvmem-sprd-efuse.
 
 config NVMEM_STM32_BSEC_OPTEE_TA
-       bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
-       depends on OPTEE
+       def_bool NVMEM_STM32_ROMEM && OPTEE
        help
          Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
          trusted application STM32MP BSEC.
@@ -307,7 +306,7 @@ config NVMEM_STM32_BSEC_OPTEE_TA
 config NVMEM_STM32_ROMEM
        tristate "STMicroelectronics STM32 factory-programmed memory support"
        depends on ARCH_STM32 || COMPILE_TEST
-       imply NVMEM_STM32_BSEC_OPTEE_TA
+       depends on OPTEE || !OPTEE
        help
          Say y here to enable read-only access for STMicroelectronics STM32
          factory-programmed memory area.

This enables NVMEM_STM32_BSEC_OPTEE_TA whenever OPTEE is
available, but prevents the link error by forcing NVMEM_STM32_ROMEM
to also be a loadable module if that is how OPTEE is built.

I'll send that if it passes the randconfig builds over night.

      Arnd
