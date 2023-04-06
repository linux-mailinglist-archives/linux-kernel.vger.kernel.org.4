Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B76D905D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjDFHUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjDFHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:20:51 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E46EA8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:20:49 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id h15so33681797vsh.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680765648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQZnNfr+rBhTTZliY5pXLRCg5E7GawaSZx7bLaXCUWA=;
        b=gr03IPWw8xCzO8z1s3XXV8rA2qkRF5MmfLt98sAud2m8xi8lHXgs60q7bNsxZL2Smi
         gl4QsqQiSVY1Y6QC4MOOGJUcCUc+Bl7XzvwW6pKcVW+WPYG9F2fhIvv+IuZYXlwMTX+s
         jfF8gl0U1RG9xhEe0cfOB6cNyJ2Q4H65kuKiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680765648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQZnNfr+rBhTTZliY5pXLRCg5E7GawaSZx7bLaXCUWA=;
        b=BFkoMgZugOl2p2WqDEy6XydM72v9j9SKtRPLHqfkKpKK2pTGe75g7cm9PZvNHj6MFc
         Znam6i/icJOYhiLdM1SucFpSPX8RZkQkKOonV3ZcnTahHq9MeYic/Qdt4rt4OjTH9TmB
         Usjm/12IJzUuGs//FwmAkz9EZZ1OH3C2dqOcyyYY8QOatSKiE6CTzoHXD3U6jjxmu7DC
         FuNTrGU9yi0X/Fz5NoPJunqRV3cjwkm/UDpuY0I0FvTP9tgV+h1T+Gxeo9Y/F3CGLcgF
         GwIdlWl+kTlFSdItd+3tOqr5wioEKFxIXfpEY5l3SEmzIlC9O8Zyd4tpeSlKl0xzm2nj
         uWSQ==
X-Gm-Message-State: AAQBX9f29dIahaVEJ0SVD1qB9/oby2yG6GhFZHg/MI7MUGTlH9BOGI/3
        tA3CcoffgnkxPUXUVAsxXE35NodWVlMcP9MTT6bdLA==
X-Google-Smtp-Source: AKy350ZKHVlhoBhxEN/6Xhz9wuYrGUS4GAEp7DN3aTjD5fTNIAiVKilFb0mDuij13QyIaSLsC3aOGmsypz86GhOovyQ=
X-Received: by 2002:a67:c01c:0:b0:425:cf00:e332 with SMTP id
 v28-20020a67c01c000000b00425cf00e332mr6176192vsi.7.1680765648481; Thu, 06 Apr
 2023 00:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 6 Apr 2023 15:20:37 +0800
Message-ID: <CAGXv+5FEEkMg+SY7ZkSHN2G9jtT6TBiN9MadZmYGMX_uVi5=gQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] MediaTek DisplayPort: support eDP and aux-bus
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v3:
>  - Added DPTX AUX block initialization before trying to communicate
>    to stop relying on the bootloader keeping it initialized before
>    booting Linux.
>  - Fixed commit description for patch [09/09] and removed commented
>    out code (that slipped from dev phase.. sorry!).
>
> This series adds "real" support for eDP in the mtk-dp DisplayPort driver.
>
> Explaining the "real":
> Before this change, the DisplayPort driver did support eDP to some
> extent, but it was treating it entirely like a regular DP interface
> which is partially fine, after all, embedded DisplayPort *is* actually
> DisplayPort, but there might be some differences to account for... and
> this is for both small performance improvements and, more importantly,
> for correct functionality in some systems.
>
> Functionality first:
>
> One of the common differences found in various boards implementing eDP
> and machines using an eDP panel is that many times the HPD line is not
> connected. This *must* be accounted for: at startup, this specific IP
> will raise a HPD interrupt (which should maybe be ignored... as it does
> not appear to be a "real" event...) that will make the eDP panel to be
> detected and to actually work but, after a suspend-resume cycle, there
> will be no HPD interrupt (as there's no HPD line in my case!) producing
> a functionality issue - specifically, the DP Link Training fails because
> the panel doesn't get powered up, then it stays black and won't work
> until rebooting the machine (or removing and reinserting the module I
> think, but I haven't tried that).
>
> Now for.. both:
> eDP panels are *e*DP because they are *not* removable (in the sense that
> you can't unplug the cable without disassembling the machine, in which
> case, the machine shall be powered down..!): this (correct) assumption
> makes us able to solve some issues and to also gain a little performance
> during PM operations.
>
> What was done here is:
>  - Caching the EDID if the panel is eDP: we're always going to read the
>    same data everytime, so we can just cache that (as it's small enough)
>    shortening PM resume times for the eDP driver instance;
>  - Always return connector_status_connected if it's eDP: non-removable
>    means connector_status_disconnected can't happen during runtime...
>    this also saves us some time and even power, as we won't have to
>    perform yet another power cycle of the HW;
>  - Added aux-bus support!
>    This makes us able to rely on panel autodetection from the EDID,
>    avoiding to add more and more panel timings to panel-edp and, even
>    better, allowing to use one panel node in devicetrees for multiple
>    variants of the same machine since, at that point, it's not important
>    to "preventively know" what panel we have (eh, it's autodetected...!).
>
> This was tested on a MT8195 Cherry Tomato Chromebook (panel-edp on aux-bu=
s)
>
>
> P.S.: For your own testing commodity, here's a reference devicetree:
> &edp_tx {
>         status =3D "okay";
>
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&edptx_pins_default>;
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>                 port@0 {
>                         reg =3D <0>;
>                         edp_in: endpoint {
>                                 remote-endpoint =3D <&dp_intf0_out>;
>                         };
>                 };
>
>                 port@1 {
>                         reg =3D <1>;
>                         edp_out: endpoint {
>                                 data-lanes =3D <0 1 2 3>;
>                                 remote-endpoint =3D <&panel_in>;
>                         };
>                 };
>         };
>
>         aux-bus {
>                 panel: panel {
>                         compatible =3D "edp-panel";
>                         power-supply =3D <&pp3300_disp_x>;
>                         backlight =3D <&backlight_lcd0>;
>                         port {
>                                 panel_in: endpoint {
>                                         remote-endpoint =3D <&edp_out>;
>                                 };
>                         };
>                 };
>         };
> };
>
> AngeloGioacchino Del Regno (9):
>   drm/mediatek: dp: Cache EDID for eDP panel
>   drm/mediatek: dp: Move AUX and panel poweron/off sequence to function
>   drm/mediatek: dp: Always return connected status for eDP in .detect()
>   drm/mediatek: dp: Always set cable_plugged_in at resume for eDP panel
>   drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()
>   drm/mediatek: dp: Enable event interrupt only when bridge attached
>   drm/mediatek: dp: Use devm variant of drm_bridge_add()
>   drm/mediatek: dp: Move AUX_P0 setting to
>     mtk_dp_initialize_aux_settings()
>   drm/mediatek: dp: Add support for embedded DisplayPort aux-bus

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8195 Tomato: eDP panel works if the display panel regulator is always
on. External DP works.

Maybe it has something to do with the driver not supporting .wait_hpd_asser=
ted
and not using a GPIO for HPD?
