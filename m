Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2E67CC67
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbjAZNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjAZNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:40:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E386DFCE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:40:15 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id m199so1979790ybm.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3nA2n2CLTUWJ4vD9ZGbE+UeuAneXwldHq4cRkGDvQzA=;
        b=h0d4/uB92ODoYzrZYmaVvUG1jvcTVC84b3cuC4xSkz94COWEqsOOr2IBowpVl0CpDk
         6KzGggs+wRnLPePErIKjd+MObcWfYQbK5L7NhK8ilrbc9pL/EFAA4EQCKIk77bKIOEHh
         P1q6wpH5pEuZZlVhMn9HMwfam7xVBuXARvfmkydFab+Hop7ms/oR01SaVcGEi8rWPCM4
         mmE/TS4q48Lh9ZHr9oiqRtEoRe8n+NKmk1P3xds7mwVwfXG0lJnz2UDQOOrfNp1h23V2
         DZQdPjse3MNVv2wq4ZgH5q97Fv1fknuS1qlKoQnW2UF0CzhzQvXorkqZfFt4FUkQCQ6r
         +0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nA2n2CLTUWJ4vD9ZGbE+UeuAneXwldHq4cRkGDvQzA=;
        b=5pG+S/uy+VK2kVEK6NFdh2MLHpT4CTeor9OYLZJLfhGgj7bNrjZMf+6LfjGFShW1xi
         dOsKKGwaVsx5Zk4EGXi+J2l8vzuvpnwx1xk3GdUOhjhULbQc0Oylj9g0J53BtwhfzRH9
         7+8Imf3xEmca/E+alkzLzDeL7o40B8VtZWJi+vT3dHTfDRjb6CeG9HuR/78cGGktOXgJ
         RqGpQy2HjdiKkJZoyQdnuDOUrg/DxF60mC7LH35l+iW//P0MS2gOpIPpz1CeSzA/zefl
         RavSZgKIEpv677s8w/wESnnx/HEFxz2hx2eC/5GPQ5BmzJ+gbVGvU5TMl7u9l3Dw6Gab
         GIZg==
X-Gm-Message-State: AO0yUKW41sIgyWcpbPGn8TAjlRO8df9hvqXb9Hwqwpl+Hz2OQy2wPb/M
        SK3xUqHqh9Q/XSdzClNIAlsITUEG41OuXJD705q9iA==
X-Google-Smtp-Source: AK7set9S+ZAAT2EmYO2ZCACuwdKqYiWYHVPGt2d1pERtloAf8IObExq0V8YgsRI5XkikpiXSbqCjcrnLxbhCxfYYD2Y=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr1253612ybg.210.1674740415100; Thu, 26
 Jan 2023 05:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20230118062036.26258-1-Guodong.Liu@mediatek.com>
In-Reply-To: <20230118062036.26258-1-Guodong.Liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 14:40:04 +0100
Message-ID: <CACRpkdZ626h9zzj8zjtqzVVp9=icRCzUts7+_SuUiuBatYBzcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] MediaTek pinctrl cleanups and improvements
To:     Guodong Liu <Guodong.Liu@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:20 AM Guodong Liu <Guodong.Liu@mediatek.com> wrote:

> Guodong Liu (2):
>   pinctrl: mediatek: Initialize variable pullen and pullup to zero
>   pinctrl: mediatek: Initialize variable *buf to zero

Patches applied!

Yours,
Linus Walleij
