Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2701682B20
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjAaLG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjAaLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:06:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CF3C12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:06:24 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 129so17645599ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcYOXBku2VHxJy8UetnYAZWJYNBo3JqIqgAbN/pCoHc=;
        b=qZ0ffD3cHSPyEP2aHjBMxqQ9w1yXBwI8ZUdEctiaVMRd+RrjqMgradk0cQSee9MuZd
         bZUo15j11DJpNUnCvW6k4aqaew+8pu3hMc3ioeLpOSgJKIQ0abGyqdl5ap6mRr8N5idl
         YIlo/BFeLh9VQRKgfOquNhDIOTeMScABbVKGH8gYv6LXCRvDjxC/T7wzxJvpAUaZPrDZ
         ziE8YoEfi0yYlYsA0khKEjvVCRSD69RNycT/oTU/pc5iUubsPD+XftegTe56XOFo5uWa
         GxhN7hgWYTVsZAtVnvJvTIfUNvrMz9gKiZjb5oOyWw0jxaMK6rcyA5ftVkfXkYWhwwxa
         70Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcYOXBku2VHxJy8UetnYAZWJYNBo3JqIqgAbN/pCoHc=;
        b=y1H0pte+oSYVjLc7XgLMGYqmDajQsaOe6aqnN1BZ1V4sWlimlzRG6l93JJgQTLBgt5
         NnCiJsCD055Xx3uKnWcNNOaGnD5/zoG9v1g5I1B8z8TnhOK7rWy3FwntmKMIfmoxr/ow
         NFynWR54ji7Qq5d854xqWkh+3iCgxZGQ6cXHUlbn9R+3DWgolLeJx4eEnq1wtVvxl02G
         rc/77CU+vSdv5cZptxQk5G1dqr9GgrdGq1jKnhgfCysolPabdj7XtrjbJElq7NIf6/00
         tqN2rI3JJkp1d1mbNjbJdX+bW9XxFtoMVm8dYrL83wlgqQPRyqxQ+KN7sP/yYfZipGcP
         0XHA==
X-Gm-Message-State: AFqh2krg0qzjckc8wCEdiKSc6pDktLyRmoUAT6B1WR5aluYPPalmb49x
        czeQ1jXQGKhw6UnrEEyNQfUDqhvOZk8yO19JDbj6Rg==
X-Google-Smtp-Source: AMrXdXsG2IG3ZAX86Ej5Fkh0a5wU7kGAbJfTqlXxD57SAjEXIgbHDjXh/JQUBJk0zHxwaDTalkJPBBZu24Ao5HdY8Yw=
X-Received: by 2002:a5b:305:0:b0:709:9335:236e with SMTP id
 j5-20020a5b0305000000b007099335236emr4925339ybp.288.1675163183394; Tue, 31
 Jan 2023 03:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20230124182857.1524912-1-amit.pundir@linaro.org> <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
In-Reply-To: <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 31 Jan 2023 13:06:12 +0200
Message-ID: <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 12:54, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 24/01/2023 18:28, Amit Pundir wrote:
> > Put cont splash memory region under the reserved-memory
> > as confirmed by the downstream code as well.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > index f41c6d600ea8..2ae59432cbda 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > @@ -100,6 +100,14 @@ hdmi_con: endpoint {
> >               };
> >       };
> >
> > +     reserved-memory {
> > +             /* Cont splash region set up by the bootloader */
> > +             cont_splash_mem: framebuffer@9d400000 {
> > +                     reg = <0x0 0x9d400000 0x0 0x2400000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> >       lt9611_1v8: lt9611-vdd18-regulator {
> >               compatible = "regulator-fixed";
> >               regulator-name = "LT9611_1V8";
>
> Doesn't this mean we loose 0x2400000 of DRAM for all rb3 platforms
> though ? About what 37 megabytes.. ?

I think this memory is further used for display memory allocation. So
we are not loosing it, but dedicating it to the framebuffer memory.


-- 
With best wishes
Dmitry
