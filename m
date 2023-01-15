Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4A66B42E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjAOVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjAOVdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:33:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BB1632D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:33:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bf43so40295334lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc2KB+6JnGN5CN8ZL6/iTxWjXrR49/KupSA1DnyxAcw=;
        b=dFJ4DuC4tiRUc97fmPGTiiz2pqctG2BFyrK4qKR8YhVmdPGybh1oT2dng+mxsgz8sI
         /DpslqS9lOwbizluHoDusyDfX9EcqLRICJiBsXvuUuZsyOL5n9yPKR6+gyuMHG96o4lT
         XqOb988Rr8gUHOJ3BHeFsNYSyXCnkhYnSCjevqSYWal0vBL830UqL4tvW+c/i2IaVDEU
         pH8FqLPg+ZR9KKefK1yJGK7WFfmFCfpnuHghQwtOtNASBHzB5iHKKqyF5BZwQyq+Fqzr
         VvpSAjTr3cTEK65ofH2zpHdRGYrR3Vbpz3RoN2Ma4AXZdZIONIGUTjRJCLZiD0TmwBC8
         wdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc2KB+6JnGN5CN8ZL6/iTxWjXrR49/KupSA1DnyxAcw=;
        b=hI+njzCDcQW50jka4iGJUiWspWW0ymztKliv9GvHgWDIigePOVVUXfWYGn1LaqCIZZ
         biSI9c3bczPKnmQX8HAPge++PrJYEUa8dgBishrCTHfRN6UQcIzvVXmY48ACv24BtQXA
         76PuSXlA1kyoeDQ+BJIz+zFvm1IC7slRBIySW165oL4ob0VU0zcYXeTFhF51oY4aGKCm
         xNLaLCffm2NbSLAqSRZ0ctbvG8HJoGtrfeSrHEhdnWgSeyKlctgEUcGlKli5pEeY0eXJ
         5IW82kfCasStwjvrvZ+oFasvEfFqUlO752LOvp3YnhUM+8la46jOoyYN7CULP6wMDF+A
         JNSQ==
X-Gm-Message-State: AFqh2kqeAyV7l2VGK/jPXN4OBblp2DxXBtkfv+4rt3wDc2mWX5wiIeUP
        xNrJGQrzOiuBbrRTGNKA5t5fG3c5LNky/sWWc/k7qA==
X-Google-Smtp-Source: AMrXdXvEYNNPSdXfMPIBcHLU2o+DgI9dKFo66ir/dhuo0bqe4WYAvtuL7IqrevDujkz1Fw4cPJgl2Smg3X0zbGA5Rr8=
X-Received: by 2002:a05:6512:128a:b0:4d3:4e4b:c8ce with SMTP id
 u10-20020a056512128a00b004d34e4bc8cemr679788lfs.376.1673818393850; Sun, 15
 Jan 2023 13:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org> <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
In-Reply-To: <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 16 Jan 2023 03:03:02 +0530
Message-ID: <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/01/2023 21:10, Bhupesh Sharma wrote:
> > Fix the following '#address-cells' & '#size-cells' related
> > dt-binding error:
> >
> >    $ make dtbs_check
> >
> >    From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> >         arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
> >               #address-cells:0:0: 2 was expected
> >       From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>
> Don't we want rather to unify the soc address range?

Well, the assumption in the original dt-bindings was that every reg
variable is 4 * u32 wide (as most new qcom SoCs set #address- and
#size-cells to <2>). However, that is not the case for all of the
SoCs.

So, ideally we shouldn't set the  "#address-cells" and  "#size-cells":
as const: 2 in the bindings.

See as an example:
https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-device.yaml

Thanks.
