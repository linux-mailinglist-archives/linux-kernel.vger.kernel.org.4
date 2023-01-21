Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47FF676779
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAUQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:46:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375E113F1;
        Sat, 21 Jan 2023 08:46:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13B16B8075D;
        Sat, 21 Jan 2023 16:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2BAC433EF;
        Sat, 21 Jan 2023 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674319570;
        bh=WIOYULKqUjmgQ9s7U3j9QvtriWuRBMzlktmPMzB7lUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ww4HRwRlML8vsq0/FWhII3m27jKcx9T7mkSjBRV2crwF+WcCfsVk1lpfHr630h+hG
         v52Dbzmtj5Z16p+5kYEwu+7/LAZ4BHxpq6zO1hebnDe6g0Skg32F4nQKO9lcGnrFnV
         n67L/g3bcYUHoaGtuSWs8qO73Vme4Cwdb1OaxYk0/k+ADKDcCbhwfwxzJBfXN9dijS
         T3VSBkQj9FaCglR3418zKcT47PUQg6lAaLZM7QBfkOAEtndhRt7rG/xkxXpvRzImkl
         /t1X9MT4RyI0mqNQNM0zyeqj+C1r+95Toy7z5OkCXGPuMrVugsYQRyfQmgacJk4x5i
         9koBEpfGiJwmw==
Date:   Sat, 21 Jan 2023 16:59:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: Use labels with generic node
 names for ADC channels
Message-ID: <20230121165954.5806ee29@jic23-huawei>
In-Reply-To: <20230119221757.wltdog4owclidejl@SoMainline.org>
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
        <20230119221757.wltdog4owclidejl@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 23:17:57 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> +cc linux-iio@vger.kernel.org
> 
> Apologies, I blindly copied Jonathans request [1] to send this to
> iio@vger.kernel.org, without checking for the common linux- prefix.
Oops from me!
:)

Jonathan

> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221211141526.463f43e6@jic23-huawei/
> 
> On 2023-01-19 22:26:30, Marijn Suijten wrote:
> > As discussed in [1] it is more convenient to use a generic adc-chan node
> > name for ADC channels while storing a friendly - board-specific instead
> > of PMIC-specific - name in the label, if/when desired to overwrite the
> > channel description already contained (but previously unused) in the
> > driver [2].
> > 
> > Replace the .* name pattern with the adc-chan literal, but leave the
> > label property optional for bindings to choose to fall back a channel
> > label hardcoded in the driver [2] instead.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > 
> > Changes since v1:
> > - Require adc-chan name in dt-bindings;
> > - Replace more node names with adc-chan and a descriptive label, that
> >   were found by running dtbs_check on adjusted bindings;
> > - sm8250-mtp.dts: Fix accidental adc-chan2 node name with pa_therm
> >   label, which should have been adc-chan with pa_therm2 label.
> > 
> > v1: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/
> > 
> > Marijn Suijten (2):
> >   dt-bindings: iio: adc: Require generic adc-chan name for channel nodes
> >   arm64: dts: qcom: Use labels with generic node names for ADC channels
> > 
> >  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 16 ++++----
> >  arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
> >  arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
> >  arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
> >  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
> >  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
> >  arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
> >  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
> >  arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
> >  arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
> >  arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
> >  .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
> >  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
> >  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
> >  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
> >  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
> >  .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
> >  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
> >  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
> >  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
> >  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
> >  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 39 ++++++++++++-------
> >  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
> >  arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
> >  27 files changed, 196 insertions(+), 113 deletions(-)
> > 
> > --
> > 2.39.1
> >   

