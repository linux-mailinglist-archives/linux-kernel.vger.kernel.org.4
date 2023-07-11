Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8574EC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGKLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKLZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26F11D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384A06145F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0153FC433C7;
        Tue, 11 Jul 2023 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689074728;
        bh=xuuHCFiGencqlt/jeI+QVDlzvHHuWL4jp2TrresZywY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kPuXQOuClxu5R4yTiHCYZoQxGLkKT/g1Gg9kiM4wWNU5YQcBX1rHSrZoC1RIJ/24E
         4QLtC+5XQczoL7EW2s2gyQ/uZVBLNqj0/lPRnif/7Ydbaegb29Tj1NSOvDKT+LwhLV
         H3WdP6C9X0JZQkZ1OZm7tP6fvba5hCZbI3Dz0y1AloPO++q7Q9DyJ39YGmHc+j9Tvg
         eG/gW9x9pT40ko9oKjpiCyBBhHBOVpJMJPLsDWNUKLqRFi3O+WsszJhlI36WdCo8Kj
         Prbr6y9msImXGgr/sv17Mj8m177dMoPwZw2FQndrJDPjMMb2uXp/I7sE5YwV+1NS2b
         s7KDXEazoMabA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Wierzbicki <mawierzb@cisco.com>
Cc:     xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
In-Reply-To: <20230522172415.1668975-1-mawierzb@cisco.com>
References: <20230522172415.1668975-1-mawierzb@cisco.com>
Subject: Re: [PATCH v3] phy: cadence: Sierra: Add single link SGMII
 register configuration
Message-Id: <168907472460.198426.11430720798374263873.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 16:55:24 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 17:24:13 +0000, Marcin Wierzbicki wrote:
> Add single link SGMII register configuration for no SSC for
> cdns,sierra-phy-t0 compatibility string.
> The configuration is based on Sierra Programmer's Guide and
> validated in Cisco CrayAR SoC.
> 
> 

Applied, thanks!

[1/1] phy: cadence: Sierra: Add single link SGMII register configuration
      commit: 3e2744cf994493135491633e43cec8d453c71e1f

Best regards,
-- 
~Vinod


