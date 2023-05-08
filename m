Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F56F9EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEHEnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:43:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC86598;
        Sun,  7 May 2023 21:43:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso6230709a12.0;
        Sun, 07 May 2023 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683520999; x=1686112999;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wLGbxnOdQH05ihvsc63364XzMDdgmp6oHJPVZ7OBOoM=;
        b=bNDHeN2Mv9sA7wX69vDsJeOoMS+Lm006HMq41c6ncW6gq7CMRV50jSJ8yuKObyIlrJ
         PiPm+3JXsaprVIMfMzNdMpopKz6Cdor9/1bdBMF9vagxHh0URpy3Mu2aghHtltX/7skL
         MnAM/oMdsd4YGiedf9m9diV9jB0vvSKddJNbtAQXatgyPp+bCXxggwGyqL3/7qJp+IvD
         u6Ta/VNfikkbjb4u7zq2bK/15j6/YjPwo40PpcW9gM5vjYwXrMTnACcH2kWO4iB7j2fz
         JNd7EOlL4fxOSHSIcGz5Jo8P+3IHuelT+oKyZNcneNPAvktnGmpkUvbFCmmCfwjcbmEt
         ZBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683520999; x=1686112999;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLGbxnOdQH05ihvsc63364XzMDdgmp6oHJPVZ7OBOoM=;
        b=DLfym5aqy3wn9y7APncgwVaEEuODetIiVzulMMe6ZBlrXfDv/rWzPAxGb8FrmxJo/q
         YUI0lrhN3wYEf7y1ppZv/Z5q6JXXZcsxUZpM+CDqW+uTaf4IAUQrgsaPijDt2TvykOu6
         JNlwvuRISA+ha0q07lGz75SSkXj4a+mz5jt/wdgUQQGNrO9nudD2ZnOB4BgGUmUVPzwS
         qABY4Iah+WvrTQDSoPuhwVcZXv888GCY7DxfCD5kAjuvAnboMa4eez/pxc+Sm5WXTj98
         myu5T5pjMB4mSjnKkY+AaF6ecm6u29w6q/RGZ7CNyTEjiNixyNgxhhcsdVUtPSFLS9cl
         j/Qw==
X-Gm-Message-State: AC+VfDwg41+eORRmJ6xAqZY8zxx48CT0liT3upyi8o3RAj7ex5wjrSjr
        FhJUYY3B1nJ1l90nFVnggDihQ49K+ZcK3KLO7ZY=
X-Google-Smtp-Source: ACHHUZ7mNoFVuUgYjmaEGFCXtfAGR8Za76cQQJ3P63GXnHwj4GjAkK7hfDQHde09dzNijnm1XeZ9jvIEVy/mf5aiAaY=
X-Received: by 2002:a17:907:da5:b0:94a:67a9:6052 with SMTP id
 go37-20020a1709070da500b0094a67a96052mr8491313ejc.67.1683520998626; Sun, 07
 May 2023 21:43:18 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 8 May 2023 06:43:07 +0200
Message-ID: <CAKXUXMzqCktKz7vGN4_QAp4n1SeP0-YHL19evmVSfseZOemd5g@mail.gmail.com>
Subject: Situation of CONFIG_CLK_SUNXI_PRCM_SUN9I
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maxime,

with commit 49c726d55c1b ("clk: sunxi: Add Kconfig options"), you
introduce various build configurations for Legacy clock support for
Allwinner SoCs. Among them, you introduce the config
CLK_SUNXI_PRCM_SUN9I in drivers/clk/sunxi/Kconfig, but this config is
not used anywhere in the kernel tree.

Can we just delete this config CLK_SUNXI_PRCM_SUN9I again, as it is
not needed, or did you simply miss to adjust the Makefile for this
option to be effective?

I will gladly send a patch, once you could give me a quick pointer.


Best regards,

Lukas
