Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB96ADB04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCGJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCGJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:53:14 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC776729F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:53:07 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id d12so8418099uak.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KQIAhdlXww65eUhy0j2w15z+KgD81bSw/EYAnBg8cI=;
        b=GqIUUxkGszWnMyOJ9v/BsV0SLfdciSErtv2GTbk1+4kZkly8MVF9kX6UN6NjIVjb32
         HKoSqSqoaG/6JON51LwZn+0Q0RhUULLXfVGKSoXK7kbasF/aigKMDSoXh/l9ADVNG9g3
         Vv3UPAnqRbJrkXBZry3fPmnF+a0p7piAnFTnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KQIAhdlXww65eUhy0j2w15z+KgD81bSw/EYAnBg8cI=;
        b=a8y4PYGPnko6Vu3xqkhkdBprPkN7QdQ4Eld5aBnL6H1rj7QJw98P5RQTRpmbvOYHdr
         P8ZkAjI/6APuaGSI9XR0Iqc7llGkadlDQA2mQRQthMYQKwJqVImmD9h0WOXLhKN++5Aw
         Ca/ro9ipMI36dfD1vthS+DC/MLKxd2DAuCQBkAXEQzqk9CkPPeqOplg6lQc4vKi85drO
         aJOoBu1i74zVqkziFGHW6pwef9m7vE1PBEGSXFrHMpH+C5FvXx7gjKNJtXCIheMdli/m
         qO2IxX74XlOev0oXqtvbh0CPvuZRrRquPlrR94BXVpvl1JCVaIQiVj689i3F8VhFt1QG
         w44w==
X-Gm-Message-State: AO0yUKUJMi3QFnnEFSwrp378rdc9kzZ2OTZc00v1n8p0v4bahvnQfxQJ
        lsul06Bi0nS6/7BAFlgV2ul81OanyhjJUXZTrglIrA==
X-Google-Smtp-Source: AK7set/+w8N6bIxRsr/VdjA+rzkO3mjOWFu0972MmNK+MtYl7ZKujQy20Hpt6L+Qt7IMdIula/6V0iHxgFoTKB6NZYQ=
X-Received: by 2002:ab0:544e:0:b0:68a:5c52:7f2b with SMTP id
 o14-20020ab0544e000000b0068a5c527f2bmr8829170uaa.1.1678182786803; Tue, 07 Mar
 2023 01:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-11-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:52:55 +0800
Message-ID: <CAGXv+5G=fm_R8yqkFGXN0999uZVTjSRW-gyM+1FCA+=TmZFt7w@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] drm/panfrost: Add new compatible for Mali on the
 MT8183 SoC
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The "mediatek,mt8183-mali" compatible uses platform data that calls for
> getting (and managing) two regulators ("mali" and "sram") but devfreq
> does not support this usecase, resulting in DVFS not working.
>
> Since a lot of MediaTek SoCs need to set the voltages for the GPU SRAM
> regulator in a specific relation to the GPU VCORE regulator, a MediaTek
> SoC specific driver was introduced to automatically satisfy, through
> coupling, these constraints: this means that there is at all no need to
> manage both regulators in panfrost but to otherwise just manage the main
> "mali" (-> gpu vcore) regulator instead.
>
> Keeping in mind that we cannot break the ABI, the most sensible route
> (avoiding hacks and uselessly overcomplicated code) to get a MT8183
> node with one power supply was to add a new "mediatek,mt8183b-mali"
> compatible, which effectively deprecates the former.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
