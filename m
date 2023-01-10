Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE89664283
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjAJN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbjAJNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:55:18 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED191527
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:53:24 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id t15so11843015ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rVCMSgatdIf3t9Qq9Q8tQnF21QDdXZk3rUx62zf2uI8=;
        b=hn9FBSlUWNgiKhcp+XGG6IP3x7ac3jxe3Q+cCwYFo6h+OfPXirEiREXUFjyi2FCoiT
         EHntTsn+pJ3rYh5MNy2CoDWTEbucfkEIdpm+HHU0GnOpThR0jLHKXBrncMvmBYIkBzIy
         3zKlr07MOTtQLl6sKhWWpZcIX4ZFZYveBL41ibfHkA+GcoUkpWTtoHQdyGx73QTyLUd0
         ItXmN/H9vQQYT2b4IjVsvy6Wbd2u85kBXKBzwYKpKaUxF5wMwiqqb0TTavELWHviTupB
         sKUk5vhOO0HoxTTSipHDF/xE6eNl1/gHQPxYE1uNfkRGUkEETWEU3iY0OLDjrrOh3Seu
         bHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVCMSgatdIf3t9Qq9Q8tQnF21QDdXZk3rUx62zf2uI8=;
        b=drH/vJQlnnsbY37G6lPLuU4rlr2PdhI4bYhfI1gTmA+l2bc1lI+4zNyO79jnDzavhT
         FINDAdiZxKUPoA5s+MdFtQrMLsfJg0JJ2WIc8rAu1qmmOoYqrgiWsilvfwt09LEKE9gj
         48jFvvjuQ10OUVNRFQH7+kA6DHM/w2gXgHhqMEYLIjLJau7lvvnaScKicBtJozQuIrIi
         yYcYFOr6tzPymidIzxgfh36gzbRvxqXGlukf5ZBUo1NTsX89A7okUKYSFWm040gXZAi8
         ixmHmBKUcJAo9UGzdJFWRw84EGbWYwi5kcBXe+kcg8kBIL29juguuZ63sU9MbFmQ+vhF
         Mi1g==
X-Gm-Message-State: AFqh2krG3eSS2O1zHW5XY0S2MsC5UvhEBGX1HIY0vQv4cQbA0Kpg/mmn
        x0RA3u9JEFDeBXH0fZ/O/bxvjOikudSEOFbb0B+gjQ==
X-Google-Smtp-Source: AMrXdXugIKCVBl9k9fZr5k8yNXAqd8M3xUejgOHtloMcYf4xIp128JO5fcHVa46s2bGC9eoKT2SVnUE9HoyhwRFH69s=
X-Received: by 2002:a25:cf02:0:b0:7b4:fa63:5519 with SMTP id
 f2-20020a25cf02000000b007b4fa635519mr2132063ybg.270.1673358797706; Tue, 10
 Jan 2023 05:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <20230109155801.51642-3-sebastian.reichel@collabora.com>
In-Reply-To: <20230109155801.51642-3-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Tue, 10 Jan 2023 19:23:06 +0530
Message-ID: <CA+VMnFxxx18=u7oFJZ9x9g0HA8PV+yNPUk7OdhffR7vdhz712g@mail.gmail.com>
Subject: Re: [PATCHv8 2/7] arm64: dts: rockchip: Add rk3588 pinctrl data
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>,
        kernel@collabora.com, Shengfei Xu <xsf@rock-chips.com>,
        Damon Ding <damon.ding@rock-chips.com>,
        Steven Liu <steven.liu@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> From: Jianqun Xu <jay.xu@rock-chips.com>
>
> This adds the pin controller data for rk3588 and rk3588s.
>
> Signed-off-by: Shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [port from vendor tree merging all fixes]
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Acked-by: Jagan Teki <jagan@edgeble.ai>
Tested-by: Jagan Teki <jagan@edgeble.ai> # edgeble-neu6a
