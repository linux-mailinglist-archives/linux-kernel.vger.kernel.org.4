Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B46E8E65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjDTJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjDTJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:42:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7524C01;
        Thu, 20 Apr 2023 02:40:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k15so2105724ljq.4;
        Thu, 20 Apr 2023 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681983645; x=1684575645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXezQIL8nQT7EHNZDg5A3zwX32Ez5Xt7dCXaMMgSYRE=;
        b=gS0rvfbFTHrddVjRYYkBoQBAkbBKiIIfAmjXA4hDLm9cXNQydDv8xPgKzQo/+DmUbU
         oD1tZQOtRIWCnc+gQ2Cq+6kJj9Du0D1TR3ZiQZZ30NM3ONRqJ2dWO0EhCl26r6v9vOlf
         uT4CK8+IbhFRfzC4312mdPAtqiJnnSeEpFTVSX66bLXHQnZAQciXyXlfZ1DkcLIMIh8N
         6Zig+xCX6r6qlJ2WeG0vnHtoV8sJyvZZmH6HBcWeKY9dXxNBK40I9KnjCffHX35gNWa4
         NZhT9Sb3XDmnFjYrdQ95ZUXrsmNJexNQuiNql4jxqOh4bULx2kBy2J1Lt6uExf5LQDTn
         J1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983645; x=1684575645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXezQIL8nQT7EHNZDg5A3zwX32Ez5Xt7dCXaMMgSYRE=;
        b=eq52xzJ0UZo2finzLWbJCX0QZ8MvhCtsRYGpe3TMxaIP1G8zqplAYFTfO6MHw2Aw+Q
         7ewa6/RDSYLk13tl/cfEnpUTwdtrZZ4F4N0uBnB7240iiw+nlk2HF2gkFYRNqQTVwxge
         R6jOE5BZjlXmjPqQASjY36zqsOWSkeT+gmZUmAxky+d0P2blC/SNsMfyC6BecWWrK30h
         6E6wJTFh7S7EuM1N/nYflww/MxNpgKFUlCs+OyBZhdNd5JwfwaalQqpp+mBpHaMt/CJy
         XuUQDqAG5NYCPcoZEyoIW31Gebnhv7qvdjBJAzi5NknAS1heT+aYJBrNkU/1VVtbgB2F
         /mJA==
X-Gm-Message-State: AAQBX9f7DEAtW55zoT8KOfw98Vpbsvv24PxLKh78OdfzT6Qe2cCe/fIJ
        sAUQsgqKNS4jCC6Ce+o0JWhbiRuwpmK0tQRqNIw=
X-Google-Smtp-Source: AKy350Y3JU2L27iVYwrYrXipxJ1TJZFDuoI/VJwjHdGAyJUSB58qs8J62vQpxs+N4iZAkbdBoW8mRtHUbMFIKKOb1xM=
X-Received: by 2002:a2e:a0d3:0:b0:2a9:eec1:71f5 with SMTP id
 f19-20020a2ea0d3000000b002a9eec171f5mr181058ljm.4.1681983644357; Thu, 20 Apr
 2023 02:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org> <20230419211856.79332-18-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419211856.79332-18-krzysztof.kozlowski@linaro.org>
From:   Molly Sophia <mollysophia379@gmail.com>
Date:   Thu, 20 Apr 2023 17:40:33 +0800
Message-ID: <CAK0UmJBMUSWSjO8d44aL+uaRfwKZ25VvNMZOH_BKUT35g5weUg@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: dts: qcom: sdm845-polaris: add missing
 touchscreen child node reg
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 5:19=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add missing reg property to touchscreen child node to fix dtbs W=3D1 warn=
ings:
>
>   Warning (unit_address_vs_reg): /soc@0/geniqup@ac0000/i2c@a98000/touchsc=
reen@20/rmi4-f12@12: node has a unit name, but no reg or ranges property
>
> Fixes: be497abe19bf ("arm64: dts: qcom: Add support for Xiaomi Mi Mix2s")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/ar=
m64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 8ae0ffccaab2..576f0421824f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -483,6 +483,7 @@ rmi4-f01@1 {
>                 };
>
>                 rmi4-f12@12 {
> +                       reg =3D <0x12>;
>                         syna,rezero-wait-ms =3D <0xc8>;
>                         syna,clip-x-high =3D <0x438>;
>                         syna,clip-y-high =3D <0x870>;
> --
> 2.34.1
>

Reviewed-by: Molly Sophia <mollysophia379@gmail.com>
