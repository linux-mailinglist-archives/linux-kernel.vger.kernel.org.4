Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7665EB194
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIZTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIZTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:49:20 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EE833E39;
        Mon, 26 Sep 2022 12:49:19 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13122bfaea6so5592237fac.11;
        Mon, 26 Sep 2022 12:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UMwkKadJ0/5HLZm3zoj184hv2XmPHwMNmeiEsetgdTQ=;
        b=b7SmT1hLGf+iXLH6V5cfo9SH8TXZjcmTqu0K3L5F/vR4HHX1/mvdPzdiuTH9x+l0YG
         WTuQWLgpoEtFtuVN4S9a8VIH3pKRtHcJsu1wbVyWI7esbtAcjWVG739UIuxSs0MGJ50O
         kz9O4x6ABwPBT+2RumV+lUUTDHb6lsmLXHo/Wc/BR7xdzL9aiwu/tBLFbDgbdmAwCsPI
         xfoWKvhFSbFRW3K243hssmUIK9dWhzdyWyKYK3fGITzPLnwoq0AVcWrA6CCaFAdwueXW
         ME38Bpw8uJ1JU+zUBvbixRpjOwh7mV98a/2H4Y6qtKHJaBTHyfJxwMAmFkjnej8kO5u8
         3j0A==
X-Gm-Message-State: ACrzQf2vlmM1QwTI8eU9g4R+xcK1ZkHULG8OWZCcGhKQw+TIupocs+GS
        dx+/CZg3+3SI69eLS7FM2w==
X-Google-Smtp-Source: AMsMyM5XE6C4Jth6p5sil02dicjWQ5cB+ydqIw6WBbiLhZ1bxYqGlBDsWpH9xYQrkLyO0D7PQLnHMw==
X-Received: by 2002:a05:6870:b414:b0:130:ea11:761c with SMTP id x20-20020a056870b41400b00130ea11761cmr214439oap.62.1664221758824;
        Mon, 26 Sep 2022 12:49:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cj26-20020a056830641a00b0065689e13f52sm8182679otb.71.2022.09.26.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:49:18 -0700 (PDT)
Received: (nullmailer pid 2678987 invoked by uid 1000);
        Mon, 26 Sep 2022 19:49:17 -0000
Date:   Mon, 26 Sep 2022 14:49:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwlock: qcom-hwspinlock: add syscon
 to MSM8974
Message-ID: <20220926194917.GA2678852-robh@kernel.org>
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
 <20220920150414.637634-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920150414.637634-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 17:04:12 +0200, Krzysztof Kozlowski wrote:
> The TCSR_MUTEX region contains two set of registers: mutex and halt.
> Add syscon, so the TCSR mutex device (hwspinlock) can use MMIO based
> method and in the same time share regmap with other devices for the halt
> regs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/hwlock/qcom-hwspinlock.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
