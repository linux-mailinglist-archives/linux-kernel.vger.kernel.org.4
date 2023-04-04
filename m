Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA256D6513
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjDDOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDDOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:20:26 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E211EC;
        Tue,  4 Apr 2023 07:20:19 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id bl22so10313965oib.11;
        Tue, 04 Apr 2023 07:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcAGXMBU45kFzxoxh7X3M9oW7jjf/HL66IWJZzW7mH4=;
        b=12GJFSK/cifEZwmxl5wuAemSvAv9lqBJi8bWL7UkathxA82EOp75axlHnSxbySD5TF
         4bHgblsFKtFPngAUi5SH8nqc3/DZCnQs2m/2SrWFWA2j/NtfE7S2gO1Oi2tkDqLv5B3s
         Kjp4Iubd+rdQAdy8EYJruYry2Xhzby+g1Q0Ou5TLuQ0oR/C9Mq/Kz/7VduDThkIDViU2
         2aHK4Fwq9Y79nqWbrsZSMEtp6Zmlzz+KNwdM1ft5lcM/zIC1dqx+u3iihxncDkFZ6LCg
         qAV9xamKnh2pmocG1m5faYnDRu9ArhnWATjsI4UTuR7shJrW6ihhuJmBqwDe5pRd4xj2
         1ubg==
X-Gm-Message-State: AAQBX9fbsngdcwZpvVEPNJ0GzIveespy6fnooTF3HTNgfICrQ9hmYSrV
        XsklpQMGG+gy9iFLVc+ApjU0Qr/yrQ==
X-Google-Smtp-Source: AKy350YBYmU5p7k1/dLAQw/GIT1ClDRVqyc+yDM4YQ40tYSJ/eShdEmc8skMGTsngHvEGoknfiFrdA==
X-Received: by 2002:aca:240e:0:b0:386:ee34:afb9 with SMTP id n14-20020aca240e000000b00386ee34afb9mr1334132oic.11.1680618018649;
        Tue, 04 Apr 2023 07:20:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u188-20020a4a57c5000000b00541269a2fcesm3318050ooa.25.2023.04.04.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:20:18 -0700 (PDT)
Received: (nullmailer pid 3827562 invoked by uid 1000);
        Tue, 04 Apr 2023 14:20:17 -0000
Date:   Tue, 4 Apr 2023 09:20:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Patrick Lai <quic_plai@quicinc.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: soundwire: qcom: add Qualcomm
 Soundwire v2.0.0
Message-ID: <168061801694.3827523.18263616021970369926.robh@kernel.org>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132503.62090-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 15:24:57 +0200, Krzysztof Kozlowski wrote:
> Add compatible for Qualcomm Soundwire v2.0.0 controller, which comes
> with several differences against v1.7.0 in register layout and more
> ports (thus increase maxItems of each port-related property to 16).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Increase maxItems to 16 for port-related properties.
> ---
>  .../bindings/soundwire/qcom,soundwire.yaml    | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

