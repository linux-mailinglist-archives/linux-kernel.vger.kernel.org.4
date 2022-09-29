Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81D55EFB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiI2Qwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiI2Qwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:52:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121C154452;
        Thu, 29 Sep 2022 09:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE083B82577;
        Thu, 29 Sep 2022 16:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB5C433B5;
        Thu, 29 Sep 2022 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664470346;
        bh=LY9g3GmYKqws0veeWPSJvuwB0VfGpNYLTLaHtaZqEbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qq4wacKqp1zt3LbmL9rs3u9c9k3fVltvNY0XY3l6lGC74MM0u+kHX+Ui+VfG22Sts
         qxHCEc0jhLlYZdEz0luPms1LXjkh95fzJXeFS4nmMLQpGCREjyov5cV5laiksxnnk6
         dQC/l6zCRl6pNGigM1WH4Q5mFcqF1Nr7crEWyp+uaLkTWRWDoIvWl3i9vsw7BHmzxe
         udmBucaulWlB42bB619ASQ1fy7mD1Elv1WwV6M34iYg5jIwT5nv+WzF4QbYO5nZjCM
         DsVOKu5oKWT+jZ2ZNXJKMR6tAKYYnQ+yeFPzc+AGcw7QiR+Uq/kZbl4BsoYrnzGViF
         08Ocg1rXh0g4w==
Date:   Thu, 29 Sep 2022 17:52:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: use generic node
 name "gpio"
Message-ID: <YzXNQwQlXF/tAvjn@google.com>
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
 <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
 <YzQWvEGeKNWKrsWh@google.com>
 <c93d5255-6b27-6bdb-3330-97a12e04ead5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c93d5255-6b27-6bdb-3330-97a12e04ead5@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022, Krzysztof Kozlowski wrote:

> On 28/09/2022 11:41, Lee Jones wrote:
> > On Thu, 08 Sep 2022, Krzysztof Kozlowski wrote:
> > 
> >> GPIO controller nodes are named by convention just "gpio", not "gpios".
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > I guess I can't take this until the 2 arch/ patches are applied.
> 
> You can. It will warn when running dtbs_check, but that's not a big
> deal. Anyway DTS patches wait for quite a while, so there was enough of
> time for them to get to next.

I'll apply them after -rc1. :thumb

-- 
Lee Jones [李琼斯]
