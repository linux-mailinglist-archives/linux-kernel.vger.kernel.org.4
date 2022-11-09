Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22D56225F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKII5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKII5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:57:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB401C405
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:57:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r14so26196073edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1hRKXwVB2zqbRKgazpAfelVDfIB83QYMnKU9WhNPso=;
        b=QiKNjIZP/NVw66cQ9HADd5LIkfQP6F8jpVSgENrQ+wAerOTYi6IsDpRXH47Zk3W9R9
         pr5AGBcM1N0WIWn9g8db9WpudVrZcwyBTWM34qSivLKNlcZGTQ+urNwmVdMuWXUMMlcq
         RvFQ2Xx+ijsh+2wQCLv8iWhJ7AeEzbq94/VcnRCFvZSRrJMFD5dV7F+Z1LUW1ItqUUos
         vXkffc0YcJOwDEpwm3Bh3U4fiof/i+c1Q1eMbOYF+1nqgKhck5GR2b6qRYSaDyYv+vSn
         m2DtbLqFRW9hQoWLJ+n1vI4YkuqI9UYtOIwq7S944lJfcEaTgRnmvMdWVMM4aZUJ/gph
         9BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1hRKXwVB2zqbRKgazpAfelVDfIB83QYMnKU9WhNPso=;
        b=guo6MPkFLBQe/whmmLZF/+4Zg2pJAnDgQvTcn6zGbCzeHya4x2/e+v/f3HsI5xf2rZ
         nOMhOuBpkT7XwLClSSD+qVz1r7RWHYgOlQi8QdIB9cuofayZKVMSBTH2FM8mAoP9JHu8
         a4iBzweNssTMpzeAN6mYYLgpf5a7BuN/OQ5mxBUjtyNUOHIE46T1Iy/8mqQZlTI3L8h+
         iOjSKbSRpEssgvvMgQl4246PDUA/DeyQogDuBd+x6+3BwwH1cD0Psq+ATW5j5DqOQkNG
         SrSNOPouchNSF/4GN97yZOcAYfzefVylCZK2fzOyLwZN6Y0ih3a20+sbg6F+LGIpNpxz
         1nww==
X-Gm-Message-State: ACrzQf0NW1UBi5SIxMh8DKzwwEIdFHxuUKVoq7jeg8OOh6N8dxumw8hh
        WMn5cdztn0+k+hkYmS6H8fk4eInyZAnC24tmI+2Rdr8AXvw=
X-Google-Smtp-Source: AMsMyM4wV6ZrQBRO3Nus3KwHc/K2UYSxn2KzEQnw8XZfrBH97PBwEteETvQa+c6qsQ5UQ/srBrkGOVcgEJ7LRr1Jhos=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr59359972edb.46.1667984250985; Wed, 09
 Nov 2022 00:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20221108094529.3597920-1-liwei391@huawei.com>
In-Reply-To: <20221108094529.3597920-1-liwei391@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:57:19 +0100
Message-ID: <CACRpkda6ghdCq2-yktqGSYRjQzO=5gW3V_F7R2oxtgTGOF10bw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Correct the header guard of mt6795-pinfunc.h
To:     Wei Li <liwei391@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 10:47 AM Wei Li <liwei391@huawei.com> wrote:

> Rename the header guard of mt6795-pinfunc.h from __DTS_MT8173_PINFUNC_H to
> __DTS_MT6795_PINFUNC_H what corresponding with the file name.
>
> Fixes: 81557a71564a ("dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Patch applied as obviously correct.

Yours,
Linus Walleij
