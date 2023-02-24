Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18F6A1966
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBXKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBXKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:11 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A2168AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:02:35 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id s1so4363962vsk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ+c56zWKAB6KkNwyl4wfURLw4xEI4TvXfEXVR7fScM=;
        b=mBf0fYdRBib48fcz8dVMkxRqv5dmT7j+KcKi6TQXWv47/sBOnplVjUA/KJlyaJhQ/u
         MUR8SPGjgkC8cTh1fdFKb3e7FHSM8YWB+6bJw3n9E66VgUJL5kFFtsaamzBOoG2BENuh
         trKPvAePy3rIQUhrjjvPeTuEOOm0WiZHCi6nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQ+c56zWKAB6KkNwyl4wfURLw4xEI4TvXfEXVR7fScM=;
        b=5sF9O56kQuS1qV0A/HakcXoC1Z37u2DgqzKF14vw07AWKmpdpRYo28yq0wCmNlC/+K
         /Fy/DB5kEngneAwo4hNjlLGT0EhUBQZyTxdaQovl4pm+0AG8Kk7H23F/VYKK7i6nUIbs
         EPqBipNzYoOxKVnd5F/xvSaT/IIZoOrcQ1UU0uaWfUNYRInBvPD63Fa9MN/r/xGpxXB2
         cMscsJaH61mTTIG+MFsW+vqY5q4ZRABPRMufeu/d8nsUcfLTmI58JBiZIiv+ZcgWZ8Ro
         46tr3NLbHzvlOXfK1eDwps949uLUjU8oEzKWxD1SnGk0i6MQTuMfxHW2ZkEd5dp4Mg3H
         SQ5g==
X-Gm-Message-State: AO0yUKV/D14qCH4Qn399gJZ25Z5ja0tlDpE7LJ8KS62RlDxafeUbZmFg
        +RSTBvEC4pclwUTsfTsfoaYURe/MgWuiAChLcAJkNg==
X-Google-Smtp-Source: AK7set9tS5Vg40qoFVl+YV3ZHnpGsg0FDitUcAkWfOL/lB0uJsb2dhWG1E7jYLg/T5T3JyAWuVyzhJYudWUCfyfHK1U=
X-Received: by 2002:a05:6102:31a9:b0:415:48dd:e0b9 with SMTP id
 d9-20020a05610231a900b0041548dde0b9mr2020384vsh.3.1677232953844; Fri, 24 Feb
 2023 02:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-16-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:02:22 +0800
Message-ID: <CAGXv+5ES6MnmL0dhumwamHDVhcbeJ10UEO=98-SnWgWzzyHBCg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] arm64: dts: mediatek: mt8195-cherry: Enable
 Mali-G57 GPU
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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
> Enable the Mali-G57 found on this platform with the open-source
> Panfrost driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
