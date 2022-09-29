Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51885EFB32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiI2Qpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiI2Qpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802B2124F;
        Thu, 29 Sep 2022 09:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EB261EE1;
        Thu, 29 Sep 2022 16:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446FC4347C;
        Thu, 29 Sep 2022 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469937;
        bh=qlqv1CfJrDbLQw6ClmshqwnAljjYeAx/NAaIi7qI+ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMb4T/ezkhjrKXVFgNcIHOe+DoJeL8pG5WdrbZdR5vLtpUSgU5OrIErOXGvFWwKCI
         oIsU1uvLQIgRd16C4AzTx8IVViaqrwUcbtVMyjVnAoZgmsdYvNTbtPG+LdF0eDUX0m
         sPPgddkUJjcK8xwPH0+912dHoAx1DqUzyatRIpPHE0mlfd4FEnJ3Ss2MpWuJHideTd
         QYDn+sSYMjoFq85POT5FoDTDgUyk/6Ad6b7XZfyQ1qptzoRRppGFS5n4heZrjRPTM6
         y274uq5Vn1W8U+LCNjFuuv1lyQZ5vWsHI4df3uvEDmEvRwgsxXv1TzvCDcLANWj+Aj
         +jLFYOfVQk9BQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        quic_rjendra@quicinc.com, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: gcc-sc8280xp: use retention for USB power domains
Date:   Thu, 29 Sep 2022 11:45:32 -0500
Message-Id: <166446992872.1979534.2157531379392547494.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929161124.18138-1-johan+linaro@kernel.org>
References: <20220929161124.18138-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 18:11:24 +0200, Johan Hovold wrote:
> Since commit d399723950c4 ("clk: qcom: gdsc: Fix the handling of
> PWRSTS_RET support) retention mode can be used on sc8280xp to maintain
> state during suspend instead of leaving the domain always on.
> 
> This is needed to eventually allow the parent CX domain to be powered
> down during suspend.
> 
> [...]

Applied, thanks!

[1/1] clk: gcc-sc8280xp: use retention for USB power domains
      commit: 27da533af9b050e751a419c743096d06017daf0e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
