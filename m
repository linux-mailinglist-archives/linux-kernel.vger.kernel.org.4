Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736CF672CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjARXel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjARXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:34:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA87561D42
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:34:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q10so227353wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMcqZ9jlkTT/EnrqF50abWmD/pX2w5h3KsRPUL/teDU=;
        b=Y49gmAzSIBUA2llk6gPqPtLMmlGrwJKyK+EeFI0U8GSsIQfAl34R5XnojOqbtuXD+S
         NLZXrdKqM1bUrcVGZaivKOzBbuJANCHPAo2OgbEi0yjlKGNCNJzZtkmHj/Vf93SLxFW+
         KaN3eLK+byjKqiIlD/S9KVD5W1upBFM5mi4Vd0rsYn4ZN5EvIP36fHoCbZiQBZr6XqMd
         Uc7vMoTKhLbS5k6LpADOLPanKsuhX6z7Kn/Gg6XSsEQ8Jcw/e6uR/6760dtToiYkq+8D
         MzBetbGrh8uX4YGfLnOvJ1GmVQ2rGjX3FWVgoCIl0H02XNeKwpEfQh8/YV6eVJw5zXAB
         T6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMcqZ9jlkTT/EnrqF50abWmD/pX2w5h3KsRPUL/teDU=;
        b=C52AblY6pTULSb/8EiGlNDQnhPpBKWXcPcjGJcvgrOaH9QNju+HuULiNS2nfS+ozlL
         LsOOjXs8KWTJnULbhKHFCOZJYgFQnJbdrdggZgJxxRTGWjXw8TQaBQrEfAGTQZbrWggs
         rBf6Klv8jBRDPxKGVG3VFtmJekNqqSaGEv1g7M/nbNa7235qCFcZ0aSQeOnWoTDAgLmE
         AJTcHXCld7xEcnCrybrIEHGdl2zvabqg2ifqcFWFpe66+10HsefgBVyQON1zXQntwArg
         8vppW9NIpuSpzQ5FjN7iAqZfvtOqsLcVBRPm4VjeBG0SZwye/m+gSLOFhloNFoNQu1OI
         GvSg==
X-Gm-Message-State: AFqh2koYHlvyqRSOqmGwq/BzzbQYNTkd9HXJoGIufxlo7Tns5zFcnnqY
        PUePV+iuPAIRGd/ewQt7Cy0dEA==
X-Google-Smtp-Source: AMrXdXuJIDrIOSPo/0awstKU4JLPlOV9/gPSywgl2jxeexFxWtosMGtgICO1AqeVXnL18yQT8mYmXg==
X-Received: by 2002:a5d:4532:0:b0:2bd:dc1a:cbd8 with SMTP id j18-20020a5d4532000000b002bddc1acbd8mr7486793wra.57.1674084866399;
        Wed, 18 Jan 2023 15:34:26 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm32569664wrp.55.2023.01.18.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:34:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 01:34:24 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 8/8] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y8iCAPOyrYXd7e/3@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-9-abel.vesa@linaro.org>
 <7fe0c49e-a628-8e76-8294-ab8faadb3a70@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe0c49e-a628-8e76-8294-ab8faadb3a70@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18 06:34:41, Dmitry Baryshkov wrote:
> On 18/01/2023 02:53, Abel Vesa wrote:
> > Add the SM8550 both g4 and g3 configurations. In addition, there is a
> > new "lane shared" table that needs to be configured for g4, along with
> > the No-CSR list of resets.
> > 
> > Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 369 +++++++++++++++++++++++
> >   1 file changed, 369 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index bffb9e138715..6f82604bd430 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
> >   	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> >   };
> 
> I see that the last two patches still use 'shrd' a lot. Does this correspond
> to hw register names or is it just a vendor kernel code convention?

It corresponds to the hw register names..

> 
> -- 
> With best wishes
> Dmitry
> 
