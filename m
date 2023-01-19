Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057567340F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjASI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjASI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:57:46 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93A6796A;
        Thu, 19 Jan 2023 00:57:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EC7655C006C;
        Thu, 19 Jan 2023 03:57:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 03:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674118660; x=1674205060; bh=mn2JbKYAQs
        NeYnkRN5qpIkeRXL317vu4/izCeLSldg0=; b=rc+37mK0rgykOYr91sA8MJnxUK
        JcUHSxUB69vOrQtZLXtQ2y3+34WpCXOv3Se7NsQYwRQjhOc/nxIogKjP2Cp3Pyy7
        /bGWCTq29Nhfcr/I1Il7AkCRw5PxOB9wRp00ZE/IDjd0LBUJsr8zESXbA30FuT7u
        FIe9Mziudr3VeSlEvXdg2vOFG2+3G2fJMvaYg2jxHhlGjy8jdEbr2XVSr3mw2cPP
        Z/1GqQBp32x0h3HW5IgWBhPCjYP5lBi/XX8MJ3U+6SQE8sN1QuSZfDN/PZ+u5FFg
        h12taYI556qigoUGGooWgAGvKAUHpVvtIZ+6XlEUlmubSroMCbZdjsLP9U9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674118660; x=1674205060; bh=mn2JbKYAQsNeYnkRN5qpIkeRXL31
        7vu4/izCeLSldg0=; b=Z1Wc+S3Uwo5G8OQ47N8l6W0p2DSVnHbOqaJT5Lfwazt/
        jLStp3Z0z7T3hPQYkOrgBsTUm2KAlHS3Vw8aot9X5U/ZAAJbxEt7wbl7UMcxpFqW
        bfr2SLl7M3IVB0aCOVsVd7WQhoMYa0/ooT0EY89pcOT7LwA+lAaGwORxN8AySvgp
        DDCDnDX4FNS7pLe8+md/xCCaXNr8/Wk/nksHhW0oDMKN/kUVjae/TLea1wEEJqCU
        S7A0xfL25qYEBYOCErtUqJdDxriE3F5HvGjqmSEfkzRJoT4xRsl3d/O5FLl9ONEM
        Brb1Ub0USVaO72dOJUCmDS+SQt1ZpJQcOKEj6/cLcQ==
X-ME-Sender: <xms:AwbJY-DkTuOpk5u44J0x7IocCo8g_SnyL0S-7ewEnG-Jl_GgI5pjSg>
    <xme:AwbJY4jPrjB_ynq5d0V35sAqI_RFKI3i32_2_vLHbE9N9AjPPw7qk3u43Tf8-M357
    uln4SLYMHH-5XmXBlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BAbJYxnlogFPWU-btDV4FqPMmP1wS6ncEsvY_z-Tdayd2bIBaZ5i3A>
    <xmx:BAbJY8xtHzI6qEgYIfOrMUE7A7zbF8YWSHBFqVDm2Vp5L2yYy_8NwQ>
    <xmx:BAbJYzTMWvDcUb7RNzQL-rJ_ArAFtZqMmtdDmIbJ451KoynkVaOdng>
    <xmx:BAbJYzzBAtjYuSwk0drj5G6_GAGB4kmfMm6BLaELLIYFmZWIuvzhKA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAAB2B60086; Thu, 19 Jan 2023 03:57:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a958eb22-39c9-4f91-8f72-cd1db7829a3d@app.fastmail.com>
In-Reply-To: <20230119033918.44117-15-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
 <20230119033918.44117-15-blarson@amd.com>
Date:   Thu, 19 Jan 2023 09:57:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        blarson@amd.com, brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        brijeshkumar.singh@amd.com,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "David Gow" <davidgow@google.com>, gsomlo@gmail.com,
        gerg@linux-m68k.org, "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, yamada.masahiro@socionext.com,
        "Philipp Zabel" <p.zabel@pengutronix.de>, piotrs@cadence.com,
        p.yadav@ti.com, "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Serge Semin" <fancer.lancer@gmail.com>, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023, at 04:39, Brad Larson wrote:
> 
> +extern unsigned int sdhci_timeout_val;
> +

This declaration should not be in the .c file, and I don't think
there should be a global variable with this overly generic name either.

     Arnd
