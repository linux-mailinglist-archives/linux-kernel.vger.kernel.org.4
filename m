Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F36A1996
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBXKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjBXKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:08:21 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0E9032
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:07:19 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id o6so21043014vsq.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fWSr1WF+X5T1bZtRLI9WjKETwvN5uS3RGWAESXIiZkc=;
        b=UUU7+bf1J/3YQBp6q6nn/9f8+qO3i7FcyCZ5pfWBkKha/NZXBKkX73onQyAu04YtLv
         sNveM4/KjxWln/WNJVDs3rarZm6abxHAKAXtxRLpDdvd6rLuwaIvm8XDp16rkL0/juCO
         hSwu8oY8/mAEtzYe5GoLALOvh3yqoCNBgp0eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWSr1WF+X5T1bZtRLI9WjKETwvN5uS3RGWAESXIiZkc=;
        b=6OEhfZmwluSwCMsg7pFA1o2iBZnB+4JzCrY8wkpGMgqQQUjHd816l6zuwW0AfGbBeU
         m0yXvAS3HJnnGxOBwD8iowVM83bdQaojVXGZsVsH9iXCN7+UkxYG10dDMEC5ANEGPT1R
         +w7mZJteJsAr37Jg1g8AmqVu1MjezEJ0zJ9k4u2DSBhYlpRQynu7JtzXvXI8Q0Tr3tyd
         9X/EZy6vb5W1mU5/tDgFrHaYNRgGEtKPKWZCNfy79WrtVXaqyWdNSUCJ3YAeF5ib6t8Z
         V8Ag1OIVknzhU85ATV3wjNjXlKjAm01WU0yOO6c/mAaoYrNzpWAkzqJmgFrgT2xpwQVT
         fJpg==
X-Gm-Message-State: AO0yUKXdLpHizglz1cMM8jIaswL6r7rEzD0ohd/QRB12KWe9h2dz8M9W
        N8AGpbrbl8NeKgGVuH2qieLy9mm2zUoq2FRr7deRqA==
X-Google-Smtp-Source: AK7set9aFwqpGWSWGfjbGo94cuHgKCgr2GvFvM/OzPybEBs7N6ZOfs/1hkngTYdnrZMb9EHV3N7v5C4YswmKg6wznE8=
X-Received: by 2002:a67:d21c:0:b0:402:999f:51dd with SMTP id
 y28-20020a67d21c000000b00402999f51ddmr2215538vsi.3.1677233228403; Fri, 24 Feb
 2023 02:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:06:57 +0800
Message-ID: <CAGXv+5H6xUZEg-rtL4Q4BvJXtOD598MHyotG4CGz3_yEy9oX-A@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: gpu: mali-bifrost: Add support for
 MediaTek MT8186
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8186 has a Mali-G52 MC2 2EE GPU (two cores): add a binding with
> two power domains (one per core) for it.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
