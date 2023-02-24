Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E66A193F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBXJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjBXJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:57:51 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E31FEE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:57:49 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id o32so3126170vsv.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To6ovkWvUPMLveAkla67N038E57W+HtJ9fEs6w0SxJo=;
        b=SCZXVvyqkuR2VF2+kZIdjTTTHiFTGYGmp4ANFKViYdqRj5iVvG4/ZBVzH4sxmZMvnQ
         AGJ/gul372LQ1l/JDlyjIkCONrXUDAg4JUlRLoNJURUfV56u6Am3R3ofagziCYJHM+c5
         pQIKWE77vIGMyhTyXI9R02itEdeLBsak2mA44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To6ovkWvUPMLveAkla67N038E57W+HtJ9fEs6w0SxJo=;
        b=sXk2JJyJuq6RaPN/lGYrI9XnxfrhsTH2e3q2a/FJOJ5i9vOh3+RnmWeyWwb5m6gpvD
         gOlUmsSILseOuCkB2aE1wouuZspBlAJcdONn0tJFT7Ok5DKDIKxFDlyVbYlvfs1IAh19
         3Y6DPTZXKxTbuhXUTCWbyZaD+nYkDKl95dKjttTZ/O6fhHa/8OBIIA/m8iDUJRBq/F9G
         W0Xo3QlcDbhJgaNeufrgmGqP1DJQVpCNWJR5WdZ0Y3aWmiyTn74FifiN4WUP4cRoGLVu
         E6Z0C37NdfkYRRaH3NQ9VdRFKwYvEGW2wVs9f5hOz09AiI12hY0RSbtsXirPyw6f5ocs
         Cmwg==
X-Gm-Message-State: AO0yUKVIOIGCMn8AI3JpTOKGnjYTEwiSZIlBlLyQiwqAECrkxeTZR2hf
        JavN4sJrzoBfIp5MX5xgB6fGuwau7VaZENjsHwgkIw==
X-Google-Smtp-Source: AK7set++hj8wJ55xIDhOBwZ0CgnOb6HCyOt28ij7RVUkakGaWXLPL0MmWhf+iYu9V4dbycYGUVr7Jzh3WvhhVcAhGVU=
X-Received: by 2002:ab0:5550:0:b0:68a:a9d:13f5 with SMTP id
 u16-20020ab05550000000b0068a0a9d13f5mr4692696uaa.1.1677232668304; Fri, 24 Feb
 2023 01:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:57:37 +0800
Message-ID: <CAGXv+5EtbMtDTwXvOqGBSNXPF4z88F-Hr0M5=PW+JeV4i_YYng@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] arm64: dts: mediatek: mt8192-asurada: Add MFG0
 domain supply
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> The mfg0 power domain encompasses the whole GPU and its surrounding
> glue logic. This power domain has a separate power rail.
>
> Add its power supply for Asurada.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> [wenst@chromium.org: fix subject prefix and add commit message]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> [Angelo: Reordered commits to address DVFS stability issues]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
