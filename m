Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7567BD34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjAYUoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjAYUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:44:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A015C94;
        Wed, 25 Jan 2023 12:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9B10B81B33;
        Wed, 25 Jan 2023 20:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679D6C433D2;
        Wed, 25 Jan 2023 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674679451;
        bh=p2N3zgnQfCgQxKWK2hV2QHveHQZJmLSmPQnhVgKDPGw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a1oLHuIaQSxSu8FHUP1v+t4E5UxLNAC3cEkZVpqX8oTmjZV98R7eTVlNIbnEzRaw3
         1Y+nV8Z2x2KrFRshFKGQuEe+zl8h1bcFU7AATqViHg15o+/fMaiKqqhC/2AN8uO9eQ
         z80ynMNhom7b07I4/X61erLKmHFNuvPN5v9wa9lKlJqIJUJ1F4vqu82C0iBQFE8MQe
         1GPrnjmWb74dznomeuF0L4Q9RQ3cDy70iTeLk6sqThWxeRcr1UyKSCykXBViHPOwVp
         MCWNG5xm3GLBU+Ni2GlaZIUnE/Pm2sWQK1BQtsnsUiajiPHO3g3uiEV4pgvjcjvtb+
         6GsTlxavh3Tsw==
Message-ID: <7ddf5c74de84c5dc291996423cb1eb46.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230123094925.54824-2-krzysztof.kozlowski@linaro.org>
References: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org> <20230123094925.54824-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: restrict drivers per ARM/ARM64
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Jan 2023 12:44:07 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-23 01:49:25)
> There is no point to allow selecting pin-controller drivers for Qualcomm

pin controllers?

> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> kernel configuration more difficult as many do not remember the Qualcomm
> SoCs model names/numbers.  There won't be a single image for ARMv7 and
> ARMv8/9 SoCs, so no features/options are lost.

Are the drivers used in arm32 emulation mode on these SoCs? I recall
there are some SoCs they run with the arm architecture.
