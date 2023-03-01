Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2B6A672C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCAEyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCAEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:54:45 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAC38014
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:54:42 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id l24so2842921uac.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvFH86Wx5RN3SI+RWTx88o9Hq2BKwJTQQWbayEx0CcM=;
        b=eLmZKh8w5eKPslfPj682pp6AqDMDr3kDWb9MF5eICVLXGgESSxa3BZT8UIJn33hSU8
         hgv1OYwD5V4o7SJjoloP4rm82+v9A4iC0QneD6l2cthy6ASnHBFg1fsePr0DnDVpvadv
         AX5goEfzIeCbD+vcU+mmaTqr+EnlRGKiw/NRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvFH86Wx5RN3SI+RWTx88o9Hq2BKwJTQQWbayEx0CcM=;
        b=f6xEA4IQm+10N2SKBvTkBdzCLEIY0KgoWslokowOdeZKIFXrTp7AI7RvDvQe079oAM
         HYzFfZxpmrm29ryQlaPbMKi7Qiba8l66JNGTcI8x8+82kt59VQIGgh6uiBESutUvUd08
         UgnnW2vVpgZx0Wea7JX1VDiHmdOYuxYw4O2SSL67O+WlGj+NSXz3/zrcMNJjMEEIskh+
         BU7+TFEmemXeMrLYBvO03an0L1Das6yQct5NWG6kT1faY9qOcxMiWViNfL9hWIsZMBoD
         0GLgiiKsKMUoDbNDpZnDPmHdxKs1rLjex0FYXJlxpyuL4dHsLvilJflF5NnivPEdOjEO
         VfJA==
X-Gm-Message-State: AO0yUKVcc3q4BS91ThjjqKsVDiJetgVqiUrpBWpkzX4sUa/ea4BtInXF
        D3Gh1LJuboTslqMDG/G6iIJf/pZfZUWEJf/JDlcgWg==
X-Google-Smtp-Source: AK7set/N+eInI6S/VIF++zybR+zm/0n4DGjWC3U76j9ITkp75HBt6PzFpjINHEpOMYtqRAIzBvtKqvk/lZ4UssMcvxc=
X-Received: by 2002:ab0:4a97:0:b0:68d:6360:77b with SMTP id
 s23-20020ab04a97000000b0068d6360077bmr3021515uae.1.1677646481168; Tue, 28 Feb
 2023 20:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-19-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:54:30 +0800
Message-ID: <CAGXv+5GYc1X0J7tXfqQ0yj5rCFgEcTN5kwB4720vCkNvEKgiOg@mail.gmail.com>
Subject: Re: [PATCH v3 18/18] arm64: dts: mediatek: mt8183-evb: Override
 vgpu/vsram_gpu constraints
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Override the PMIC-default voltage constraints for VGPU and VSRAM_GPU
> with the platform specific vmin/vmax for the highest possible SoC
> binning.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Suggested-by: Chen-Yu Tsai <wenst@chromium.org>

Chen-Yu Tsai <wenst@chromium.org>
