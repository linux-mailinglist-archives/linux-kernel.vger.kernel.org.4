Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8E5F6E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiJFUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:06:57 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F61BCB99;
        Thu,  6 Oct 2022 13:06:54 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so2163027oop.9;
        Thu, 06 Oct 2022 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80q+U5/dIlTPVlYfuTJ0XFctEk9b83bIYA3FjUO6hsc=;
        b=nq8jZIhp45ZAVOgaJEAy7ZoCeDadGBGSQ/6DRTgfGauQ9fZ7CSbomHpcO+LXzQKk9I
         IRGpc1A24xqbDEssMfaz6f/BGdRKcQmWlRiFckShuC9/haa6Sg80d6KxiY7HZ+nPmLpm
         d6s5vYb5NgHoiQ6lgeIpsuvzZiTZ1y+a77ybRORgvAONunhunFNB2RA4CvQZc5GzwB9V
         B87hFMcEEDP8kFv5ZLTH+nwg0kttvlzdpKTGHYioqrA/Pw0xBo74qIq5B8Zx44p/NcDP
         AooxK1I2iXKYptZwr7okWtrKlWGqPN4GTaX88NWnXHWXX7vzCAMSLNLqxEcFje1Kn4Tu
         PP+A==
X-Gm-Message-State: ACrzQf1+SgoUWuR4BVbGySKXw+bJ7huuijoSCSoQcZf31G3CerGIsLoM
        2oGdaraDS3I2TvnzTFmRoA==
X-Google-Smtp-Source: AMsMyM5zRHuuD+i7mKe7Be7MeoXuRrMDqrFVr5rc1SiyNZeMcIRrIrkxOCUcAkp0If3rh1/vOq8tSA==
X-Received: by 2002:a05:6830:1e4c:b0:659:eca3:2c70 with SMTP id e12-20020a0568301e4c00b00659eca32c70mr687374otj.210.1665086813610;
        Thu, 06 Oct 2022 13:06:53 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870c14100b0012752d3212fsm278337oad.53.2022.10.06.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:06:53 -0700 (PDT)
Received: (nullmailer pid 88604 invoked by uid 1000);
        Thu, 06 Oct 2022 20:06:52 -0000
Date:   Thu, 6 Oct 2022 15:06:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: pinctrl: qcom,sdm630: convert to
 dtschema
Message-ID: <166508681103.88478.10236771403142846231.robh@kernel.org>
References: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
 <20221006104104.171368-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006104104.171368-4-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 12:41:04 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SDM630 and SDM660 pin controller bindings to DT schema.
> Keep the parsing of pin configuration subnodes consistent with other
> Qualcomm schemas (children named with '-state' suffix, their children
> with '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml | 189 +++++++++++++++++
>  .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 191 ------------------
>  2 files changed, 189 insertions(+), 191 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
