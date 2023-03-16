Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC796BDC93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCPXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCPXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:02:16 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1214B79F5;
        Thu, 16 Mar 2023 16:02:09 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id s7so1854537ilv.12;
        Thu, 16 Mar 2023 16:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmvVqikh6/QfFmFI2mRQ/ucisc+hDn58SbNI9LqJ9zo=;
        b=ZfbxPn2ZkD7QhRrZnhy2sCWMhNbtRwqwtVTQNM12WkYgv3mwvTnz0j0t22Z0EHTyu2
         R5uaL7xUCxRkubk0pJ++419V/nIYhs7PRPr0xJ36FCzLw3hFr2KjZ3Z+AJP1OUY8HSWi
         hGX7kmYEjkWnuSHmSyyL9jdifogAaBPCnD2rN6aJb21RdpySz+1uJ8Lo77DLddL5ZeQs
         G9bJhkGxecX0qdCYzUCc0Fzb9OoRjSECvjaMkdV9a49KgoNJWKdALpWVOAzp4CJlC2oz
         P7QFV4b3f10E0ddq+ADca5fw2o/ze+xku6jU64JfVID6z3v8L41Z3Tg5sD9Na4PlYQ8f
         u+aQ==
X-Gm-Message-State: AO0yUKWtTJrKgveNR/XQd6DRkwQeg+15jtougoRrIiqlKpIGy1LG1PBD
        41/pOJoqY2T6QFwMG+QIIw==
X-Google-Smtp-Source: AK7set97s+LrVQ8SM6AoTfldDY2gHz8mZ4cqgjWw8tkYxBdwoe91TMbdBuhB9E4oFi3bgv6kPBnIew==
X-Received: by 2002:a92:cb0d:0:b0:323:162a:80d4 with SMTP id s13-20020a92cb0d000000b00323162a80d4mr7794023ilo.4.1679007728267;
        Thu, 16 Mar 2023 16:02:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i21-20020a056638381500b004061415b230sm165988jav.117.2023.03.16.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:02:07 -0700 (PDT)
Received: (nullmailer pid 4048220 invoked by uid 1000);
        Thu, 16 Mar 2023 23:02:06 -0000
Date:   Thu, 16 Mar 2023 18:02:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: qcom,sm6115-pas: correct
 memory-region constraints
Message-ID: <167900772534.4048165.9681291463665388117.robh@kernel.org>
References: <20230309082446.37362-1-krzysztof.kozlowski@linaro.org>
 <20230309082446.37362-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082446.37362-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 09:24:45 +0100, Krzysztof Kozlowski wrote:
> Qualcomm PAS devices expect exactly one memory region, not many.  Also,
> the memory-region is now defined in device specific binding, not in
> qcom,pas-common.yaml, thus also require it in the same place.
> 
> Fixes: 838c558bb8bc ("dt-bindings: remoteproc: qcom: Add sm6115 pas yaml file")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml        | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

