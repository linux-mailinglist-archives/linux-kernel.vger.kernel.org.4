Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25946D7306
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbjDEEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbjDEEGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D046A8;
        Tue,  4 Apr 2023 21:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3EB63967;
        Wed,  5 Apr 2023 04:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D1DC433EF;
        Wed,  5 Apr 2023 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667582;
        bh=B2jXylkttF8JMZ1fNKwW05vowoDuKvZ8TQ/oLz1P9l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfbYKTmejnNI0Z242I0xXYOIvLaIHHLyysUH+o9llQDdri7Dyh9smLRWWNwHCFkCq
         mVL1K3d62cNS1iV5LV/vmNjRRp/ci5ZpUZIea4m0cx6JUQ6C7/SrOjQp3CHdetGk93
         1rt8Ou100I91ExMy3NfpnEhsZofLaDk0I/BIC1If8AKTI4UkTUEeQlbIYV87RWBRYg
         Ri9dqpZWVhcLCSPXxzbqsKQAyYRthqbqooc9qz6E4/jOAcyEYZsB09WHhgjq9FWJBX
         r4PXPI8tg5JxL8UmVzqZFC51AFKzLFAvTx43qZNQyPOivhW81dibLmqJHADHx+i8NR
         t6IleI+qeyPug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add MDSS_CORE reset on QCM2290
Date:   Tue,  4 Apr 2023 21:08:54 -0700
Message-Id: <168066774414.443656.16797951336713258256.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316-topic-qcm_dispcc_reset-v1-0-dd3708853014@linaro.org>
References: <20230316-topic-qcm_dispcc_reset-v1-0-dd3708853014@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 12:48:03 +0100, Konrad Dybcio wrote:
> Add the MDSS_CORE reset which can be used to reset the state of MDSS.
> 
> 

Applied, thanks!

[2/2] clk: qcom: dispcc-qcm2290: Add MDSS_CORE reset
      commit: 002c3fb6f4f38b50ef0514247c2d55fc6ed8c6d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
