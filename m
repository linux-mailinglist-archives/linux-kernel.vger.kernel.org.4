Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50D674C96
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjATFha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjATFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE45B5B7;
        Thu, 19 Jan 2023 21:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB378B8206B;
        Thu, 19 Jan 2023 04:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC7C433F2;
        Thu, 19 Jan 2023 04:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674104042;
        bh=9B8AESEnaiyyvG9bBTaaDPwbKe9TAiv/vyN8K/61H08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLcujfbpKxYaAmL0gAhh6QQUl6Va+0xU6t7jkMJg6U2amU27lcnYghTUv13FV6m9G
         Ic4FGg5JjSZpJugbWHNULmZ1Gb+1oyhwRkg3RMaM5yIRbYQFaLGfx0PENCLenMrSC+
         AwFweHYWMywbEWU0PawPwjKf33YJpGm3ktPZQJSLBPI7yITnFwVAvlhnV83YveO71N
         UKhVzyK2/peUu4ApOQZQM04bfTGG8blSYtiH0kFCV2xzmliHmtD2yogOhtVs3c4zsM
         Q7z4vea+17LlDUYmLCyTHW+CUlhMVw7gwjPsb+0ILAw5kT9ZJZ5wHX3dDx3I2RfEUI
         UE2oTS+kLyQww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] Revert "soc: qcom: rpmpd: Add SM4250 support"
Date:   Wed, 18 Jan 2023 22:53:57 -0600
Message-Id: <167410403676.3048186.9960546404192439260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
References: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
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

On Fri, 13 Jan 2023 16:22:31 +0100, Konrad Dybcio wrote:
> SM4250 and SM6115 use a shared device tree and the RPMPDs are
> identical. There's no need for a separate entry, so remove it.
> 
> This reverts commit 5b617b1b10c1c6a4365d8f956032e95c53b8e388.
> 
> 

Applied, thanks!

[1/2] Revert "soc: qcom: rpmpd: Add SM4250 support"
      commit: a36489778ba8f7eb98c3e9fca2d300090bf1ffcd
[2/2] Revert "dt-bindings: power: rpmpd: Add SM4250 support"
      commit: dfe5ac7023624617d402ca1c295552fbd271e20c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
