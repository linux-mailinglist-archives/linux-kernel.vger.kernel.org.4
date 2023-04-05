Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA956D77B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjDEJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDEJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81BE10F1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F02B622C0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982EFC433EF;
        Wed,  5 Apr 2023 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680685514;
        bh=6UOsNk0X2EylcfvdlpsXSdVi0P2RDTf/zQlUU+hIU30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCQM04hnhxN9QaN2hNVsod74aSBvna4szC05s51/Aejemx6VZiBunQLX3Z+xh8YHL
         skzl4/2sPMH915F88Xk+LFyrcmJg4JV5b9tyHOkuhdSg0qVVeKHpkJRnJaZeugE7hq
         N197X7UteLj7qwbC9AZPiQ+iJDUpbjdr1j2+fLcmea5Lm8fSqVaxGrfbYbOhnhn+fX
         4crzQQMQxyNXfErVI3MCkKqA7dsBDYq+k9FgvXAnVnqf6qKkT1PsXoVj6SmrlVHd6r
         WRtLvWNHy6XS9mXgLmc0raCJ+gK/jMkm/qyRl3zgm0m8EyI114FMt23785MgTuGpNz
         IU81/H82SKcxg==
From:   rfoss@kernel.org
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     Robert Foss <rfoss@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/2] drm: bridge: ldb: add missing \n in dev_warn() string
Date:   Wed,  5 Apr 2023 11:05:07 +0200
Message-Id: <168068549313.3820417.2469721913539804296.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405081058.2347130-1-luca.ceresoli@bootlin.com>
References: <20230405081058.2347130-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Wed, 5 Apr 2023 10:10:56 +0200, Luca Ceresoli wrote:
> dev_warn() and similar require a training \n.
> 
> 

Applied, thanks!

[1/2] drm: bridge: ldb: add missing \n in dev_warn() string
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8cc0b604f234
[2/2] drm: bridge: ldb: add support for using channel 1 only
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e09220f42b5c



Rob

