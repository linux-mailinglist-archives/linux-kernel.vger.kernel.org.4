Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF19A697245
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBNX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjBNX5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:57:45 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669F22DE2;
        Tue, 14 Feb 2023 15:57:45 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id c15so5338660ils.12;
        Tue, 14 Feb 2023 15:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAHW4DhwJZbxilzfQorihYAlFt55J9Boo02H+OZ0j7Y=;
        b=FHGSxLKswRB4M3py0pMkL97AbfH+SYb52wsPpnZAAppWEV4acSf4MTFJucP341DWre
         E06rIT+NMiFrICYmBO3aT1bV28EcYeFGq7QpHavvM+dXaz5p6+fpu2TVyzQ1kauaf6bC
         h/ouK2qlbiL2RWdX0Hu1c/VzV0LBT4x/DXSjOEfgdC5HMsnjUWR6ler+fjR7YODPI776
         SBRDdzbG4m6LnGwFVnbg2F8Vu95cNXQhS/5251siTlQf9xuWq9CH/QKd8pCOqzdLX2XA
         J5FpawTIWPbpgbRJh3qMz552XE1DHzSy15EiVOwpNQiZVZDKF8JW6T50k6Vaj9I2Dm+o
         kwyw==
X-Gm-Message-State: AO0yUKUFTFAlYKwlUIWuCLmeFQvOEAzaHM1oVODvSQCR2120vjrK9EaU
        Vdv5yW6LRXc2XbC/Bz9OTQ==
X-Google-Smtp-Source: AK7set9wRNYosZORMASHpBqoeU49VUZ207K6fd05rz3fHMC+SorGlXnL8WC8q7ld5bzE/fEXJKnsEw==
X-Received: by 2002:a05:6e02:1807:b0:315:6e7f:f413 with SMTP id a7-20020a056e02180700b003156e7ff413mr248218ilv.4.1676419064254;
        Tue, 14 Feb 2023 15:57:44 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.5])
        by smtp.gmail.com with ESMTPSA id h10-20020a056e021b8a00b00313be472e06sm5168520ili.67.2023.02.14.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:57:43 -0800 (PST)
Received: (nullmailer pid 56398 invoked by uid 1000);
        Tue, 14 Feb 2023 23:57:42 -0000
Date:   Tue, 14 Feb 2023 17:57:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        krzysztof.kozlowski@linaro.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Subject: Re: [PATCH 01/10] dt-bindings: display/msm: dsi-controller-main: Add
 SM6350
Message-ID: <167641906184.56344.10104072482060372297.robh@kernel.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211122656.1479141-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2023 13:26:47 +0100, Konrad Dybcio wrote:
> Add the DSI host found on SM6350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

