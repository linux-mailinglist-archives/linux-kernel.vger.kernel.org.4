Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A796F80A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEEKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjEEKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:12:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E41A1CD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:12:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3023a56048bso1404745f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683281561; x=1685873561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y0bRf+iBVXoyw2t48+nk5d/eoVvSBwgKQazCXSoXiA8=;
        b=RQ4mYduUsWNc0p6PCP6mjiMa2MJKUEZT8iS1NELl4zSnwqWAIpyF0Wu32HpdCmmZBS
         rSjP39WVQpJbqQsqdeIjNMEjmFmugdj2PL9BFHSK0NpXosmx9O98bKtrFLx/tPzJWBPS
         I8JTgUWQrYApiotbuxQUTxeAWQKrRjelt/d50EZFWkHT9ZOyTiL4rO8LmiBt4A+9JkrC
         ULhP7BhCUf7bYi2m+AZs7OwVAFkKHp8/jI1ptpstxB1qjc6b/mtXIit6hRaW3E6HmRju
         bNdXj3xVwnu+HzVYeH98IJTTj2PNoJoCj3XvKmPen2cSf6hP2a3TUaCIA/YXiWnEDiBN
         YGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683281561; x=1685873561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0bRf+iBVXoyw2t48+nk5d/eoVvSBwgKQazCXSoXiA8=;
        b=FIqis1sXyNVcP76GWjOnCg/yfXu82ISvsOR/qqjuiRmrsnsMNRCO+f+oMA2gHjaZEN
         FnRbvKDnrnstIhJwDtinJcz3MyVEWl0ejEwbyv+b0YOZ8J8p9LGgs3wSIQKTNPwDnL5q
         VPie7CG81dzFL//WlXiUPy5DQcxWWk3QqGNtHPEKXzNhBK52V/mjxJJwHPaXyaAAofE9
         THq4e4hpqw2gGSJkDj5ksFgBqgx8xZSDatEwj2t9AmndFOPt7va0AxR23Yo/tdzreBZa
         LxPXdH0b5iO9vCdIYVPX/ifgXSf3C0vh9Wr6nPpcV3DqMxiGbduoEy1OqjoofC8eFxnc
         mg4Q==
X-Gm-Message-State: AC+VfDwck2Zq2zsZPxs9SIHvLd7HDB/6jriO3I/zXG9B8rd5Qd1eKNF9
        JbdPzQrYsylxLSUULA45/IF6FfA6IkN+2ljarzTl1w==
X-Google-Smtp-Source: ACHHUZ4JHzv+IXATh4YQe/DhLOy1ZoUi7cMInaGDAzwlWZtEmHRKVVxjHBtTX5ZG65Kwk1hBgk0OZkEsxgEk2FVkiiM=
X-Received: by 2002:adf:f2c3:0:b0:305:fbfb:c7d7 with SMTP id
 d3-20020adff2c3000000b00305fbfbc7d7mr994297wrp.44.1683281560698; Fri, 05 May
 2023 03:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230505075354.1634547-1-bhupesh.sharma@linaro.org>
 <20230505075354.1634547-4-bhupesh.sharma@linaro.org> <CAA8EJprw-KP94Q-8V-uvdsj7y64AdHoMxJQS2X-wtspGmFiifQ@mail.gmail.com>
In-Reply-To: <CAA8EJprw-KP94Q-8V-uvdsj7y64AdHoMxJQS2X-wtspGmFiifQ@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 5 May 2023 15:42:29 +0530
Message-ID: <CAH=2NtyRQ+qjookORagY1TUSW5oWjoMwv=rof52O1ejqQ9x1WA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and
 cDSP remoteproc nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 14:45, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 5 May 2023 at 10:58, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > index abea44fd369d..3e8ace0ceebc 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -34,6 +34,18 @@ &qupv3_id_0 {
> >         status = "okay";
> >  };
> >
> > +&remoteproc_adsp {
> > +       firmware-name = "qcom/qrb4210-rb2/adsp.mbn";
>
> Please follow the established practice of firmware names. As the
> firmware is not signed by the device vendor and is generic, this
> should go to "qcom/qrb4210/adsp.mbn". Same applies to the rest of
> firmware paths.

I think this minor name-change can be done while applying the patch
and should not require a new version.

@Bjorn Andersson , please let me know if you think otherwise and want
me to send a new one.

Thanks,
Bhupesh

> > +
> > +       status = "okay";
> > +};
> > +
> > +&remoteproc_cdsp {
> > +       firmware-name = "qcom/qrb4210-rb2/cdsp.mbn";
> > +
> > +       status = "okay";
> > +};
> > +
> >  &rpm_requests {
> >         regulators {
> >                 compatible = "qcom,rpm-pm6125-regulators";
> > --
> > 2.38.1
> >
>
>
> --
> With best wishes
> Dmitry
