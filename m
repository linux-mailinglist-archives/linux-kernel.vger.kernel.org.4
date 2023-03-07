Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A66AE15B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCGNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCGNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:51:49 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C185A44;
        Tue,  7 Mar 2023 05:51:06 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id l18so14329962qtp.1;
        Tue, 07 Mar 2023 05:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkT33vlgNt//t2eiEBaAGprv91xiJjaEz4Fy+NYb+5c=;
        b=x1G34rEiRvCmWTR/D4klgWxp1F3rm2NJ7jOX86d5ZplBl2i86MCf3TaGpesrCNJxq7
         KAulVnnEGkpqHztfGEb2IpU22QUKKl1gMjQj44rUSoyJjywsSDr1jkoKgGDCBrzWo5/T
         +448cDKOT6IyyFNzB9O3IsvimyfDRIpXbXVccxF/ZiUu2W3H8F5e532wb88stBmG4706
         en7TEZH010V6edfDu1DRESt/Z5Z12Ox327cIkMKOLMSSW5Q97Y2SZpwoDlFJWm0rPUmG
         hAJ6M4WINKBi8EAd3bteWBLvAr+qVpPdyAwu1LCLqyrCGcecYQa1JRGIpnv4JtkoflHI
         LZqg==
X-Gm-Message-State: AO0yUKUratoCYeSyoqmS3/O0hq2AmiUn3+mof3uF3ZBDLkjLergvyiJt
        wOfirVr4ysUMSGT5i463llp0cmbzv0Bo
X-Google-Smtp-Source: AK7set8FcvNphlcY+fE9vM0WYuT5WJWwzH50ueQN0ZAAPkNv3iM7V5dtZdyXQbn75pxgsSyLIjHGTQ==
X-Received: by 2002:ac8:5a46:0:b0:3bf:d9f3:debe with SMTP id o6-20020ac85a46000000b003bfd9f3debemr25180162qta.59.1678197052841;
        Tue, 07 Mar 2023 05:50:52 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8082:8c7f:9efe:1ea4:c2ba:e845])
        by smtp.gmail.com with ESMTPSA id g186-20020a37b6c3000000b007430494ab92sm9452110qkf.67.2023.03.07.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:50:52 -0800 (PST)
Received: (nullmailer pid 39932 invoked by uid 1000);
        Tue, 07 Mar 2023 13:50:48 -0000
Date:   Tue, 7 Mar 2023 07:50:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,tcsr: document SDX55 TCSR
Message-ID: <167819704835.39874.7191179198144936686.robh@kernel.org>
References: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Mar 2023 08:26:17 +0100, Krzysztof Kozlowski wrote:
> Add compatible for SDX55 TCSR block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

