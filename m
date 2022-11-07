Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9711961E91A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKGDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKGDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129A10549;
        Sun,  6 Nov 2022 19:12:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FC27B80D7C;
        Mon,  7 Nov 2022 03:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F3C433C1;
        Mon,  7 Nov 2022 03:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790771;
        bh=6lrQKUqM298XVGBM7THXqZcqeym2M8+q+3KjUjaSB/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpokX/ngw5X7XWAVgbCKvki0z/4i8+36mIswI9FVVlveeQk26wmpZGSHqfs1x8PY3
         bdiqLvg/S8L2yDk/qNKetIhKJlJSsCDZ6XRiEd4bpy7n6xyQfMP7BtqLw6Wgbms6O1
         89+wNqOHTQgJWWKu6iMRjjPJ6RWR9SMAyoTCeMZWVvcewNNVP1lvRxWskbEPLqPsai
         7jtQF7B7dn4qPWoiLj6I6iB32qUWQkkc3eKCHjT5jAurizjVR0qY5DrWf0tuPcaDAY
         rEL5jTz+Eh2ETo3MtYq/73LgSWaxVl8tDGm5G/4TsFzckx/b3psG5TduC6AKCn05bd
         /u2Nv8XBHV9+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, konrad.dybcio@somainline.org
Cc:     pashadubrova@gmail.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        martin.botka@somainline.org, Andy Gross <agross@kernel.org>,
        jami.kettunen@somainline.org
Subject: Re: [PATCH] clk: qcom: dispcc-sm6350: Add CLK_OPS_PARENT_ENABLE to pixel&byte src
Date:   Sun,  6 Nov 2022 21:12:08 -0600
Message-Id: <166779074257.500303.7313241594081608053.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010155546.73884-1-konrad.dybcio@somainline.org>
References: <20221010155546.73884-1-konrad.dybcio@somainline.org>
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

On Mon, 10 Oct 2022 17:55:46 +0200, Konrad Dybcio wrote:
> Add the CLK_OPS_PARENT_ENABLE flag to pixel and byte clk srcs to
> ensure set_rate can succeed.
> 
> 

Applied, thanks!

[1/1] clk: qcom: dispcc-sm6350: Add CLK_OPS_PARENT_ENABLE to pixel&byte src
      commit: 92039e8c080c63748f8e133e7cfad33a75daefb6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
