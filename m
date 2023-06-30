Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98474355A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF3GwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjF3GwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:52:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A58B30F6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:51:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a1245542so24404551fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688107918; x=1690699918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBW2ODM2guWVZdVNnU/ZES/eGWsE5AoCM8ERdHN+G5k=;
        b=nc8+oxUWp5DFHwbTo0NYizKyGgQgFkvBhDxNPNUsX8fFlcDRgc0UjitbA/WmZT5gGt
         AQpS5FWCMK0OPMWi/7kJHZs/8o2YooPQP6kUMt/8T9wLWfZoRhawJhk6Vl9H+wPbanba
         90z5RH1PDVJZr190f6x7kcWYHbjz4Yp5G15QJe1ZYcylHcyuB0I23QmyQhYnKo+HqcNT
         fLUX0hFlqLU5O9M9YVGb95bdksWjo5UDmUoHS0CkDhSYf7LBQJnLrJjJarrcS/JQfmLL
         L7dMPM9wiKNu4234i+W6K2e/iSSiyLJ4qVIP4xLpW6liN0iH3A26PS/qRWaZ+yCmuKRm
         rs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107918; x=1690699918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBW2ODM2guWVZdVNnU/ZES/eGWsE5AoCM8ERdHN+G5k=;
        b=YPZ2sMR536xRgaSrYIPWTtppDeJ8T0QD/umWLVP7d1FKZxfyTb9NhSnJs+Rob24tMs
         kh0DPu4LFdUTcXDb73k133tcVUqYxhSKvjB+yvwjqaehclLEIwRcdc6BYoFNhgYtmVzU
         smRxqXb58oNp7grl53gRERQQimDOPuNaK8Gqss4p/XfwIaIsb7J5IUMfspMiDDxobrpw
         ItX1kiVyusYuUanbUDRmbNbXWCxAgXKij9lAgDrWX93EtSH4QfrDGRAZcOCaCO3s2QVQ
         UY54aqSFqhZtyZEiVLqdh5QpyNCKAs9lFe4SM4P0WlS7hkJRipusbnwauI1eQZArJODA
         NV7g==
X-Gm-Message-State: ABy/qLayko534oJtyThhjjW/XOnvJGAngd2HEVBRSR2Yw0JXC0anQpnX
        hyr1te19T21woAFlS1FG6Sx52VZq5FVgMGSe+mdKag==
X-Google-Smtp-Source: APBJJlHNp8Ainsp3NPDijOl5zudm1amCzUpI/b6OsWN0NSoMe20xSzSBReBYTUzp2a7lNP1NV1Z5kJiY4LeNW3XdO5k=
X-Received: by 2002:a2e:8e8d:0:b0:2b1:ad15:fe38 with SMTP id
 z13-20020a2e8e8d000000b002b1ad15fe38mr1273612ljk.3.1688107917676; Thu, 29 Jun
 2023 23:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX0A8mqz5cS4+CqjRgpQQKuSp=3SvE1KJ_di09VjJQVoGg@mail.gmail.com>
 <20230630045246.1674919-1-jstultz@google.com>
In-Reply-To: <20230630045246.1674919-1-jstultz@google.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 30 Jun 2023 12:21:46 +0530
Message-ID: <CAO_48GEtT_rG=7aDG8g7Eosu0RWqzuNqGwsW7ODdomwu=ekafg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add T.J. Mercier as reviewer for DMA-BUF
 HEAPS FRAMEWORK
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "T . J . Mercier" <tjmercier@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, 30 Jun 2023 at 10:22, John Stultz <jstultz@google.com> wrote:
>
> T.J. has been responsible for dmab-buf items on the Android team
> for awhile now, so it would be great to have him on as a reviewer.
>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>

Thank you for the patch;
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

I'll push it to drm-misc along with the one removing Liam.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cb075f52d97b..f4e92b968ed7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6184,6 +6184,7 @@ R:        Benjamin Gaignard <benjamin.gaignard@collabora.com>
>  R:     Laura Abbott <labbott@redhat.com>
>  R:     Brian Starkey <Brian.Starkey@arm.com>
>  R:     John Stultz <jstultz@google.com>
> +R:     T.J. Mercier <tjmercier@google.com>
>  L:     linux-media@vger.kernel.org
>  L:     dri-devel@lists.freedesktop.org
>  L:     linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> --
> 2.41.0.255.g8b1d071c50-goog
>

Best,
Sumit.
