Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE51566E6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAQTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjAQTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B495AB79;
        Tue, 17 Jan 2023 10:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B327B61505;
        Tue, 17 Jan 2023 18:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A818C43398;
        Tue, 17 Jan 2023 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979874;
        bh=MG/2VzB/JupsGKOFEWe7C7NhpQJfFvIuqo0Zg7tFH50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GM1fSE2xmZCpPm8t/lSsVzrqAKmvT+AtrvfZaF/0L1M8uLYuURLSBjw9OOW45eJmC
         QcfsrzHoW8JEDhvVhGQ1i1laBjNz2qBxGOrubePp6RkTR4wCc62mzyFr4yDcbGN/SD
         4Tklz1BD8fqDGNWhj2WeCHGnMKw+X6jSz+ENJCjo7/jsEJ8I9CtNhyesdv8e37fBVG
         qWXUCJOPAFbu8WBZC19mx43R0NC8f1jdC/8q2hiFXe09MCevtAu4IYxT5lX7uUk45N
         LlJMi5x5tjOysLLWcYvHbfsRr18jzyneVMkscB3URI9cYcSfiUhsCV/dpGijCOEyY5
         jq645UYs4edyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org
Cc:     devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Add debug related nodes
Date:   Tue, 17 Jan 2023 12:24:19 -0600
Message-Id: <167397986262.2832389.8271907046439369343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230116164032.551223-1-bhupesh.sharma@linaro.org>
References: <20230116164032.551223-1-bhupesh.sharma@linaro.org>
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

On Mon, 16 Jan 2023 22:10:32 +0530, Bhupesh Sharma wrote:
> Add dtsi nodes related to coresight debug units such
> as cti, etm, etr, funnel(s), replicator(s), etc. for
> Qualcomm sm6115 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add debug related nodes
      commit: bbcb07d299b5c1b5d996bb571a290a153c19e7e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
