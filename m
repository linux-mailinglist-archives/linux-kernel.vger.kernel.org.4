Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D474CB89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGJFEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGJFET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867CD1;
        Sun,  9 Jul 2023 22:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F9460DE2;
        Mon, 10 Jul 2023 05:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD6C433CC;
        Mon, 10 Jul 2023 05:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965458;
        bh=FkwM28Uw00htPDY0f68P1yi5hqii377p8l5uGcXnqCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUYzbbI11uHV8FAM1EtqXFmQVoKzx0XW6D4sVFmVWHGxBeicyKkSfHDnE4DIE4pbk
         m8XHPZxNG4JiZj9Oe5zg1Pd6qA7t8O8s0wa6C1CjK6KDBB0XIrE+e+fyXmCyuxYAk6
         g6duUueTNjTJIqX0jj2b21RvXRHk60/DRH5jFlm5zN5OixD1bY3qaOBrvcJBPgLkhB
         SRXHBZjl/BLaaNW9D4YVuoy9Pj/KoJMYIwg2nfgIn/p504zP3DoB2gKExq++DU9b8r
         szqe4vMvh0LsSfmyqTJCQDBy+YT8MtbNO2Yy60fzq3MKw+WnqWutctWQQai0nogTyl
         FbeLNQGXswADA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, davidwronek@gmail.com,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sm7150: Add CLK_OPS_PARENT_ENABLE to sdcc2 rcg
Date:   Sun,  9 Jul 2023 22:07:01 -0700
Message-ID: <168896565985.1376307.6069729452916590160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630191944.20282-1-danila@jiaxyga.com>
References: <20230630191944.20282-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Jun 2023 22:19:44 +0300, Danila Tikhonov wrote:
> Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm7150: Add CLK_OPS_PARENT_ENABLE to sdcc2 rcg
      commit: ff19022b9112d6bbd7c117c83e944cb21b438e91

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
