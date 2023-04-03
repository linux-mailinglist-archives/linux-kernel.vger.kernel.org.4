Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE206D43BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjDCLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:41:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2365FDF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:41:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so546709417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680522089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQwYEr4pKkfke0jhgUHPHRW1QNIRUtJN7UgklUowBjA=;
        b=ySUXl80aPbBmXyMJ4NQs3scmpJW3dzpyyps4heIBtIg6mlA6TKMCdVo7vrV0er/INr
         m247iD9wxlqXbI99QTfvgtAsC+B+0M03eoxc8L3PgfGbb6Kz+hxV25oDbZH3Fv8o884x
         GB0gCeqEHr4MP6MIu0JBsTVIOkNXJ4AolD4l3Qe3muSoBhmrqmfpZ3PRt1oyeGPByj6J
         QH43QM2YNwkYTMUPx5ZFkyy79MGnn5A/RA5MSFhHCQ38XGDY+DgNNwEeIpd0RamR8NwF
         ChiuKlP4FUxxAlHuEbjHpRuuedc7ZR6HIXEov1mbkTh/jmKGHCM9DLU8JRL5UiOEhMOF
         bLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680522089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQwYEr4pKkfke0jhgUHPHRW1QNIRUtJN7UgklUowBjA=;
        b=ajYr4E4PkTF7huWQj67A6s5FIhUOJ5xz+dezBXFBZ6Sssr47EeQDNmuRS4P53hcXnp
         i0QiaTN57hIt650wUyvhU6fHeZQVOqKinHGZYZKqvESRnwWjiIiWZWzjKb09XCs/MfwF
         D6G7LNovnGNjcatmWbpYjy/ZpkPv8QClymdvRNU6A1KJI2zyxyKHbzq685M6Opx2swn8
         V1u6lJzdv8xULxeEPrVtVzL/eak2PAkwCvMv9GnktDqHn4fSgf42A01TSVrZv/hsywkM
         4Ku8QdijQqcrrADt26b6czrsw1qz3p+46+Sl2AlhcImi9eg/sk3WqblkQWXuZaz5ly7j
         1bDw==
X-Gm-Message-State: AAQBX9eRvPvn6k5h/BDNndXZ6vd2OYkQ9whxI6aebowKF/5GJZxeWqC+
        qckMr7Y9F6vYhBqimguK5ci3GGnCQOWQRM8vVkbiCw==
X-Google-Smtp-Source: AKy350YvvdpcWM32OptCfFv33crL4CNbvFcInBw9INTnk7ZaRYMCGd8X/zChpOIi2LChP4iIEHKVFumXjsezNh257JY=
X-Received: by 2002:a81:b149:0:b0:543:9065:b225 with SMTP id
 p70-20020a81b149000000b005439065b225mr17943827ywh.5.1680522089216; Mon, 03
 Apr 2023 04:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org> <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
In-Reply-To: <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 3 Apr 2023 14:41:18 +0300
Message-ID: <CAA8EJpqRu3JQpTOG0COiLCXOSX=w63Yw8KkY2E5+Cm7-V6=51Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and registers
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 13:54, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Apr 03, 2023 at 11:18:07AM +0200, Krzysztof Kozlowski wrote:
> > On 27/03/2023 14:29, Johan Hovold wrote:
> > > The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
> > > hlos and pbs.
> > >
> > > This specifically fixes the following error message during boot when the
> > > pbs registers are not defined:
> > >
> > >     PON_PBS address missing, can't read HW debounce time
> > >
> > > Note that this also enables the spurious interrupt workaround introduced
> > > by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
> > > debouncing support") (which may or may not be needed).
> > >
> > > Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > index c35e7f6bd657..a0ba535bb6c9 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
> > >             #size-cells = <0>;
> > >
> > >             pmk8280_pon: pon@1300 {
> > > -                   compatible = "qcom,pm8998-pon";
> > > -                   reg = <0x1300>;
> > > +                   compatible = "qcom,pmk8350-pon";
> >
> > Same comment as Dmitry's. There is no compatible "qcom,pmk8350-pon"
> > ccd3517faf18, therefore indicated backport (through AUTOSEL) will lead
> > to invalid stable kernel.
> >
> > You must drop the Fixes tag, because this cannot be backported.
>
> That's bullshit. Do you see a stable tag? Is 5.19-stable still active?

I'd tend to agree with Johan here. Neither of us has added the Cc:stable tags

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> The problem is that the driver was updated before the binding was so the
> above mentioned probe error has been there since this file was merged.
>
> AUTOSEL is crazy and people apparently just ignore it instead of NAKing
> when it is suggesting backporting devicetree cleanups (which to be fair
> should generally not have Fixes tags in the first place).
>
> If 5.19-stable was still active and someone suggested backporting this
> one, they would have to change the compatible string to match the
> inconsistent 5.19 kernel. Note that that would need to happen regardless
> of whether this patch has a Fixes tag or not.


-- 
With best wishes
Dmitry
