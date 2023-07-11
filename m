Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3123E74EC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjGKLZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjGKLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F8121
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 507856148D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7C2C433C9;
        Tue, 11 Jul 2023 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689074735;
        bh=P5JUmCuHjYtgHblM6krp4O3Esprol8uH6xKGMilXXJ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JY5m9IjR8gK6cYqUtfmTgjqNt46Ws0PYVxphS2pIIUvTmH6sMr4VvCj5MKViRJ9go
         /7q0oq8LkobGWKv7vd2ymQpkeeQ5cuVoZfznCLs4kEVKRPMFF2ShT1a6dFaz9fUKrc
         KQ6rJDKW7kk6JwOTMdF1GpGnAf4zeDGeS5+H9qv48Pg4G/2mTGaxJDa+mgl1bpRbRH
         5x5Venh7SWNYKflIPZbeL32DJJJKN4N0ZuPBus6idYdAuOU3Hv4cinbZBDo6Tcdrdt
         j63I1Iv4FhSy8RXlHhiTVPfHU6lGIZkDX4FIjS3Eo/y+IkIFGDqmdetmj7kxf51b3x
         iQgD6MLqA2R7A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Wierzbicki <mawierzb@cisco.com>
Cc:     xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
In-Reply-To: <20230626105533.2999966-1-mawierzb@cisco.com>
References: <20230626105533.2999966-1-mawierzb@cisco.com>
Subject: Re: [PATCH v4] phy: cadence: Sierra: Add single link SGMII
 register configuration
Message-Id: <168907473193.198426.16749805293094708083.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 16:55:31 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2023 10:55:32 +0000, Marcin Wierzbicki wrote:
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


