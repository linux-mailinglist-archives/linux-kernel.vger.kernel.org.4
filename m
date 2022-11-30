Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A908363E075
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiK3TL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3TL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:11:28 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5D5445D;
        Wed, 30 Nov 2022 11:11:27 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id n205so19846071oib.1;
        Wed, 30 Nov 2022 11:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JhMgGZW7My2+iKHTLOJlbdH8i+Z4qqitNV2auxp8XE=;
        b=3Lx4kzjCVjChRS7YDzWxLyYITAZRBR3VeCqG5MYAbEBDrnrtdzu83PW6fMwBKpFyoY
         CD6xEFzcTzw5weSDMkQeYmTGRyaVJKnBWRtUonlHdJAv4aqs4jSVj3JuR2V2/z5hCln6
         DFKMESXqWY+evHPAYGjcVIpJZPXNi54gNwWy66tcI+IxXJlR+ugrr6n9YMLEaRxEAMyi
         +n752g/MO3q2DDF1uw8iJ5HwvKRWKb2jwoI67bfTJwuCAc013MOnQlPopNMZeBbHDwpq
         x0mpohtMFV2YsnhuzAfn1wS8wRHWMmJmkg9x39mrB1gJU3oEppBJ9EVYpLdf+jPokbbW
         UsxA==
X-Gm-Message-State: ANoB5pmPQLaLJZig+SbBwjC/oHqCczTKHYPpWl0IfqRFydUOdO5zFFpS
        laMehRX26KBobNq363o00A==
X-Google-Smtp-Source: AA0mqf7htfyXtTOqZ6SLwCWAtka03LgntaMGU5dLEbwjX1nbs89vbcUHfQasU5eIlJmkF1/HAWFS4g==
X-Received: by 2002:a05:6808:1309:b0:359:d97b:3f6f with SMTP id y9-20020a056808130900b00359d97b3f6fmr23361909oiv.298.1669835486319;
        Wed, 30 Nov 2022 11:11:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s16-20020a056830439000b0066c7733be43sm1290820otv.30.2022.11.30.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:11:25 -0800 (PST)
Received: (nullmailer pid 2629509 invoked by uid 1000);
        Wed, 30 Nov 2022 19:11:25 -0000
Date:   Wed, 30 Nov 2022 13:11:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: firmware: qcom,scm: document MSM8226
 clocks
Message-ID: <166983548453.2629449.4233608295006445088.robh@kernel.org>
References: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Nov 2022 10:23:44 +0100, Krzysztof Kozlowski wrote:
> Document the clocks (core, bus and iface) used on MSM8226 SCM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
