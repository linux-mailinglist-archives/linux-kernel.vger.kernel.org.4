Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBD629F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKOQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiKOQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:41:58 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D92D1EE;
        Tue, 15 Nov 2022 08:41:57 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 12DD03F30C;
        Tue, 15 Nov 2022 17:41:55 +0100 (CET)
Date:   Tue, 15 Nov 2022 17:41:53 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom,msm8976: convert to
 dtschema
Message-ID: <20221115164153.rcyo3h35bj6vxy4r@SoMainline.org>
References: <20221110085230.15108-1-krzysztof.kozlowski@linaro.org>
 <166852857073.244019.11894552754264671717.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166852857073.244019.11894552754264671717.b4-ty@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-15 17:09:33, Krzysztof Kozlowski wrote:
> On Thu, 10 Nov 2022 09:52:30 +0100, Krzysztof Kozlowski wrote:
> > Convert Qualcomm MSM8976 pin controller bindings to DT schema.  Keep the
> > parsing of pin configuration subnodes consistent with other Qualcomm
> > schemas (children named with '-state' suffix, their children with
> > '-pins').
> > 
> > Changes during conversion: update the list of non-mux pins (like sdc1)
> > to match Linux driver.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] dt-bindings: pinctrl: qcom,msm8976: convert to dtschema
>       https://git.kernel.org/krzk/linux-dt/c/966d0a44f103950265db458180b581275a225b89

I did not get cc'd after providing review, but with the fixes this
obviously gets my:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
