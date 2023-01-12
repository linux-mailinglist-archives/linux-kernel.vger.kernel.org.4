Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786616684A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjALUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbjALUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:30 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31A1089;
        Thu, 12 Jan 2023 12:35:12 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15ed38a9b04so1536968fac.8;
        Thu, 12 Jan 2023 12:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmZnK0zcd3SZBoh1Xw2femsbyB+99nacCuPNrhyq6IQ=;
        b=Me0fPrNWg/z9VRH4GeXXx0uJI+VGzcy9i6ovYdZsdgboSo5kMBpXFD6gbu3bbRSi2O
         CfrpN+nKGeot03Or3VRnZ06Gct3wlXuoHoEbHXhljPTgtjos4Yro5JMbRSyfsuYjwKDj
         U3ijXYY4+SnRW+T8Pjb3IB9uEfoMb1Yg/vYz2Uz3dYd5iS68xj8XYY7EWcIg+EI+/9Cw
         9UGQugkRpJVhJGOpSGKMJfjGx9pJaZR1PaNnd1Bqg3lXTBrDhDFf1Qr7llrUZmJY/U03
         zQ0cjPC6W9032PfGB3woa5o3HR+LCWECyq3UXcchiUsbrZzu36l8TjUjjcwFggZUk42K
         RBtg==
X-Gm-Message-State: AFqh2kqTBNFZE431wMOGwvEEHorUiaxNKA3FkrKncVunBmvG3FZEikfz
        +iVR2kYykVYoNq9sn8E7Hg==
X-Google-Smtp-Source: AMrXdXsDOJuiqYdPLKP9TKilnRemC7vk9UtW4q4G/aO9LEhHzGkejleFhZpNLoVp7E2epL1sPxtnZQ==
X-Received: by 2002:a05:6870:4694:b0:148:b4a:5285 with SMTP id a20-20020a056870469400b001480b4a5285mr44872309oap.12.1673555711772;
        Thu, 12 Jan 2023 12:35:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a4ac592000000b004a3543fbfbbsm8774978oop.14.2023.01.12.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:35:11 -0800 (PST)
Received: (nullmailer pid 91475 invoked by uid 1000);
        Thu, 12 Jan 2023 20:35:10 -0000
Date:   Thu, 12 Jan 2023 14:35:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: qcom,ufs: document required-opps
Message-ID: <167355570878.90919.6440456968214920595.robh@kernel.org>
References: <20221228124331.258416-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228124331.258416-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 28 Dec 2022 13:43:31 +0100, Krzysztof Kozlowski wrote:
> UFS device node on SC8280XP uses required-opps:
> 
>   sc8280xp-crd.dtb: ufs@1d84000: Unevaluated properties are not allowed ('required-opps' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
