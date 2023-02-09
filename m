Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831206902F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBIJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBIJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:37 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD4725940
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:11:35 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id cz15so1426029vsb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w68fjacIbYROHj9NrwdwNA0c0aQCtfhI8MuuSuFFTGU=;
        b=ZIYZaanS4Y+2sOHLh37grO5tgcR4JefyElqlYAUc1JIKKZAgas3J6AID8Itlb6wbKc
         AAfgAJqufU0jImwFeaP/YnfqImuC7ohwXwWBnzxJmM1nhMj8LPnDfRooMWAeeV3d2WS+
         wSs9SJPo19TuBsLQaRpmUwVnQzff9s24CscOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w68fjacIbYROHj9NrwdwNA0c0aQCtfhI8MuuSuFFTGU=;
        b=pl1kolA9b9qX2EQn0WnqjKe//PvVXeoz7Rd+cLCnpgHz0IFKSsd4ydBQoIgBD3aCpD
         xJSNJ6CxBJjl+Yu8o85q5gxn8LCb3Gq7m0lN9WdGCKtOZ8nVIdOj4pSyBTB0VBx0qEsU
         sKB6w/i+I5ffIyFcwahsyu9vj5e7SVybjU/2rtXcW1KpOYb/kDKjk+xufdcz4aEAW950
         h0n592VqMEWz2d4D6UziQlK2di+WbEzKyQfJfkdzqy1P6l8b0nY2tNTAwCgwSTth/zTR
         Wbk0h7/HcqOQTmPVVzAMWtR/jPioAC+a2TcZfZXyG8QVOubD4fyVazM4cZhDRYV08ti9
         WoTQ==
X-Gm-Message-State: AO0yUKW0Kyu8OmTXWRoL7et2/olIjlLK7DOK2ao3xsXKxNp3hctot7Gc
        SfqHVEaR7R4mYDnNDz9eWT12qkW16zdXpEFxi0VFyg==
X-Google-Smtp-Source: AK7set+KPzqBwjxATKFm3ww9TDUL0+dlDvBQLmcuye57In75cyMGFwgEmQXHgRNRnpRNwOctDpjGIdp71O9nke3/6hg=
X-Received: by 2002:a67:d202:0:b0:411:c830:e5b5 with SMTP id
 y2-20020a67d202000000b00411c830e5b5mr364925vsi.65.1675933894598; Thu, 09 Feb
 2023 01:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Feb 2023 17:11:23 +0800
Message-ID: <CAGXv+5Hd+XBqKX5w294KVw56BHkkD3NW9ED_RLDP0OXYDxv=nQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] Enable GPU with DVFS support on MediaTek SoCs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
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

On Wed, Feb 8, 2023 at 6:45 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> We finally have working GPU DVFS on MediaTek SoCs.
> On Panfrost.
> For real.
> ...and the best part is that it's going upstream.
>
> In order to get GPU DVFS working, it was necessary to satisfy a
> specific constraint (which is different, depending on the SoC)
> between two regulators: GPU VCORE and GPU SRAM.
> This was done through adding the mtk-regulator-coupler driver,
> which transparently manages the voltage relation between these
> two vregs, hence completely eliminating the need to manage these
> regulators in the Panfrost driver; this solves the long standing
> issue with devfreq+opp tables not supporting managing voltages
> for two regulators per opp entry out of the box, due to which
> we never got GPU DVFS on those SoCs, often locking them out to
> a low GPU frequency.
>
> This changes. Right now!
>
> Tested on MT8192, MT8195 Chromebooks.
>
> This series depends on [1].
>
> [1]: https://lore.kernel.org/lkml/20230208103709.116896-1-angelogioacchino.delregno@collabora.com/

Whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Tested on MT8183 Juniper (Kukui-based device), MT8192 Hayato (Asurada-based),
and MT8195 Tomato (Cherry-based).

GPU probed. When running glmark-es2-drm, observed state transitions in
/sys/class/devfreq/13040000.gpu/trans_stat , as well as actual changes to
values for regulators and clocks.

Also observed that sometimes when glmark terminated, the GPU would not be
brought down to the lowest OPP.
