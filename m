Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52969DAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjBUHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBUHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:05:53 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E4CDDA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:05:52 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id k22so1662190vkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1cYKqMet8H+ii8MTj3LDy2njm/8Z3UGGXga63FCV+I=;
        b=R5Z5iOehdhaO5+AIYt0tTWNGgV8or5fvRctQsvFvL3EDJxauyJhHWy5pncSVF8PZqE
         nTZLZ9VRORycd3DcEm0C3k7LNxNrPsdbNPcDyuRIVmDrruIDjoTNthDUZGnsXLGsJT69
         WleSWWLxlS+pJi10G4m6iiH3hvlmlHTwGnOdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1cYKqMet8H+ii8MTj3LDy2njm/8Z3UGGXga63FCV+I=;
        b=aDHJAfuIvjB9ylfYwsuVhcD8FI8ayp+2lalhXUrCrqKLMlkIQ+vAhOxG+Ut0OVCU7q
         93uUR99WFqOD99To9cnCUsqncCQbfOpRj9jLqVzxAbq49di9qHraTwueQTSlfZTUFT6D
         GmLVnDxuj222M26zbJE0XaA2Uh8u0aaBMKKeUXae5AYEpZOZ29zLyS+bXGqRpDHJlC1x
         6q/mAlmk2Y3jANKO6FIWADLVWpf4uIRoiALkaunNznHEwLOJEzs5Q+0rSo88ksGfpqH6
         J0HeZcqcyxYIYGewcuL3CaEFhNGGuEyg7ZsG/Qj8qx1gjmMPOToVMB3R1BqDCRDTSj8P
         islQ==
X-Gm-Message-State: AO0yUKWCTIaw+MJfz3Q0jf+5lb8T7OnawVEgwNPLMTOEjxR8SOo7MgRY
        3WAQRbghwCmyfhNR3w7aLjVswJYLkxCHyzPVxrifvg==
X-Google-Smtp-Source: AK7set9ds/uYiuq04sAgmJcSU9zYEOvalROd9bpv/L73UMiOVYuE3J4KhAbSqG8R/1csA8+vbSVOfJcx7s+uruF8xoI=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr880296vke.18.1676963151277;
 Mon, 20 Feb 2023 23:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:05:40 +0800
Message-ID: <CAGXv+5Hqx-b0rH4K2NFdvHrTmkn-h09Jn-RJWjYbW3gNDc+tqg@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] soc: mediatek: mtk-mmsys: Compress of_device_id
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

On Thu, Feb 16, 2023 at 9:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Compress entries of the of_match_mtk_mmsys array to reduce the amount
> of lines and increase readability; this brings us to a maximum of 90
> columns.
>
> While at it, also add a sentinel comment to the last entry for the
> sole purpose of consistency.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
