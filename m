Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682366D7CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjDEMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbjDEMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453C1BC1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE567621B8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DB1C433EF;
        Wed,  5 Apr 2023 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680698676;
        bh=T8/RXs3yXPQqX3RzNRz5sLD+ny4FJMMc6afxAEiRi/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFzZBYmREyn4y0ESQunHejKqMvoQMlsw06ozZIOFVnz5KvqR6Skl48sqrYQpuWw9S
         Qh6xB5E4tvl/pF+rkIUyCXXzLVR8M+IBld+loZ0OeaTyhWsS1TPg0MLtRj2wXmux1w
         /DGrm1o3qk8FBJIxd049FG1JY1XwTaY3CoqWVf46HPlQaxfNJ/+TBOHmVyembtLuY9
         C8DaMfhJuqrs3zj233ztYg7+fs7gfkpr0QB5zHM1tsmzAe+ygxSt71E8wWpwl1JpBQ
         WmpesN6ddje/7NmstnlqaIGwWLYWq5IERGHdLu6oeam+6BRF4rBKHLCtsCM722v3C0
         70BC962BNxCwA==
From:   rfoss@kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Use constant sleep time for polling hpd
Date:   Wed,  5 Apr 2023 14:44:29 +0200
Message-Id: <168069863327.3876648.15304782439765709083.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331030204.1179524-1-treapking@chromium.org>
References: <20230331030204.1179524-1-treapking@chromium.org>
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

On Fri, 31 Mar 2023 11:02:04 +0800, Pin-yen Lin wrote:
> The default hpd_wait_us in panel_edp.c is 2 seconds. This makes the
> sleep time in the polling of _ps8640_wait_hpd_asserted become 200ms.
> Change it to a constant 20ms to speed up the function.
> 
> 

Applied, thanks!

[1/1] drm/bridge: ps8640: Use constant sleep time for polling hpd
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=4224011374d1



Rob

