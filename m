Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78118681FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjA3Xqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjA3XqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:46:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202602BF23;
        Mon, 30 Jan 2023 15:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D476130B;
        Mon, 30 Jan 2023 23:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDCC433D2;
        Mon, 30 Jan 2023 23:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122373;
        bh=6CiSYBjoesluD+/5chzBuwYHxxi09E0qRpjcMY/XoCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKE9BsNvuE0GjpcOpEqbs2SyYxQi1MMnfclArHK8SuekqZCwPhhlqiCUjLHfCTvjq
         XzDHm58hq/RAgAKvgEEBBGJp+PiyN3ZeDkxZZH1y0R4bnQl6sYplp652vJ3LIjr7GG
         tw1k8Dsjz+Duovs+JDCQDLsrKP0G97wFQHCU3y5J8jDCy+ua5Tanpqb4S12IVR6xrp
         17E3pDef13AHn+wPlxSix+NQQ/2ub52+srs5JeZ1qE6aIeCphIzIz4KFQtasM9w+2V
         Uydo0gU6hSEtPyswuMAjgpTAjeydNIbUWXHdtNy/p6sRSTo/whRn1GUakxBlx1ej+r
         aSZWQXjgSUPCA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        konrad.dybcio@linaro.org, mturquette@baylibre.com, arnd@kernel.org,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: fix duplicate initializer warning
Date:   Mon, 30 Jan 2023 17:46:09 -0600
Message-Id: <167512236603.4092892.5518902407835115318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230130135555.3268172-1-arnd@kernel.org>
References: <20230130135555.3268172-1-arnd@kernel.org>
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

On Mon, 30 Jan 2023 14:55:47 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In one of the clocks, a redundant initialization for .num_parents
> got left behind by a recent patch:
> 
> drivers/clk/qcom/gcc-qcs404.c:63:32: error: initialized field overwritten [-Werror=override-init]
>    63 |                 .num_parents = 1,
>       |                                ^
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-qcs404: fix duplicate initializer warning
      commit: d4cb3e7113f82f7378527890aa7b4006234665fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
