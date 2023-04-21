Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08AC6EB139
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjDURxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDURxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:53:00 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102110D3;
        Fri, 21 Apr 2023 10:52:57 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-187e041b08aso1573956fac.2;
        Fri, 21 Apr 2023 10:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682099577; x=1684691577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZuA6YnetcoH1fBBOjh6OWXo5QXfMiryrevWyy06PqU=;
        b=N7Ji2qM/2WM9xNEHFX/Yf+aOZ4WX3tj0U11Mlbl+2S4wM+0g0kVwQdkNpTMLhPff13
         nxNgGeLMk1K5AUqOr9iEbZjTuIzo+i4nIvRbkcS782i0EBhO2fBtdM6p2zPxDHibt88N
         t4bNwe5O5ZlD7aHGMfgRIdodfxOpaXrq4JRfihz1/aXvtsSzZYrNevQr+oCNEHvXw6RI
         LD9+OZAMt+I9mpZh/sjkBDujB113+N2qtWuUqxfXXNjfsBvF+bMHiB5dFxPBFrEeL2Xa
         oZc/dAdOL2Q5/xE2/nijjrub9LEr9xl/q84pemTNAfMK/bIYpo69a5MWv9x5XkZofqLe
         BGDw==
X-Gm-Message-State: AAQBX9e1oM1SDGGO+Cjq95pHxLLXaorC76cRmCvM6YUY1FFVdL17tMCm
        LHMirr/OgMpFKaYuAFclyw==
X-Google-Smtp-Source: AKy350YYj9G7YUb98/l/1ld/1teWRZxeVjFZ5m7JQI0C2fIwomZSfIubcU7JemWvoqRNils5giWsJQ==
X-Received: by 2002:a05:6870:1d2:b0:187:a330:81a2 with SMTP id n18-20020a05687001d200b00187a33081a2mr4400380oad.54.1682099576780;
        Fri, 21 Apr 2023 10:52:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j20-20020a056870d45400b0018b03bf5f97sm1971545oag.41.2023.04.21.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:52:56 -0700 (PDT)
Received: (nullmailer pid 1540771 invoked by uid 1000);
        Fri, 21 Apr 2023 17:52:55 -0000
Date:   Fri, 21 Apr 2023 12:52:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, quic_jkona@quicinc.com,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        dmitry.baryshkov@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: qcom: Add SM8450 video clock
 controller
Message-ID: <168209957511.1540718.15695207046392293504.robh@kernel.org>
References: <20230417082127.11681-1-quic_tdas@quicinc.com>
 <20230417082127.11681-2-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417082127.11681-2-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Apr 2023 13:51:25 +0530, Taniya Das wrote:
> Add device tree bindings for the video clock controller on Qualcomm
> SM8450 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
> Changes since V1:
>  - Change the properties order to keep reg after the compatible
>    property.
> 
>  .../bindings/clock/qcom,sm8450-videocc.yaml   | 84 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,videocc-sm8450.h   | 38 +++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8450.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

