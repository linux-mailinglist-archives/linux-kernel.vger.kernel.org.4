Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0F6EDB01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjDYE6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 00:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjDYE63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 00:58:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA248A52
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:58:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso8059334a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1682398705; x=1684990705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0Eu6RwlDMBI2VACTLVW3OyI+qTBgEnmFpIUv7kN7Xg=;
        b=f7goMULptLM/h4aCQSheJXz1NcaoQxEI6Y09Gh8UZTO77/S24BAPjTWfUCQvp4jqNX
         qaAnVant+f04AGkWz61s25P0VxS6cO0gxQSRz+l9tfT/E6rCBaxrTHC+EyAn8iCDtgKY
         cV30I4N67+Tl6b8aNJCy7WUOEt91S4PrhzlZ1sLAx6WKXGdVvBm4KuG0e0TY1Ut3gNj2
         R+jAy3FVLCXRZpzRCYtr06tBO4ZaVPmHAPQmTGZsxiiWpFWPMOmNsvokQBJoh044w5ig
         RPVeNSJf/y1LvkvIBPi003s3V8hIcycBahJjyKKt89NOrJ+OwMfFKYNeI5VJdefT7W+M
         5WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682398705; x=1684990705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0Eu6RwlDMBI2VACTLVW3OyI+qTBgEnmFpIUv7kN7Xg=;
        b=Qb0JicB55YF1QRK65hgEAlA8SYKVxcMhnN3poZPUMzaWa2LovvirYqpev8HZ14qzGW
         w8bldkL7KS9+7XU8OKivEWUU1WQDIK25jppYuI2TW3+GnbW1iOyXdMtveQpKNq89+Dxl
         7VdnXidAVYdXSQzZInK6PYwCSjdPd7W6TDChjMVvbY+r9czBlCIWhGN/B8dZeAP3j0rI
         bJLPz3FA50kNJqMWzXMx/ShgQi7sHc2dx6M4JTixTeaTQFDM/Gxu8arGdRHZ4Dhpg5o3
         99yxeFToPKZ+PYFhAwk3ff0m5+OG3R5qPet9DvMqzFNfeyFowolx++m/f02kZGDrWflb
         0Krw==
X-Gm-Message-State: AAQBX9f4UPc8UxqRBaYW7GeBnqIG/zMd42C8KLwU8txljpqJtCPKFhvP
        ip0QWRiPsX1XHEfDVaJ2OPuP24+4HZRDkUEgfl9ti4Iijw/plsGAt/8=
X-Google-Smtp-Source: AKy350auphzv7gCr2o8Iiur9PYK2zIXYRVW6d8MJgcNm8GMQeGwmvI+FOwh/BdkzaQO41xURDxBCvys3dBu3FMP0kdw=
X-Received: by 2002:aa7:c916:0:b0:504:78aa:4f2d with SMTP id
 b22-20020aa7c916000000b0050478aa4f2dmr13658270edt.0.1682398705333; Mon, 24
 Apr 2023 21:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 24 Apr 2023 23:58:14 -0500
Message-ID: <CAKXuJqiL6_Mrh07HrBm6hMc3wZkW7vcfxR3_+h4_pY6hjMf2XQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] phy: qcom-qmp-combo: Support orientation switching
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Apr 24, 2023 at 10:40=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.
>
> Bjorn Andersson (7):
>   dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
>     orientation-switch
>   phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
>   phy: qcom-qmp-combo: Introduce orientation variable
>   phy: qcom-qmp-combo: Introduce orientation switching
>   phy: qcom-qmp-combo: Introduce drm_bridge
>   arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
>   arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
>
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  51 ++++
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  28 ++-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  28 ++-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  34 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 227 ++++++++++++++----
>  5 files changed, 309 insertions(+), 59 deletions(-)
>
> --
> 2.39.2
>
Thank you! I have been looking forward to this patchset for a while :)

Tested with 05ac:1460 Apple, Inc. Digital AV Multiport Adapter and
0639:7210 Chrontel, Inc. Billboard and both work with orientation
switching.

Tested-by: Steev Klimaszewski <steev@kali.org>
