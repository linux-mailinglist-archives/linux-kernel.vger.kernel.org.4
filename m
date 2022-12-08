Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175A5646DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiLHLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLHLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7C20994;
        Thu,  8 Dec 2022 02:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0709F61EE1;
        Thu,  8 Dec 2022 10:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1326C433D7;
        Thu,  8 Dec 2022 10:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670497071;
        bh=ArApedBR9W/0AgitPJMhjcF2716GJAKc1wlrDPvEWx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iE9Leep4FJc+rEM6FXqSrIH1eqZ0hEPSd/gqpKzkLaJS9psb+HWBRtfMJbvEmy3kN
         PpIQwKQlf+I/zS/4eyF63w9DWzeihJjvmdZ3tCWotLFmGR1q3VNCZvtJ1/YQO6gq6J
         1t5ftRN+j6iCdR/MEPMP7fdTmA9gzUAdH8nsNwIJ+36JOc6aa7PIBu94TXbXh3qA8g
         J0HJFcJYJ3jE95bw7rHCUz31TY2aMpK4p5RQGLsHPCmC+zDduZ5KZmq7xVyDA/fc8F
         Rul9Cay4tBGrcbPqG4No4+sD+fOrvhsvcOD0ziJXXKHFNmt1xcLLIdzFNY3BB3lmAZ
         Pid5KDv0zRHxA==
Date:   Thu, 8 Dec 2022 10:57:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y5HDKfC8Q1F7FXcI@google.com>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org>
 <Y5Dzamz6XRZudQzq@duo.ucw.cz>
 <Y5G30ttrf1RJa+sM@google.com>
 <947e47d3-4235-8f16-d3ef-c3ddd7d51acf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <947e47d3-4235-8f16-d3ef-c3ddd7d51acf@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Krzysztof Kozlowski wrote:

> On 08/12/2022 11:09, Lee Jones wrote:
> > On Wed, 07 Dec 2022, Pavel Machek wrote:
> > 
> >> On Thu 2022-12-01 18:08:58, Rob Herring wrote:
> >>> On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
> >>>> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
> >>>>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
> >>>>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
> >>>>  3 files changed, 61 insertions(+), 67 deletions(-)
> >>>>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
> >>>>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>
> >>> Or should I apply it?
> >>
> >> Thanks for ACK, let me take it, I guess.
> > 
> > Did you see Krzysztof's replies to this patch?
> > 
> > Sounded like he was going to re-work it, which is why I left it.
> 
> The only rework needed was to add "dt-bindings:" prefix in the subject.
> If you could add it while applying/amending commit, that would be great
> and spare me resend. Otherwise, let me know if you dropped this patch
> and expect a resend.

Sounds good:

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
