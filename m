Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C560F18F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiJ0Hw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiJ0Hwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:52:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6450AC09A4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:52:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 959BF66028B1;
        Thu, 27 Oct 2022 08:52:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666857170;
        bh=2ckvdLsZ8CotfrVFln8EXVlUdBz1dfcyRH8Dif/TH+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oYfBE5VlCAbNeG49FfqtEoqVJ/EPBcfsNFVyUtSE1McxVfgN2l5iel173ERd0TOTC
         GB+/79+Q1UJ9jb5EOAHEWcp8ok/Pp/NOxxLtkVNJ2frHhOA2U4L2GKGar57VRLsnwi
         8VrR+iXOiyBfsT7ak9dQpfcftvzGiibLAWo5/ex7hL4XcSQLzkDw1DXHE1Ju4SLkko
         dVhkKCp2osgH14MRsJEN+vGlz29pMF/X+pjC5RjRRr6kB0FgDQzd/0HI/U3QaEHVel
         JfduYRQiGkkSo6P0JJKNXwWII5P3eYOkfLmUp3d/D0HGxDWZrfcAagXEC85R7CJDlw
         +acdQwINniOPw==
Message-ID: <8e727fd0-cfa6-1b1f-e000-bd3ccd9e34d8@collabora.com>
Date:   Thu, 27 Oct 2022 09:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/bridge: it6505: Fix return value check for
 pm_runtime_get_sync
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221027032149.2739912-1-treapking@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221027032149.2739912-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/10/22 05:21, Pin-yen Lin ha scritto:
> `pm_runtime_get_sync` may return 1 on success. Fix the `if` statement
> here to make the code less confusing, even though additional calls to
> `it6505_poweron` doesn't break anything when it's already powered.
> 
> This was reported by Dan Carpenter <dan.carpenter@oracle.com> in
> https://lore.kernel.org/all/Y1fMCs6VnxbDcB41@kili/
> 
> Fixes: 10517777d302 ("drm/bridge: it6505: Adapt runtime power management framework")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


