Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9269DAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjBUHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjBUHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:06:08 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC3252A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:06:03 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id w126so1907974vkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfybcSb/k8uIiyikSufepDJldHy41XoHgoO+/sM6dlY=;
        b=PjEF9BF/+eykiRu2kO6/TCvD01SBcFkKc9j20k4sfYekcZVrutoP8IFZUCGdB9iqx7
         bICgnB+63J6vfGJF16SIv3+jX5na0D4+O3vtQjAST44cXmb8hnJFLnlzEIx5iAr4DMXH
         AsB5OMOLiP0jCQ/62WHG/8x43XNyho2u/AJEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfybcSb/k8uIiyikSufepDJldHy41XoHgoO+/sM6dlY=;
        b=Nesk46N/Ri1TH6ko5xmG+Upr0B59GVM5uNbtrpBKYG3dB2s8MyTsM7X82bw17IW18T
         t+Sfj1xljQB4Q74/7lV+u181X7b5ROYMhWMlwgcgOaivaU5R0+V+CCTIQR7HXvxeK5xF
         WDR59C0UZNlvM2qjcLlBFNqmL9UnWQZW3DCu5hdEa9vDK2DukTDw81qLyuqZMUKqkXrr
         NDjJMkBT8y6/h7wKuaJZVONQTqjNfcPpQyiaJUQ3YI+dKa0EZoFCo5IYI0lyfDrg5txh
         YAzCq38GXaTC9ELZX9xOIsiX5/ciQ7N0NkwqsQQe3fazFJi+jbyUKXd71RO3KYEciYNR
         n40g==
X-Gm-Message-State: AO0yUKWY3RqGzRe7VKh2D9dFWmzwwpZ4UB73f/+QOIVOvqK+bybtWsOe
        ogy0cCiLjbTgK9OMwsmb8GaVmRNGUXmQjdjYo+HhVA==
X-Google-Smtp-Source: AK7set+OnPrFCVbikFqpSUdTza5B84fPwn8b4qF59+su/dSBE/FEN2fpy0kFxRLk+tGKHBcTmLfJbqS7LLzLUXVtXNA=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr880354vke.18.1676963162332;
 Mon, 20 Feb 2023 23:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:05:51 +0800
Message-ID: <CAGXv+5Ea6RiCqiAvs-mmmX2gNrB9ZdXDGnO8NXVkjFe2avpXFA@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE()
 to allow auto-load
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

On Thu, Feb 16, 2023 at 9:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Allow module auto-loading by adding a MODULE_DEVICE_TABLE for
> of_match_mmsys.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
