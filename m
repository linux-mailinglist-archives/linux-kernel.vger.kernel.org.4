Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD6702155
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjEOCCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEOCCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547401712;
        Sun, 14 May 2023 19:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1669612CE;
        Mon, 15 May 2023 02:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A953EC433EF;
        Mon, 15 May 2023 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684116139;
        bh=470fg0q4D5l5QNjkmRtxrTZcLO4hXnPzfSgt/4ivIys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTK06w2OktkUrbd2ZPfQR+xgFpM2DwmpYkOJXxAEKGp/yT7jWweLbS6O49PlIylUi
         +921FesY9ScyHPS1CCBCQfDft3VfFl+yIQ9NQ+ZCO0Q7hxa0dfFdPV9hizq2GsAdki
         1gcqQMEQ/xewIazTFbHuRG7XjCKzKroT4jEJMRD0oL6JjRJpEqcpvaE+LT7VU7KN6W
         Mk7Lf2lUnhjH3FcWWQ8kQZ3SSfxazCTKlR88HU4oTIN1TNBxCZ+ONNHhoIc2zPdNIi
         /oRJ+dcBRu5sVsTSYc0CyhkjG6mHroEo3Oy2CiL17Hs+jTWMT9nXoLQZ+whxO2P1QX
         m+BfOdA+tXUtA==
Date:   Sun, 14 May 2023 19:06:11 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: restrict drivers per ARM/ARM64
Message-ID: <20230515020611.bahv3hk5jma7fwzi@ripper>
References: <20230514114711.18258-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514114711.18258-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 01:47:11PM +0200, Krzysztof Kozlowski wrote:
> There is no point to allow selecting clock controller drivers for
> Qualcomm ARMv7 SoCs when building ARM64 kernel, and vice versa.  This
> makes kernel configuration more difficult as many do not remember the
> Qualcomm SoCs model names/numbers.  No features should be lost because:
> 1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
> 2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
