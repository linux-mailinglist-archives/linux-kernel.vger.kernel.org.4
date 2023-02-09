Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596368FEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBIEbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjBIEb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348CA402E1;
        Wed,  8 Feb 2023 20:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F754B82002;
        Thu,  9 Feb 2023 04:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97888C433D2;
        Thu,  9 Feb 2023 04:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916508;
        bh=J2pwcrOU5aKD30zaMWcMe9iY9z520fJZOWw7Oobw98Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RNcx6pPZ2pz4X0ZAqka3feiq7I0BeFnIg3uvVj/iLN7uZ8MY56/jO/z5XT7ULzGLT
         E0G4atCNIMMmybnjKkXi9gzwaEocWZTsmZ3dI7DZwM1YqLziXFKuQG4rmkOeh0L6ug
         9JqH/iQ2TNEBuE2fzarfzoqQMH03CceEU4szBvl6WPxBYz1qdKqmoZAAg6aw9XZ7W0
         1/vFzsNlwQ+rL7IhCf7tuTKDFoYiF4X+kozDHo86E0AWzbbBljiT2He5xpR0xCoP86
         8Og4k9u4Kogoy/wzjwRl0J9wlrSx3vDT25SSktUB0JmJY8eE5HBGCHwnLAoa1J32AV
         0966gyLpCHPiQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] clk: qcom: cpu-8996: add missing cputype include
Date:   Wed,  8 Feb 2023 20:23:04 -0800
Message-Id: <167591660367.1230100.14464372831689638829.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123201812.1230039-1-krzysztof.kozlowski@linaro.org>
References: <20230123201812.1230039-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 21:18:10 +0100, Krzysztof Kozlowski wrote:
> Include asm/cputype.h to fix ARMv7 compile test error:
> 
>   drivers/clk/qcom/clk-cpu-8996.c: In function ‘qcom_cpu_clk_msm8996_acd_init’:
>   drivers/clk/qcom/clk-cpu-8996.c:468:16: error: implicit declaration of function ‘read_cpuid_mpidr’ [-Werror=implicit-function-declaration]
> 
> 

Applied, thanks!

[1/3] clk: qcom: cpu-8996: add missing cputype include
      commit: 5930196eec0d5dc454db6418d82dcfb094c93373
[2/3] clk: qcom: gcc-qcs404: fix duplicated num_parents
      (no commit info)
[3/3] clk: qcom: rpmh: fix double RPMH_IPA_CLK assignment
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
