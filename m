Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED167DD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjA0G1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjA0G1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:27:15 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA386DFD4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:27:12 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id s4so3311503qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0aWZpGFELfbdnYfESYZXXP75fpqFOpqbk6j8seUM1IY=;
        b=bmvtle+uR7LgOpFr6NPKTt0cz44Ut/VSmygItH61ogyN/F4nDNGg6FgbJ7n+6B6wb3
         SIc1zfPBPYy1+2bvWtzAet/Lpd/tcrSYjlXCbFeNCtR4+9nQc/eWGY/mQBGkWxcDQP2A
         sHSbnYL3pPEozCvduCs7vlMDfxFEHQVTP78/9RV/wA5HqGbN0wVIb/QfEUiOqtobxiaV
         0Vg38cQ90cJNTRIhL+SAk23WRbCVxI8PPQwgRyRHk2QQB/ZHVVmBEC6AxLoP9rI5MKcN
         9K5mU9YvzDqTgpPXLrqZJzb7h+iM5+me+ULTVncmv0oIXKIqH3+VDF8X4SkumiE/TwdC
         q9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aWZpGFELfbdnYfESYZXXP75fpqFOpqbk6j8seUM1IY=;
        b=QJSjw0caTETp/h8B6h8oPcnA1J+4jwGmwn0JtnLgztgCfCKb+vWYLnmb800ZTXbucr
         G9e8ulR/0jiKV8ropkah9iw5fZ2wElShDkMsE8ZEmxuFvOfhYGp9Ycx9mu2HxWGUQUCp
         0mWNGgl/S/yNH0lb8brXeCEH4xkJSFIYsr8vsrYOd8OZErj876nF0EA5d0M2Ob/KMk7N
         KWoWSyQZXe86iSmhy6kWASis1x1Zwf8RIkhHi10qyR57KcMcUoaWz4aMnRlJ6Yi067mI
         iesZ8ggyMgv1sqke/t2l+z2PMVKj6SdZb8qGFStT7yjaauN6jW5kWYyPwiuLtzrwWZTj
         MjDQ==
X-Gm-Message-State: AFqh2koc4dpyoFBDlhJX9xBMn9aA0TO+LqsQFZq6up2/PmP9zJJhumVj
        dKqCKMhOJbAgWSqiJUbQeigTbfU/Ak5usPJ8sn4/tQ==
X-Google-Smtp-Source: AMrXdXsx4Hwyv/0QcCZQtECAgeaV3PT0x1I6Ste4FFeEN5Xoc29DAJH8HwWtUurLYy91dN/6oCG1WZiEbO9jAuAZpY4=
X-Received: by 2002:ac8:7c98:0:b0:3ad:83e0:2a7d with SMTP id
 y24-20020ac87c98000000b003ad83e02a7dmr1616920qtv.477.1674800832038; Thu, 26
 Jan 2023 22:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20230124183257.1525376-1-amit.pundir@linaro.org> <b47b5a49-6e68-c827-a88e-f61fb85521c8@gmail.com>
In-Reply-To: <b47b5a49-6e68-c827-a88e-f61fb85521c8@gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 27 Jan 2023 11:56:36 +0530
Message-ID: <CAMi1Hd2F0DZVU1dpju1C0MGfb59qnEyi3Lz3qY+sT=hFbycfZw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-xiaomi-beryllium-tianma: Add
 reserved memory region
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        phone-devel <phone-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 11:45, Joel Selvaraj <joelselvaraj.oss@gmail.com> wrote:
>
> Hi Amit Pundir,
>
> I have a Poco F1 (EBBG) variant and I can confirm that the framebuffer
> address is same for the EBBG variant too.
>
> I did a quick check by running the following command based on this link[1]:
>
> xiber:~$ strings /dev/disk/by-partlabel/xbl_a | grep "Display Reserved"
>
> 0x9D400000, 0x02400000, "Display Reserved",  AddMem, MEM_RES,
> SYS_MEM_CAP, Reserv, WRITE_BACK_XN
>
> So I think it's safe to move this to sdm845-xiaomi-beryllium-common.dtsi

ACK. Sending v2 shortly.

>
> Regards,
> Joel Selvaraj
>
> [1]
> https://wiki.postmarketos.org/wiki/SDM845_Mainlining#Find_the_framebuffer_address
>
>
>
>
> On 24/01/23 12:32, Amit Pundir wrote:
> > Put cont splash memory region under the reserved-memory as
> > confirmed by the downstream code for Tianma variant as well.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > This change should probably go in sdm845-xiaomi-beryllium-common but
> > I don't have EBBG variant's downstream code nor the device to test.
> >
> >  .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts      | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> > index 8e176111e599..47cbf725b0e3 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> > @@ -7,6 +7,14 @@
> >  / {
> >       model = "Xiaomi Pocophone F1 (Tianma)";
> >       compatible = "xiaomi,beryllium", "qcom,sdm845";
> > +
> > +     reserved-memory {
> > +             /* Cont splash region set up by the bootloader */
> > +             cont_splash_mem: framebuffer@9d400000 {
> > +                     reg = <0x0 0x9d400000 0x0 0x2400000>;
> > +                     no-map;
> > +             };
> > +     };
> >  };
> >
> >  &display_panel {
