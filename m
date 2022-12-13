Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174BE64B8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiLMPhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiLMPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:37:41 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89993328;
        Tue, 13 Dec 2022 07:37:39 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1433ef3b61fso12961723fac.10;
        Tue, 13 Dec 2022 07:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW+dC+68+BTVu73IRWlyS7SMNwjWGWNtiGIwb1qrBTI=;
        b=H9KWO3mfI+2mToo1vz8Bv6vMyq1WPts9qKbQ9Iv6eOaaKn1g0Flf19zq1R536ogjU/
         YxiO7s4NmhKTdsZDx3OARw13JBvVPXBlZEVb05mG2HVyDg6dJttlebWfrtProtoDk6Z9
         hR26480neFpZana4PQFzhSLrNVJPiT1ri6INskdUBTJoPVbWMOEVlCY+WotX/ktp+OcD
         Ym+RoIaSO4kWsTNheo9DywppW2r7mU3EiWy7gDbJ+6kfC3Ywpiz0mJyfHmyDwMzMU9B8
         KlzCVzdnwNFU6LC7Iw+1+UFin57OmJlIWjzdxUNnvpbLuKP+yR+wJ8B/klAT7lbZ4/Jn
         dgVw==
X-Gm-Message-State: ANoB5pnj/ihzwuRw9tQBjgaoLrVR4oxMvzLeEGnNrWSWA1qRrU9QUaAJ
        y335tNDMWLyCbkVmsGeazQ==
X-Google-Smtp-Source: AA0mqf77lU8cnJX06O/VG5p29VbYIblEYzyBmW0136PMIfc8wdcCfZNj9IABnruJCAb4nVl0dT4tUQ==
X-Received: by 2002:a05:6870:b14:b0:144:e7c4:92e5 with SMTP id lh20-20020a0568700b1400b00144e7c492e5mr10778243oab.3.1670945858533;
        Tue, 13 Dec 2022 07:37:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ba35-20020a056870c5a300b0013b9ee734dcsm1549839oab.35.2022.12.13.07.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:37:38 -0800 (PST)
Received: (nullmailer pid 1420639 invoked by uid 1000);
        Tue, 13 Dec 2022 15:37:37 -0000
Date:   Tue, 13 Dec 2022 09:37:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 03/12] dt-bindings: watchdog: qcom-wdt: fix list of MSM
 timer compatibles
Message-ID: <167094585686.1420426.5448151585460043975.robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 17:35:23 +0100, Krzysztof Kozlowski wrote:
> The MSM timer ("qcom,msm-timer") is a bit different timer and watchdog
> device than KPSS watchdog.  It has its own generic and specific
> compatibles, so fix the list to reflect this.  Adjust the example to
> show the newer KPSS watchdog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/qcom-wdt.yaml    | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
