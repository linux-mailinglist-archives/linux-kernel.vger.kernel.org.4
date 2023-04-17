Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F76E50D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjDQT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDQT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:26:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56C6A63;
        Mon, 17 Apr 2023 12:26:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j12so17527751oij.3;
        Mon, 17 Apr 2023 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681759581; x=1684351581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgR9yWNpXpcXRujoJTOWZN4Ac0PmAsb3IYAK2OBiNYA=;
        b=A8POwEXBtxt+z9gTMk5vE9Iw0O2L50tlrIpIBNPihPRGY7iBhlfQHgpQV6cMdIguFV
         Zc7g/Mr6qy2w/TL+uwD/XDpQIRYhH/ZwzlmUvA+j3NNU8FdP4OWsfnhrwwrL2pykM1bV
         qEkfNp/kQFga0y8gsJYNwNPF5gOJRRBDyCQLoK9+GJLxNd8YZOVCUMBLxXMyYZjP63XF
         /7n09KvbS0laZg1caprKHGE6Mm2+/UgcR4wfeTHxPXGqi0BAHGl64bQKA7VFgpIAYYa7
         sBR5CsJrsBSSTKsK7OtL04IfWLFtkNo53bRHTAotAV7mhQtYwR9SOj+KjFuJum5Pha8g
         jW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759581; x=1684351581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgR9yWNpXpcXRujoJTOWZN4Ac0PmAsb3IYAK2OBiNYA=;
        b=bO4njCABvp8SM908V6GHC3KPYWfLnBeXBhlKV9ynql+2Hz9m56sE3qsq+CH+SMbQRL
         Mzkv+0b3WwjOOQ49lqWBnzGIUJintqXMrtMU1pBWdLVx5Rral2MwIE/F7glCqM+H8T1s
         +n+WUzUDB7qxXv1tR6jh6xwccU0maNB1Hwp4dfREqQNL8QFqF1PbWJ+NKpuMmCqIeCu5
         LuLnyWz0F4eHKTNd+BQv9V0owsFBDGMYzyMmJ8295umvDP9x3LAhS8SDw1ApI9ObIZGO
         eML5v9yKgKvPNBcsSC6gswBdZia2hVmokfdLM3GiB/+V8JHRVw7S6Dl1Drlv9yaRsUwo
         WvTw==
X-Gm-Message-State: AAQBX9cWHGuW5THqcrMxdoXxQmzKq43EQ/xMfrAA/+ioLYYAiyOQ8o71
        4T94wmP/zTMcE2OOOLzawh/GZBL2oeNc3mucFJU=
X-Google-Smtp-Source: AKy350Z22GK6kLG6tHEeqc6xa37gCtz2jfI4yCVpFEw8uzuKlFwUL0hIMP6R+pDki+ZmMO2BdQwHr9XWxrdFNQRgufI=
X-Received: by 2002:aca:f0c2:0:b0:38d:c10a:e7b6 with SMTP id
 o185-20020acaf0c2000000b0038dc10ae7b6mr13624oih.3.1681759579651; Mon, 17 Apr
 2023 12:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230417174237.52638-1-colin.i.king@gmail.com>
In-Reply-To: <20230417174237.52638-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Apr 2023 15:26:08 -0400
Message-ID: <CADnq5_MCRciy+zvVmJ0_HeAsYV-g9cMjNoyezhtZP77erFrGsw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix spelling mistake "aquire" -> "acquire"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Apr 17, 2023 at 1:42=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in the smu_i2c_bus_access prototype. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/hwmgr.h
> index 5ce433e2c16a..f1580a26a850 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -359,7 +359,7 @@ struct pp_hwmgr_func {
>         int (*set_ppfeature_status)(struct pp_hwmgr *hwmgr, uint64_t ppfe=
ature_masks);
>         int (*set_mp1_state)(struct pp_hwmgr *hwmgr, enum pp_mp1_state mp=
1_state);
>         int (*asic_reset)(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MOD=
E mode);
> -       int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
> +       int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool acquire);
>         int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate st=
ate);
>         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
>         int (*disable_power_features_for_compute_performance)(struct pp_h=
wmgr *hwmgr,
> --
> 2.30.2
>
