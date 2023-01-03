Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F9765BF20
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbjACLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjACLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:38:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E81261;
        Tue,  3 Jan 2023 03:38:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8872C61284;
        Tue,  3 Jan 2023 11:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF6DC433D2;
        Tue,  3 Jan 2023 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672745911;
        bh=R2Dzj/2kb3SslWczETl2IKtdwzAJ8TDrNr/cvB9c/bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViZbtT6fzJtT12QWCtJch3B/IdWvJMDV0JzyQ9EluMiaHGPwcvstBdXAFkS4dGICs
         AJ+uATz2UcTNe/76z9x7RXq/O4up0kIMcfeV7i5mi08f8s58pW+oAt4iTHuxg16CEX
         hseKN4p66dYkSATyVnUh7bO9uLmkgqPsXmDBo7HRp/egiPNIlHfqh/o6krJd4gr5GF
         rveCcDgmbj3vUseF/cB24YarBegw6IY+RYuhaT2zcA9/8HpAy7JGWNKNG0YsG5s/Oz
         qY2OVvWJhFNalLqq4cB+ezdPR0TjXz/07qA6u8xwWiJIMCwXMkoicHIR0iDAegd58I
         I+KXfuYDC8OqA==
Date:   Tue, 3 Jan 2023 11:38:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: document
 pm8550, pm8550b, pm8550ve, pm8550vs, pmk8550, pm8010 & pmr735d
Message-ID: <Y7QTsdL9xSQzIM2b@google.com>
References: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
 <20221114-narmstrong-sm8550-upstream-spmi-v2-1-b839bf2d558a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v2-1-b839bf2d558a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I changed the subject line for you.

On Fri, 18 Nov 2022, Neil Armstrong wrote:

> Document compatible for the pm8550, pm8550b, pm8550ve, pm8550vs, pmk8550.
> pm8010 & pmr735d SPMI PMICs
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
