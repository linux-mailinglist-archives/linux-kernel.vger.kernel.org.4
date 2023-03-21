Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3656C3B08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCUTxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:53:46 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734754D2B5;
        Tue, 21 Mar 2023 12:53:20 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w133so12051526oib.1;
        Tue, 21 Mar 2023 12:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvDUHb9mHZ3H5XBG9Qrw/6yfPAcHbkJRtRTB2OtceZM=;
        b=tK9Z0gugaA9MPcQccz8kmhVo0GzaA977v6nf+JcBNXcU/WWKkq89a4A/qBBn1rRqJk
         bToMdnLMeGXSth/3os0HAOgs4WokXWN+ptkRDZ+ZEyNsPKTL2r8+FeiYFCOp+78TYTYU
         I7js7IetaA6BcFeVduSv+usDpoftqNyeBFKP1kXYDOCd2fxeCxQfPJBVo4z3RBk5xh7U
         +NRh0F5NAag4lPIjOFjIsiDXAOjVYay+m4clX2aerErC6DGjdk2YOOH4YBH8P2/UIEgI
         vBbornGooVChOOd/0paj3+GAPf5uB8L5Pr5R4QUcLkXLu2kQwra3wlX5U9z2PFv6/7pr
         a//w==
X-Gm-Message-State: AO0yUKX8TmvlS8Jwp4gjXAH19VP5c+Q78/71D3grL0AEhDAwVRJwFasN
        1NWhAfhSgT46306y4HouaA==
X-Google-Smtp-Source: AK7set+PfrlzdyluKEri9dVWtlLQhA8KJm7p7kcuU0BFcw4do2Hy3yuEnq27AVzW/6YAJxI0m7sxSA==
X-Received: by 2002:a05:6808:9a6:b0:387:e06:6602 with SMTP id e6-20020a05680809a600b003870e066602mr132316oig.49.1679428365120;
        Tue, 21 Mar 2023 12:52:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q132-20020acac08a000000b0037fa035f4f3sm5160147oif.53.2023.03.21.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:52:44 -0700 (PDT)
Received: (nullmailer pid 1341754 invoked by uid 1000);
        Tue, 21 Mar 2023 19:52:44 -0000
Date:   Tue, 21 Mar 2023 14:52:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
Message-ID: <167942836356.1341699.17699410680064353553.robh@kernel.org>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320135710.1989-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> Add an 'nvram' pattern property and a reference to the corresponding
> SDAM DT schema.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

