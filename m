Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C05F3445
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJCRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJCRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:12:14 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3E37FA7;
        Mon,  3 Oct 2022 10:11:29 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso7157913ooa.5;
        Mon, 03 Oct 2022 10:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0pChhc/ijadlRrXN0j65OuMGvd5FGIUzE21sQ+v/NZU=;
        b=TWzJJAaJSIMgl71C2yD3KWyFirHig9pfs4aak64rChZ+x3tL3OL/Bvtty/tqzgwOBF
         QK8gXPnbZmaw0pwK7AbxC0yHdpkANX9qNRXZ2wmUzvRGL51DuedQrC0OwjeKM39GoOc5
         JqMm4xlnIlnxhWH092dQzeO80LKB0D9xas2uFlv2hUQuD/OtT6a2mOLXw1+j5w64XD75
         B4MK2obxZdbsTDeE/RuqP3asSBkEg/ApZihe1xrKOKo5BMMIjEUoKLu+n0nJ0U9vGJGI
         cDSFzTlhSSrLfh73J48AbB9KjkVaNtT1nBUhSv+rkdKk+JXGM86rW+bH0/DJ+aWT1UuX
         csnw==
X-Gm-Message-State: ACrzQf0BPZidTtcpC8gjB721bCBPrFE4nxjwzDIcMxU5yNd/N105bEeX
        FuFsmuqt0d7aJDXpcK+dQQ==
X-Google-Smtp-Source: AMsMyM4vttxcn4QeYiNAvWlVgrfAPCvK/z+zYNNEyBVexFtkVkvU6QI/EClXE3whsVoUHsd/AH6KvQ==
X-Received: by 2002:a4a:a70a:0:b0:475:601f:1e14 with SMTP id g10-20020a4aa70a000000b00475601f1e14mr7942423oom.5.1664817087589;
        Mon, 03 Oct 2022 10:11:27 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z187-20020aca33c4000000b00342d207e68bsm2549765oiz.37.2022.10.03.10.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:11:27 -0700 (PDT)
Received: (nullmailer pid 2460517 invoked by uid 1000);
        Mon, 03 Oct 2022 17:11:26 -0000
Date:   Mon, 3 Oct 2022 12:11:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sdm845: convert to
 dtschema
Message-ID: <166481708590.2460461.9509973949497064599.robh@kernel.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
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

On Fri, 30 Sep 2022 22:05:29 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SDM845 pin controller bindings to DT schema.  Keep
> the parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 176 ------------------
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 158 ++++++++++++++++
>  2 files changed, 158 insertions(+), 176 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
