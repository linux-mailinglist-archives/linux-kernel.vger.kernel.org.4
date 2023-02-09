Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4968FF53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBIEfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBIEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D94DE13;
        Wed,  8 Feb 2023 20:32:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A5AD6188C;
        Thu,  9 Feb 2023 04:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6D5C4339C;
        Thu,  9 Feb 2023 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916498;
        bh=1YP27iiprCubd1EXcNa/psOqvMoP0fjUFoWdzqvlI+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVxKA9MrIdGcJsiLCF1Zbb0bbcBTJ7Z0bJ+fHGKesnLw3cz7gy7G12OE6ZfJ69mWV
         +rieaQMB9NFDVyjunLgkheS5weCmhwcpqCYkIuphKp5FHslnI/MgpDocyUJt1R8H/O
         pRmwxfJTaAflD4DyYI+3nO3SJI8SWjwCvQPPOquORRlEiv8EcSmwjaR002oL4AxKfN
         7BaIY6nvs1I/eN8/3Q76pVOnVMfgivrELU3uFqBxtoJJhtH1REyRyLP8b9p9vRhdB8
         GCQVBHmO7QsBftwGV5E2GJldiyH+dDfDyGA0GennZ+/vmEu1BW11OSeVNJ29i8yzkH
         DsNB52UdvQ82w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/7] clk: qcom: msm8996: add APCS clock driver
Date:   Wed,  8 Feb 2023 20:22:54 -0800
Message-Id: <167591660365.1230100.12792933034952529675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
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

On Fri, 27 Jan 2023 01:03:12 +0200, Dmitry Baryshkov wrote:
> The sys_apcs_aux clock can be used by CPU and CBF clock drivers to drive
> those clocks from GPLL0 while doing initial setup. Add simple driver to
> setup and export this clock.
> 
> Changes since v4:
> - Expand comments in the apcs-msm8996 driver describing the delay and
>   the reason for setting up the sys_apcs_aux clock as a fixed rate
>   rather than a fixed factor clock.
> 
> [...]

Applied, thanks!

[7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
      commit: 027726365906fc863265635e545d063a45807fe8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
