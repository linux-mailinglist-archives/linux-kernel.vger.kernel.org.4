Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE66AD621
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCGERY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCGERJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC015848E;
        Mon,  6 Mar 2023 20:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764B5611E0;
        Tue,  7 Mar 2023 04:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA1EC4339B;
        Tue,  7 Mar 2023 04:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162627;
        bh=rVDg4VUi5i15dQeV5hompTlC6GGFjSfeadyd59og5v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r168Y8njiYTpw/+PDhkKZybAscG2OzjrFnLkuOD0wFgolMB0y2er5OnW95k4l/rEn
         SbBTxadmg06sGgUnAddxjiecX6lCX9l9ni7Fwm9u+fC9QO0uAd45VW/Fb/jMfgqYNs
         TYyEmfmrOJFe6mEtQDJTbwEV2APCkSHf7K0iXP8UsalWAfNuNkFdKt3q9TPQwPAcoN
         xNYLpMh7QhJ7C1BHlnj5g4j7q94pHy2rrQkxcaDXKCHNywUtrDPT7+MX2/x35X1ddn
         aOJo1J3Db3NYFaVpYvz2j37PZHbnbSOql3utNdoLGVmr9cdQD687YAPR97Q44qT9z3
         E2hUf7XQiAU5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
        Loic Poulain <loic.poulain@linaro.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Fix qcom,vmid handling in rmtfs_mem
Date:   Mon,  6 Mar 2023 20:20:31 -0800
Message-Id: <167816282864.1458033.13136297821113812493.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
References: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
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

On Sun, 05 Mar 2023 11:32:32 +0100, Luca Weiss wrote:
> The commit e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to
> more VMs") which landed for v6.3-rc1 caused some issues on platforms
> such as msm8974. Fix both the error handling and behavior when qcom,vmid
> property is missing.
> 
> Please include this (or another fix) in 6.3 still.
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: rmtfs: fix error handling reading qcom,vmid
      commit: 947007419b60d5e06aa54b0f411c123db7f45a44
[2/2] soc: qcom: rmtfs: handle optional qcom,vmid correctly
      commit: 749d56bd5cf311dd9b50cfc092d7a39309454077

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
