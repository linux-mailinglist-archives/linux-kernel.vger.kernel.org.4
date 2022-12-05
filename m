Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF946434F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiLETxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiLETxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:53:08 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCA1F3;
        Mon,  5 Dec 2022 11:51:54 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id m204so14291852oib.6;
        Mon, 05 Dec 2022 11:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OABe4APNrqTjAjC9IHdX1q9h/86aV468xSebKnvpC9g=;
        b=fC0KK9Bpu3L6nCdn5rj16ZxFbtdRGkWG0tqrpccU8QO729H1dXyemVcnQmyPTzSWHS
         pzwwEcTuIRBg4pBP07SJUuDpvz2wo/8DD07kZfWvoacoKShYf/uNr/w2JaMGEp+MIRjx
         9AdahFQ4PrBaCgVpwCeQOs6Ww8/3tWDeH81xg9wKyi7PMM/+73hzG+dQd2NWagmKgZcv
         HfmjI0BkCMGU9Z8IARoiWJPEKX/D4EVqTj10SUdE/Bp/CZTVRJ7DMi8Noh05TP0CT/KH
         SqSb4oC0ojra3V6QWkYMr5cTBf+eoHlb2dylWBrXVepgCoqra3gL9lcL2fRvcG8LnZOZ
         qYWQ==
X-Gm-Message-State: ANoB5plqPgJzesTJe+Za4kLVubaM7IW1OJrE79f1zAgLtcZZKfZKGDv7
        JgYC8DfQBAdFW3+PSbtXhQ==
X-Google-Smtp-Source: AA0mqf5tXleS8mFr5PdEW3ApKt3ceNYoeGgDv2f7tUQ056WpBIXcqmyNI0r3xVwaB26uaXLzPk93iw==
X-Received: by 2002:a05:6808:1c7:b0:35b:daa1:2cf8 with SMTP id x7-20020a05680801c700b0035bdaa12cf8mr11160886oic.247.1670269913874;
        Mon, 05 Dec 2022 11:51:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e9-20020a4ae0c9000000b004a05e943f9esm2185834oot.21.2022.12.05.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:51:53 -0800 (PST)
Received: (nullmailer pid 2484781 invoked by uid 1000);
        Mon, 05 Dec 2022 19:51:52 -0000
Date:   Mon, 5 Dec 2022 13:51:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 12/15] dt-bindings: remoteproc: qcom,sdx55-pas: split
 into separate file
Message-ID: <167026991240.2484723.9733855287242546876.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-13-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:30 +0100, Krzysztof Kozlowski wrote:
> Split SDX55 remote processor Peripheral Authentication Service bindings
> into their own file to reduce complexity and make maintenance easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |   4 -
>  .../bindings/remoteproc/qcom,sdx55-pas.yaml   | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
