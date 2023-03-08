Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA96B14E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCHWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:36 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003E95467;
        Wed,  8 Mar 2023 14:19:26 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id c11so251934oiw.2;
        Wed, 08 Mar 2023 14:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM20CAq7ARPknGk2Dja16aPHXClqGhFO6N0YJRwPcEM=;
        b=pMBQ6ZVSis5PnlqcUjjObV2iws2X99vCPPIzvI80Fl1oaBDF9I7eMSY64B1Va3ESuN
         3vT/HJKgwjxGUb95Gzr7i9fzxW4D85a+7tI2kQPya7IRVyB5yf6+6BjytiWFv7Loxk5X
         JUH+almFfGPHZ9CZPnarl0lvjhlRJvx3/yMR9W2kbowKux33ilOzuqoGGq3ZzOzSWmdO
         hHpGG0HVBCBj9IB6SK/jAkjD20zK+9quKur+i/TzVboz4rXfHeI0bapRTJzBk9PXNMF/
         ooplYfV69Cl/1tLvFo5QsLXIL8tEeGDenTpWpKq9P5beFPxiiTh44D5/RIPyvRISiqBC
         DcVw==
X-Gm-Message-State: AO0yUKVcewRgCsL+HSwVDK9Ly5QmEzOn5CLEHcuhMjRqe9lBIjwB1RHU
        fFW3zo38zX3zq4+BaS2b/MJ/AwajUA==
X-Google-Smtp-Source: AK7set9rMbr3UxVYnU9cuQy+4F93CfhxTFIuJDyb4tCFesMdTXG2yXEa+qzVtOpAoijDwmvD7lirkA==
X-Received: by 2002:a54:4103:0:b0:378:2fb7:f6a6 with SMTP id l3-20020a544103000000b003782fb7f6a6mr8092737oic.45.1678313966243;
        Wed, 08 Mar 2023 14:19:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q65-20020acaf244000000b00383e0bec93bsm6787375oih.49.2023.03.08.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:19:25 -0800 (PST)
Received: (nullmailer pid 3947628 invoked by uid 1000);
        Wed, 08 Mar 2023 22:19:25 -0000
Date:   Wed, 8 Mar 2023 16:19:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: smd-rpm: re-add missing
 qcom,rpm-msm8994
Message-ID: <167831396365.3947549.16567147910185285587.robh@kernel.org>
References: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 05 Mar 2023 13:24:28 +0100, Krzysztof Kozlowski wrote:
> Re-add the qcom,rpm-msm8994 compatible, dropped during conversion from
> TXT to DT schema:
> 
>   apq8094-sony-xperia-kitakami-karin_windy.dtb: smd: rpm:rpm-requests:compatible:0: 'qcom,rpm-msm8994' is not one of ['qcom,rpm-apq8084' ...]
> 
> Fixes: f935a752f229 ("dt-bindings: soc: qcom: smd-rpm: Convert binding to YAML schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

