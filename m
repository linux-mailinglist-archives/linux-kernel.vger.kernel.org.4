Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC80B6C8521
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCXScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCXSby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D695212BF;
        Fri, 24 Mar 2023 11:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15BF6CE276B;
        Fri, 24 Mar 2023 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D091C433AC;
        Fri, 24 Mar 2023 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682695;
        bh=wRBE24LcWjOGg2t9TBn4CHi2d572AMBII6jwnZxbL8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnMbYpkq5Yf28p1rRw0M2I+uS/F31Yb6c2Hy4J7GcK2A17wki2lD/FqaM0SiaxWdC
         A+AFQfUU11XJQnlxgcUgakMYCK3oJNboeCMOjguaU1tiOq88LQtKsPDhP0uDEHrnfL
         2w36fhuLYxtnZrQIofKsJ+AkOtbf0aMuQvTeqTIE3/4gI9HCaNPWJ9LijBWkwMkXfw
         4lk2G+R06c4g4qyEAtBGEdCSuzi8Boxj+RSadXkjA3X9e/DMhp/X8NePosldrSZc4s
         P8zLrk/hlzUkL6i/20ELS+Waqiyc32F86xhumC//ROIeAkuCQHqWCSZDngBuRwpPxX
         uFxmnVIJmPliQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, jassisinghbrar@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, konrad.dybcio@linaro.org,
        linux-clk@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>, robh+dt@kernel.org,
        mturquette@baylibre.com
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: (subset) [PATCH V3 0/5] Add APSS clock driver support for IPQ5332
Date:   Fri, 24 Mar 2023 11:34:34 -0700
Message-Id: <167968287203.2233401.11163223502955044307.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217083308.12017-1-quic_kathirav@quicinc.com>
References: <20230217083308.12017-1-quic_kathirav@quicinc.com>
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

On Fri, 17 Feb 2023 14:03:03 +0530, Kathiravan T wrote:
> This series adds support for the APSS clock to bump the CPU frequency
> above 800MHz.
> 
> APSS PLL found in the IPQ5332 is of type Stromer Plus. However the
> existing IPQ targets uses the Huayra PLL. So the driver has to
> refactored to accommodate the different PLL types. The first patch in
> the series does the refactoring, which can be independenty merged.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: ipq5332: enable the CPUFreq support
      commit: e16dd29a3dff57eb6c84374ad8d824f1ec1c48bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
