Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9F6BC128
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjCOXdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCOXcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2389FE51;
        Wed, 15 Mar 2023 16:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74E8D61EB3;
        Wed, 15 Mar 2023 23:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC3C433A0;
        Wed, 15 Mar 2023 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923143;
        bh=ONJkos0WPpFG8tJg/C9jz97nBKTg+UsqKzw+zUPC+j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvfgAza3/Kl1jWx3hAKQWGjpAAdeC09jVWQywrI8S5rQ3MZDaxq1Xx8yGFhGKGmwi
         WqOiSUtJoPexnSylv5qXKQIRb42iSjrrghktbj9kRyqM/8Jj+IimkBGGJw8hwolQPB
         waSTzuDzcPhc4OHmcH0/pXYm59VnidHc8ij9rl89CoJf8kf5p3HM2qAonY0/Ra5vP7
         b1GHxzDFm7YiRWwcYu/a6YNRIj3MsVOQj0+zjHlLuF/DFbX6ndmCcf9ZKLOnO80B0j
         kfaUoeS6fMUj3tOYwM4cGDRBf2yNCedKQdAWZt/Hpe7G0aTHkZm4lP5hwlENSWlE7J
         j/KaSxHGKCmJQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Add missing DWC3 quirks
Date:   Wed, 15 Mar 2023 16:34:53 -0700
Message-Id: <167892332567.4030021.1862299841768461252.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302011849.1873056-1-konrad.dybcio@linaro.org>
References: <20230302011849.1873056-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 02:18:49 +0100, Konrad Dybcio wrote:
> Add missing dwc3 quirks from msm-3.18. Unfortunately, none of them
> make `dwc3-qcom 6af8800.usb: HS-PHY not in L2` go away.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996: Add missing DWC3 quirks
      commit: d0af0537e28f6eace02deed63b585396de939213

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
