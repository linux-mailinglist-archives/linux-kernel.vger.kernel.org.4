Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0235D65B99D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjACDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:15:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEF4BE3C;
        Mon,  2 Jan 2023 19:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3351761198;
        Tue,  3 Jan 2023 03:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FDBC433D2;
        Tue,  3 Jan 2023 03:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672715704;
        bh=4IuSzLDCv7ed56dOHlWiqWJvdc/p2IbvW/+n/2kGkn0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tHi5ktdJP/uYKZIRSBRpxCqCkG1/XHRzwehdR1aFgjUW+jW+pCENZ9q9wiiX5QpqZ
         d8VSLVjPio0QDY1Ky9YkA8r9wipq5OB5mCGII5BFJusmxx+4Xkvs4Y2EemppuR0Gtf
         bRj8xQebaBoT99Jmxsx4RFfGJva4Bbf78tXCZHJewj1q8HUmD3f1Qni2jr0M+cYm/n
         1wlXsqb+CdQ/UqBjx5WILE44ZWXzJi1OwkDybFgexIeQLkoEQbQqeXzNRYF+8trBqm
         pHoT0LOYB9IqwG6HB3jHgJ7lA/SDRWw9+76RHGDyvQI0aBcG57JlSu9xVNIZhzvcXR
         X1lOtzF3GKZUw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: disable by default Soundwire and VA-macro
Date:   Mon,  2 Jan 2023 21:15:00 -0600
Message-Id: <167271569384.1479016.15403527811879879442.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230102123734.478433-1-krzysztof.kozlowski@linaro.org>
References: <20230102123734.478433-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 13:37:34 +0100, Krzysztof Kozlowski wrote:
> Soundwire is a bus and VA-macro requires a supply, thus both are
> expected to be explicitly enabled and populated by board DTS.  The
> HDK8450 already enables Soundwire devices, except swr4 which as a result
> of this commit will stay disabled.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: disable by default Soundwire and VA-macro
      commit: b9ae6ddeded793c80747e4f80211379d001a263a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
