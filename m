Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E065682EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAaOJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:09:47 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755493B3C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:09:46 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u72so18184885ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFbhQuUo0EANg9ln/8HeggaLONs0W8b8hm90uzCebrE=;
        b=lXhE5QJ/7ynLxd0cKoZKcWrPZ6pZhe0ydWHoxEQ/fP/wC8I/V4QxGpbSmQ+lUnnxpJ
         cQOR0kISIROUfHgSW1INj/zCUMXF+Wai+tZBZB3QFx9b3nTUbHJYkQwUa3dYh8oB13JG
         KOjEN+l+fCxXvlyUNAdGYSYZ2M8wrnzi7vDXBxbh+Tl8SW3Lctl8pBjI4OR0GC8G60J8
         3hfq5FdUZBBFsnOR0DvOX84zihVdGl6Yunew8uFOeiSSEKQqfKTguockjtrAaGcHDEFy
         wzxww5QFFjhj3osj0P8C469s+iKMfKluIZiLfk9KW0ax4UF5Drst1JXxv6PkWaY2j/Y+
         Nqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFbhQuUo0EANg9ln/8HeggaLONs0W8b8hm90uzCebrE=;
        b=oCDVFLZZctKv6R9N3B/i7SpuX93OhoBTy6kUSKU47Dt1rZY9fdeP4mrQnIrg3WGxCH
         Lvk2+BMLed6OeWGqfnfaRaLwmUUNHBLeXai1guhb/DOz5CCScuGjO3xjPplrNCMhST/f
         u5BIvPuuMLot4tiYHbJHqG95qLEC0xuFzHayZco4jkkTe4fFicUMAVc6lDnzmJrDy1Yt
         Eh0J4pWnnNtKhnpYUSqIarTxurVUwrDr+R3Ai/wQmtHEFaJ1iegXnFYJ8OrKWXX2Jfwq
         pZoi3ZKNjFZPSjVZ5zgs7+4Zglod52gQ7VFnIwARBtfGRppEe4rorP0nbT5EkHHogST8
         mPZA==
X-Gm-Message-State: AO0yUKUA/EP8iJRXwP0JCZOk/9/zXkGgL+OhRjoMkE3SPdMnpU65WJ6c
        QiYSd+G+jHBIH+JUUQS/uQ8Hx+A0+exQQEztykh0751DCwn+XQ==
X-Google-Smtp-Source: AK7set/JyxFpgXjZ39+OJTzGZlXsVX4g48dYlb2Ht7MOnFxjEwFbvN6pnKjEeiiK9Cg01y2Xr8GRYPFw+j/bzlCRElw=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr3400674ybg.210.1675174185738; Tue, 31
 Jan 2023 06:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20230131140304.626779-1-clabbe@baylibre.com> <20230131140304.626779-2-clabbe@baylibre.com>
In-Reply-To: <20230131140304.626779-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2023 15:09:34 +0100
Message-ID: <CACRpkdZpcEUhk_rXdT9B7Y-38Z5cJ8QM26XXNkK-Udr=foVOcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] leds: remove ide-disk trigger
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 3:03 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> No user of ide-disk remains, so remove this deprecated trigger.
> Only a few platforms used this and were fixed in 2016.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
