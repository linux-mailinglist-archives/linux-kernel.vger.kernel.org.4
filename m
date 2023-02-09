Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33B68FEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBIEaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:29:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC53D913;
        Wed,  8 Feb 2023 20:29:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57C0CB82013;
        Thu,  9 Feb 2023 04:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895EDC4339E;
        Thu,  9 Feb 2023 04:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916526;
        bh=s36LJV6q5eY40doox73LAXq/1qN+GYdeRjFvZAR7V5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ls9pcoVQCJRPbzBPLHSvg8qag1aRdciGhVfGwt3m7IbJCdwDidFKE0WZY/eL9II11
         3L+pobq/UJXEjB3gP8k2Y7yl/BmOfiiaoyZgyNueIiGCEjW//alMNF2tqxiudV9CKP
         Wyk9QfdYTjWrXUrfzF8n559/6Jvo7c8foERDglN3j+xErOTrBAbj8s9gyVI5muAvR+
         3TMfVhqBatpGrWZpXbMfxLMt5XU49s5Y+QZ2xA98wwpaFncMwQTrHcRjSubAyQnQx4
         JfFzx1Sqq4rqox5MAR7BFJ1hSDIt2kU4Xveaezgefk+daNjeSRWIOKZyKE2QAanfW/
         ooMbZ9SIxEi7g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable SM8450 DISPCC clock driver
Date:   Wed,  8 Feb 2023 20:23:22 -0800
Message-Id: <167591660368.1230100.12272344095100280610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127-topic-sm8450-upstream-defconfig-v1-1-93cf603db08b@linaro.org>
References: <20230127-topic-sm8450-upstream-defconfig-v1-1-93cf603db08b@linaro.org>
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

On Fri, 27 Jan 2023 17:34:33 +0100, Neil Armstrong wrote:
> Build the Qualcomm SM8450 Display Clock Controller driver as a module
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable SM8450 DISPCC clock driver
      commit: bbf814c98f09dc0efd06156d93c97726f3d90d2e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
