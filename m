Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A037E6C5B56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCWAWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:22:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354B2D69;
        Wed, 22 Mar 2023 17:22:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso366057pjb.0;
        Wed, 22 Mar 2023 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679530920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ew/jPNlIE4OVZf16YBuF35hJ9UHUXMnnNtrgoWeDu0=;
        b=WiYaMhZ04v5QuGOplmNmgMo6AI2VD6E7Pby2WsO8odIaTJfCLBapcjfc8ShwxJHvPJ
         cCxH6BqubAhmYZYyChHhqdOh5D0Tqeu7YRVy3DLb4SXTXq/u0FWxmBMOmX2Q2HaIFpRm
         ZnszruorLJSwCumgC1/4LQt6KmMWMsDQcQk0h3VV3WDRNQWVpfS5oTrZtHzjneyQhveO
         OiD8zZvXA1tc3QRKLKdaG0F6ahLiXTrz3/5nwdAOQPT5Wt80SJsA+4aV8Wni6/x5Y/vj
         YN2/IioGzT9+ggurrmxcsd1GhzD9WWucTOjOxsZw/WWh7kIiSjhhBubluu/l2iNP2L+V
         VCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679530920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ew/jPNlIE4OVZf16YBuF35hJ9UHUXMnnNtrgoWeDu0=;
        b=x/B1vcTtpd5GGDEkg244GooepJRWOi9WdAYsI5x8+Oq4Z14qCsD670Rf6LapHSCTxo
         IrdR4uIHu6GTsiq3wf/o0V+ftPnjlY3o2jkpNEbl12LmTW3Ge0KtCswScwj3YrCvdQoW
         4SPsA0oMDgFjY+NwVZmBH5XFxvnBNtIMZ78zaMk10PBMUXTNAtR0oWG41EK47qlsITKG
         vQqNwfVp2zAodmzbusWXkKaM31UrwbuCmQLpLYONwkgqx/Emp3Bxviy+YyvNyN95yQku
         mR6nnN3Na2RTq1EVLg3vWNxdovd11j3Fep/FdAH97D7rqurl6GQI1KALMlRhOBt8iwHX
         uvnw==
X-Gm-Message-State: AO0yUKXmIcVPe1cRgQEXuR8NRRPRY78qIjqmG8/3uccuyR8ftolMBqeB
        J3bQjEZLwEPIjSQtic2AmyaJD5JkUJPDhA==
X-Google-Smtp-Source: AK7set8+3ET1jExl9th2b8YaVrcRPXoMCfOTxbHleY8lh23anpTzho3rf76+fDfZcHZvi2RmMmZvuQ==
X-Received: by 2002:a05:6a20:c510:b0:c7:5cb6:2ff7 with SMTP id gm16-20020a056a20c51000b000c75cb62ff7mr1296482pzb.22.1679530920392;
        Wed, 22 Mar 2023 17:22:00 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id d22-20020a63fd16000000b00502f9fba637sm10199103pgh.68.2023.03.22.17.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:21:59 -0700 (PDT)
Date:   Thu, 23 Mar 2023 08:21:53 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Move elish dts to common dtsi
Message-ID: <ZBuboZi7iJrovuWv@Gentoo>
References: <20230322171555.2154-1-lujianhua000@gmail.com>
 <ad39709b-5e1a-8659-8bbd-cb28e2e6366a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad39709b-5e1a-8659-8bbd-cb28e2e6366a@linaro.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:08:52PM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2023 18:15, Jianhua Lu wrote:
> > There are two panel variants of xiaomi-elish, BOE and CSOT panels.
> > In order to support both panels, so move elish dts to common dtsi.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Remove sm8250-xiaomi-elish.dtb to avoid build failure.
> > 
> >  arch/arm64/boot/dts/qcom/Makefile                             | 1 -
> >  ...m8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} | 4 ----
> >  2 files changed, 5 deletions(-)
> >  rename arch/arm64/boot/dts/qcom/{sm8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} (99%)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 1a29403400b7..8d2b3c57a4a8 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -183,7 +183,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
> > -dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish.dtb
> 
> This builds, but it is a loss of functionality. Instead the board should
> be renamed here to one of your final namings, e.g. boe.
Acked
> 
> Best regards,
> Krzysztof
> 
