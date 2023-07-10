Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291D974CCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGJGLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGJGLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:11:38 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3BFA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:11:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzttY24yqzBHXh5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:11:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688969492; x=1691561493; bh=azaJMEJAgL47SIIml1shBWGLWae
        rskcRy12zpLCLts0=; b=dA5Ro6S2v9dpjMVbyDn97YTVeqaEvSTZRHV9OmE6O4n
        KAFHOMBfDzniX1jwJk5AW4EZLg7SKBt6BTyR+SpYlk5o5E3JqH7P39BbRxaNQz+A
        cwc34INwJWAe/JGHjn7ckj4U9mmLYj5zNNt6vaCvR1R5lCY85Wz/m0VmYOctW3rH
        r3w9qLvD0upxPbkgZ0mDvzLKO9zdbeKGGcbpEpvVZWbI/zcfMRSYIDFXzo73pTo4
        +feEpWcj9YyyRkpqSAVYFMESlzMF6Wym1wcUJjrTto/LQTErBGNXIr1EdLkSf7pg
        vk0yps3mK1SL0Lp3q8vW4t+z7ArM3+B7/YQC88si3LQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7i5rJhvPfX03 for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 14:11:32 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzttX52cdzBHXgl;
        Mon, 10 Jul 2023 14:11:32 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 14:11:32 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
In-Reply-To: <20230710055219.53210-1-xujianghui@cdjrlc.com>
References: <20230710055219.53210-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2fb128f812c7bf59d7af52193e307cdc@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignments in if condition are less readable and error-prone.  Fixes
also checkpatch warning:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busnv04.c | 0
  1 file changed, 0 insertions(+), 0 deletions(-)
  mode change 100755 => 100644 
drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busnv04.c

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busnv04.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busnv04.c
old mode 100755
new mode 100644
