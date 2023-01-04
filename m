Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50F65D2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbjADMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjADMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:45:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0219C24
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:45:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so26304270wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JoyE4PJWzp52kEQxZdg5xRzmINtYTSDR3GIdh/fen5o=;
        b=i2Q/j+795TYv9w0QGb5kGADj0/TDDYgZ7oc9eCOCy8Xrgx1fBkExbj4IrVJVkwUM21
         8ES9qTesJVKLd49BSl+uXksWGO7vf8sI4EfhxMK67L6JQNFTqZHqwHTCWgxiEy+oavFK
         EeDqIPKvUKsMvoyQLGSptukGhbsdLBw/cZUVnLx2I4XaGt9RwZSdpqfmwgF3t991ES0p
         LVq9LKBrnxUzguC22xPQ/UT+gi43vjis4XleOV7RqPvh3jLowLV+eDI2POPaY/bIG1eF
         tHqFKVlTXMUYlTENM0qkltyKfY/W0kbXBdXeLdhJCffE1bB794OhfPPGSoBnCmWgTKsw
         Pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoyE4PJWzp52kEQxZdg5xRzmINtYTSDR3GIdh/fen5o=;
        b=ixc96Cy2sxtf8iYDGB7YiWodbtYUMv+IjpzAG1spa7oJBKKA4OUHL1sFk1qCiamj1d
         Spvk0RRvOGfpG08WZqzr/IzM8NchkS3of9DeYumuhU02wvU+W6FoQkqSySZzisET+bpO
         nBEb4r7yerNOU2iHmRyUOSXl2qBy7F7Gl/K8OJIchTbP/oIQdS/843LIbGWL49Bdk0hB
         Kc7kD5Pg/dbeGwJubWq12bLg0OfIDXmhgoc3+x1kXO1jn7s0i8r31SX9L1l3QTwTcwM6
         k5GyjEDYRMAaCSIKt23/5ERYHipemhmJRvFmCPkty0z7T4knvpm7pOFSDgQ3WQYddtVs
         kBHA==
X-Gm-Message-State: AFqh2kqHnlYqnxO0TTqHhOoFsBqpU5HoHme7W6ffdpD7G1+xOlrVCDo/
        Pjhf+wsonSG3/Dx4zFR82w5XVQ==
X-Google-Smtp-Source: AMrXdXuOHq0R3jJqhQZ89qbuXqn8jDJ+4fL/qm9ZowCLln8b45hYqyJuEujJSRfFX1H2V9Pf4KG6pg==
X-Received: by 2002:a05:600c:4a9b:b0:3d1:dc6f:b1a4 with SMTP id b27-20020a05600c4a9b00b003d1dc6fb1a4mr41485468wmp.5.1672836306720;
        Wed, 04 Jan 2023 04:45:06 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003d1e3b1624dsm54726447wms.2.2023.01.04.04.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:45:06 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:45:04 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 3/4] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Message-ID: <Y7V00JiPAYfqF4wH@linaro.org>
References: <20230104093450.3150578-1-abel.vesa@linaro.org>
 <20230104093450.3150578-4-abel.vesa@linaro.org>
 <07a849a9-03dc-f3af-1d3f-2369cb71451e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a849a9-03dc-f3af-1d3f-2369cb71451e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-04 12:46:55, Dmitry Baryshkov wrote:
> On 04/01/2023 11:34, Abel Vesa wrote:
> > Adds the RPMH clocks present in SM8550 SoC.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   drivers/clk/qcom/clk-rpmh.c | 36 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> 
> I think the plan was to have the _PAD clock as a child node of the rpmcc. Is
> it still the planned implementation?

Yes. Here is how the dts rpmhcc node will look like:

         rpmhcc: clock-controller {
                 compatible = "qcom,sm8550-rpmh-clk";
                 #clock-cells = <1>;
                 clock-names = "xo";
                 clocks = <&xo_board>;

                 bi_tcxo_div2: bi-tcxo-div2-clk {
                         #clock-cells = <0>;
                         compatible = "fixed-factor-clock";
                         clocks = <&rpmhcc RPMH_CXO_CLK>;
                         clock-mult = <1>;
                         clock-div = <2>;
                 };

                 bi_tcxo_ao_div2: bi-tcxo-div2-ao-clk {
                         #clock-cells = <0>;
                         compatible = "fixed-factor-clock";
                         clocks = <&rpmhcc RPMH_CXO_CLK_A>;
                         clock-mult = <1>;
                         clock-div = <2>;
                 };
         };

The clock nodes will be probed on of_clk_init.

> 
> -- 
> With best wishes
> Dmitry
> 
