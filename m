Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10569DAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjBUHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjBUHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:11:22 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C526F2313F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:11:21 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id f20so185414uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DUvCeFI9BHWAoO/zKvffMjZuUEizyKxpjmRG4IyfZI=;
        b=U5KZdGiXJibu7wRYaxdO8HYzWbPJyYS6XheXOL9JFe+YKSqEEjtZZeuVgyAKELDP8K
         AEvWkZNSwhMdd8iTivrxTKWfywG2fAwi48dgmGUCG1T/S+EoIMMkozbGylKqbZhpkNoO
         1GsmiEV5XJyMthaIEl5gYZUSnUhnm+fuU9C84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DUvCeFI9BHWAoO/zKvffMjZuUEizyKxpjmRG4IyfZI=;
        b=JFvxTgP4FH1+B+wLXMk794R91FUsAEXH6sn8/d3dMk2gwoKkb8Gj7FGPjaFapFGaCM
         CSLrjVj83bZQ2cwDfeOtOQ8Mw91yZ8rzmpfuqjRlrpOfB/weOJa5wdOEkKOZKwV+Wf3M
         K8pWjMEm54kYlWc4A3ulV96Me4N5tOXUJ39g8ejW42zbKx7xmLqQilegGLvR7h+nllIy
         +2m2KverT28pZIdT1yIAfkZv4TVNTBZ+EKMpKMYNCStE+D8NUvlEgEHK86leTU5B3b2F
         FhKz2jkugYE3clE1TOm5Bgi+M7UNbuleDM7QwnhFJ0hLXylqYmx6SadnM+RSYs97vv2A
         roIg==
X-Gm-Message-State: AO0yUKWTnrNMJvva8CPaT0mmT1Gmb4jBjpuQq+rMB4wagwpgfmy/+4VN
        1PUsM7mIhDASp7mFDsChTRcp5m4YBFYrMbix6C+FyA==
X-Google-Smtp-Source: AK7set/yqwhMIo1VLl3ac92155791hmnZ3MjUsVUCyfkhacYq1LOD2N4kB2QwF3gdeKHtYu1rW9Bfxw3g2Zsn0izPyU=
X-Received: by 2002:ab0:53d5:0:b0:68a:5c52:7f2b with SMTP id
 l21-20020ab053d5000000b0068a5c527f2bmr613970uaa.1.1676963480849; Mon, 20 Feb
 2023 23:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:11:10 +0800
Message-ID: <CAGXv+5E+EExkTSn8GKKEVHGrJf8aP+ZNwuMVPEO1v6frtfAeCg@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] soc: mediatek: mtk-mutex: Compress of_device_id
 array entries
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

On Thu, Feb 16, 2023 at 9:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Compress entries of the of_match_mtk_mmsys array to reduce the amount
> of lines and increase readability; this brings us to a maximum of 95
> columns.
>
> While at it, also add a sentinel comment to the last entry for the
> sole purpose of consistency.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 38 +++++++++++---------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index c5b1b42303ac..5c875139425c 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -921,31 +921,19 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id mutex_driver_dt_match[] = {
> -       { .compatible = "mediatek,mt2701-disp-mutex",
> -         .data = &mt2701_mutex_driver_data},
> -       { .compatible = "mediatek,mt2712-disp-mutex",
> -         .data = &mt2712_mutex_driver_data},
> -       { .compatible = "mediatek,mt6795-disp-mutex",
> -         .data = &mt6795_mutex_driver_data},
> -       { .compatible = "mediatek,mt8167-disp-mutex",
> -         .data = &mt8167_mutex_driver_data},
> -       { .compatible = "mediatek,mt8173-disp-mutex",
> -         .data = &mt8173_mutex_driver_data},
> -       { .compatible = "mediatek,mt8183-disp-mutex",
> -         .data = &mt8183_mutex_driver_data},
> -       { .compatible = "mediatek,mt8186-disp-mutex",
> -         .data = &mt8186_mutex_driver_data},
> -       { .compatible = "mediatek,mt8186-mdp3-mutex",
> -         .data = &mt8186_mdp_mutex_driver_data},
> -       { .compatible = "mediatek,mt8188-disp-mutex",
> -         .data = &mt8188_mutex_driver_data},
> -       { .compatible = "mediatek,mt8192-disp-mutex",
> -         .data = &mt8192_mutex_driver_data},
> -       { .compatible = "mediatek,mt8195-disp-mutex",
> -         .data = &mt8195_mutex_driver_data},

This conflicts with the MT8195 VPP mutex patch already in Matthias's
temporary branch: http://git.kernel.org/matthias.bgg/h/v6.3-tmp/soc

ChenYu
