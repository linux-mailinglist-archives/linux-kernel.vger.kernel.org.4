Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C37694C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBMQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:15:41 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010D618B19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:15:40 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16debd2786aso5847103fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n00XwKmDj7Zhd185pYuu8ZoQFNENKpBwwusRZRdqFfA=;
        b=B7Ms3LWMXQT1D2m+TZUxvcLgPRJY0e1HjsPk1qEfUWwrMXjM/cBH03F42Oq0GY3t/2
         Vk60mCS+nRAf4XWaUcxxAN7C4dPPE0PTjyfOYz77owMl5uDG7unIFED5/4nGCaPLuxxK
         uhscyN+sbD1jm8ZVmWQyVdlw4wuahoBZrK62Bzx3amZLlPCICeVtV858iR+wSQgOD0WX
         +OrfR4zm02S140bYQM+5sxpuHZezSM/4NwiY4kf9mfUaV7hZr0/NdfXyCMM8cRm3KfGe
         YyF2h/JWt+3nLMifBPDzxGmboHb+Rz1sY4dOsL9EKpjGf1y1rLmaJUWtkPp08ctF70QT
         85Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n00XwKmDj7Zhd185pYuu8ZoQFNENKpBwwusRZRdqFfA=;
        b=wyT5fGB6KtkTN6ptHZ0Yvh4qS1vxuoA3j+2/P3W9ZT8jXzeL0uPcHQ9fpLcHxYZ3E9
         Re8cwW9Bf3XnVhO+uCI9qUPBcYgqz4mD9+1kjIpe0MGecDdnxlcnRO2QNHf5lwn+DRfg
         GW2PriJVqR84HlllJSZNHSU0LdQsWHiY4TpOfHEhUHlHSESEl2ePv9KCxKuTXysG41eC
         Brs+GVc//O+aCQ8jmZo63FQapNhVM2eysOcVmLHpfXx1ZZHIjs1t8UEi3UaVkLAgRZSN
         eyuAHbxLnLvtpx3LEcVWR0UPdds26eExLZxflda1ff1NyGpSa6lks9lsnjc1o4XCcmDS
         vIiQ==
X-Gm-Message-State: AO0yUKXMxbq6LV2FdXOH/VIxehMKzXWd6rWQDlO25WucoIKfFNtgjao9
        qvmqaeop9m1UPXesBGwP+Hd9tpA4Wx6D2x1Y3Nw=
X-Google-Smtp-Source: AK7set9RyIIPHVCELYmiS06jLlThqm2dDvK3fN3R53a2gbk5cyFDMJ6F/3CaMYl3xWodnmdfFNn9dpOMGkBZ55r14gI=
X-Received: by 2002:a05:6870:13d1:b0:163:a303:fe2f with SMTP id
 17-20020a05687013d100b00163a303fe2fmr2647823oat.96.1676304940310; Mon, 13 Feb
 2023 08:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20230210022839.3152-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230210022839.3152-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Feb 2023 11:15:28 -0500
Message-ID: <CADnq5_OaFqucwsJwm5CCQw=R5CpKnnWFDvp_M0=hutEKAbA0Og@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove the unused variable ds_port
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 9, 2023 at 9:28 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable ds_port is not effectively used, so delete it.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabilit=
y.c:280:35: warning: variable =E2=80=98ds_port=E2=80=99 set but not used.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4030
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_dp_capability.c    | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capabi=
lity.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 24d356ebd7a9..816bf4ff8017 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -277,7 +277,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *lin=
k, uint8_t *dpcd_data,
>                 int length)
>  {
>         int retry =3D 0;
> -       union dp_downstream_port_present ds_port =3D { 0 };
>
>         if (!link->dpcd_caps.dpcd_rev.raw) {
>                 do {
> @@ -290,9 +289,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *lin=
k, uint8_t *dpcd_data,
>                 } while (retry++ < 4 && !link->dpcd_caps.dpcd_rev.raw);
>         }
>
> -       ds_port.byte =3D dpcd_data[DP_DOWNSTREAMPORT_PRESENT -
> -                                DP_DPCD_REV];
> -
>         if (link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP_VGA_CONV=
ERTER) {
>                 switch (link->dpcd_caps.branch_dev_id) {
>                 /* 0010FA active dongles (DP-VGA, DP-DLDVI converters) po=
wer down
> --
> 2.20.1.7.g153144c
>
