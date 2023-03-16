Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18D6BDC26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCPW6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPW6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:58:15 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B275A1AC;
        Thu, 16 Mar 2023 15:58:05 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id l15so315937ilv.4;
        Thu, 16 Mar 2023 15:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l704mHB6P35XYwPP13DrCjsav8dvUidfz2noFHka/Ss=;
        b=Z9AtcoA2DbRJXLnU87SfmczL1nbOJ2a8fvUqh5fl4JuYk1Q/bF0OWbpYF4uShXJwAy
         JTSCt47Tt8xXxW9ZU7e9JW1BiNX1KwZxx0EwRmB8+bYFbqvGNioVKbynrlErA+B/Yc8d
         eIVOdodyYT7tYnKQAHFk4J6qNWJMrA3RoH6alcDsA8+NpQw6y67lbLdDmOJeJEtkoHpT
         PiZR0SiI5qE4yuXW6y6G/ItJjphUCk0IC1wZS6wx5nj6Cjp4u6t4N7kuUoldlYmthhdU
         GcbUDn6OT9EHxLH8CgTMhWI0hkUydTQBKFNrQhlGximohB1kAcIH+/z0lKOD7F1KG98j
         VSRw==
X-Gm-Message-State: AO0yUKXEe+lFcBjzlvWNm2Cl/yr93EVPGlK/Op2qLKmUIfHSomirSfwn
        duupwk4CYR34XBnmqa+mfJRLdNi+DA==
X-Google-Smtp-Source: AK7set9UBteBcFMfkTZiqR4T3jybhFHmGTAtJwKsUnJmTEG2xkDk+cJEFyyn3VQRFitZ5kRPaYa1rw==
X-Received: by 2002:a05:6e02:f07:b0:310:d294:1664 with SMTP id x7-20020a056e020f0700b00310d2941664mr8185176ilj.7.1679007485188;
        Thu, 16 Mar 2023 15:58:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z4-20020a056e02088400b0030314a7f039sm172276ils.10.2023.03.16.15.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:58:04 -0700 (PDT)
Received: (nullmailer pid 4039287 invoked by uid 1000);
        Thu, 16 Mar 2023 22:58:03 -0000
Date:   Thu, 16 Mar 2023 17:58:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way
 to enable unused clock cleanup
Message-ID: <20230316225803.GA4036689-robh@kernel.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
> (or at least most) of the oneline peripherals ask the interconnect
> framework to keep their buses online and guarantee enough bandwidth,
> we're relying on bootloader defaults to keep the said buses alive through
> RPM requests and rate setting on RPM clocks.
> 
> Without that in place, the RPM clocks are never enabled in the CCF, which
> qualifies them to be cleaned up, since - as far as Linux is concerned -
> nobody's using them and they're just wasting power. Doing so will end
> tragically, as within miliseconds we'll get *some* access attempt on an
> unlocked bus which will cause a platform crash.
> 
> On the other hand, if we want to save power and put well-supported
> platforms to sleep, we should be shutting off at least some of these
> clocks (this time with a clear distinction of which ones are *actually*
> not in use, coming from the interconnect driver).
> 
> To differentiate between these two cases while not breaking older DTs,
> introduce an opt-in property to correctly mark RPM clocks as enabled
> after handoff (the initial max freq vote) and hence qualify them for the
> common unused clock cleanup.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 2a95bf8664f9..386153f61971 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -58,6 +58,12 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,clk-disable-unused:
> +    type: boolean
> +    description:
> +      Indicates whether unused RPM clocks can be shut down with the common
> +      unused clock cleanup. Requires a functional interconnect driver.

I don't think this should be QCom specific. Come up with something 
common (which will probably have some debate). 

Rob
