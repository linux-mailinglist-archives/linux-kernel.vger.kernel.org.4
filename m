Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614C6617BC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjAHSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjAHSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:04:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBF7FADA;
        Sun,  8 Jan 2023 10:04:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso10492720pjt.0;
        Sun, 08 Jan 2023 10:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TK9smNKM8L5ERP2lizjy7Jnwhohf+9dokgzX4r6ntOI=;
        b=Qf7hnJIcbNkPLRgDeCx1mPkm3FYoZY/ZKQHdqDqtPrbwb3JiWrQJJxODlVbmrM6OKk
         5t0UCbk+pKur7Xir5n1lAv9auFRdp3xqsBHGLPWKddFOEtB6Fpx3mLlMHovBc7JgzjJd
         1GTSG34qi4u4RZyhAhP3p3edne34Zf7Pzy6MEXAiTDgKuyZtvbpGl5RcdFF97NQ6+y8v
         atiKgb/c1UgTjgIccFghn9IqqlCidZr790vyEBD9UUXhSZEpbqcJwv1C7noK7TdIRFJz
         n6ej8uwFD+KB/lLpluuNgPmFBo0c+qk0SeLuGsvPRQW9hCKnKuGYlLaBLPP4G988qyCW
         Cjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TK9smNKM8L5ERP2lizjy7Jnwhohf+9dokgzX4r6ntOI=;
        b=ntq+RZjAppx5+pUCj0ReC3C59Ccbv2D8qoB+4ocLWES6T+3DcmMi9HVysHrEV2ZZk7
         IXzypfMd4mGGBnVkH7g1QRjvYVEKzloHKxlAfVQyITV9khZjopZF4Gl1bwfc5+51zZuY
         XP3/SfU2EBUFmLIlFCTa1mRPNCpp43iPvZzKUEkBrBS/jHuQHEFWRjGi7/d3siQJHbGq
         pXW+yrMsKqk0LbAIab7InuIcMZXe9ggIVpzfOO8q+EtW+66nY2AaboHwhPyj9DRCSv9i
         iBgvQlrcD6PqNkOZ2QdJWwXRv4uhtSL2ojWFOhd7Cgcl4Wzk4d0gzlhMpufguGLI1d0U
         c2Gw==
X-Gm-Message-State: AFqh2kpcn1jP2U1Fo9s9mC2DF/fXPC7HVUnB+ivaKwtpiUSL6PNxt44C
        IU2Kh0Y9DImoM3f6tM02G828IeBqS/LVCtmEqEw=
X-Google-Smtp-Source: AMrXdXsDxMzHFLOsyNd9DUqsjwJ02X9bbVf+QTUbTWyqZ1yZVRCvE4bSrXySHp2hEQ7gkYIKEJY1ikrKofail+wOGIg=
X-Received: by 2002:a17:902:e384:b0:191:34ee:8faa with SMTP id
 g4-20020a170902e38400b0019134ee8faamr2468426ple.111.1673201066408; Sun, 08
 Jan 2023 10:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20230108130440.670181-1-robimarko@gmail.com> <20230108130440.670181-2-robimarko@gmail.com>
 <CAA8EJprb1nC6LCbPQ18tU=apxY+8YfvL2uhrVzwgqJ+GXsjEvQ@mail.gmail.com>
In-Reply-To: <CAA8EJprb1nC6LCbPQ18tU=apxY+8YfvL2uhrVzwgqJ+GXsjEvQ@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 8 Jan 2023 19:04:15 +0100
Message-ID: <CAOX2RU5zSDppy-EsBJDmwQpD=GqXJTPd_m=5RFZFb7WvB5etqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: correct USB3 QMP PHY-s
 clock output names
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2023 at 18:32, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sun, 8 Jan 2023 at 15:04, Robert Marko <robimarko@gmail.com> wrote:
> >
> > It seems that clock-output-names for the USB3 QMP PHY-s where set without
> > actually checking what is the GCC clock driver expecting, so clock core
> > could never actually find the parents for usb0_pipe_clk_src and
> > usb1_pipe_clk_src clocks in the GCC driver.
> >
> > So, correct the names to be what the driver expects so that parenting
> > works.
> >
> > Before:
> > gcc_usb0_pipe_clk_src                0        0        0   125000000          0     0  50000         Y
> > gcc_usb1_pipe_clk_src                0        0        0   125000000          0     0  50000         Y
> >
> > After:
> >  usb3phy_0_cc_pipe_clk                1        1        0   125000000          0     0  50000         Y
> >     usb0_pipe_clk_src                 1        1        0   125000000          0     0  50000         Y
> >        gcc_usb0_pipe_clk              1        1        0   125000000          0     0  50000         Y
> >  usb3phy_1_cc_pipe_clk                1        1        0   125000000          0     0  50000         Y
> >     usb1_pipe_clk_src                 1        1        0   125000000          0     0  50000         Y
> >        gcc_usb1_pipe_clk              1        1        0   125000000          0     0  50000         Y
> >
> > Fixes: 5e09bc51d07b ("arm64: dts: ipq8074: enable USB support")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Nevertheless, could you please add .fw_name to these entries in gcc
> driver (as you did for other clocks in 35dc8e101a8e ("clk: qcom:
> ipq8074: populate fw_name for all parents")) and add all pipe clocks
> to the gcc node? This way you can drop clock-output-names from the PHY
> nodes.

As you noticed they are in the GCC patch already, after the PCI PIPE
parenting fixes
are merged I plan to add them to the GCC node to avoid global lookup.

Regards,
Robert
>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> [skipped]
>
> --
> With best wishes
> Dmitry
