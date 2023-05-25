Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8301971045D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbjEYEwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEYEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F29E48;
        Wed, 24 May 2023 21:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E52860E95;
        Thu, 25 May 2023 04:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8113C433A0;
        Thu, 25 May 2023 04:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990271;
        bh=yPWlr1m88yvGKTplxsZSrI4PBlREyoZqPFjMnXi5y1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiIdflatCgeMagOVFfXVZm1kQlwcvETvg8bqgQf9xtcNNKZ0Vwd3SbKdA+zlKYSqy
         Ip2wbqzvsQMFtAMCAI7KMc5ju3W5LDBjKGRJoKkLDGQpZN76vqTz2UxZJ2koTTgZob
         rCVyev2tXb1MjpBHfy3r2YvqTkigBPyD7iX2VJLt19fiLlcxR6mlz6KBCeDnAIYIv+
         okibPhINWFwQ4NJ2aD6gLnVIKxXy0+5EqNF+De8dqSiWkUtTjsnzCJP9O0YXBYuqhJ
         utGQpAV/GIPYO+yjKSKGsV/F123C+WAINgLlAAsjVxjhSZci2xt69x/AbY6kYfdQnB
         QBlJJ7yjV3HnA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: (subset) [PATCH 0/2] Fix SM8550 LLCC
Date:   Wed, 24 May 2023 21:53:51 -0700
Message-Id: <168499048186.3998961.4435358713846464435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
References: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 04:18:48 +0200, Konrad Dybcio wrote:
> LLCC was recently untangled as far as register regions go [1], but
> SM8550 was omitted. Fix it.
> 
> [1] https://lore.kernel.org/all/20230314080443.64635-1-manivannan.sadhasivam@linaro.org/
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8550: Use the correct LLCC register scheme
      commit: 661a4f089317c877aecd598fb70cd46510cc8d29

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
