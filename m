Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12F6DFA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDLPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:11 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D0459E1;
        Wed, 12 Apr 2023 08:33:10 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id k101-20020a9d19ee000000b006a14270bc7eso3212836otk.6;
        Wed, 12 Apr 2023 08:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681313589; x=1683905589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOjaCPYafQTgElcWLu+C+9q7oFGdFz1gmtpWgWQoSzo=;
        b=M2RKc5h7zyXgTfETW5JmahmeJTk6eogkmQPU1VBcsYVmQbYdtdHo2EUX9C1nnXeUeE
         84YBudoI8QSJypL+ZVsyelbA3t3e8EgmtXo+ugKVZN6wt6InAB/PAMuuQ29kAHEShCNz
         j3asaWZ/5bupNZAXWgSg6TF2RGQ6QNlipgDAuWOFWByD1AR04IwaEz7xEjIHRukzy9MK
         vtvqD5HHkARrMWMfpdYMaYt6bC33zQx74fc3GuPW09p2+EhERSYclmZxY9maNj5o/HOk
         isbds9aaIjWFfnGyboTuBNH02Dq3dY+1t8wMwTKSo79OPEtSw54kX0LUj7iCeWI5gyj2
         wWmA==
X-Gm-Message-State: AAQBX9eL94LNw6VpSRI3NHIK3BXVf3X6ekOkbVEX8c8XWkVbzSlMEvg9
        S6XqWycHcAh4YGFSg/j5YkMBJX6PVg==
X-Google-Smtp-Source: AKy350aJpoIwH0hm0Dtc/H4sRBjBI6NWqyeiXLeGnh9wj1Cv9m157DT65w5pOWUg7WSbSXvkfU/l4Q==
X-Received: by 2002:a05:6830:1e4d:b0:69f:65de:9914 with SMTP id e13-20020a0568301e4d00b0069f65de9914mr9393639otj.4.1681313589629;
        Wed, 12 Apr 2023 08:33:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d6c07000000b006a205a8d5bdsm6668119otq.45.2023.04.12.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:33:09 -0700 (PDT)
Received: (nullmailer pid 2472906 invoked by uid 1000);
        Wed, 12 Apr 2023 15:33:08 -0000
Date:   Wed, 12 Apr 2023 10:33:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        devicetree@vger.kernel.org,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/msm: dsi-controller-main: Document
 qcom,master-dsi and qcom,sync-dual-dsi
Message-ID: <168131358792.2472835.6239404234836108897.robh@kernel.org>
References: <20230411143149.16742-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143149.16742-1-lujianhua000@gmail.com>
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


On Tue, 11 Apr 2023 22:31:49 +0800, Jianhua Lu wrote:
> This fixes warning:
>   sm8250-xiaomi-elish-csot.dtb: dsi@ae94000: Unevaluated properties are not allowed ('qcom,master-dsi', 'qcom,sync-dual-dsi' were unexpected)
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

