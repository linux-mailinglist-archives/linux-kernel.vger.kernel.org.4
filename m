Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA887396B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFVFOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFVFOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:14:31 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927FEE9;
        Wed, 21 Jun 2023 22:14:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1aa291b3fc7so3778873fac.1;
        Wed, 21 Jun 2023 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687410869; x=1690002869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLkAJTK2rHXLnydfvNobWwhxqrckKAUg+e7vHH2WIEo=;
        b=KzmQSF0vF7g0mvNuBSbFNTNPE91YWovm35WSTXpxHNiNQ1TTHMGvtrN/B8a0YTfGCD
         ByFqAgQY3kutEpzHlCW0ID6+WOH0WGfdb+PGwk4suGSfPTSBru81XAu6xOtmrK5BINt9
         UrNv/jlyN0A7HzEgsKHF1rb2VuK1kqiVUKsXkyLyKSo43G+/gkoV3VReDrUoQ1VMT6mp
         c7apfIZIqTLqfAfYkf6UURF4GB3U8ocITo4pO7MRcwfE9csIgr7KS6Afw6u3t1R24//G
         RFIriwMZX5DU2nbmiluxalBSiDPwN2RiTrk3l8kApI3AMqPA70H9ZDQxRpYvIFNLtND2
         0Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410869; x=1690002869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLkAJTK2rHXLnydfvNobWwhxqrckKAUg+e7vHH2WIEo=;
        b=g+hxSrLKG3gPy6YgRDO6H+OeSYeXNWAZ+YpWMdvFKx4K27ecs66YGtDgznV8MAaSWA
         Cp8htUXaHJTDBZb29LeRRiSLFygsrmHgwPN9QDNHotWOelwBMr+S3ik+BEm2PR88xNCM
         HnjtgVgkvzW4epWbIzjmSx/aLQgW0L++SHMO+jOAnEhcAb1bE9nH9yMcxPrJxX1Z1FnT
         Nb5xr+Kx5TZeruwanLT/w4MA+McsLYuWWutAJZ+Q3TTJ0fYTslH7JaikVxISIWNpDt9c
         GRNHHi32BIGsFL//lLv9IiJk1AxGFjU2g1AFhNcWHrveezYn+vEflOk/iwwGpD3vB5Un
         RB2w==
X-Gm-Message-State: AC+VfDy12b7gH3LAP9a+v4GNRcgWXpOQVGY1IK2xmeMMbSJyshkalwR4
        cAjuZJ0LexRy7UL2M8MEIR9cx2P/MHP4ax70hKX6OiDN
X-Google-Smtp-Source: ACHHUZ7NSH1J2uf00lMQRtT+29fESbvRfKoQxMnSKTKtBUBjXBg/uoOcTxTdfI+NT2zDK6iDYWq7vpa/tKUqux+U2/A=
X-Received: by 2002:a05:6870:5a87:b0:1a9:89eb:36d1 with SMTP id
 dt7-20020a0568705a8700b001a989eb36d1mr12144545oab.47.1687410868951; Wed, 21
 Jun 2023 22:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230620100231.1412582-1-sergio.paracuellos@gmail.com> <168739869603.42044.12383139966264039986.robh@kernel.org>
In-Reply-To: <168739869603.42044.12383139966264039986.robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 22 Jun 2023 07:14:17 +0200
Message-ID: <CAMhs-H_fUSnXHgO0ZXuGOX7gkuM98HXm+Y_jq1DxCv5Az=3Rag@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: add Ralink SoCs timer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, daniel.lezcano@linaro.org,
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

On Thu, Jun 22, 2023 at 3:51=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 20 Jun 2023 12:02:31 +0200, Sergio Paracuellos wrote:
> > Add YAML documentation for the timer which is present on Ralink SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Changes in v2:
> > - Remove redundant 'documentation' word from subject.
> > - Drop clock-names property.
> >
> >  .../bindings/timer/ralink,rt2880-timer.yaml   | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt28=
80-timer.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>

Thanks! Which tree is this supposed to go through?

Best regards,
    Sergio Paracuellos
