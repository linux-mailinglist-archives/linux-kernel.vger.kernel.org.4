Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A95EB4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIZW6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIZW6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:58:07 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234877F262;
        Mon, 26 Sep 2022 15:58:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127ba06d03fso11212000fac.3;
        Mon, 26 Sep 2022 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=epyIDE9t3WUpMt89cRPv2cckD3O12ExvX3hn7aJqqwU=;
        b=QljuZnAbuY+/kvTGf6K4BwJTPcR2DksdD7lLYOFbMti/0IQrCWE9nKxH514C+KTnJc
         O2JNL9OLUT6jfwaVtpOxTJBmI/RpUE/qIg0lyJX188DcHdjxHaEPuIslpImyCnsnhF8v
         a4AuhXRzL5F+efQPcOthkBxnXzFXRsKBUBbijYr0aYgysJu5VNAG+2nCg6sg3W5Vdftn
         jcpfKTCLNrmZ54FaeZaryGj94RhhGuxtxywte5xoay7YwcWyZ+fxSKEBmO8bdehrg3wU
         eHGUU4l035sQ23Np2w/92Y8iA4/cvp13erfhF2OYyv5jFvJu1ubXqnI69XvQl9xQNEO9
         tswA==
X-Gm-Message-State: ACrzQf0ric7UTULLBim2uTj9JmR1qjf6XG+7wZ4ULeS+Qy7+b8ByfmlM
        3QQrmbxkTQIkk7g6erPgV19GmZVrhQ==
X-Google-Smtp-Source: AMsMyM4Y3XzNfRebEVuyawLZnrgxtX+upc5Kkaue5quLOYpoJkfUPf0wfRF02DeA4T6MtSd44EbMXA==
X-Received: by 2002:a05:6870:b684:b0:127:aefe:eaee with SMTP id cy4-20020a056870b68400b00127aefeeaeemr599766oab.53.1664233086342;
        Mon, 26 Sep 2022 15:58:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a056870b41200b0012d6f3d370bsm9829017oap.55.2022.09.26.15.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:58:05 -0700 (PDT)
Received: (nullmailer pid 3120697 invoked by uid 1000);
        Mon, 26 Sep 2022 22:58:05 -0000
Date:   Mon, 26 Sep 2022 17:58:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/11] dt-bindings: slimbus: qcom,slim: convert to DT
 schema
Message-ID: <20220926225805.GA3120664-robh@kernel.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923161453.469179-11-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 18:14:52 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm SoC SLIMbus controller bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/slimbus/qcom,slim.yaml           | 86 +++++++++++++++++++
>  .../bindings/slimbus/slim-qcom-ctrl.txt       | 36 --------
>  2 files changed, 86 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
