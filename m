Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F096BC462
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCPDSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCPDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE096C03;
        Wed, 15 Mar 2023 20:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CF65B81FB2;
        Thu, 16 Mar 2023 03:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B5C4339B;
        Thu, 16 Mar 2023 03:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936667;
        bh=18q+EUM1V5K95X8f6dK5IfTeRfqj4x1R67isBHg9scg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OQ0uAlMl/KD2uP58tsM6ZHNfrDEnuyzVahPsM+xbJ2ZtBvtxmzqkppDPyR58g8kM0
         QXypG0m99OdeQBzZWzc7Lc4pMRMdqvOBDi3qpYZ/b1xFp+YcbhcqZTyGcl4lU4ZvJw
         F7hbYBpeEyL4u0b+mXW+/dmAxPP6hK8DSKHodCFPdHxFmecaEs8PqLw9NWtOMxX8YW
         e13+wF47DDGhRMoGsOsCq6Z0nbVga6b6kbRr+b2+WRKRAk2RVB6i0Y1cT7QPIJgBFA
         60vM22YKpN5+h1Q60Cw5ny/wudDH5JUreKZHNlDLE8zX/h/C8gO7lbrA5Y24+jRfLB
         kpbL4Wb6hQ2Zg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: (subset) [PATCH v7 0/7] Krait Documentation conversion
Date:   Wed, 15 Mar 2023 20:20:51 -0700
Message-Id: <167893686408.303819.7722718672200121136.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
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

On Mon, 16 Jan 2023 21:47:44 +0100, Christian Marangi wrote:
> This series convert the krait-cc and the kpps-acc/gcc Documentation to
> yaml.
> 
> This series comes form a split of a bigger series that got too big and
> now hard to review.
> 
> While they are still more or less wrong and doesn't really reflect real
> driver implementation, they are converted to prepare for a fixup later
> when dts and driver are finally fixed.
> 
> [...]

Applied, thanks!

[4/7] ARM: dts: qcom: add per SoC compatible for qcom,kpss-gcc nodes
      commit: b74ca4a0e3043af06819905306e05189f337466a
[5/7] ARM: dts: qcom: add and fix clock configuration for kpss-gcc nodes
      commit: a9e6d16ad493529da4a48d7ae474ecdc399ee884
[6/7] ARM: dts: qcom: add missing clock configuration for kpss-acc-v1
      commit: 6b20edd72930d83e9c2c2017df883b3c5c1502fd
[7/7] ARM: dts: qcom: rename kpss-acc-v2 nodes to power-manager nodes
      commit: 158ce4b3e1dfcf3e38c0dbfd626aee0f1bbfa3d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
