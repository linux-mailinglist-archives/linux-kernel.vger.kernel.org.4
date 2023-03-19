Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B26C0533
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCSVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCSVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:05:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03029D337
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:05:15 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5447d217bc6so192433737b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679259914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJwr32nXo3n3jCAviEoeLqs6lIUA78kCP1VpZbyNQgg=;
        b=CL+UY8SopOn9ob1vM7RQAWFKv3P1o5tmKWr0GBhdBtvGJeilM1qaiBUS12BV7T77aS
         sktmDLln7XEEo1Zb1BFKsV+IOlm8f8/eEAyjtQ8ICoYDI6iXiVoMsh52xuIlCzL/Bon0
         jCSS3T7aTPzQ079DapAu1+cJSQUi9Iifgz2vPh1RtY6afQ9TeLK/aEusRym625gF3Oul
         5pHKSAFD4t0KTRY13yse7lyNLD+zhIUVC3CQWz9iImuR7uFyMw63OIVM+Swlax+OsgEu
         2GpLEC8FrcB5lY7uuxuffDLGzZJ5cQAsZ2DYKjOOIasZTWmXpscgF+eLkTtRq2AcJ/CF
         mEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679259914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwr32nXo3n3jCAviEoeLqs6lIUA78kCP1VpZbyNQgg=;
        b=MaLWIfYJ1UNccV12g0wKE5F+7X0NxcdomkDiRQM/INGYCi50NAk3xfpn1fakYDPpdK
         L7NkYqHVVTm3JR4U6Ei4d7tFgVBbH1CdFo3DFAHD5ldBvplwK7HzlCZnKtkFlGQHEjeP
         FQViFP4COGTnVDhlARm5x68S6J79ElrnSqwvKtuGjCHP5ORflKXubRQ2Fh1vduSxv4M3
         VSLy7BlSlLM7Ao1aNx+FM9H3D4k091qpNHAlEqVZO+hICFTiEano4KfyTWjGljLJnLyN
         o1bHhuVrLF35540iChqKNzR30sdGHwroOVbCSDAIUgE9JiTzIPAW7YFC7M425EZ6WEeA
         XFGA==
X-Gm-Message-State: AO0yUKUcgZs9ZKGpg9TsZmw2siYdA4W8UiMtlxOJql5yPv/jvScWjpKG
        a7qnQ/R1fECygTJ6UJ74pbKKYOlRXVcGfNChqEZPNQ==
X-Google-Smtp-Source: AK7set+xsBN/Np6Fm5HDOI9Y0MBGXMYg1Su1jiQMnSUNnee2Q6cteK4f+D2SVzraHD9lMSM2HujZ4D5MerQnoteiJIk=
X-Received: by 2002:a81:a807:0:b0:536:4ad1:f71 with SMTP id
 f7-20020a81a807000000b005364ad10f71mr8255817ywh.9.1679259914203; Sun, 19 Mar
 2023 14:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230314222705.2940258-1-konrad.dybcio@linaro.org>
In-Reply-To: <20230314222705.2940258-1-konrad.dybcio@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 22:05:02 +0100
Message-ID: <CACRpkdYpTFncS476ud16RsSv7sraLtJzOVzEL_bNaZRdkSg3CQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,qcm2290-tlmm: Allow input-enable
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:27=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:

> Allow the common input-enable. This was missed with the
> initial submission.
>
> Fixes: 5147022214db ("dt-bindings: pinctrl: qcom: Add QCM2290 pinctrl bin=
dings")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Patch applied as non-urgent fix.

Yours,
Linus Walleij
