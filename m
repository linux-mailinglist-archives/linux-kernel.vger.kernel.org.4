Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EFB74CC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGJFJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjGJFIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4F273E;
        Sun,  9 Jul 2023 22:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8328460E15;
        Mon, 10 Jul 2023 05:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF9C433CC;
        Mon, 10 Jul 2023 05:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965497;
        bh=ml1LSHyojLz2JBk3IY0Usxxos+JwtW8hWEoiEyom2wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST8O1PoGeL3NF2ukVRZBOfxkhMc/paqzQz4/jy9l5MpkhJ5VyS8TkPE8IUN1dnqaU
         oVUclAlzBSLUoEGII8UpNZrlER+QQAOjBcCkF1DzLseppeTaYTqH35NhCHhs1r2e8D
         x9HOSPqxzeVJqNqIsBG1WiKs4/v0XTeQVScSyB+Z+ZdDrvqiw1AnNPpID0JGr8PRkg
         PzFKIyLpzGFVt4Y/gjKsxomyVTGMRFTtIb0+1sg8dpjBmjWa8fC2a+zKoomW76jyiD
         j48ze37ZOxe1c6XS5BNdaAtlJvnwe40TKHyzpICAqzd7y9gVTTD7rU6LixRtz/M2n8
         I1XEgLUxu0/zA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
Date:   Sun,  9 Jul 2023 22:07:36 -0700
Message-ID: <168896565940.1376307.16512891292048089013.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230506-msm8226-oxilicx-v2-1-f7e4ebff3d61@z3ntu.xyz>
References: <20230506-msm8226-oxilicx-v2-1-f7e4ebff3d61@z3ntu.xyz>
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


On Mon, 29 May 2023 10:34:40 +0200, Luca Weiss wrote:
> On msm8226 we also have OXILICX_GDSC but we need a slighly different
> config, with a .cxcs defined for clock but with no parent.
> 
> 

Applied, thanks!

[1/1] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
      commit: e21e74c6e251152dfc45efdf2279db2778d51223

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
