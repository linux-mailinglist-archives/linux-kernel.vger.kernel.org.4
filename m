Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538D36F70B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEDRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:17:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729C59CF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:17:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f7db354092so545988f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220647; x=1685812647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cesjGSXjro2rP21G4rfu9sFt4XxldgqoChhP56PAftQ=;
        b=bQdeDQMoqV7rN3vtRGhuybfgZUuJhgEUVdxXqmYM7fXnW2PqGNOgSJ5R6CMyD52tPv
         mCug7r5DbZYfxwOJtGTBXzqCbIs3ufbeU3rVJNAs5nJwu+7q4Xlp4VZfKOO4MS0A9Mxs
         Bg+8wmqHFB24tZgMY9WCZ7v8zSqMEi+bXRYOv9Kww/18HOBH64iwPFRXv31tq8IOMWVh
         l3LX663CNri3IIuBBsGdMoDaG2WBxJRpSp0o5f4tiPGbekCmb4FwJiWA3U5LAo7rf+Pc
         fsOdURUFTsmH2m188oxX65a/uWielZM7BHes83NUjeWRoRyALkL4xkmtuVR+V2+Sztb0
         mZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220647; x=1685812647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cesjGSXjro2rP21G4rfu9sFt4XxldgqoChhP56PAftQ=;
        b=aX0PUK3ecyQXglKG9aaSt0w6NSuoBPyDJ5Umh03fREgnMx7cLcHbmSatePYEYcZYG5
         gKj7jDkgZ6UyFz4x3Kg8aVvtVlkf06NqeKs4akBO3RCasvjFprbTqWtZElU1qk7KeeoK
         5Ph5lFE+ZRKtDEZ9K0QLANgh6FR3+fE2eGUUnBwK16EdjzCB5xC4lPXDy7P8zo96kaXe
         Kz933t+XPVsn3QuEwGywoTSXKhiuBXdglO5Et/0pDzFeL49X2EqCnBXqRAJqJPuQtGif
         7GxTnmH35ly7ex1/qeGIccKISX+5DCLpIdFjFm8h6qdHccNR6AbZiavVzJhX1tAk5BC5
         ccbg==
X-Gm-Message-State: AC+VfDxYY8r5ZXeyOkzeFn2YqChwf+xdYd3HmS7hhkLrLJOwIKozqP4D
        +K+7x23iZLANAcq+8G2BA+zC/I4QUqLxv1t2dvZyAQ==
X-Google-Smtp-Source: ACHHUZ7NHJwYpkgXge7DBw6W2FOE8VnwhC47ZVAWC4H18sdpK0BPJ9hjuCVU4kLBbw7ShhCY+1y34VcTfC58/BaM5JU=
X-Received: by 2002:a5d:5447:0:b0:2f9:1224:2475 with SMTP id
 w7-20020a5d5447000000b002f912242475mr3184075wrv.68.1683220646768; Thu, 04 May
 2023 10:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-2-bhupesh.sharma@linaro.org> <3b84361e-fba0-3551-be55-474495f02a01@linaro.org>
In-Reply-To: <3b84361e-fba0-3551-be55-474495f02a01@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 22:47:15 +0530
Message-ID: <CAH=2Ntzk09vT===p0dd69RckDx_+2k_UPqd=YyagkJJhwfv-JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 17:27, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 1.05.2023 12:58, Bhupesh Sharma wrote:
> > Add the default and sleep pinctrl states for SDHC1 & 2 controllers
> > on QRB4210 RB2 board.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > index dc80f0bca767..5a5294cc6e45 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -190,6 +190,10 @@ vreg_l24a_2p96: l24 {
> >  };
> >
> >  &sdhc_1 {
> > +     pinctrl-names = "default", "sleep";
> > +     pinctrl-0 = <&sdc1_state_on>;
> > +     pinctrl-1 = <&sdc1_state_off>;
> property-n
> property-names
>
> Other than that:
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Sure, let me fix this in v3.

Thanks,
Bhupesh
