Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95185B7D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIMWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIMWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABE5727C;
        Tue, 13 Sep 2022 15:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A791061633;
        Tue, 13 Sep 2022 22:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C368C433B5;
        Tue, 13 Sep 2022 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109291;
        bh=vwj6rOH8DtgXp8i++JebimgUOwTOTyDedo+ZJufRtLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dyk2w96HEeMtgoAZmOo94rcMbbiMdVSiYeH6kfQDOOJfyAXULEZomjGXaj5SzGZl6
         ucX6j/1/p9zHPfsSU2NVV/0jnuhvJ+N+tdiABL6RTNaeaDnSIBWIuLqL/DUbrT6By4
         FGBVVQNYaPOpbyeFLr674VEGXbNwuunWoN2nDddn0ttEZ6Xez3oMFH7pLvs6LknZYV
         Nyu6YWY9/zJ90paIakkEtHzJ5yr6znCAwelosV1QVaxNewpq8QVlKTkcqDjBZwpEJy
         claptbgSzPPfNQVKossZVjh0lnbbtPf/5HEQaQT2/2YkjulKnDTg5foTF78q+d9JIs
         4mDzHKgaAYf8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     danct12@riseup.net
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        agross@kernel.org, sboyd@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: sm6115: Select QCOM_GDSC
Date:   Tue, 13 Sep 2022 17:48:03 -0500
Message-Id: <166310928494.670084.490990942314599075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220910170207.1592220-1-danct12@riseup.net>
References: <20220910170207.1592220-1-danct12@riseup.net>
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

On Sun, 11 Sep 2022 00:02:07 +0700, Dang Huynh wrote:
> While working on the Fxtec Pro1X device, this error shows up with
> my own minimal configuration:
> 
> gcc-sm6115: probe of 1400000.clock-controller failed with error -38
> 
> The clock driver depends on CONFIG_QCOM_GDSC and after enabling
> that, the driver probes successfully.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: sm6115: Select QCOM_GDSC
      commit: 50ee65dc512b9b5c4de354cf3b4dded34f46c571

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
