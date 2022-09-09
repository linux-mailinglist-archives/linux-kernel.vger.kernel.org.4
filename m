Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCB5B3ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiIIOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiIIOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:39:57 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639F2DAB9;
        Fri,  9 Sep 2022 07:39:52 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12803ac8113so4383119fac.8;
        Fri, 09 Sep 2022 07:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ftf0UiBiLz6oFjDNarvElWVwFaQsvk8ZXx/a/CGTdUA=;
        b=glcYjFQn/spcxFV3Xbqgd1TpuMc+lKgGTMDl/afa5uuSuN9Hqk3gsmqQ/a71Z+Zzin
         vxsJXgeltKUv0GrQNHv+yS9IHGJHVAkKzscA+99dS32t25oaA5oN9S5lKTA8yMrnRcdX
         S3qJHTgamA1onWuW/VWt58hnEwLyZ2z7mKuLIl/NpH6cbUB4Ni5Z56p39u0bJu0ZoW+Z
         +WH0YTyxL1XQMyPRJpUNwGQhrCbAZYL/pe2B49iJBTSRoTsRsXUor9qF0nJAa2lESmr3
         dBuJMPeu19jEYJCEyr1G4gKOz00fv2ieRH0vylSGv4QMuayTjyF05u7JJmtYuOdClunY
         hvjA==
X-Gm-Message-State: ACgBeo12AK38bKgxJ8W0Zy66aZGTo7J0Van8MAz9sMVJuVPzEO5RwUfD
        9eGn6PWAL/0+b8BjUofqCg==
X-Google-Smtp-Source: AA6agR5sH9jO7ewRPhu2gd//ThcK3OpubXNqMdFFa9cMj5yim/Bj6Us12fZJ2x/42Jw0BfKu1F4DjA==
X-Received: by 2002:a05:6808:152a:b0:344:c8d1:27e1 with SMTP id u42-20020a056808152a00b00344c8d127e1mr3922484oiw.294.1662734391944;
        Fri, 09 Sep 2022 07:39:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 19-20020a9d0113000000b006391bdbb361sm340925otu.31.2022.09.09.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:39:51 -0700 (PDT)
Received: (nullmailer pid 1025314 invoked by uid 1000);
        Fri, 09 Sep 2022 14:39:50 -0000
Date:   Fri, 9 Sep 2022 09:39:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom,pdc: convert to YAML
Message-ID: <20220909143950.GA992904-robh@kernel.org>
References: <20220103074348.6039-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103074348.6039-1-luca.weiss@fairphone.com>
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

On Mon, Jan 03, 2022 at 08:43:48AM +0100, Luca Weiss wrote:
> Convert the PDC interrupt controller bindings to YAML.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v1:
> * Adjust description of second reg-name as suggested by Maulik Shah
> 
> @Rob Herring: Hope it's ok to keep your R-b given the above changes
> 
> This patch depends on the following patch, which fixed sm8250 & sm8350
> compatibles and adds sm6350.
> https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss@fairphone.com/
> 
>  .../interrupt-controller/qcom,pdc.txt         | 77 -----------------
>  .../interrupt-controller/qcom,pdc.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml

In checking top compatibles without schemas[1][2], I found this. Now 
applied with sm8150 compatible which was the only change since this.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/3005191129
[2] https://gitlab.com/robherring/linux-dt/-/jobs/3005191129/artifacts/file/all-compatible-warnings.log
