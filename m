Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF82074CAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGJEFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:05:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F89E0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:05:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qzr546Tz5zBHXgg
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:05:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688961928; x=1691553929; bh=cnZBI7U3lIITIHLY98l50CsDLls
        BGTgz6H9cvCDkx8k=; b=c333Y7tB+/CYcqDWpKGZq730C/9R5EHPvIXWYnKRVbJ
        kbN4Yt2a3aX3YDATizXoQNjt/+TuofRb7c4hRAPxC+RUw2TkVSZecbxfr8r9qQ4u
        cs0F0E204GxvOe92444aX9xsJQF49oKU0e4TSfbsgCAdliD3+o233vvLM/InsIvI
        DKI/lnWLdD0pYfNsV70QOxWLD2ano/eJJ9jzT4Q+EkMMl8UPJRCfUy7hACw64vqX
        XXC2k/KR72M23mhOvxrVf6uQjgJCkV/IPG+b0cNE/BHpKHydNEKJubvFiK8CVYh2
        m3TJyzM0eChqFUEN/eKPMeKxLTugyWj48zMnpCpW6xQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pkObRt-5Mk0p for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 12:05:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qzr544Zs8zBHXgf;
        Mon, 10 Jul 2023 12:05:28 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 12:05:28 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
In-Reply-To: <20230710040334.53045-1-xujianghui@cdjrlc.com>
References: <20230710040334.53045-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2c2765a57b940f56af70cd7f5af03817@208suo.com>
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
  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.c | 0
  1 file changed, 0 insertions(+), 0 deletions(-)
  mode change 100755 => 100644 
drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.c

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.c
old mode 100755
new mode 100644
