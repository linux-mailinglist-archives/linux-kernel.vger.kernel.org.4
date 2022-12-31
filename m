Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8B65A3A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiLaLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:04:45 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F306CE04
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:04:43 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k4so19420458vsc.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8s9I1GFb9vnJYgyzF3LyGBW5PFYtk5cyL1Hz3ZGmM0=;
        b=uPbAiz2zy95lZywFI2dEhF9ilRfpoGzunGA9KXqogD3RSi1/EWRrzJIM1vxnoNcLG/
         wMRaS1tQFpJ7O0CHd/bAPop9GTEtzSq+ihpNxkWVTggDztMR/1EXThpUR0ma8qZJpsuB
         +5yopTeCpNY32IXV+4QsqVei184W34IOQPvkTMRWarGgU0k+TufPQ88LiZSurlfnqkX6
         KRIFSPPBLf6EptkgSOxoFOiyEIMfI/QcBcuaaIWPxbLUpy+3cnBLS+aMbHAYPhmjaAnx
         npwb2foOdUX54K4VR7+ilQVPV5z+1Xq4kcwyWf9l/m8oVjIevhw4iLAXcvJOe3LN1w60
         E41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8s9I1GFb9vnJYgyzF3LyGBW5PFYtk5cyL1Hz3ZGmM0=;
        b=Yo+jcxX4vYix+yj+ZAPrkv/xO4eX8waSWuAGDoh4hQnXucQejr+1Yc2mmDa/QgyJM0
         Itvdl0SQeYUjOijIxe2M2MB+RUR3+WgA0W59Dul8Zb/xXcC32vWGnEbS1Gvy64Wtugcj
         AM7oZXESSXjjiiplDIdzlptJNLcStK2tI1gW2w4SFDFvtG9AuRHhZyWBDNRUaFl2wjOh
         oyXXMBobhlZvqXo9zDu+PYYjitzgW0LvDG3nctEPjEhgfpovILLYBega1/sEv/U6OsKV
         b4+dmNQ+d7RoeNyPSet1LfTqR29bFBCYVsTATJJdsRuHJTbdtqw8T67iIIiqJDLedjBT
         fcFw==
X-Gm-Message-State: AFqh2kpTH150gSZS5mY9zQugPyKuXHawLH609UMfwxjGabMJzHjuz36M
        6piS1oQ+lUxLMjou+/phKCW3wB/dOd73sm+YDjbBew==
X-Google-Smtp-Source: AMrXdXsxTLOmViWobRZ2Cuj/KRsod18koNJDIh7HfLSsbcb9G+N+RMccym1kxCwlWb0RlW42UqAhlI3ZMJlpVGWDkK4=
X-Received: by 2002:a67:fad7:0:b0:3b1:5690:a240 with SMTP id
 g23-20020a67fad7000000b003b15690a240mr3963799vsq.68.1672484682183; Sat, 31
 Dec 2022 03:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
From:   "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date:   Sat, 31 Dec 2022 11:04:30 +0000
Message-ID: <CAJB8c06F8MaDWEgNOVgL51NG3vgnxcuC2ta2UpbyrG2BqcOVfQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc8280xp: remove GCC from CX power domain
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 4:04 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bindings do not allow power-domain property in GCC clock controller and
> documentation does not indicate that GCC is part of VDD_CX.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Maybe the bindings should be fixed? Maybe this was added as workaround?
> Anyway looking at documentation I do not see such relation, except
> downstream vdd_cx-supply (which is the same as in other SoCs and we do
> not represent it in upstream).
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 1d1420c8720c..d14663c9f34c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -799,7 +799,6 @@ gcc: clock-controller@100000 {
>                                  <&pcie4_phy>,
>                                  <0>,
>                                  <0>;
> -                       power-domains = <&rpmhpd SC8280XP_CX>;
>                 };
>
>                 ipcc: mailbox@408000 {
> --
> 2.34.1
>

You'd be better off adding the documentation. The CX rail is required
to power the clock controller.
If you are pulling this out and finding nothing breaks, its probably
because the bootloader left it on.

Per my understanding of what dts is though, we ought to be
representing the hardware dependency.

gcc is a root clock for just about every peripheral so, you can be
sure it is on when you boot.

Seems to me as if the right thing to do is to retain the dts and
update the documentation.

---
bod
