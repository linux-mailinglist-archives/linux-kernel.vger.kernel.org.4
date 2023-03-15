Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53926BC169
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCOXfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjCOXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5CA729D;
        Wed, 15 Mar 2023 16:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43CFA61EAE;
        Wed, 15 Mar 2023 23:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E565C4339B;
        Wed, 15 Mar 2023 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923156;
        bh=uxTO2R08zyYk1/nh2PzCyZRbSLTUXrTM2nJSh6o2AKQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pN8fORl4MySZCrVX539bJwg8nllBHqs+4AuKRzRFzZMWDh0dGakIdWSWPyAtYrL0C
         nKT03hiJa1GerOR/kFvPsC+MhmJ8ePtuCsyYMqa21hbkmosCgH7NfKQ5Om3HvduSJX
         33Lhv3YYDzPieNXEf8WpFgS2kOggbtt+eydapVw/U5q95qcLtgIuREQQr0FKMXrd4U
         dgBCXfxiih82OTx9In/Lkl4bnvPKxDzotabtmu/hoB/AEB6iAFRAiQExSJ3OgRMt8M
         ivhQ279ZErDh+SHhVToakgF0QzBXNPRvXri372MChhXzuO3Vp4EKGJ1afQWOedwyMN
         uPE6+KOnqQOjg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] soc: qcom: gsbi: mark OF related data as maybe unused
Date:   Wed, 15 Mar 2023 16:35:08 -0700
Message-Id: <167892332562.4030021.17200416968495112528.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
References: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 10 Mar 2023 22:44:13 +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/soc/qcom/qcom_gsbi.c:117:34: error: ‘tcsr_dt_match’ defined but not used [-Werror=unused-const-variable=]
> 
> 

Applied, thanks!

[1/1] soc: qcom: gsbi: mark OF related data as maybe unused
      commit: 903caf42eabec2e39d836cb0aa8bbc23717408e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
