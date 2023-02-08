Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31FF68E9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBHI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBHI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:28:34 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494EB746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:28:32 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id y8so19113012vsq.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDwdCkBr+epoTFV8128V+K8ZDu4uZiFedibzdz23bSY=;
        b=evtZGJLNjmw9Zm4yLdTXY8KBBja9oIjRep6uxIqQmpn4T0huYcPiv+gjhczlK27ZEA
         1nIgQ8Vx2VTTBD5GZBYzQ+fmXsxYTrUkRNvIZfzFAyzT7rq0Z1c424O2AY3RxD6lM99p
         bHFbQcz6EyNmWuDnfmpIshtHoFIbtyHaoYqO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDwdCkBr+epoTFV8128V+K8ZDu4uZiFedibzdz23bSY=;
        b=76jehe9/mQG96IDqRjXwU6aO3zBKL+UuXQPR87p4L8Dxd9hd6ociPi7z8t9nTL8VgM
         Pl9eqXI9Mg+D42VpIwJc2ZQRBSydxH0yfr5lIQF8nNTWunAF91i/cUx71gKPxszT2pGK
         tCrJU61eQI/NJp2+xmrfAXyPIBBRY1GTsUMVLiYnLbxWTli27Z1dIZJQ8lxMjJL9bskF
         WbjKE77d5HARUfDexHtVAh3Fh9O7oZTI8/Wgw3s4H3+OQUQNy0u4vUnxn0hDovX2Aws0
         s31CvCV3WOs81yzgeTvmHg7luMuTcXd5YkZEHqQlQVHh2xsEjs2U/kqaSmL+pmeFPoEC
         Z8Jg==
X-Gm-Message-State: AO0yUKXFYYRv/sltbERAuU8JYtrNcDi8y0rU/mgc6AI5LxR2eWMDm9RX
        c7ynWYyO4BWKDTfiw1JT0q/D64zBcWtotGlf71h2Ag==
X-Google-Smtp-Source: AK7set/hpRWfHJFWXLG17yEKzouX556hGHZ4DtbxJ5D9T8cyICAY1smDzFL5vj/d6St643qyfmjA84QzpHZ0Ei2fbTQ=
X-Received: by 2002:a05:6102:4b8:b0:3fe:ae88:d22 with SMTP id
 r24-20020a05610204b800b003feae880d22mr1523855vsa.65.1675844911888; Wed, 08
 Feb 2023 00:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-36-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-36-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 8 Feb 2023 16:28:21 +0800
Message-ID: <CAGXv+5HTP0cLGEQ+qkAt8nsOp5DqCOgPyAOJ66fF91SKX=hZvw@mail.gmail.com>
Subject: Re: [PATCH v1 35/45] clk: mediatek: Split MT8195 clock drivers and
 allow module build
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
> option: there's no reason to do that, as it is totally unnecessary to
> build in all or none of them.
>
> Split them out: keep boot-critical clocks as bool and allow choosing
> non critical clocks as tristate.

The power domain controller references vppsys*, vdecsys*, vdosys*, wpesys,
imgsys and camsys. I'd argue that this makes these clock drivers
semi-boot-critical. Maybe mfgcfg as well when we add the GPU?

They should be bundled together at the very least. The power domain
controller not probing disables all display and multimedia capabilities.

Also wondering if we should have "default COMMON_CLK_MT8195" ...

I suppose the same questions apply to other SoCs.

ChenYu
