Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A37284DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjFHQYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjFHQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670E30C0;
        Thu,  8 Jun 2023 09:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC2864EEC;
        Thu,  8 Jun 2023 16:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6500C433D2;
        Thu,  8 Jun 2023 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241456;
        bh=emDKGIQg2V1uHsyxtEynP85YQXxJbVOJVysU9JlSER0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJUnoS5++nDbgKkDeQ9AGm6pPqxgSxSZidZhGnW0YZbFREIIhCADii8SngEzdBzA4
         6YPp6mt3E68OHmSQ+cNZM1w7X7Rs+O3dUcTDfZFVNyOh5y92Ui1mQNivLzJj7PrDny
         xOen3Or+JaupPEgFg7HXPwlMUfE2eBvz7gjcqgcdS8UH4jnT1MtnM3zj5li3A708r4
         tzhiMo8H/foF33fiYq1J5blFeroxWMaT/jTFjTiJu3kOao9GOaSUTJJxXp2GSjA6S5
         Z4lQg/ZbcKIW5FgLbtbc1bibLBR8XKhMCpV8aXWfnEWznQqZ0kN6GVpgnNHOpj1q5B
         jfUcPN1b82KHA==
Date:   Thu, 8 Jun 2023 17:24:10 +0100
From:   Lee Jones <lee@kernel.org>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,tcsr: add the compatible for
 IPQ8074
Message-ID: <20230608162410.GB3572061@google.com>
References: <20230526110653.27777-1-quic_viswanat@quicinc.com>
 <20230526110653.27777-2-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526110653.27777-2-quic_viswanat@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023, Vignesh Viswanathan wrote:

> Document the qcom,tcsr-ipq8074 compatible.
> 
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
