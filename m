Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC272EF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjFMW1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFMW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31C19B5;
        Tue, 13 Jun 2023 15:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F6463624;
        Tue, 13 Jun 2023 22:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C039AC433C0;
        Tue, 13 Jun 2023 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695236;
        bh=FS0pagPihyDU6Qd5xHnqniuGzViZ3pLvHeQMey9fEeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdIBRrqa8W1OcsdwgY3TsJBYAAJiNcG8dlML+lRJ5C9Y6SPAuxG9Qjkx42XSSJCJb
         w3DN4zwZ2SdNXbLLPEUiaLF+2yIHGKjzLXg9FD28HsiQ+UXbbTtUGtVVWyB5WR8ldv
         LY4RX7WQYaRAACORgD0y6hd6+8csTyj59oC3Zi0DKpV2RSF+iYtJ4g/iqGjpTYypDj
         SNhaf+5aKIJ4mbUG4+jzCLB2P2NQ2ADZURczGxm4O0cOrjAFFppORNfeX3iFGqJS8v
         uSsjFxNC5wteH9AKeu5vL0US78vSmoVH1gBcYJPuAIfswFLi49fNoWplbQVT0fxBAH
         Yoo2zPk/hlAfA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix MSM8998 count unit
Date:   Tue, 13 Jun 2023 15:30:14 -0700
Message-Id: <168669542895.1315701.431621222486027478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531-topic-msm8998-bwmon-v1-1-454f9d550ee5@linaro.org>
References: <20230531-topic-msm8998-bwmon-v1-1-454f9d550ee5@linaro.org>
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

On Wed, 31 May 2023 18:33:03 +0200, Konrad Dybcio wrote:
> MSM8998's BWMON counts in megabytes. Fix it.
> 
> 

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: Fix MSM8998 count unit
      commit: 1c8267cd14ed6a592a2c2a8eb0fefad4eabe5b4f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
