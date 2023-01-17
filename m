Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDE66E6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAQTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjAQTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:11:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942B5C0EB;
        Tue, 17 Jan 2023 10:24:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD4FBB819AA;
        Tue, 17 Jan 2023 18:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6099C433F0;
        Tue, 17 Jan 2023 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979885;
        bh=1xhBsSjuMWtLb+h5smhvXK2Y1tkUk1ngEy3iBNxPO5E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZLbVXljW6PMwbZE8e9dMRiA84wIQSQeb7RLvvJrRJySApXDi3KML7Xx7bQg33Aq/h
         RRJUgs2ogFblQV0pPR3PXxwc4JO/fRbZmRjbzJCjE4756jI111lS94dOhAnWHO6U9I
         5I15cEx0NmtmKpgLciJ8yOBzk9MSN+iGgf+3GnmkTaNAV0BK9dLGzUuGOfOBugkEnx
         Ody57govgb//apqZJqH2hhCYU9gYFxIIc0fNVWrFIVNqbvqVFsE93R7StfQy+WQZ+W
         WKcgbxlEHEJIdmGR1kJAsJiswgiuxwh0UerOk2VqEao27GnGe3l72E6uTfDI9+Kv5u
         tJh9MFJtvMpnQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, rfoss@kernel.org
Subject: Re: [PATCH v1 0/3] SM8350 Display DTS
Date:   Tue, 17 Jan 2023 12:24:30 -0600
Message-Id: <167397986261.2832389.3618972043357258742.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117120223.1055225-1-rfoss@kernel.org>
References: <20230117120223.1055225-1-rfoss@kernel.org>
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

On Tue, 17 Jan 2023 13:02:20 +0100, rfoss@kernel.org wrote:
> From: Robert Foss <rfoss@kernel.org>
> 
> This series was split out of v4 of the SM8350 DSI series[1],
> and now only contains the DTS changes related Display on SM8350.
> 
> 
> [1] https://lore.kernel.org/all/20221230153554.105856-1-robert.foss@linaro.org/
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8350: Add display system nodes
      commit: d4a4410583edc065f8f311bdb642cf8f23c8e97e
[2/3] arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
      commit: ea9df63f0f23bffc1b8840104d683015f5fa82d4
[3/3] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge
      commit: d96d8f9192be33454ff3fa95a380c836b3008610

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
