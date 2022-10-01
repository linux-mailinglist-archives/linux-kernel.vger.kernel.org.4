Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717F5F1B33
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJAJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJAJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CA16DDE3;
        Sat,  1 Oct 2022 02:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1EE60BC6;
        Sat,  1 Oct 2022 09:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980CDC433C1;
        Sat,  1 Oct 2022 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664616157;
        bh=Ex6Y0JIz+7pjgm7ennD6lM916YkBwdHj2xozA8m3euA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8CqnaNKAE4iwqE+Y/jZsvntjoJ2jmuVtOW/dS8Rj5PCU6S8r9CkUu+7f7NDQbiHI
         l3944Cw/MTUECmZZjZYaJIu7I2ZgrS10MAot15sPAviZw67bKE7SIwctcaxwi2OrBD
         NorXzlMco1usdV4tFOLX+LaPPAFhFa3XMrks+khnsqaN38yAG8G/v23DVrAMsx79O5
         HUTHiXq1Z8He5uzk4Yczo5fQ4bH4BpJpEdvWB2PsyVozcHWg5MhLaXoM038EybBp7h
         5Ifc/z8vGXCQSlYlI4ghKUNqKWS7p79lfsmDfEFHsN19bjwj8Ts3xPP3RJb0IzqoNm
         OWFPL2amNTuaA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oeYhf-00Dwe3-EA;
        Sat, 01 Oct 2022 10:22:35 +0100
MIME-Version: 1.0
Date:   Sat, 01 Oct 2022 10:22:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: clock: Introduce pdc bindings for
 QDU1000 and QRU1000
In-Reply-To: <20221001030403.27659-6-quic_molvera@quicinc.com>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-6-quic_molvera@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <114fb5a01a422c15997a9a4daebce584@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_molvera@quicinc.com, agross@kernel.org, bjorn.andersson@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-01 04:04, Melody Olvera wrote:
> Add compatible fields for QDU1000 and QRU1000 pdcs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> index b6f56cf5fbe3..5c7b790db7e0 100644
> --- 
> a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> +++ 
> b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> @@ -33,6 +33,8 @@ properties:
>            - qcom,sm8150-pdc
>            - qcom,sm8250-pdc
>            - qcom,sm8350-pdc
> +          - qcom,qdu1000-pdc
> +          - qcom,qru1000-pdc
>        - const: qcom,pdc
> 
>    reg:

Please fix the title of the commit, as this has little to do with 
clocks.

         M.
-- 
Jazz is not dead. It just smells funny...
