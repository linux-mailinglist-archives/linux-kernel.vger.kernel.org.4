Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09F0688B18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBBXr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjBBXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:47:21 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF4709AC;
        Thu,  2 Feb 2023 15:47:19 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-142b72a728fso4713740fac.9;
        Thu, 02 Feb 2023 15:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVOXirA4z7CfrmRlboMNH4I1gSpccVX0rDaay7W0l1Q=;
        b=onWnijCOoF7/RV1wNfJwZdZ6tlLck2sCbUDX5o/RUddn3r/EpDM56ouwhOkUco/YdH
         TZOd3A86hdlLRqnhTihiFInRSYI9Dzo7ja8KyKEbBWUEiafZb85EV7dphIX6faPaBusd
         SGoJoeInonhkOm7dhYNib+NlsX6ZtrhyGCHH7zLU+kF2illqjGqwxRnU5XRWbC/V/Uc4
         OkMGZH0fLtbHqHRDR49ZMVgUIUiHOmVwjZc6lXxBNbvMwSaVPyM0mVdz1zmp/O88wlgh
         /7utlbmJk9r0ve7Q/J6AgEs3hwrpoDMkArQZAFFrfOl+OIwoRVFpqCWrhcWx9dxGu+pq
         c8Bg==
X-Gm-Message-State: AO0yUKXW7fXYIhutRt5bIm8VUE4cECBuiOD6sWxakEMqEm23efbPwQ70
        M+QjOuhd1uaIAwmxJYvVl6kLXuLoFg==
X-Google-Smtp-Source: AK7set+K1WIEMvjOmFWspD8Zix1LEJxukv2FMuW5ZzXoKLmISLRxZiypAuXTOEQlLBluqCVRZKqFfw==
X-Received: by 2002:a05:6870:9706:b0:144:c5e3:643a with SMTP id n6-20020a056870970600b00144c5e3643amr4563294oaq.4.1675381638772;
        Thu, 02 Feb 2023 15:47:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b00163263f84dasm349453oac.12.2023.02.02.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:47:18 -0800 (PST)
Received: (nullmailer pid 2919272 invoked by uid 1000);
        Thu, 02 Feb 2023 23:47:17 -0000
Date:   Thu, 2 Feb 2023 17:47:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: qcom,sm8350: add input-disable
Message-ID: <167538163683.2919233.2796308068230571125.robh@kernel.org>
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
 <20230201154321.276419-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201154321.276419-3-krzysztof.kozlowski@linaro.org>
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


On Wed, 01 Feb 2023 16:43:21 +0100, Krzysztof Kozlowski wrote:
> The SM8350 HDK8350 board uses input-disable property, so allow it:
> 
>   sm8350-hdk.dtb: pinctrl@f100000: lt9611-state: 'oneOf' conditional failed, one must be fixed:
>     ...
>     'input-disable' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

