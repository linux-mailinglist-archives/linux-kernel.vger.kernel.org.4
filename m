Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2060C61A3A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKDVxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKDVxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:53:18 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94651C20;
        Fri,  4 Nov 2022 14:53:13 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id f4-20020a056830264400b0066c8e56828aso1695287otu.1;
        Fri, 04 Nov 2022 14:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvvF8Aqd3noj+HWJ7vp4a1Q3rr1/LAyV8Ei+hP/r408=;
        b=TyWryf2gawbSsQjMtIlObThvf/YRhUTh2w1Lpku/zrltIV+DRLTK/8cp5N3SrgInmX
         JPFyjoBz006H9uO75qe8cKLOiySC2WaAueW8yT651lFMszXiMwuEkMDA+2mDWa34jcm1
         t/1+cYhVypN1ITfVOa5RwX3+cHZAyytYBvuXCzYNJzcMm1SFwc6r0bL7fwUAOhwc1uwJ
         4PAJ6laHn69NoUu6w1jkWACf+00jf76eRfJst2YfMnisQpH5L5XcY7LHwTzJlSQqQymd
         I/+mMDNWxmAigo9j36sP18urvVi8oWa8/a2C9d2Q2KaZrnyO9Ll2Hzwyv3/898tPEVBk
         zeWA==
X-Gm-Message-State: ACrzQf2pvD46TtF0tRgtaN8Nu9lEAmkJe2Ecd6xYuMN+RY3/eUllhfuj
        adtAoPyXlGkAUNce6l2/DrG2sSF3QA==
X-Google-Smtp-Source: AMsMyM7Yq2jRp9KgWwkClIjf0/3AFsWrxqfGaUDIl1G07eQkmyvnFAa/bpxE51DY8HV/CDYUb6sj0w==
X-Received: by 2002:a05:6830:1d49:b0:66c:5619:4c62 with SMTP id p9-20020a0568301d4900b0066c56194c62mr13574991oth.182.1667598792775;
        Fri, 04 Nov 2022 14:53:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o65-20020aca4144000000b0035028730c90sm123154oia.1.2022.11.04.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:53:12 -0700 (PDT)
Received: (nullmailer pid 2892422 invoked by uid 1000);
        Fri, 04 Nov 2022 21:53:14 -0000
Date:   Fri, 4 Nov 2022 16:53:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: power: supply: bq25890: use one fallback
 compatible
Message-ID: <166759879338.2892365.17924268048310200238.robh@kernel.org>
References: <20221102182011.106040-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102182011.106040-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 02 Nov 2022 14:20:11 -0400, Krzysztof Kozlowski wrote:
> BQ2589[0256] seem compatible between each other in major aspects and
> remaining features are auto-detectable (by reading device revision ID
> register).  Existing DTS already uses the compatibles with a fallback,
> so adjust the bindings to reflect this and fix dtbs_check warning:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: charger@6a: compatible: ['ti,bq25895', 'ti,bq25890'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/bq25890.yaml  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
