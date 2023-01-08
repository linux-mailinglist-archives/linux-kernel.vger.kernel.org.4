Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4196619EE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjAHVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjAHVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:25:41 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF023E039;
        Sun,  8 Jan 2023 13:25:40 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id v14so6530814qtq.3;
        Sun, 08 Jan 2023 13:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksz7ViHyFyLEVp18UsYpjLBaN8EOjwCMJVlsdXXw1/M=;
        b=B4vbN/2TfnaIMpmL7flMeHcMIYJ1iqXnyUATi+iYsC2AEURExHFTF1CUDbEq3mupYj
         tq4+ru0sYkzOAFvgGUQuoa0bSZzxuJsptpL2PPTNYHr6cuGM4wL7MKgKN3oP+tobXQWI
         oBE/wirBIhvzWBoKQpYRauYcKnaDbknD3wAv4Ri6CZNpc874owP1Zrd+dqsYMuZAiBLk
         CEuEkeXppJz6lCrsb8juAAhiRG5o7tevVuKUC5aV4dmiLU8qpPQJTZ+i9Ld/Fa3F+wv9
         BUFtLJk9SLr7QlNFzH0CtOtQuQRaa8XdhgnuePKewYFWnmBzXtl3SwdwcXg6i653ZwBC
         p8XQ==
X-Gm-Message-State: AFqh2kqONH1icyJJepmAGrah8dFyU8OW+5KwlHXOIozl1P9FNsyPbapB
        Yo+iGAxD9xYC0l4sZLALbQ==
X-Google-Smtp-Source: AMrXdXukOPv2EWWUFUiwl0S670ba8FNlvRZ5ttDhfiIxFVihnoRmeRIzVeyZxWHBC/pAev9a3Lq8oA==
X-Received: by 2002:ac8:4a93:0:b0:3a7:ec9b:e00b with SMTP id l19-20020ac84a93000000b003a7ec9be00bmr84865891qtq.68.1673213139859;
        Sun, 08 Jan 2023 13:25:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id cm8-20020a05622a250800b003a50ef44a77sm3681603qtb.28.2023.01.08.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:25:39 -0800 (PST)
Received: (nullmailer pid 299755 invoked by uid 1000);
        Sun, 08 Jan 2023 21:25:33 -0000
Date:   Sun, 8 Jan 2023 15:25:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, echanude@redhat.co,
        robh+dt@kernel.org, ahalaney@redhat.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        johan+linaro@kernel.org, quic_shazhuss@quicinc.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: qcom,*-geni: move
 #{address,size}-cells on i2c/spi nodes
Message-ID: <167321304950.298101.1811705941067068955.robh@kernel.org>
References: <20230103182229.37169-1-bmasney@redhat.com>
 <20230103182229.37169-2-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103182229.37169-2-bmasney@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Jan 2023 13:22:20 -0500, Brian Masney wrote:
> Move the #address-cells and #size-cells properties on the existing
> i2c/spi example nodes below the reg property so that all of the
> address-related properties are grouped together.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/Y6Wnh+tXPhF6aC1b@hovoldconsulting.com/
> ---
> New patch introduced in v4
> 
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml       | 4 ++--
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml        | 4 ++--
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml       | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
