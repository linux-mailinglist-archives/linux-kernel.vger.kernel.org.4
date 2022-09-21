Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241015BFE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIUMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIUMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:50:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A498D0D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:49:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z6so9767443wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DkE0WAM5mBu4ol1yLPj+NtrxueZJIQFbjIxfnKHOi+c=;
        b=fkVqEcFGM0lszd7i6ZN54hIQLat5l7oCgnekCg8Mcp/xH8bm7jzzBSm/8T99t2FJpm
         UKhvOZnolU1mC8n/A6PxqziXzyL7dAJLfd5NYb3bGkMxCYDIcJCPVRl+ayHTFOWfSc8E
         ldcjbDqKIUHYfP8yaCj4r+mYgHsOBVhohcQOuJMDo04q/WBQPawhodmaZKr+uGD7df5m
         tB7bhZ5p6+nkIzqzXHMPdlS13HXKDcN/RZULhLmYtQWlEB/UXVstJrFY2X/wAhSdLKWP
         /VCUzReL1oxF3uIcnbK4JNfF2diQdvfxYI5/cZYemamcINcXuts5x2LyDZxoDJmPQdW5
         mwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DkE0WAM5mBu4ol1yLPj+NtrxueZJIQFbjIxfnKHOi+c=;
        b=gv5GW7WPpIcYz2MW+XnNH7TROWkovPt5wZ6snrFo7slT/bnx/Srsy8sGnsaaYZZXMa
         l8eNoNQ8uzkOQsMPiw8kVG2fa0CeKQtogpvYNLSKmGVa1A7RodkbYQ7AcfrjKk7771/D
         abuIq+S7Qv8m6tqooMM7sT5vHOmvl3wcrz7rDFY22DMkUTTgB0vKSsK8XyjW2ABswRBl
         yLtGRYK4X7v8t7EnR1AMvM7iGg7GUL+RyVFf8ZimQQlCL6zJsa3yGMCk6+88liDWR/L5
         +WtB8FAT828jCW6RMQHUHpJ2haCJ7eCUdPAutur8KDN+Y4viaJLhDl1C/d5oo6Z2clsF
         BSHA==
X-Gm-Message-State: ACrzQf1Dor6YynJyOObrtL8RaVu34tT9CLj78dRalAIZQ+ca6SqOCcUq
        rmDPTOv9X7J//EZhSyZ6YqA1y6UOoslMAMhiNyv9tA==
X-Google-Smtp-Source: AMsMyM5tYRcSdHsIUm8rGqjJOQIruirH3/EfGzk0TsgEMAGJo3vw/I8EmT0b8+R2yFAUfQhs7u3SxGVqCTZda41+Yeo=
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id
 r15-20020a5d6c6f000000b0022a77786ea2mr17780311wrz.15.1663764549512; Wed, 21
 Sep 2022 05:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:48:32 +0200
Message-ID: <CAPDyKFpQxTjFruj3Hm_xtiPTKcH9aQ=wFYvpRR2mnnqiHVGtdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] MMC/SD support for MediaTek MT6795 Helio X10
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 14:09, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series adds support for the MMC/SD controller found on the
> MediaTek Helio X10 (MT6795).
> While at it, I've also made the compatibles and plat data ordering
> consistent.
>
> P.S.: There's no dt-bindings addition because that was already merged
>       and it's present [1] in next-20220915
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220915&id=55e7dceee83ca6584a08bd876ed0ec38de5b13ce
>
> Tested on a MT6795 Sony Xperia M5 smartphone
>
> AngeloGioacchino Del Regno (2):
>   mmc: mtk-sd: Reorder of_device_id and platform data by name
>   mmc: mtk-sd: Add support for MT6795 Helio X10
>
>  drivers/mmc/host/mtk-sd.c | 109 ++++++++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 47 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
