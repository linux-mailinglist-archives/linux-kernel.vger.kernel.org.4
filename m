Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C8681A39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjA3TV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjA3TVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:21:24 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A743B0F9;
        Mon, 30 Jan 2023 11:21:23 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1631b928691so16394023fac.11;
        Mon, 30 Jan 2023 11:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqEEzAjm7ErZyTSvMvMr9NKEMMUAe4vIhpRQfZAeFjM=;
        b=TCG7yf8txyOlcdFkE+W6K4M3n2gazRvaKWosARw+j53nZWJ5QmoHLROiXXnWMOJweB
         48uviP206WRdIUlvg9XAYk+94o520Jkdn2jCwBpFogT8VTBjFvkZoK7OiFYsNl20O4GZ
         4akZr/PAUBCFpt6ATkcsl3YN5yuKeUXC4dL8Pk6hOsqwvi2N8BmUytro9t7WZeZ6QA7V
         frXLSw9rs/aJzOeK5GRQJr6qBXYokhMN5AoWuFp3cI1QNAlCxGzoTY6Cvp23iSAoycUH
         Ig3vsyNYE3d0OGU7Gi7W8Jsd0aekibHtKRh2UwRk0IKNScs2CrSp7UObiJEiP0PMVtKf
         Ibzg==
X-Gm-Message-State: AO0yUKXZ6s1KkaA3zHjhFgLh95jO9aL6PjWSm6He3Tr9CZZ5AzPBNQ1f
        0tbhZ4apT+T/UwO4Qsyxm/wbL7dtvg==
X-Google-Smtp-Source: AK7set/TnYkY8abbpnKNtMFcxbrdXaGRsVZ0fKHz4Atlf94NTILAzGwNNPGDY1/GnL7mP24I+xpXhw==
X-Received: by 2002:a05:6870:b526:b0:163:b8fe:1e5e with SMTP id v38-20020a056870b52600b00163b8fe1e5emr3109349oap.6.1675106482830;
        Mon, 30 Jan 2023 11:21:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 14-20020a9d048e000000b006864c8043e0sm5702626otm.61.2023.01.30.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:21:22 -0800 (PST)
Received: (nullmailer pid 3213774 invoked by uid 1000);
        Mon, 30 Jan 2023 19:21:21 -0000
Date:   Mon, 30 Jan 2023 13:21:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: allow required-opps
Message-ID: <167510648099.3213715.103009992195904156.robh@kernel.org>
References: <20230127121122.342191-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127121122.342191-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Jan 2023 13:11:22 +0100, Krzysztof Kozlowski wrote:
> Few Qualcomm SoCs require minimum performance level of power domain, so
> allow it:
> 
>   sm8550-mtp.dtb: usb@a6f8800: 'required-opps' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
