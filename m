Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5E6A197F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBXKFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjBXKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:04:37 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EF6530C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:37 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id o6so21026314vsq.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TOM+IbwtBAiPFvq6ycNMUw45nB2aH2u3BMzF8LfulTo=;
        b=lJjz2Ig4+Qs0/rc6HicYYxTiXTrw3KU0aEtlIWog/dkOb8669avk/G9Gc4z2yCrPEl
         UoSJKuPWV6wmTncogJPoVR1Libzx7QPM8JhpBQbdMWNV0msZeWG4uvYtb/X+GnIDdPXR
         xm22++ecslEfdQwZpn9qB5YEVo0hakXaU17uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOM+IbwtBAiPFvq6ycNMUw45nB2aH2u3BMzF8LfulTo=;
        b=h1g+NhFVIm5y4WTJeNVTqBMrKfC20CvgzUXgPXGBC1uXk1bYt+u1PQC8CTrYmTT9IX
         rPQzE3tFTUTidfnBg+VgDg3bfx2ILTyvWsA7kWxrThOTbqjmIMzXlmwNWK8E1JyOytCA
         4za7HIih66AaukFR8GERoCVaBo39f9ARBybqdGlc9KwUcyGeOf9/Lb892vMX7CZNzydE
         v16WSNDWw7pQKDYYeMdqi5Oaw5wDHL6ASul3QAxvy2LHMqNLCzx+D21kly/2cD5f6Frq
         iIb849jnw1AQ6TLuXIb7VI3AOFJIbHu+91djwAErFgIh2uxHl1dMU3Qlpu47gAuH6j3G
         1htA==
X-Gm-Message-State: AO0yUKUG1qYbDOgjQnZ4d/u6hn6Nr8uS1EL7OoJixDbHDOR43nifU7hl
        QrsUeLBxMFP9jAL9FF+7tC7XO5omgnQACgKNaiEMAw==
X-Google-Smtp-Source: AK7set/SYPCxVBflpRQGKecsjnyfDdkoGF7kargtYFZ6pSE/pnkb0nj2hS8BJcPINJZtdPjnTGck5LQCaDsEStN/Zvs=
X-Received: by 2002:ab0:1014:0:b0:68b:90f4:1d8c with SMTP id
 f20-20020ab01014000000b0068b90f41d8cmr4235195uab.1.1677233015332; Fri, 24 Feb
 2023 02:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-12-angelogioacchino.delregno@collabora.com> <4e0673e7-5685-ad1b-2fac-4ae544caefeb@arm.com>
In-Reply-To: <4e0673e7-5685-ad1b-2fac-4ae544caefeb@arm.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:03:24 +0800
Message-ID: <CAGXv+5E68nV_Lj-fE5aTqBryUwMu+JJ0N=EZEzjLTXp+980MEQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] drm/panfrost: Add support for Mali on the MT8186 SoC
To:     Steven Price <steven.price@arm.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alyssa.rosenzweig@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:46 PM Steven Price <steven.price@arm.com> wrote:
>
> On 23/02/2023 13:34, AngeloGioacchino Del Regno wrote:
> > MediaTek MT8186 has a Mali-G52 MC2 2EE (Bifrost): add a new compatible
> > and platform data using the same supplies list as "mt8183_b" (only one
> > regulator), and a new pm_domains list with only two power domains.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
