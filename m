Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4A6BBA94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjCORKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCORKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:10:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0915565;
        Wed, 15 Mar 2023 10:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00C7B81DD4;
        Wed, 15 Mar 2023 17:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0121C433EF;
        Wed, 15 Mar 2023 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678900231;
        bh=6bkfr7+DSuZPOgyQFpALDv2ew7m1XXb81pexUPzB9bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJ1hGspZU/l6FJgE8QplbYQjznKXNc/O/uonoEN4+LV7KEn7zHazIjr/ihcraJJbq
         12h/jtnVpayOiqrQvdyHuHzXEAC9I3YS7b+aGT51yJSZ+Nz8+GfYlyKPBDXX6JsTJ5
         Md7vxen2xy/jjRRLT6Iv6ud9eMvv6FBXwAZsa1ql2KoJtu6pU4v1HvERognyMC9+cD
         o/4aOdEueNoQCxy+UbkWGhOxzVJ5oJ5QUDtlmb7uKtknaJ3PPEYI7Jacu9TYwZ4Fau
         euCLld1rHFQB0ftzx8x9hKzxKsB9xrlYB+1hYiMu8d4xFOs6svcyCy2p6buGFM6jI4
         XcG9ZoGLBcRpg==
Date:   Wed, 15 Mar 2023 17:10:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, krzysztof.kozlowski@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
Subject: Re: [PATCH v8 2/2] dt-bindings: leds: add QCOM flash LED controller
Message-ID: <20230315171025.GE9667@google.com>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-3-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303095023.538917-3-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2023, Fenglin Wu wrote:

> Add binding document for flash LED module inside Qualcomm Technologies,
> Inc. PMICs.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml

Applied, thanks

--
Lee Jones [李琼斯]
