Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A09641C8F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLDLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLDLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:03:33 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C43C41
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:03:30 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3e78d07ab4fso21434347b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti97vue+p1otuKOmCQPiLBpzta3UxRwZ8KEodoJhDPw=;
        b=oZklTmbYW4eMHQrKHSOeyHhw13Ngjifq3jsYm9Ym88iI3PxtwyNVz0LFmy72KM96nz
         myTgieJH5xFjCe4Z7XbjGhbK4QF8IRsaCvhHcuZzupp83tVC/clkY0IeNIr3i/ghUAJh
         zypRMXTTFaI5ULx14ht7r6aalrb9YDNgo4RbTvqmo4/0THPuWl5l1C6AEY3peQhOZq2W
         IRercajv1I+7Jty/vzWxih30Z3bCXogRmQZ5IPYefgy/y0aCAtZ2v12vAj0pI3Ls+7dr
         qVeFN54x5t7T7g1ef/PcUQOTAQVtRdGcLYfHECaP64LaZj4ixJlSoBVrRdbcjc+16bbj
         DIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti97vue+p1otuKOmCQPiLBpzta3UxRwZ8KEodoJhDPw=;
        b=Xb84q9ZaiDdkJHNm6IratzFgzBfvhJ81sVjqIo720da6OuyMos/1OLKWjNfT+AoHDx
         D97G81H2lAbCGhbEaxR8yrzDTk8g9//0XyfcvOCtCcD6ufBgHz7xbniSeOHEnCsVSiJt
         aLcVpUi569b7ecY7Z5XadW+d/6VsuxdYZI8IfRen7GK2NgcEbkTguQbdeV4L9m9mXC9P
         DukVv401+zbZJPqPq3hYVC4p/LMYz9eBrUWUyViV33Obah2jkUZo9eX+YZmmMOsBAAgW
         O+aGf/08skzdVTAs2pPZIEDkI/gRK6M450y6Bx8k/d3gfBUSwTNI3ssDUX7qDFRWenlo
         C4kg==
X-Gm-Message-State: ANoB5pmfeA8js4mjLw99YAauXYBt9NFdbUzCROgGmggh773iKQYRNTGf
        xwespxTMO4rWkKWFptGan1RpJ4HMEWO7XraAqnbJnA==
X-Google-Smtp-Source: AA0mqf6SpcqXBAG7FHVMlKO95gFw7lX4zbHorRCDCx0FmL1/kjBfuZDjeBDSJ+FHIqnYAwVyqEeP2N1mzmnJ9xCfGFs=
X-Received: by 2002:a81:120d:0:b0:3d5:ecbb:2923 with SMTP id
 13-20020a81120d000000b003d5ecbb2923mr18353542yws.485.1670151810188; Sun, 04
 Dec 2022 03:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org> <20221204094438.73288-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204094438.73288-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 4 Dec 2022 13:03:19 +0200
Message-ID: <CAA8EJpqJSAdHh0L_FZZ-_5QowXXmaAxShGOafuvqvd_NcmfnzQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: qcom: qrb5165-rb: fix no-mmc property for SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 at 11:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There is no "no-emmc" property, so intention for SD/SDIO only nodes was
> to use "no-mmc":
>
>   qcom/qrb5165-rb5.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
