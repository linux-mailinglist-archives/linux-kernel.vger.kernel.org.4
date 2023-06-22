Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D941473979C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjFVGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFVGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:47:47 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697A10DB;
        Wed, 21 Jun 2023 23:47:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1aa291b3fc4so3883727fac.0;
        Wed, 21 Jun 2023 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687416465; x=1690008465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm05e4OjfSKirTmXzup6QLFGhueq90/W0vX/QkT2XU0=;
        b=iii1AVAsQ/V4oYfgaI9L/CUTtLUg0Rd1TaLO+IBJ7KJZ7TI+clJ7gSF0oVmPzdVUCj
         vD23+plFWJz52pUwerUjO0BRaj7RBRHgKQhnSnzI7a+Is5wzV8CBYSSqjrPzQ24QY3Z4
         0Ch/6MTBDgCzS8zpPx+GkPfMYbgi+KIEQFCUQ6WK2vRWpckjboMe/aK/0/VmzNeeWZzn
         AixJChElko8SUE2Mf+Dv7ELmaisklHAi3WD20VAERF1rjWLX0ucOih+Fm/uFEM4kGCJh
         Jc31CsHD13U8GZPpoLeX+1RiFWNNfmGSogiW71Url4PLnLhy7kFC8w7EGv3q5INH5sMR
         ME+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416465; x=1690008465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm05e4OjfSKirTmXzup6QLFGhueq90/W0vX/QkT2XU0=;
        b=UkKpAAtFtk6h6nxK62fGH6Fi84U7BLQ84tAzT/OioWioVUazlkHnddLPjqpFxsj4Wh
         XtXI/IhBG1FLcmG7eP7rmb1r4BtzQch3g+x++Cma+Q2CkQJ9DD2DYS+xzvywKUfITj/I
         qUheeST7BKJyFM8xK0MeOxILT4K0OxUnJJvaaYhh9hyab8JHb+u7NTfp3VSRV00ejPOD
         1FOlyZBKFzm0EwoAji/UWYFvx+srmTRDionME4gG12xdUGE/Jp8RvPGKQAqiQaHabqvP
         Nfb1mU3TnOvSIUGkYZPILGPENXeuB2LwTFj2I2cII4GHmFVBiBXiFtBB2TvlgGzhR+eh
         dRDg==
X-Gm-Message-State: AC+VfDz+tFh/dB5t2/IxrOP/ve+wrJ94PFrRFgGltwpYemRtCHY3c1p2
        Uf5R50F2DBz8GpDwf6OkMLx0hmimmfSL81aFbS0=
X-Google-Smtp-Source: ACHHUZ6pYQ2K/dd0joq1B6c+l/mP/Q3M90DEW+Qz8EIw3MdKrhSkrLcYTA+AK7m8sAZ2vE5s6kBLDFniEYhS5NceT/Y=
X-Received: by 2002:a05:6870:1846:b0:1a6:9788:c8dc with SMTP id
 u6-20020a056870184600b001a69788c8dcmr7972164oaf.47.1687416464850; Wed, 21 Jun
 2023 23:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
 <168739869603.42044.12383139966264039986.robh@kernel.org> <CAMhs-H_fUSnXHgO0ZXuGOX7gkuM98HXm+Y_jq1DxCv5Az=3Rag@mail.gmail.com>
 <50f75267-492f-d36b-f977-da2fb3a3fd1f@linaro.org>
In-Reply-To: <50f75267-492f-d36b-f977-da2fb3a3fd1f@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 22 Jun 2023 08:47:33 +0200
Message-ID: <CAMhs-H_QU+wXt=GWEOiBmYEGKf8=mA2yUCZk5ALtegve60OtWw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: add Ralink SoCs timer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        robh+dt@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 8:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/06/2023 07:14, Sergio Paracuellos wrote:
> > On Thu, Jun 22, 2023 at 3:51=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >>
> >> On Tue, 20 Jun 2023 12:02:31 +0200, Sergio Paracuellos wrote:
> >>> Add YAML documentation for the timer which is present on Ralink SoCs.
> >>>
> >>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Remove redundant 'documentation' word from subject.
> >>> - Drop clock-names property.
> >>>
> >>>  .../bindings/timer/ralink,rt2880-timer.yaml   | 44 +++++++++++++++++=
++
> >>>  1 file changed, 44 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt=
2880-timer.yaml
> >>>
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >
> > Thanks! Which tree is this supposed to go through?
>
> Preferably clocksource/clockevents/timer drivers tree/

Thanks for letting me know :)

Best regards,
    Sergio Paracuellos

>
> Best regards,
> Krzysztof
>
