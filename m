Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6264351C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLET70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiLET7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:59:07 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE02C6;
        Mon,  5 Dec 2022 11:59:05 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so14776254fac.2;
        Mon, 05 Dec 2022 11:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEAnu7uzdyKxi6uACyBWEuDTuRvgDtHrA+B4q7yunNI=;
        b=D+Lui1HyMAxPV19DwKn6gzMS4TiVuLqjFN3SK24q6j3RGSrCbn0Iu13/DTK6dUBaPt
         o2lBaFVCFpdKAXYq2RNkHuVN2czGtqrSEbVK4Q5yFYV0GeJ13OG3tuCkonjGBq8vBkWZ
         06j2b/DrnoR4TETqtiDTZytVxGyppWt5O9cPBeTEABgyUHJ2bMRkrKiMk8p/d6SiIKha
         zkYIk3/i815zDvcVhpyziO0REDM93fuARw44O8MoFkT3dpUYbmBhHtxxrtzVjkkLMQ48
         n5oEa6G0OCbkZJLUHv9D/aSgHepdr3d5M0tlKnFf2nyRUej+jOGffrIt627hdqkK4SVu
         cAEA==
X-Gm-Message-State: ANoB5pmm2AVBtGu1chP501r9KZMlmtYygEBzn9raInfGNyaZBw0V1BKf
        a+KZpCm0lgduEETbVTO6aLo6xgQNmw==
X-Google-Smtp-Source: AA0mqf7fMiFCbI8Ep2v3J4RDnUbCcrXNHnij3aDhkcB8B5lNYqwmPndSfV/2xe9bU+mWpxxsCJnq7w==
X-Received: by 2002:a05:6870:9a8c:b0:144:9227:7292 with SMTP id hp12-20020a0568709a8c00b0014492277292mr3959634oab.10.1670270343555;
        Mon, 05 Dec 2022 11:59:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c14-20020a9d784e000000b0066e83a74b99sm5256954otm.35.2022.12.05.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:59:03 -0800 (PST)
Received: (nullmailer pid 2494946 invoked by uid 1000);
        Mon, 05 Dec 2022 19:59:02 -0000
Date:   Mon, 5 Dec 2022 13:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     andersson@kernel.org, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@gmail.com, swboyd@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
        sean@poorly.run, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org, daniel@ffwll.ch,
        freedreno@lists.freedesktop.org, agross@kernel.org,
        airlied@gmail.com, dianders@chromium.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 05/18] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Message-ID: <167027034166.2494886.3657636401660788311.robh@kernel.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125123638.823261-6-bryan.odonoghue@linaro.org>
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


On Fri, 25 Nov 2022 12:36:25 +0000, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 152 ++++++++++++++++--
>  1 file changed, 142 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
