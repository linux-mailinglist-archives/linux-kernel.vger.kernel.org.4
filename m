Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B56AC0D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCFN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCFN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:26:44 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355732DE62
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:26:40 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id s23so6421807uae.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678109199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN/NRHsgi+29tfd9af/dsSJusS8NpVnuSBCAvZQTYLU=;
        b=7EP5oRNffVWlv42EMexNJJHQGzZappwu9HafOabJl/FalPTaCDSc6GD9C6tzyDuNGG
         C88uM05u6aD2iR4M0czzdAOiNBhyDeF0hK9qtEiyFNuSyB5J4DdCTT9ZcAQr1agz/ATn
         EWXFAUiuNb/B9BZajYn6jZhJVqyJT0y9wsbGeJU1WxO573NA6fGK5O2szihp7tbLfjGe
         6N47KmZMCXxsnYazY1XOUmZD7UF4Q6yjthz/kyCIrpDu+bpyiQjcxlKiYIA/cGcA8wyN
         xRfiz9nQtkr2hAuyVw4/TnK0niUW0fWifHGLkEroY+fBPU52nbKpuEVsCdVGZ1VmlbIi
         MPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678109199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN/NRHsgi+29tfd9af/dsSJusS8NpVnuSBCAvZQTYLU=;
        b=ARt84lhonKoGq7vAxZPSENN+CPM3pFFCss0Hg6yMDa0oDnaD9qzYUN2lmeIlb91/JN
         YYhXEsQlxLPBvsVwi41+BggqXrvv8L9yhA7hJnkBXMO2aE4kpghdVRz/4GvKtCT9SQRm
         LyMGrLtMsw9q37UrHcBcvfkcTWjxnjtIXKF6Qt+J/xrcVEZ70GktZdt84i0Qls4QmZSA
         A7XopGjGePxP8Azsbna1WZGqT3ny6cjGBBsbCdhBunmnO55rVUTleKe6DI4UXg7U0rPL
         9jwYs9DjYqh13kLs2R6v7mmsNbX1rzOJ90La6XPM8EwKptYMdX/UTLLjWo02+ZBaP+4i
         SBFg==
X-Gm-Message-State: AO0yUKXjp0BHuboefyD24D4SLkA3FmeNOquN/cPAYS/C173naT2dYx0Q
        ypUcgwNQOyJ3orSh7apBEDFbu9F/hb9FG0QJQdWy9g==
X-Google-Smtp-Source: AK7set9lpQfCvp9mgRUIQ9scJCpMlxJQDLmgtz3ZR8uJabc44QFXsFRgSzH64Or4jbCgc6vGisUQldmtXjT6xC5FvXU=
X-Received: by 2002:a1f:4a81:0:b0:410:4a2c:1e9a with SMTP id
 x123-20020a1f4a81000000b004104a2c1e9amr6165830vka.1.1678109199261; Mon, 06
 Mar 2023 05:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20230214092713.211054-1-brgl@bgdev.pl> <20230214092713.211054-3-brgl@bgdev.pl>
In-Reply-To: <20230214092713.211054-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 14:26:28 +0100
Message-ID: <CAMRc=McU8RfXirCS=ErjVeRcXwVPJ9szePTFQ-foOKoP88KQZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: add initial support for qcom sa8775p-ride
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:27=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This adds basic support for the Qualcomm sa8775p platform and the
> reference board: sa8775p-ride. The dt files describe the basics of the
> SoC and enable booting to shell.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Bjorn,

Now that the merge window is closed, could you pick this up into your tree?

Thanks,
Bartosz
