Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF185B5B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:32:22 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4159222BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:32:18 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 130so12753617ybz.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WvP/x+fCZxYCMiNOMMw6Im5i56naXzsqIQAk9GCt+2c=;
        b=N5Yc8JvZu0ZC1+InYD0uhXoRkbBXkfd9RS4qb8IqrlfR146XTCBR9WjqAXpXsfnBUX
         etqPpV6vNrXg1tjEayXCP/Ks/qdgFiFS3LQ/UHlY2Pz/UMuDbZ6C4WMHKPJCUhdwtXY3
         ogk6oBVpUP4bsK9XOcGrgF/gbeIcCq6fk2dYC0OEE3g0pg1xpjOJCjjBxFkDNxrfcjJ0
         k22J30ZwZIWttJo6XPbQKb2/Vo/PXUs/9X7dxST0rI4NS0CI3lXoNXREXs4Pv8LdusQq
         cRtcNzZBqdG5b7uCKRNVDI3tEbO7VWXDW79iCOT9MGGl3LH7nB6lHOp1PqH6V++K9nsz
         jd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WvP/x+fCZxYCMiNOMMw6Im5i56naXzsqIQAk9GCt+2c=;
        b=SqZA+8acekS7MFicRRXIiU4QWGZRdlJsxFuzA7glWKZPlCxLFQtxif1rR3N7L1Ja7A
         G5uDCAytoY6Rkew8iSIDxLtWaOjudHGcaNFkCaZADep9qa0HzqVyFOXltm281YLfkObI
         B7qZNod2pl7WftlvHQRAcCyut/6mIMC+/I9m6lQRG4Cx7HgeB/9jpQdU9cjpK9Ebdonl
         RYmXPU1rkgNG/sr9O+Xr+BzDHmd3FDBaPZpybq7gsMNhXa1nTpgzbpuEg51mGBpmU9nB
         H9eiPeD17hw0GR+YG8biNDqbM1ZBcnjbJ3MqFukVT5OGAcvlVd9xFVxNDfMVr5gLHsSE
         pEOw==
X-Gm-Message-State: ACgBeo2/BXO19TYExML81fJFS6cBqLlQ/2WSXmXEw8flKg16IlHBuXuR
        o2sHZjk1AVpUMheHnva/ESsqeP5SvoMwaUxBZCWXTw==
X-Google-Smtp-Source: AA6agR6R+jK3kreNZKXAI1lHh3Mfck+8y0IA1Ml+8+hw5jJge/fH6yBe8CDqGJ8wEob4KZqomXaiJ+WGELAhXUgwYm0=
X-Received: by 2002:a25:ba45:0:b0:67a:6298:7bac with SMTP id
 z5-20020a25ba45000000b0067a62987bacmr23756170ybj.194.1662989537861; Mon, 12
 Sep 2022 06:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220910170207.1592220-1-danct12@riseup.net> <0a2bb48f-c67d-0544-5037-d02f658a3351@connolly.tech>
In-Reply-To: <0a2bb48f-c67d-0544-5037-d02f658a3351@connolly.tech>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 12 Sep 2022 16:32:06 +0300
Message-ID: <CAA8EJpr4_G_uK5oj9Y0j_tE_LsnqDHKaU1D_nhXOiL0sA=aMnQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: sm6115: Select QCOM_GDSC
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Dang Huynh <danct12@riseup.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sept 2022 at 16:17, Caleb Connolly <caleb@connolly.tech> wrote:
>
>
>
> On 10/09/2022 18:02, Dang Huynh wrote:
> > While working on the Fxtec Pro1X device, this error shows up with
> > my own minimal configuration:
> >
> > gcc-sm6115: probe of 1400000.clock-controller failed with error -38
> >
> > The clock driver depends on CONFIG_QCOM_GDSC and after enabling
> > that, the driver probes successfully.
> >
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
> > ---
> >   drivers/clk/qcom/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 1cf1ef70e347..d566fbdebdf9 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -645,6 +645,7 @@ config SM_DISPCC_6350
> >
> >   config SM_GCC_6115
> >       tristate "SM6115 and SM4250 Global Clock Controller"
> > +     select QCOM_GDSC
>
>         depends on QCOM_GDSC

All other Qualcomm clock drivers select the GDSC if required, so I'd
tend to disagree.


-- 
With best wishes
Dmitry
