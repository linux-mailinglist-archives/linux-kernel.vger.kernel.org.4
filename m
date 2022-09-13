Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159285B6DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIMMv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiIMMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:51:44 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F66F550BA;
        Tue, 13 Sep 2022 05:51:36 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso1907440ooo.12;
        Tue, 13 Sep 2022 05:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rCib1oPKNeqwhjgyZPg5qrlZWJuZ4oIqDxh1dHYtZ8M=;
        b=YJjNmBeGRepVHpfk/808zSHgzfVr/6Pjd6Wj6cVcjvwYe6gOt+26O8AiG0oGHamVaW
         XEMv/8BqrLrc16Py4Sr9WOZpp9AKec7Hg73KgcO97Nk3hLlfe1nwWX/LHEa6VmkrJ22o
         2SXtJA67ll516pZ2iv5IbVIiqydlqs6ay/l+MbKjkkSkdCCti13udJ8q4KMNEdG0EQmt
         wLDzTy1569VnyO7O9A81xJYBb3Fx6g2dQV6LO+wHR6Xt1AUBVhX2W3u2wcZ1sxVh69wT
         OO87Knpoh5JqjVA1jbn0xZ2mJlKBEfXlwabXqzD+gN9kkVIhIt0PPNLW7DebvMn/26NC
         IhUg==
X-Gm-Message-State: ACgBeo2VueXRyRv9Kj7VjJVXJWZJPRlTyayTfgvWeLtCuvkESXPJzLDS
        Xqqfa3ZRQARBOFqCR5CgyQ==
X-Google-Smtp-Source: AA6agR5mi7Jah20YgSuPWfVOtUnnTXJ+PFtSuNgGWRT9VPeGRubhOqoZaY45lklY7gFU99uh/CFu1w==
X-Received: by 2002:a4a:ae01:0:b0:44d:fb9b:ecfd with SMTP id z1-20020a4aae01000000b0044dfb9becfdmr10935773oom.64.1663073495394;
        Tue, 13 Sep 2022 05:51:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w8-20020a9d5388000000b00616e2d2204csm5879427otg.21.2022.09.13.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:51:35 -0700 (PDT)
Received: (nullmailer pid 3472863 invoked by uid 1000);
        Tue, 13 Sep 2022 12:51:34 -0000
Date:   Tue, 13 Sep 2022 07:51:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] dt-bindings: hwlock: qcom-hwspinlock: correct
 example indentation
Message-ID: <20220913125134.GA3472817-robh@kernel.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092035.223915-3-krzysztof.kozlowski@linaro.org>
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

On Fri, 09 Sep 2022 11:20:22 +0200, Krzysztof Kozlowski wrote:
> Use some consistent indentation (4-space) for DTS example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/hwlock/qcom-hwspinlock.yaml    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
