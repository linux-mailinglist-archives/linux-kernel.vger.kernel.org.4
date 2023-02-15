Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD16984F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBOTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBOTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:49:49 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C241B6E;
        Wed, 15 Feb 2023 11:49:15 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-16a7f5b6882so24272590fac.10;
        Wed, 15 Feb 2023 11:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCKB1GmkGqKzi3qlguY0d4xIlc4o+GKLU2+qn3OriIQ=;
        b=JsVXGYe89FWDhFzoYu2R0nlvULS3wIcDQ2/xt5VU6C7QJzWlZuMnmseaCYbC/Jy+XB
         ERzZklESPNZ8ZwFMY45XavEfwDEXRCR+PWEmH5TbYSfgj6PEKVLUbd0flzL7HAxcCGEi
         ihewc2wJEER0Q2VG1T3ZdvXwqT2k1nTAPlHOhDeFoybPiGPXKi38cQAk9iqvkjdM3Yy7
         FlsoZNRXn/HYrw5wXLATrSo1XBnKixEf2athMy6Dl9P6p4/QPN5ZFCkmHjuAeZUt/Kpu
         rHwKfQKxHn2W5krkcVnkGFxxXPxjfLL9Z9FdqTRiOtYxvvVEaeLbhHnKwZGO6dapne3H
         Ng2A==
X-Gm-Message-State: AO0yUKUh995DpA9ajoiB2gHHlKhH8FkLl0FLn73kH5lCTPZfCiyJC30p
        YMm/KOMqxtqrQWAslNVtWHpYT/UBHA==
X-Google-Smtp-Source: AK7set/45g0dj5NpkqKQXm1LuueV/uADXZWsrn5BZINkMVUBQzApudSM6llLVEsgK+O7dxyuyZrhUg==
X-Received: by 2002:a05:6870:80cb:b0:16d:d644:fadf with SMTP id r11-20020a05687080cb00b0016dd644fadfmr1729552oab.43.1676490435121;
        Wed, 15 Feb 2023 11:47:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dw43-20020a056870772b00b0016e0779de32sm3538928oab.1.2023.02.15.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:47:14 -0800 (PST)
Received: (nullmailer pid 458641 invoked by uid 1000);
        Wed, 15 Feb 2023 19:47:13 -0000
Date:   Wed, 15 Feb 2023 13:47:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, David Airlie <airlied@gmail.com>,
        agross@kernel.org, marijn.suijten@somainline.org,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v2 8/9] dt-bindings: display/msm: dsi-controller-main:
 Add SM6115
Message-ID: <167649043339.458588.13199640844936490270.robh@kernel.org>
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-9-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213121012.1768296-9-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 13:10:11 +0100, Konrad Dybcio wrote:
> Add a compatible for the DSI on SM6115.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

