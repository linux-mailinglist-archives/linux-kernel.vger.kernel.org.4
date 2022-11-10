Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05A623F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKJKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKJKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:00:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C36011A0A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:00:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z18so2249214edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2odpp67XrwEsYQ5qgNjwznTYFgGSgGMTen/aFOlfBHo=;
        b=w5Oi/kOCYUP//oQsE/7WnRe4lkruoLsvkkON6QbMzHzT65213W8isBn10sgByyAphs
         +YLn/DkdvpvQ29qVJ/b0p5xC4eJR6C7ZGjgwxQNzo1k5C6ly3dmzspu5oKyvtneCB8Km
         aqpD8RAAK9LNQXkcnQLiWEkq0J7TgMQfJA9U9eXo55XWlEd4oOpyDCDZDO+cm3J3FpQO
         H/6yusCZlu/zOzd9QjHMS5wM33wg8gtu2vLAZ4ZgNFCjqTeHkf/h0cSX93u4BGHAG8Ia
         Pm1oOUmsjAhJVo8cinMRe6QjYmBJLHoePgHZPoipmGWFlkEmvLJMvo+GGD7OGJUv9jAG
         KVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2odpp67XrwEsYQ5qgNjwznTYFgGSgGMTen/aFOlfBHo=;
        b=YSz8oGgifTs3jlvT4tdDqOX5FlT1oW+Tc5EAeSDtY7aZxtwaFWADTyuhbK9xZjz5vn
         XL3rfSghFoap9aGYcgxHu3r/whzwdU+pDtcJBmFCJ+/JZKdvUyMucUY//hToq+ZpPaTS
         nkhwrNkGt1w3Gq/juoqXJ9l4VDC8CrUbY8JxYM37rn1qA31AaKrV4LJVEoew0YZm4mzQ
         cb8s96O0oUltfhA4DHvTP+HRvrnQXWlPBOKWX5o4vZmnUbn07uRJdnDmunDj5DFZgLbc
         VnTMGycsTOD4RjqL/ZMTcYthpE+gXzGSW6bPNQBnphzxDGTBVVnsNJ5al88/1Osspw74
         Cn4g==
X-Gm-Message-State: ACrzQf21e4DGHO+iSrAx8rHssP6xMOK4+NxtM4s+vYrz/4hSKUo84S0p
        OlAZSM4kF0JSyXD73hJYw9XJp1XjsgFo65a4QFTVbA==
X-Google-Smtp-Source: AMsMyM6h/kF5BTrJAJvpwMlFB3z9bBGXZoV5+JPSItJMwFXOR5GNihzM7BleUV6gcrOiWnUTuuxCYagD9ge9jupAI4w=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr62575422edb.46.1668074420887; Thu, 10
 Nov 2022 02:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20221031100843.14579-1-clin@suse.com> <20221031100843.14579-2-clin@suse.com>
 <CACRpkdY-uaQ--vFM+vVPbwa-q9nbSU0rQB+qbL=9m0wVMwA3Aw@mail.gmail.com> <Y2vZJaoWThP2aipE@linux-8mug>
In-Reply-To: <Y2vZJaoWThP2aipE@linux-8mug>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 11:00:05 +0100
Message-ID: <CACRpkdbW=WMA-9OkJgBoBov7ewGMN_Coy=KOQfS_uwzHNsuGwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 5:45 PM Chester Lin <clin@suse.com> wrote:

> > If you have the compatible, surely you know these indexes from
> > that compatible string?
>
> The nxp,pins property is more like a common language that both kernel and
> u-boot can share with. Of course hardcoding indexes can be achieved as well
> but that also means the index matrices in both kernel driver and u-boot driver
> must be revised and synchronized if new boards may have different reg and
> nxp,pins.

Is it new *BOARDS* that need a new table really or new *SOC:s*?

I was under the impression that this is per-soc and then it can be derived
from the compatible string and should be in the driver.

If it is something that vary from board to board then it should be in the
device tree because it can not be derived from the version of the hardware
i.e the compatible string.

So which one is it?

Yours,
Linus Walleij
