Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7D68ED86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBHLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjBHLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:08:23 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC61241F9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:08:20 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 184so56068ybw.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3UlESeBgDciAANYrbDYeDSe/nLTXzJWVU7vv0QvjTQ=;
        b=FpTH+5SNG50VekrvfskE3miwhfUFl+CWP4tBydhtVNcsbNGeVvYDyBR45eJn3DiqC+
         RQApd/xtzL6xrDBazYsmciFcRnbB+A+8EVTN8uOr7YbtjfTyCkvhpbSYs9PYUQzNPSQ+
         IfAjUFG3UrAWy7KH515p6NiHKTERG1xLCsjZitWwrn4hpUHG5myGgFUyqkjcNszyelPE
         4XgiaA3YlvBsYmYmJDOhzWb/jXN3mRFaOwqmiLTMVWotEINHmsZT4XlDLf7+pEaAhLRX
         zUmDirZkeX7gifq04Zt9YgA443YIJ8UBXd7fFsMj2naruVfbTHXO0x/comBGG06fqMed
         fMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3UlESeBgDciAANYrbDYeDSe/nLTXzJWVU7vv0QvjTQ=;
        b=1tf4PDbyctv4QBV6Ak6s3D3zMUhwkNafoJZyJBfpjqypZYB0FdBLb/bg+i79BHk3YN
         +Od5RBU+ICezydRsg/Fk5MvtXmlTlixMX505gHJ4dNhM+Aeu9Fud9D1aDjK9UelsbyGx
         jwcgFjJkH1DcaHt/DxulGxnLZ+B7poghA0TNrGJ1S6ht2Wbzz2H6pFD5AtisZYUUpIOJ
         hf1eol/56+N848ksrw5j6kuyrHGG9mWBED6LO+7huankcU8xjqEzXh/Wxdvh10QRZ6ot
         +vRGQHBIDYftPJl1yY28YICePozWAo9NSNRV7YSC04+xeMQWN+oK9nbeh2wHaR/yHx6T
         aLQQ==
X-Gm-Message-State: AO0yUKV8eZDtj2dilyupUgxcrDTyTQKMzeqW4kJmrNNBbNK00xSGcI7C
        SjoR009Fx7mQM9mAAv0lY8lAaJPzH7vMPc+KN3lw7Q==
X-Google-Smtp-Source: AK7set8xHbCP+Q2iJNCuxgj4D+UrE9o+1uWIfbVQJLQpwO5h1x/YO2XK51m0DHdQHHPEJpJ0k7HEhsu/xE2qaEsRvws=
X-Received: by 2002:a5b:85:0:b0:8c0:638c:74c6 with SMTP id b5-20020a5b0085000000b008c0638c74c6mr252977ybp.341.1675854499608;
 Wed, 08 Feb 2023 03:08:19 -0800 (PST)
MIME-Version: 1.0
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Feb 2023 12:08:07 +0100
Message-ID: <CACRpkdbmXri1vtRShm7a3N0sRA7Qg_ni5FpAtiEv+72a6g9Wng@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:06 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Currently all Rockchip gpio nodes have the same compatible.
> Compatible strings should be SoC related.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Bartosz can you merge this one patch and keep the rest back
so we get a more defined DT binding baseline?

Yours,
Linus Walleij
