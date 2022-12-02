Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC3640FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiLBU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiLBU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D754EAB62;
        Fri,  2 Dec 2022 12:59:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D13B8229E;
        Fri,  2 Dec 2022 20:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70ABC433C1;
        Fri,  2 Dec 2022 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014737;
        bh=XG3DnqKJ72OdCbdN7xm7CR0ApNJIXeff3/1N+uhznVg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X5B0N6MHPK0e9njQTGR9/kc7WSX76CHqD7XV+V2BMbIY/yFVfTWxSLjcwbXES7dcl
         9HU70v5hCR68DfDgqtVx2kccN3Z6KbrY2sfDk0eL/Ns+iU5Md5qjurQb6VDEwO27of
         odUxyv8U/wVosYhmyQ9XyonqysBiCPF5F/2uE/vynnaLi9Gm6Re+JPO7161DYz8fSR
         VbJGGAzCIQoVSzHKZIzvJcjoVG3xSslVcnLmCfjkSWjsya0jHxkQRH7zEdNKD/C/Xk
         YLAWaROGc+Eqi0EIHdor5vaqcEs0hxKDVszv/sc0JyPUEx1MjlkAtPcuRi7MAqIJGZ
         dwOLpHEC94GNg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: krait-cc: use devm variant for clk notifier register
Date:   Fri,  2 Dec 2022 14:58:43 -0600
Message-Id: <167001472423.2721945.5427672478145031647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108215827.30475-1-ansuelsmth@gmail.com>
References: <20221108215827.30475-1-ansuelsmth@gmail.com>
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

On Tue, 8 Nov 2022 22:58:27 +0100, Christian Marangi wrote:
> Use devm variant for clk notifier register and correctly handle free
> resource on driver remove.
> 
> 

Applied, thanks!

[1/1] clk: qcom: krait-cc: use devm variant for clk notifier register
      commit: 3198106a99e73dbc4c02bd5128cec0997c73af82

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
