Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B46437C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiLEWLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:11:12 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105CC12638;
        Mon,  5 Dec 2022 14:11:12 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so2612569otp.9;
        Mon, 05 Dec 2022 14:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ralaIRtcH3bKJ2EdfuH0z+9DVU86PUeEF8RsXgkQ2Ag=;
        b=GkElIwMnGYYkakzqhjhMdtHP+FRhPP87ITsTpqPbhg9gkVXhsKu92yFHLYWTVBMrvN
         xfa07Whjw75vjkag96y4AClfGMx8Fz+JTvTOBIdigrfhFX2CviK30YpX/owMixvhGKon
         3KFlaL7tPJ78uwNsanLz1gx2k014i3/PKpnghtVjgj8YVPr8l9xBWhGyL3VOA5EMaoyO
         BF01qFxdafr5S2TvcVFC0lGtPRw6ke6v6lDFkHsSo7Pi/lMVW1SJ+/tqFoBud916In27
         2GlxnNM21yHLSzyibU3waTEvaQpx0lKokr32fNdmE2VJDZQ8w5IOX78GVopxieJZf/qf
         OAgg==
X-Gm-Message-State: ANoB5pm7Jo4zZzKp19eVXzhH5x11vcVaQqbBGb1SmwMBKXbrBAqextfw
        ztssH+6bWdyud0sbj3qHHQ==
X-Google-Smtp-Source: AA0mqf7pxK8NYoHFZhdTULJUfbXlgm2GELhXPB7cFNCWoFxNQ+rlkBvQ3SFaHNpElJYmKBZxPg/Stw==
X-Received: by 2002:a05:6830:1f2e:b0:66c:5279:1281 with SMTP id e14-20020a0568301f2e00b0066c52791281mr41548002oth.384.1670278271249;
        Mon, 05 Dec 2022 14:11:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s16-20020a056830439000b0066c7733be43sm8323758otv.30.2022.12.05.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:11:10 -0800 (PST)
Received: (nullmailer pid 2778416 invoked by uid 1000);
        Mon, 05 Dec 2022 22:11:10 -0000
Date:   Mon, 5 Dec 2022 16:11:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: mmc: sdhci-msm: drop properties
 mentioned in common MMC
Message-ID: <20221205221110.GA2754803-robh@kernel.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
 <20221204094717.74016-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204094717.74016-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 10:47:16AM +0100, Krzysztof Kozlowski wrote:
> There is no need to explicitly list properties already brought by
> mmc-controller.yaml schema.
> 
> Fixes: 8574adf5222d ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")

Redundant, but not broken.

With 'Fixes' dropped,

Reviewed-by: Rob Herring <robh@kernel.org>
