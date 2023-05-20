Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67670A481
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjETB5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjETB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE718C;
        Fri, 19 May 2023 18:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD03A6163B;
        Sat, 20 May 2023 01:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB8C433A0;
        Sat, 20 May 2023 01:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684547863;
        bh=nro0QPNP0dZ5T4kKuyRM2tszHlYNpG3EVWO0M9ORTo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQVtjJkkC6uBeOrdgdxaf88s8Ido+DY6UtNk1vh8nzZUuUr4nILFB6bIn7sqj0rNH
         HS4Nc51ezIMIP7ZEJs9xDjywEd4rn9HAaf9qiwENIWpN+eytf0E4p/iIX3Q3ak3KVC
         bW/xV9JZGZW1bpiN3uMsnghzG+fZ/WFA/PTD1L3DpYUlvLDZR1sMEZYLZugd9+pVq6
         LLChfKjw57Ut1K6YpKoNW9zE/3BSNVZ4V9vxyAEucq4qzQSug9a7MyvRREO2XQ1YPq
         a4zmtlv2C1T8Kd+Qf58ErA9mJXI0lxdWpZPoBvc+3YQ5t6S0TLtkiDuHSmtdeu6i4o
         FlID+mwtYfkbw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com
Cc:     quic_arajkuma@quicinc.com, quic_sjaganat@quicinc.com,
        quic_poovendh@quicinc.com, quic_srichara@quicinc.com,
        quic_anusha@quicinc.com, quic_kathirav@quicinc.com
Subject: Re: (subset) [PATCH V3 0/6] Incremental patches on minimal boot support
Date:   Fri, 19 May 2023 19:01:25 -0700
Message-Id: <168454808161.2842337.17993685425906614863.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 14:10:04 +0530, Devi Priya wrote:
> Patchset V9 of the series: Add minimal boot support for IPQ9574 has been
> merged and is available in linux-next/master.
> V12 being the latest revision posted in the series, the delta between
> revisions V9 and V12 is posted as a separate series as suggested by
> Bjorn to avoid possible confusions.
> 
> This series adds the delta changes between revisions V9 and V12.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions
      commit: 6fb45762691d12d9812c41d20b2f5db1412047ae
[5/6] arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
      commit: 4fc6a939aba4c0aa723b9da8363d262d3d60e57e
[6/6] arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
