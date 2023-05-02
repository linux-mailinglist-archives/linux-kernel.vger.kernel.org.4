Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8686F43B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEBMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjEBMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:23:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5049F0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:23:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so24517517276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683030204; x=1685622204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9d4XFb7xb8OHKeS57hfPSsM1vaS6gs1EOIjHEvSu+U=;
        b=pdk+LOCbnHtCE3mOZ70HW38W2/zkGMStOeJYjOd3f5bCG4RM4eja3TJmykQ+LwcgjX
         bwXXUezRFTBXTaH9ZAUMZPHaKXgC/gFjbOOq8S5FocUhpec1mmFmIXI0PNf72lo0tvk5
         ZxNai/BAFSS0vmx+cDHyE07xJt2EGzDK65UibW9yJaJwKrVxMmYwRzmZfruwQEd0PgZN
         DqrnNUxbnczKuAnVex2KIm0pVYJQs0MjP6FGopp34ZRflwf8pJRqQcMbosH1J+9Ca0YC
         LJt52bEACoCSVZxw5LXbK5nKB45NwCG8PvpZ0UUtP/Jgkrrc83jNmqabA5pM2HuDw/3t
         pvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683030204; x=1685622204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9d4XFb7xb8OHKeS57hfPSsM1vaS6gs1EOIjHEvSu+U=;
        b=SqZs9qNTvopXzJifXK6K9zYtf+aK6VqjK9nDF/Xn6f5qCVrw8TK7ORsBwUl9UqCppx
         KalOqIWwdvQOGTUoWQJsOv8quDsV+x11nhaEBjIYmre45j9Zf/Y+R2VlkeC9h7995TUv
         fUrBQDjIq9ljaKV35vRiZmfcLyYuP5BKyUSHGHE8T3zcHcgDn0Gx+0Q5OdEied8ZkK+a
         sEWj9hLmMICuN28zrDj328Y26G8XDfhkQKCGZPSd6mFJp1OX5CLw9BAShgtaEIrg3xZt
         399eShLuASXV+qwkW5ikc5Lc4FRAi+BAX1RgPQODmM5IzeX/8wZWRr4ATanhowQe+vbq
         q3rw==
X-Gm-Message-State: AC+VfDwHSX8ju8H1/QBw5Voz04rbJxTZLROmFqU04syZOJzsaBPKOj9L
        u3xtCcVMeyHFUf0WQ776xz11t4I46rFKcu2aWMVcu8sgjj4tXk3m
X-Google-Smtp-Source: ACHHUZ4oPkdNhxDZb/SBbRSl2WZqfg7TLqI/32eUmaj3j9TxrZekC7RtQQ9woWJQKcpALFYENvuc3afd/BaL03v2q3s=
X-Received: by 2002:a81:9809:0:b0:55a:9000:59bf with SMTP id
 p9-20020a819809000000b0055a900059bfmr2554786ywg.22.1683030204676; Tue, 02 May
 2023 05:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-4-bhupesh.sharma@linaro.org> <1aaff58a-f07b-1e2a-e27b-df41eacd19e7@linaro.org>
In-Reply-To: <1aaff58a-f07b-1e2a-e27b-df41eacd19e7@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 2 May 2023 15:23:13 +0300
Message-ID: <CAA8EJpog9cbB_y4zyeECkXRjOGznEATpztAOYsMx61NgyH3Xqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and
 cDSP remoteproc nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
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

On Tue, 2 May 2023 at 14:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 1.05.2023 12:58, Bhupesh Sharma wrote:
> > Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > index bff6ba1d689f..3ab46499d3fa 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -34,6 +34,16 @@ &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > +&remoteproc_adsp {
> > +     status = "okay";
> > +     firmware-name = "qcom/sm6115/adsp.mdt";
> status last
> also, don't we want to use .mbn (squashed binary)?

Yes, please. Also, just to make sure, are sm6115 and qrb4210 binaries
fully compatible? We already have a mess of sdm845 vs sda845.

>
> Konrad
> > +};
> > +
> > +&remoteproc_cdsp {
> > +     status = "okay";
> > +     firmware-name = "qcom/sm6115/cdsp.mdt";
> > +};
> > +
> >  &rpm_requests {
> >       regulators {
> >               compatible = "qcom,rpm-pm6125-regulators";



-- 
With best wishes
Dmitry
