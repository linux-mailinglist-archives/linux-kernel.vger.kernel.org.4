Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D296617EC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjAHSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjAHSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:13:01 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB51247;
        Sun,  8 Jan 2023 10:12:50 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id o13so3831504ilc.7;
        Sun, 08 Jan 2023 10:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Cf33NF2XNY12BKiXzVChtAPguuQUdKSv5dHZKLHLA=;
        b=S9b7iYqV66lxeBfxb4TKbqAvzBOZUbSafTz2T8Kii6U1mQ7qRD1OOM4lFzteQapOM7
         CsARQoNi/CbtldDjUd9MJNhJHJldusuKbY7RqjVtI3bLTpdiqDC7vUiug6kgiT0tCmfC
         PHP1hua4rqBC518wMhUZkDN9XPplXnyN/7/oB0VM+JsSdPlphv4B6OoD2mIH0wcYEFfP
         gnegGQ6xS0Se/+Q3HWgDNQvYWSaxCzFd5Q1Ah6vJl4WnyCaoSLRasgCjzFlYPyyzj7Al
         GAz5hBydOl97hbdcLGayBCwJ3l/avTjuxBPpcDADvbFzcN29TGpGTlLHS2jcp++rSqe5
         surA==
X-Gm-Message-State: AFqh2krXQBNFUjccEIxWT7naudzQORlEORod5e4q3Q0YUH2pMCFvlhYc
        fk9Y97uWN6c8DApnjXZOww==
X-Google-Smtp-Source: AMrXdXsZAaxkb8liK9Eg0Agrzx+atp3rsTQ0A3RfwyhbgDjsL/zbZk+48rzHpF3zbcavFStPOlPcvg==
X-Received: by 2002:a92:d382:0:b0:30b:c7fa:7492 with SMTP id o2-20020a92d382000000b0030bc7fa7492mr42504098ilo.12.1673201569672;
        Sun, 08 Jan 2023 10:12:49 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id v8-20020a927a08000000b0030005ae9241sm2089906ilc.43.2023.01.08.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:12:49 -0800 (PST)
Received: (nullmailer pid 157023 invoked by uid 1000);
        Sun, 08 Jan 2023 18:12:46 -0000
Date:   Sun, 8 Jan 2023 12:12:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy:
 correct clocks per variants
Message-ID: <167320156602.156895.4809121171592550942.robh@kernel.org>
References: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
 <20221225115944.55425-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115944.55425-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:44 +0100, Krzysztof Kozlowski wrote:
> Different variants of Qualcomm USB3 DP PHY take different clocks
> (according to upstream DTS and Linux driver):
> 
>   sc7280-herobrine-crd.dtb: phy-wrapper@88e9000: clocks: [[43, 151], [39, 0], [43, 153]] is too short
>   sc7280-herobrine-crd.dtb: phy-wrapper@88e9000: clock-names:1: 'cfg_ahb' was expected
>   ...
>   sm8250-hdk.dtb: phy@88e9000: clocks: [[46, 185], [44, 0], [46, 187]] is too short
>   sm8250-hdk.dtb: phy@88e9000: clock-names:1: 'cfg_ahb' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      | 72 ++++++++++++++++---
>  1 file changed, 62 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
