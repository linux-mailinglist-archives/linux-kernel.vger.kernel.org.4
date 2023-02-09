Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C496902EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBIJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBIJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:10:34 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FC2A15E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:10:27 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id l18so252920uac.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gUiV/qw4JVOOcTovWw+xyQ31ogBLTJYuBUEOiv2Lb9U=;
        b=QIIdel1hmP8z81Hism+qg1TEwzk5Q4RapO0/kQvbT2plytwESYSceZGMKXLlsMHLnJ
         aQwTjjAYJQpFz0W0Q9oBoHZAVdYNXekXiEQ69PeqGwM/y6MTkxHOr539NoK1u1ne5tJs
         YzOWq9vDJkLexZVnCS4T9l4rHtNeFWP6KBsT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUiV/qw4JVOOcTovWw+xyQ31ogBLTJYuBUEOiv2Lb9U=;
        b=IyrMFIrLWguDbROecCU6Ah0y6UKcJNO2lClt9gpObHlffSDKT0EQQS9zotQBvxG1BX
         rSXx/W1BYjpOUVSq9GJBNp0+8Fhc0HS8PkAclvEWpSx5AeJILS1x9wetK/Q1edarPO26
         wu7tVmYS5CmMt112SzSMc6JtoGUojdtuQq1mWbtoC76srsGNokGYzJZBhRZNcGOuSohM
         xKn/QguFgju3N/Gq2xNBBAId20yioXkOlu6KkThbQQQTkQffPJEMvFQGG+FG4uzOxGk8
         DQH5uLWnU04to1i3E7w+fAOZe/dqzXsL/bJSTV3GaiMI/7GccoiGFVjrORvSMCgrjZR7
         NDmA==
X-Gm-Message-State: AO0yUKUC8HwrIPOtDpa11d6hfU6u98iY5rr8G1sFRe1el4/F+ZuLy79R
        pCmj9Ai4GpiHNdhYI71d8RIcuzwBF8pJtCBn7SOhYQ==
X-Google-Smtp-Source: AK7set9iFbENJrUNl+hKyQ+MIZq2ziVgQa1lldvrUJbRi6mBlcQ3E1DlqRIz/5dmXyM5bWmpsndHSjVSmc3EWCSsyvc=
X-Received: by 2002:ab0:2bd5:0:b0:5e6:3536:22e4 with SMTP id
 s21-20020ab02bd5000000b005e6353622e4mr2456477uar.55.1675933826994; Thu, 09
 Feb 2023 01:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Feb 2023 17:10:15 +0800
Message-ID: <CAGXv+5HkdWUWmq0Jk5F2ZuFVHN5T07CYwBdzSWR7Z0=pmkJ5Mw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Panfrost: Improve and add MediaTek SoCs support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, tomeu.vizoso@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, steven.price@arm.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 6:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
> and improves MT8183 support: since the mtk-regulator-coupler driver
> was picked, it is now useless for Panfrost to look for, and manage,
> two regulators (GPU Vcore and GPU SRAM) on MediaTek;
>
> The aforementioned driver will take care of keeping the voltage
> relation (/constraints) of the two regulators on its own when a
> voltage change request is sent to the Vcore, solving the old time
> issue with not working DVFS on Panfrost+MediaTek (due to devfreq
> supporting only single regulator).
>
> In the specific case of MT8183, in order to not break the ABI, it
> was necessary to add a new compatible for enabling DVFS.

Tested on MT8183 Juniper (Kukui-based device), MT8192 Hayato (Asurada-based),
and MT8195 Tomato (Cherry-based).

GPU probed. When running glmark-es2-drm, observed state transitions in
/sys/class/devfreq/13040000.gpu/trans_stat , as well as actual changes to
values for regulators and clocks.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Also observed that sometimes when glmark terminated, the GPU would not be
brought down to the lowest OPP.
