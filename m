Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F4681E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjA3Wqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3Wqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:46:30 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327D233FE;
        Mon, 30 Jan 2023 14:46:29 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id i11-20020a4a6f4b000000b00517b271130eso24728oof.1;
        Mon, 30 Jan 2023 14:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F1RdX/xgBkyvYMUH0G/meuG8LhtJiq7ztAqA3CqviA=;
        b=fIzlure5RlNpX1iDxpTJfI9c0ZhhQxyWFBMtkb1W/fRa64sU8GRZRR9lW8mHxM5HVS
         BlFYq9eKa63ZBM1rsHEWIgkbiCnQjfe5hHbXwOPlWX2Rxa+MOxbWva2oddO8y9Wvk5Cf
         OQ3lQ6q7ZhZpcTYG6o96L/W8/QVaqKeeMwB2rOu53Z5sFy1ObUTjSdEti3MGD1cZ/HQR
         jSnD+A7FH7KiQaEAqBJ9bVJBTQWvD7AAaJt/05WjIZy3HlHW7Sw7qunUDodOTbtE7z2w
         AXdOJTXh2nEus3u3+UaNp6glu4dL/YDx/tlnfOn1Ojzt4MWS0rSKBqlRTK28bAUxCFLJ
         5utQ==
X-Gm-Message-State: AO0yUKU4ColRBEGlmy5v7ydag02834swxptyk762L9b+GYIMOoWKLgdb
        MtAJsJjsZVemq2x9mndstQ==
X-Google-Smtp-Source: AK7set/zrARTH9YZ5hRP87f14TpvluXFrdr4Vm6LHeDh2OLvXQ6XHffHmAbqvTkyP5JeJ9RoIr5irA==
X-Received: by 2002:a4a:9198:0:b0:4f9:1696:a47 with SMTP id d24-20020a4a9198000000b004f916960a47mr4638970ooh.5.1675118789223;
        Mon, 30 Jan 2023 14:46:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q18-20020a4a88d2000000b004f227a05684sm3443334ooh.34.2023.01.30.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:46:28 -0800 (PST)
Received: (nullmailer pid 3664984 invoked by uid 1000);
        Mon, 30 Jan 2023 22:46:28 -0000
Date:   Mon, 30 Jan 2023 16:46:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/7] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM8550 compatible
Message-ID: <167511878766.3664930.5199848080705768898.robh@kernel.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-3-0b0acfad301e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v1-3-0b0acfad301e@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 10:54:34 +0100, Neil Armstrong wrote:
> Document the SM8550 compatible used to describe the pmic glink
> on this platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
