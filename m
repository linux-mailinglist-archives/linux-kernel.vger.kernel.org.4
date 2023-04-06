Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C96D9DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbjDFQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbjDFQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:48:43 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF01559B;
        Thu,  6 Apr 2023 09:48:31 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id s19-20020a4adb93000000b00540fa505f2dso2898586oou.7;
        Thu, 06 Apr 2023 09:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799711; x=1683391711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoIKZZqHzGJyVdkCs91+pdHog4YytlT4U9+saTPsm+g=;
        b=Wk6pafJEVrJxAS/+ms9G0Aw9U9efhbao9LafLFFuHk30BQOCYqXaKjCDhfg38MISfE
         gQ8TGxBBbb+e/VX7PB0kYucbr64vhSTSiHqJqmq33jZ687dRUw24DQX15femIOd/ryHa
         VssVxBNIrktwz4Zqz2bTZv1Xg6F3vQORmBCTgJ6bavtVm3UV1ySNZFgiBSPjDE1iyquk
         9LQMpwGq//lN1rwK5GuqJCpf75t5At9T4eJIfHrhpRoaCSkDLv2kJ0UDesFia6sW5MCS
         ITBM5rwYMOdE2/NuKtlrA+2m8Dzn2Xx46wKAWPOv+1iWffOD1CWoZxLgnSHnobKCEUAl
         eT6g==
X-Gm-Message-State: AAQBX9ejsezMwiP7rlXlb4hn2bRhtzY+pGcXizZTrtSMHDkOwt9hsugY
        uTJhQ5nZdFn3Ti172z5Qr9n2JgJwNg==
X-Google-Smtp-Source: AKy350bLaW+BX3c2Xv1k762fNr+o+vedJksgFUYP/cJObhkX4zHsPA7YruOqiMaeTFLd/cH01dIJqA==
X-Received: by 2002:a4a:58c1:0:b0:525:36b1:86dd with SMTP id f184-20020a4a58c1000000b0052536b186ddmr68684oob.7.1680799711017;
        Thu, 06 Apr 2023 09:48:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i128-20020acaea86000000b00386eff32f58sm858979oih.13.2023.04.06.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:48:30 -0700 (PDT)
Received: (nullmailer pid 3283911 invoked by uid 1000);
        Thu, 06 Apr 2023 16:48:30 -0000
Date:   Thu, 6 Apr 2023 11:48:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yuti Amonkar <yamonkar@cadence.com>, Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 5/5] dt-bindings: phy: ti,phy-j721e-wiz: document
 clock-output-names
Message-ID: <168079970960.3283855.16770288555764334439.robh@kernel.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
 <20230404190115.546973-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 21:01:15 +0200, Krzysztof Kozlowski wrote:
> Document the clock-output-names property of clock children, even though
> the nodes are actually deprecated, to fix dtbs_check warnings like:
> 
>   k3-j7200-common-proc-board.dtb: wiz@5060000: refclk-dig: 'clock-output-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

