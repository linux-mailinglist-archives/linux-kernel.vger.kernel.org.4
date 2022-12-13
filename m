Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0158B64B896
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiLMPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiLMPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:35:58 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9306220D6;
        Tue, 13 Dec 2022 07:35:57 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id r11so79216oie.13;
        Tue, 13 Dec 2022 07:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fyM7Oq897dP0iyYSq8XKa39blCeFeCNeIHlGUw62Fo=;
        b=iYjo76tjpKOWib3cDsgDsxfwSotqEpGGMMdhocW9If6bDNhmLkY+Wnn1H0lD9JB/l2
         EA6GTVvBedTnqUhGUwn2s+HyM8sR37P/FBQq0naXoe/tV34FV+qfYuuDnOV4lXPs9cWk
         7+S1shQRpPX6rq2SjQxI4FUowiOZIYMRGopE3TnRdBH3yyj6DAWbK2Jxe5dhtRmGBMSc
         T9mg1r+kgDWCLU5M8VJxDbIRfJhJcT/ZoQOB+NXzBSHyubhq4EkKKeaQ4bwBUSftNzm/
         kW2/+3mmWtg/zEehUI82590XKmMakXv/mF66oxcq7ygYmGSjqanc8M2+B3aj0jwPGTnH
         wPuw==
X-Gm-Message-State: ANoB5pkhyeuVRj5J1p1VgJAOMIg7qdFPH1TvJbQeUeZ0KnMgOxP000A+
        DFgouawEvoQAUkrFjBKGVA==
X-Google-Smtp-Source: AA0mqf4d8qkA9UCSK3qnQDyCxy1P1rFLT6e1dxdNl+RKtFHaXWrrYz+P5U0tgjg2Qu73YYIOtZVvuw==
X-Received: by 2002:aca:6003:0:b0:355:1de8:de4b with SMTP id u3-20020aca6003000000b003551de8de4bmr8303960oib.36.1670945756260;
        Tue, 13 Dec 2022 07:35:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s6-20020a0568302a8600b00660e833baddsm1333351otu.29.2022.12.13.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:35:55 -0800 (PST)
Received: (nullmailer pid 1400184 invoked by uid 1000);
        Tue, 13 Dec 2022 15:35:55 -0000
Date:   Tue, 13 Dec 2022 09:35:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 02/12] dt-bindings: watchdog: qcom-wdt: do not allow
 fallback alone
Message-ID: <167094575462.1399947.15312005395353889633.robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 17:35:22 +0100, Krzysztof Kozlowski wrote:
> The compatible "qcom,kpss-wdt" is too generic and should not be used
> alone.  Mark it as deprecated when not prepended by specific compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
