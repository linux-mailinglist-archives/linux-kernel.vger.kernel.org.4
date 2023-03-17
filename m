Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F06BF391
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCQVIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCQVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:08:47 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26E132E1;
        Fri, 17 Mar 2023 14:08:44 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id b5so2904996iow.0;
        Fri, 17 Mar 2023 14:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdeUcwkFIlQZgUxwb9drUJ0ySipAOYm/0rfwO/4aPpc=;
        b=bkiOdvSn/r8DwZBdv60mCtoQ89Iqkz34XsonM25DNdhL3055k7zFyqnEwQ5JHFFww5
         nyzjccewt6mfuZlPrKYDCCsWdkR5mUP0t87PywUrXwzCb61XEQ7YPDBcbzxdYNQEA8Ly
         6keDvt5FdedNrAi7Fx3CkKoqAThPsllIGxUn1+Mei/CLO3LNyEajAa62+8T1ZDCCIrlX
         OekOKPuVyUV8PPpoHaZL78iQZWJ5J4v6fAgBuRxq05My66ibh2bzbVvbp280n9Wp6Odv
         pmgdkO9T1tXJm0FlA0nW6kwCGOzyKgrYA2T0yBPbgOZuD0a7yx45WdwgSBgkoaIuVSxa
         8t3A==
X-Gm-Message-State: AO0yUKX/jfLmF7MxGYYuigpNVGvRlrsJNUVHaVSC9xw8qvmbEo8fcoQ5
        xIDbGp2CP/EW1f9iHAaBo9iRyl5m5Q==
X-Google-Smtp-Source: AK7set/45EZ0ycQziEup4cQDERJPhpjt1goKHYTferZIPv9k8kJlp/ltPTbLDADiGGRyyml6jh9xqA==
X-Received: by 2002:a05:6602:180f:b0:74c:97ee:3e56 with SMTP id t15-20020a056602180f00b0074c97ee3e56mr547729ioh.19.1679087324160;
        Fri, 17 Mar 2023 14:08:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p5-20020a056638190500b003ff471861a4sm996551jal.90.2023.03.17.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:08:43 -0700 (PDT)
Received: (nullmailer pid 2808633 invoked by uid 1000);
        Fri, 17 Mar 2023 21:08:42 -0000
Date:   Fri, 17 Mar 2023 16:08:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 03/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 use fallbacks
Message-ID: <167908732148.2808553.10369606745080518223.robh@kernel.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314080917.68246-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2023 09:09:07 +0100, Krzysztof Kozlowski wrote:
> Rework the compatibles and group devices which have similar interface
> (same from Linux driver point of view) as compatible.  This allows
> smaller of_device_id table in the Linux driver and smaller
> allOf:if:then: constraints.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 58 ++++++++++---------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

