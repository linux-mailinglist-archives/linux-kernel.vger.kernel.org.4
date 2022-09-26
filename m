Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC55EB555
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIZXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIZXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:17:32 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D21A6C63;
        Mon, 26 Sep 2022 16:17:32 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1318106fe2cso91067fac.13;
        Mon, 26 Sep 2022 16:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XPxifbNAU1DUL4dDAEIQOBkOb7fyjx4kZQiFyJ7rwrk=;
        b=RNf2QJf2C3jiA0I2btBTJp9k4OffBA4pxKtlpiO/qINiEJB7z/g09BZ2zhYNrrxsFn
         3G72b40FECCmxMe4Qv7diSlCQF7Tj8DtqPtWhy3koQTwqeZDwe6iOOIIrY9n91SB2OZt
         BvgG1/h94lld0HoQmqS+jyAbjUkUeEf/By7mbXT6J39bLaeMp3WP/Gv8QRM7+AEsjclG
         30H5K04e2hGyVPJmJJ60ojxsEfIdWJ3/jJIwwgatV1OpJ74uyJSnwppLaLWCVmF/rZOv
         0VOJ9KxWINxb5YafH/aDOL27n9AwRMeuzCcCT1phDtL1NNaxzSEErFNDGPuYJigdWsmU
         aMqw==
X-Gm-Message-State: ACrzQf1L1vaMIanBqgU34UkOPcQax3d1xSEDSaZNNYLOsukKDca6dZ2y
        xVikv8Xv1LbU1Z34I7ZHF2eCqA5xLg==
X-Google-Smtp-Source: AMsMyM4jP5+Qy8Fb0PQyXJTBmk40lcKCj2d+gGM9oarCI9IbKAAcJ+3cK6apgWWibrflDUGRZcU+dQ==
X-Received: by 2002:a05:6870:c146:b0:131:6110:a456 with SMTP id g6-20020a056870c14600b001316110a456mr610973oad.136.1664234251267;
        Mon, 26 Sep 2022 16:17:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d7-20020a05680805c700b00342d207e68bsm7759583oij.37.2022.09.26.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:17:30 -0700 (PDT)
Received: (nullmailer pid 3154922 invoked by uid 1000);
        Mon, 26 Sep 2022 23:17:30 -0000
Date:   Mon, 26 Sep 2022 18:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
Message-ID: <20220926231730.GA3154888-robh@kernel.org>
References: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:13:12 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
