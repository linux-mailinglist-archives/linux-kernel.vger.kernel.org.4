Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271B620613
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiKHB3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKHB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1B92D75F;
        Mon,  7 Nov 2022 17:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4344B81714;
        Tue,  8 Nov 2022 01:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB1C4315F;
        Tue,  8 Nov 2022 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870893;
        bh=hrb63pEYbTDbYcY9kx5aX3xHqe/fPdpBXlyne0tZ7Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRILw4E6jO8Fk9PnVLbOxoYaeLkV2YY6ppxt56ZOXYsvR8XmtaZ4ruEhILvHvf65x
         kIjK7kBZt3UFmeFfASFJD6g1XPOUoyGXaEPPTFLH8GXQChQTX1kEdARAp6HyfXvlwb
         E0fdE2T2Wynp7rvY4mafTpAb4YL3Cz3Gt4a0XZdVbpKcKStVz8/x8AWjI754Iuh/mn
         2NFMc2uOAENd7jaPuvA/PH1p4uwqSZDi3uzYf8VHh74d8DEQFZKbgfIGaukP1xg4Fw
         wtocHYieGqXXQIE9/Th2wDfVG2ATSnHDtR7Z7QtJf82rzxV9UAW+YBI65n+3VPegpe
         /O65PK/mt7WWQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     swboyd@chromium.org, agross@kernel.org
Cc:     dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Remove fingerprint node from herobrine-r1
Date:   Mon,  7 Nov 2022 19:27:42 -0600
Message-Id: <166787084678.599230.17638706199431069085.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221025180703.1806234-1-swboyd@chromium.org>
References: <20221025180703.1806234-1-swboyd@chromium.org>
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

On Tue, 25 Oct 2022 11:07:03 -0700, Stephen Boyd wrote:
> It turns out that only a few people have the fingerprint sensor hooked
> up on their board. Leaving this enabled is slowing down boot for
> everyone else because the driver slowly fails to probe while trying to
> communicate with a sensor that isn't there. Remove the node to speed up
> boot, developers with the board can manually enable it themselves.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Remove fingerprint node from herobrine-r1
      commit: a35ef6df1e61cba41a5266303f6a493d1a71b06b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
