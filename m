Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6B6833A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjAaRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjAaRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:19:11 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989B582A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:18:27 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bj22so4323738oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NoU1EXovLnFLevH5+dru1O1RM5oa8IccUfESnUe7Q8=;
        b=MpgLmRdf4UpdmRw6C1M2N73PBlyKKVVdoyrSaCTLUHwPkUxnfQ7vzoggNfm4nM3JYu
         5BM4MJfgOpsD/5EZ552iW/0xenZduj7kNYpREOM3WqBc7fs1rPN5OHg5/giLGl1rTPwt
         e/xNy0KxeTn6fzIaD6/WIfcCm7gD2A4bGV4g8FyfEXtGvLsyD4Y3aeee48Ui15U1q7id
         dbtaLzRgGpbqMjfKwqzsmn9YFEHW3iEh1OHrBa6iJAbQyJvaZWuUWA3NRVPej3A64vgm
         mkJUuln7McItNBp5jJqmwOEL9Rw3aXT5fSGauhpyG4mRQZpWVayDv8dFnhEGBhVXHbgm
         5nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NoU1EXovLnFLevH5+dru1O1RM5oa8IccUfESnUe7Q8=;
        b=5B6BXxjfmcyQlaL4T5eNhGlRpeUKO8j0GrsPbD54ax5Irf8fuL5ualMzAKYV2UpAUX
         W5I/zt2iGXlzYvMc7v17ggg/JSj0LTpgEE7IaXecyLYbt91tGXl7pat2GYppThNfTwLu
         59XFCRTV5S4BWNXJ8PJerUn7wZBkfIiAPg14/g5Jp191WH+THdE+3xPgOxpPGhdgAN9K
         NTyP0CEauhhOhML+lOpZ6/lByB0RKSlSAgQXoghsT1546ag9ue+tA0bIieab2yuUgstj
         /e5DjHWmyXZPQYLdktrEQ0n9pO9wto3OiMkBwk5bpKbzJ8yWe6dvpmkyczg9egL/X997
         CWHg==
X-Gm-Message-State: AFqh2kq4pTuJ4VMSI0cya7FWOsDo2LbUtDMeSiw0mM4AjPe9LJKUEa4a
        2tarcrJAQWPKx7zufA/6zEtfXsEQjV39U06ZgHE=
X-Google-Smtp-Source: AMrXdXtq9ETxjTpquXp6xMOCFLNGsDfdhQgYEHycqqdimQWIi+k0o73I+TMPM6JUs6ufmAIcvMZj4jdA3+gNyB/Lewo=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr3059225oib.96.1675185505458; Tue, 31
 Jan 2023 09:18:25 -0800 (PST)
MIME-Version: 1.0
References: <202301280939083976293@zte.com.cn>
In-Reply-To: <202301280939083976293@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Jan 2023 12:18:14 -0500
Message-ID: <CADnq5_NhqLdLxvFXjNgD1oLz-yzf_ozqoM4HjxRVzMZPJCaFDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: remove duplicate include header in files
To:     ye.xingchen@zte.com.cn
Cc:     alexander.deucher@amd.com, haoping.liu@amd.com, ian.chen@amd.com,
        dingchen.zhang@amd.com, sunpeng.li@amd.com, xinhui.pan@amd.com,
        rodrigo.siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, wenjing.liu@amd.com,
        dri-devel@lists.freedesktop.org, george.shen@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 27, 2023 at 8:39 PM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> opp.h is included more than once.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 6475664baa8a..1a2ab934b4bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -46,7 +46,6 @@
>  #include "dpcd_defs.h"
>  #include "dmcu.h"
>  #include "dsc.h"
> -#include "opp.h"
>  #include "hw/clk_mgr.h"
>  #include "dce/dmub_psr.h"
>  #include "dmub/dmub_srv.h"
> --
> 2.25.1
