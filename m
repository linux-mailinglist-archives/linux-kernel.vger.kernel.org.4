Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2996D6D7DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbjDENni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjDENnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:43:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125354C19
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:43:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l27so36276784wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680702208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91zpGfc1a4L74i5yjY800PRBiUccdNyLDZUTPZtClIM=;
        b=fYuMeQ/jyRYzCPZSwSv+LxC+ky2mQ+a8Vsojki1W1EUk4o0Qxf8UehggIl0LPruQHk
         bDlJCGe46tinBLb34DAlpGqlxlSfq13oD44hc6tZyJ6oEUEjWE/mGYQs+6VLF46BlfT8
         leZEKJvqcO7ENOVpHQhg+U2Rwv6B+gvs55IV9+JX8AFsp1F0k6p6XBNFhREXxum7WJkQ
         hDjJ+50b3KA9ni2WKyD2hRaeeGs7MOxrJbCJZu8QMZw7fvwDjr2T8YbpzVeSRh6jB4M1
         xLpT2KXx2MZc+tU1Cg6VklfnUd42yPAlVKJJNAhFZFH6sTpjz2XwsyGLXd+NN8Y+I37D
         QUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91zpGfc1a4L74i5yjY800PRBiUccdNyLDZUTPZtClIM=;
        b=cZFH2XtfMK+D87Ldj49kip2csZQxQJTph83Vl1vZYQMKngM0aofFTH3TBpfHUsRUfJ
         C1KI+3tjcSHaKcEMFakv89+qldgah/8r3Oy7V5bx4nrtbzWUBVrLFyJY9pRvrl0K1DOm
         txgzPrAgLkP+93KU/t27pqXKySoyA803bxss8eM81u9iefyEplDeITNuKXTeSEJUhZfe
         Yy/IHIehKY6eQcFfJAalUJu/RnkaVvPQ0s6gNwu9zZH8rH4vPR+DspiUH5+XX6Hl4lVG
         fZeRIEAxY8amJqs/N4mSK9giIStG1b01NUrFM5UaKGk0codXdcmHYHLD3EZsdnUSL3Du
         +hgA==
X-Gm-Message-State: AAQBX9eTJ+lA3dBMMDAPoJ+VmaASq7yV6STd7ALBbpgd1qzvwda/8Oo6
        fEbAn6qj5WoD9cFUkmU2rVYEhh+Fw78uvOH61bmfAg==
X-Google-Smtp-Source: AKy350ZaLcMHG+5zgfFflSVokVyqata0DNKN7cBymBE0f4C4IzGeqoPndhBChYUnv8Dyl5UEhEkAps+0WiJAzKlYhwo=
X-Received: by 2002:a5d:4572:0:b0:2ce:ad09:4d47 with SMTP id
 a18-20020a5d4572000000b002cead094d47mr1176570wrc.4.1680702208456; Wed, 05 Apr
 2023 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230401154725.1059563-1-bhupesh.sharma@linaro.org>
 <20230401154725.1059563-2-bhupesh.sharma@linaro.org> <1403741d-ef51-a9c5-821f-358c8f470dab@linaro.org>
In-Reply-To: <1403741d-ef51-a9c5-821f-358c8f470dab@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 5 Apr 2023 19:13:17 +0530
Message-ID: <CAH=2NtykGGcYHUTTzHMA7ft3eKAbGtrO4tN4dnLdg5cjE-N9Gw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: qcom,qmp-usb: Fix phy subnode
 for SM6115 & QCM2290 USB3 PHY
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 15:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/04/2023 17:47, Bhupesh Sharma wrote:
> > The USB3 SS (QMP) PHY found on Qualcomm SM6115 & QCM2290 SoCs is
> > similar to sm8150 QMP PHY in the sense that the phy subnode supports
> > 6 regs, namely TX lane 1, RX lane 1, PCS, TX lane 2, RX lane 2 and
> > PCS_MISC.
> >
> > Update the dt-bindings document to reflect the same.
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Bhupesh,
>
> Can you use scripts/get_maintainers.pl to get the Cc addresses instead
> of writing them manually or inventing?

Sure Krzysztof, will do.

Thanks,
Bhupesh
