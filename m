Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814266663FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjAKTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAKTsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:48:14 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9443F61;
        Wed, 11 Jan 2023 11:48:07 -0800 (PST)
Received: from g550jk.localnet (mobiledyn-62-240-134-128.mrsn.at [62.240.134.128])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 76FD0CC3A1;
        Wed, 11 Jan 2023 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1673466486; bh=rsOZZ2Ln+JMozd3x8JmeFsooYZX8jZpZTbWXHGDAW20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PGM1W1+RqDKTo5OpqZU9lc/tFiWV6NxJ/AW4tHcHn/naz5PTV4P5t7uHrZ6ICT/y6
         M0FqkU67SEXFdimjMBJG1+WPuSKVDt4CYNcWw/KfZe1QbbSe2OlJNK7skBuNJgZKSE
         KS6YAZra8LAp4m1eBR/RvcFyocMb0Mq+lvvldWos=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 compatibles
Date:   Wed, 11 Jan 2023 20:48:01 +0100
Message-ID: <4899603.LvFx2qVVIh@g550jk>
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

gentle bump, I hope this patch could get applied in-time for the next merge 
window.

Regards
Luca

On Sonntag, 16. Oktober 2022 11:00:30 CET Luca Weiss wrote:
> Document the cpufreq-epss compatibles currently used in the tree, plus
> the sc7280 which will be added in a separate commit.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml index
> 24fa3d87a40b..d6af29ee889a 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -25,8 +25,12 @@ properties:
>        - description: v2 of CPUFREQ HW (EPSS)
>          items:
>            - enum:
> +              - qcom,sc7280-cpufreq-epss
> +              - qcom,sc8280xp-cpufreq-epss
>                - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
> +              - qcom,sm8350-cpufreq-epss
> +              - qcom,sm8450-cpufreq-epss
>            - const: qcom,cpufreq-epss
> 
>    reg:




