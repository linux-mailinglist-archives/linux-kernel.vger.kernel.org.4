Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5146A19A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBXKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBXKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:09:56 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDE658EB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:08:40 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id f13so16664417vsg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erxkKaNmgReQjjCE5Nun08H4QtCCa/ZqQiqJBxoU1Ok=;
        b=X8+SA9pfi1u8C/Wv6YyefYb/yeJjqHbKIaAaHzXq4HKxYUUHaNYaVsO9Vq3GWF2tMG
         30+rCnyWewJtcmlDac+TEe742tubnvXwDpwXdgRGEgAw10FYMe6HKyIg+TGOK7rLHBJf
         6x0CvO35P9Ej3Q+x2erGFEjEPgDOiIYwiFkdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erxkKaNmgReQjjCE5Nun08H4QtCCa/ZqQiqJBxoU1Ok=;
        b=BJ/VU4x5NzdH6RTzyo4aK50GOAhcp+dBt8Ei2mf9MGpGbCJpNb7Tw74Vg1WuOgYMmV
         a8H+TOsKSXrXfuGW/lYjz26lNgUZk20KTfoKgEP9kE8W74kLVrgn3lL0OGs9qrkdMpDI
         h7VXAmy4u6bt4vWFUcxCxtAOdYjCSuCnwtSaItqjbz0FJdBTNzm9y88mjmGPpjKT7n+j
         /SOey4jVNXmRId5Bn9k9ypm272OUWxcAooptKLGjYWH8KE7BRJ8DlMRqlIJTFT/lNFuW
         lsGOat17zerpki5sQMey3VP9blp0XPBM7/IhNGtVSr0dDm732Y47LyVavKICRQ3pGg6c
         N4jw==
X-Gm-Message-State: AO0yUKWdpiWh7EC15VP0KJ4WERc0/vL0ks3WfqzA2UhtJj6A6K9HmCse
        TldBA43AfGzFKdL8+FfVFSbl12G64sKeze2pmm5e4A==
X-Google-Smtp-Source: AK7set/1xvdm5pq0EgFdZuGlRUZGFwjjdxewTbrvfcb4P2N6x5bfqAjJm08NFJELbq4Kj0E1OC3BOpwdByH/f1V0aw4=
X-Received: by 2002:a1f:4343:0:b0:400:ea69:7082 with SMTP id
 q64-20020a1f4343000000b00400ea697082mr2084061vka.0.1677233319375; Fri, 24 Feb
 2023 02:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:08:28 +0800
Message-ID: <CAGXv+5Gk-G=TTSu8E7v8EHMfrp4j0mwFR32hi3_urPJ3sDxpDg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: gpu: mali-bifrost: Allow up to 5
 power domains for MT8192
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MediaTek MT8192 (and similar) needs five power domains for the
> Mali GPU and no sram-supply: change the binding to allow so.
>
> Fixes: 5d82e74a97c2 ("dt-bindings: Add compatible for Mali Valhall (JM)")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
