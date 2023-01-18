Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80F672380
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjARQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjARQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:37:03 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59C21965;
        Wed, 18 Jan 2023 08:36:50 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-15f944494ccso1069877fac.8;
        Wed, 18 Jan 2023 08:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITuX+8zwC5q8D34a6fPDAXRGD1lwZVV/MYd3Iiq3SsU=;
        b=lN+FXJDKq+l+s2oQxGBxe3I+6FiJiIp9WkoQIqMRFSJewxTyX5bGdgTOXM3IihDQbA
         h0USW2H5BJ+H950TUr3Ib1c4527jMscdxv1QgrrnNsaisMPv7FKBAEaXeCdhjKfe9zGw
         m7tDoLazH+luYObnREVnVF86HprwaN6hAQrJUqRF5Hiu/2RYBZEToGhoyDNhtv8dItQL
         TCn+j3ThrkguOOdu6wMa38ErxmF/macQhpsCR/AA0W8d9pl+ScfIUVzwkJcyEVcZ6RB7
         S7C10ErW/0C4MzyJeLhz8qbPdWxo/aWYFWQ1Bt17K1V4U2Qr9A7ZeHZRAMvN0FldIQwo
         kWaw==
X-Gm-Message-State: AFqh2kqPooxWUC7GgVWmPYvyHKe562bor2BJFInjcmKc/opBJjbthr96
        /qDkAyDSIVuJqZea7Xv9C0YCy/dHFQ==
X-Google-Smtp-Source: AMrXdXsqZ/WJDE7Vhs5jZ+/7JgHJqm/DqA/cAwKCbqtzxw33WJ3zGvkaRr5YXeMSYofR80ZjvdJ68w==
X-Received: by 2002:a05:6870:bd47:b0:15f:11f9:a1fb with SMTP id og7-20020a056870bd4700b0015f11f9a1fbmr4143535oab.1.1674059809653;
        Wed, 18 Jan 2023 08:36:49 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id el35-20020a056870f6a300b0014474019e50sm18311258oab.24.2023.01.18.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:36:49 -0800 (PST)
Received: (nullmailer pid 131535 invoked by uid 1000);
        Wed, 18 Jan 2023 16:36:48 -0000
Date:   Wed, 18 Jan 2023 10:36:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: phy: Add QMP PCIe PHY comptible for
 SM8550
Message-ID: <167405980798.131477.17272900590548498744.robh@kernel.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118005328.2378792-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 02:53:21 +0200, Abel Vesa wrote:
> Document the QMP PCIe PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
