Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96542654758
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiLVUjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiLVUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:39:22 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE121802;
        Thu, 22 Dec 2022 12:38:46 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id s186so2935919oia.5;
        Thu, 22 Dec 2022 12:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m3vdeoqRapejnKIbOke3igL2UHNLgon/GdxcFm+kZ8=;
        b=0LUX5Pr+dE0mvKIw9/JdA0wr532iIcFqQ0xg1FFHLze5eYadt87V3EiRHDYdkt/q1g
         j9frj9rjyXlGv9GNNFhFrC1uJm6P32u8ax2JQdP5nN2PLbUR4urEJ2WfRqeeEiUsAG+j
         LbfPb+IgM1r1AQoU5X1O1caUSxcNkH7OWp2+UL+hL7OmAOvcM+oFwrUijyAvgjM20Kun
         utwshQVtORncSnEy32EcGODzGhUN4qMZt/cEPbo0xgKWZF7m0Y8xJMVbuL37WF9OAi+9
         UjbtpUE8tEwQ+KsC0hXI97H0l8xaGuRb6sFTeUINbpg6RTM3LoJNd47PpbkDElTejbtW
         911g==
X-Gm-Message-State: AFqh2kqfpf1ladX6+ZiRQMgLPBjBVBXKhb1ZWnxcPEGct1oKxmhJD121
        3MAkYWStFh91EOc9hRXWbA==
X-Google-Smtp-Source: AMrXdXuYdVVTMMnQkm5gnhNsazhIx/OOOqoRnvH+O9vVz6IawyTzbghgBPgrK7U/Dw/pm+YKbyV4uw==
X-Received: by 2002:aca:3d88:0:b0:361:8d6:944d with SMTP id k130-20020aca3d88000000b0036108d6944dmr2841162oia.47.1671741525643;
        Thu, 22 Dec 2022 12:38:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e9-20020a544f09000000b0035aa617156bsm743444oiy.17.2022.12.22.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:38:45 -0800 (PST)
Received: (nullmailer pid 2079648 invoked by uid 1000);
        Thu, 22 Dec 2022 20:38:44 -0000
Date:   Thu, 22 Dec 2022 14:38:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] dt-bindings: phy: qcom,usb-hsic-phy: convert to DT schema
Message-ID: <167174152396.2079609.894160712392200876.robh@kernel.org>
References: <20221222155805.139284-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222155805.139284-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 16:58:05 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm USB HSIC PHY bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,usb-hsic-phy.txt        | 65 ------------------
>  .../bindings/phy/qcom,usb-hsic-phy.yaml       | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
