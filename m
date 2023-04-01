Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C866D32EC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDARih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDARig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:38:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D162611EA0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:38:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n19so14742517wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680370712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHBqzvO5WDF7u1QGl2TVozBLpKV5U1kYxV58riFi8bw=;
        b=SgS3eQ4kYIH21i5cm+mF/DDDvzngA6KKbO1WpgO/LPuN5FY5GM+lekU/FVq1y+8EJD
         MRam+XzmEwdVGfLEOdhvx93vghq+Ium2Fo6yKXT87E1lPuqJji1/p9q3SnKxq4auUF2y
         lgVbo+XnH5xVPHazmUeYFFezkfR0b4+fiVqT0Lb298oWbfvxVXRnAMC1tY2TUzairR7e
         rPZBtDJCPlp4ei2zqyaWCGhEsUQsjGljhuSDg6Okf69kJIJHap3wFoteewv/1N9IY470
         ybH8em+pav3/cmA3ItQMh1ChKR0kZnvU3qPfsQmkeu5JWuEk8ltssFckt7gmKqMqxx0E
         sbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680370712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHBqzvO5WDF7u1QGl2TVozBLpKV5U1kYxV58riFi8bw=;
        b=HBIqe4gsdMUlJTRzOGmUcMjgKiSLKEe3zs8M7fAcDb9dJpWNmgSv6E6rO4nkL3TxIg
         uzDclNckd6mBf4gI93f/Uyj0Ijv5Ymsoi3gICvqjY8WGc0R9gArzEpmQOWVbbgln2Ur6
         NUmTccdBEfgNIy1DDC4NDr5qXI2HUS2O/rEcG3j3+seLE/WnidYINjIjOy2SYYmbCf64
         eiXtWuUFxOHP9ICcw8uWaFfzh61gmCu3rZFvnty84rCuuV+QJ4dEDsGunXhbgZZBrH7I
         +Mo2GlIAJhYpr+Ha4ZolcBcYVdt1ffhghjOQnZIdH78/7y7HS5ardA+GY8EY4z/7w4YB
         aJpA==
X-Gm-Message-State: AAQBX9d5NbIEzDBgoyE6DA0RYHE8/4N+TYI/sj4c6cKwChUWokxvP6vo
        O1lA5qoqbNC4I2VdkFJum9iQ0IO0AMBo3YbLyQQ3OQ==
X-Google-Smtp-Source: AKy350YmqYab5PN4atg2Mmis8zj/LaW7ayPF8nUWEyPaE6kOzvJ/fYUrWfKLzrKDc7XO9LEeVGx+MwYR4u8ZPoyz1GM=
X-Received: by 2002:a7b:c8d3:0:b0:3ef:6935:da8d with SMTP id
 f19-20020a7bc8d3000000b003ef6935da8dmr5713659wml.8.1680370712243; Sat, 01 Apr
 2023 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230401154725.1059563-1-bhupesh.sharma@linaro.org> <CAA8EJpq4O-=Qd5cS=yKiBzkHcUSWSL7HarFy7WknYpF=FkDOoA@mail.gmail.com>
In-Reply-To: <CAA8EJpq4O-=Qd5cS=yKiBzkHcUSWSL7HarFy7WknYpF=FkDOoA@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 1 Apr 2023 23:08:21 +0530
Message-ID: <CAH=2NtwmFWVCwU87=kr_mUqer_8kOiTgHANSt5sxHkH3fLB+7w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Enable USB SS qmp phy for Qualcomm SM6115 SoC
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 at 22:40, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 1 Apr 2023 at 18:49, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Changes since v3:
> > -----------------
> > - v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-4-bhupesh.sharma@linaro.org/
> > - Fixed v4 as per the downstream driver code: https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296
> > - As per the downstream code, the qmp phy on this SoC is similar to the
> >   SM8150 qmp phy and is indeed not a qmp-dp combo phy.
>
> Nit: sm8150 has both USB UNI PHY and USB+DP combo PHYs, so this note
> is incorrect.

I think I should have clarified a bit more here, but the complete
context is that for the previous versions of this patch there were
conversations on irc as to whether this was a
'qcom,usb-ssphy-qmp-usb3-or-dp' or a  'qcom,usb-ssphy-qmp-dp-combo' as
per downstream code and hardware documentation.

But after a careful look at the
<https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296>
documentation it appears that this indeed is a
'qcom,usb-ssphy-qmp-usb3-or-dp phy and not a 'dp-combo' phy.

Thanks,
Bhupesh

> >
> > This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
> > SoC.
> >
> > Bhupesh Sharma (2):
> >   dt-bindings: phy: qcom,qmp-usb: Fix phy subnode for SM6115 & QCM2290
> >     USB3 PHY
> >   arm64: dts: qcom: sm6115: Add USB SS qmp phy node
> >
> >  .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |  4 +--
> >  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
> >  .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
> >  4 files changed, 42 insertions(+), 4 deletions(-)
> >
> > --
> > 2.38.1
> >
>
>
> --
> With best wishes
> Dmitry
