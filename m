Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3996234DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKIUsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKIUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:48:18 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C91303C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:48:14 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BB659203D7;
        Wed,  9 Nov 2022 21:48:11 +0100 (CET)
Date:   Wed, 9 Nov 2022 21:48:10 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,msm8976: convert to dtschema
Message-ID: <20221109204810.fyestfmom7nzgqt2@SoMainline.org>
References: <20221108140909.51422-1-krzysztof.kozlowski@linaro.org>
 <20221109113334.u2jhlwqgpfubfg5w@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109113334.u2jhlwqgpfubfg5w@SoMainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-09 12:33:37, Marijn Suijten wrote:
> On 2022-11-08 15:09:09, Krzysztof Kozlowski wrote:
> > Convert Qualcomm MSM8976 pin controller bindings to DT schema.  Keep the
> > parsing of pin configuration subnodes consistent with other Qualcomm
> > schemas (children named with '-state' suffix, their children with
> > '-pins').
> > 
> > Changes during conversion: update the list of non-mux pins (like sdc1)
> > to match Linux driver.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for sending this right as we are upstreaming MSM8976!  With one
> question and one nit below:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

I retract my review on this patch, see below.

> > [..]
> > +        items:
> > +          oneOf:
> > +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-4])$"
> > +            - enum: [ qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2,
> > +                      qdsd_data3 sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk,

Missing a comma between 'qdsd_data3' and 'sdc1_clk', making the bindings
checker treat this as a single string 'qdsd_data3 sdc1_clk'.

- Marijn
