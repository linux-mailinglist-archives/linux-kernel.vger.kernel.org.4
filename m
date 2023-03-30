Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A106D0624
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjC3NNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjC3NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:13:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268799;
        Thu, 30 Mar 2023 06:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3D0B828C7;
        Thu, 30 Mar 2023 13:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C25C433EF;
        Thu, 30 Mar 2023 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680182010;
        bh=6E6jFHtYIw5DptuqTHixVsIl5fjkh15ei8BZIjlv0Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C25FigMiaDq2/vPdIbcy5qtNzfVgoWj+hoP0NgqvnGo76rjaAUr0FW7P5qZUwF5jC
         /YglmykQv+A9MBk+k0ABIht8dzcVLiMcgvcVRATS7xA6oNRz5d4iBUAejG48IGZmw4
         xi2yo0EtbDJKVwFjt2i7uByEHJsPfPUONiKUhZkwrRoouDahjeEMVG1wjAlYHeRFfw
         /Z/otX0kosHcTQQHefS1a7002QrhZpbF2iOERTJ3+q9b4JKtVVVTKzUQ89tbxTZDDy
         SO9lfkNgispDEyZt3Zy2R+7GenqUy7OKf7BWS2u6XVvSWhZS4iYCJDeiSLpDvlHZCi
         YCntRrqKp47Jg==
Date:   Thu, 30 Mar 2023 14:13:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/18] dt-bindings: mfd: qcom,spmi-pmic: add
 compatible for pmm8654au
Message-ID: <20230330131324.GQ434339@google.com>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327125316.210812-7-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
> for it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Lee Jones <lee@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Change-log?

>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 975c30aad23c..0f7dd7ac9630 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -79,6 +79,7 @@ properties:
>            - qcom,pmk8350
>            - qcom,pmk8550
>            - qcom,pmm8155au
> +          - qcom,pmm8654au
>            - qcom,pmp8074
>            - qcom,pmr735a
>            - qcom,pmr735b

I believe this is already applied, right?

Not sure why I have 3 copies of seemingly the same patch in my inbox.

--
Lee Jones [李琼斯]
