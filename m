Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28A72E487
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjFMNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjFMNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CCBAC;
        Tue, 13 Jun 2023 06:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43DEC62E96;
        Tue, 13 Jun 2023 13:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59D1C433F0;
        Tue, 13 Jun 2023 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686663978;
        bh=0rLyJ7Um8xHPNMu03OwaG3r7b8np6OjbkMb9kt0aihQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iM+rcbROLB5JB/ybOayIqTBFWRea5VRToEaYbL7v/gTfVtFBx+lzMIaSVUSe/fcml
         mDgb6VM1iRjtbcjMLqXsnSVO9LkEZmDlmiC3YZ2W05mijUgwOCvovA4SjuQHwFKM3Y
         Jv9yrcViXVcndpEEH8y2D5oByRKcU1Qju4ILu1rOw/dePVRdDfb0fj6QfIMzsQJMG+
         xLrGpqTC2Zz2kFpnNFbAniPV6W8fqPA6q6c5gDMBsR5wV+Qh6MYLQxSQp6GKhBta8C
         i2XbGrCRBn0+WJIDynCpUNjIZtsrhfTHUkUKePbADlUAsC1phPYqi/JHHe1Xq+5Xc2
         Hhs2pnXa8zStA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b2f9f47256so42792081fa.1;
        Tue, 13 Jun 2023 06:46:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDxicfrVknVkrozVwQvQvYdGmSruaz8wmpjRgpFK7ANpqeEw5jcK
        VxBzbu23sz9f3nBEkVNubc7sBstWHpMl5OoXYg==
X-Google-Smtp-Source: ACHHUZ6WmyAIhsvQmsDE0BVCAxrCpRVVRL5HwS87Mu9fv5OxAQFMDCIxNRznw/fOYZNggQvJaqHC522pRJwlOweV5/A=
X-Received: by 2002:a2e:3c0c:0:b0:2af:25cf:92ae with SMTP id
 j12-20020a2e3c0c000000b002af25cf92aemr5357006lja.22.1686663976708; Tue, 13
 Jun 2023 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230418150606.1528107-1-robh@kernel.org> <b8a062a0-10e9-bf17-c109-f6986f9dd02c@linaro.org>
In-Reply-To: <b8a062a0-10e9-bf17-c109-f6986f9dd02c@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Jun 2023 07:46:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvmN7824Q0vnWpnO3a_Fdo5Ybc2tcGnJZAfDLM=-1Apg@mail.gmail.com>
Message-ID: <CAL_JsqJvmN7824Q0vnWpnO3a_Fdo5Ybc2tcGnJZAfDLM=-1Apg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:50=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/04/2023 17:06, Rob Herring wrote:
> > The "qcom,paired" schema is all wrong. First, it's a list rather than a=
n
> > object(dictionary). Second, it is missing a required type. The meta-sch=
ema
> > normally catches this, but schemas under "$defs" was not getting checke=
d.
> > A fix for that is pending.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
> Linus,
> Could you take it for current fixes? The code was wrong and dtschema is
> warning now about this.

I have other things ready for 6.4, so I'll add this one.

Thanks,
Rob

>
> Fixes: f9a06b810951 ("dt-bindings: pinctrl: qcom,pmic-mpp: Convert qcom
> pmic mpp bindings to YAML")
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>
> Best regards,
> Krzysztof
>
