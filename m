Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0645067E6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjA0N3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjA0N32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:29:28 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8519757A9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:29:26 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b1so5924590ybn.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d90t2HT4axfU/qrUeGEIoyPWhawGVIFewaicVqJDUqg=;
        b=bkF37mijcUJHRTb1p6rDKR/QOD6cFK2fbdggg39R9YmoMeA6tsJ6yvEJ14vk9DFsmT
         cnWWi3EdLY4EgOwM0aFp0esXbWtzUduqqXAgTchHNp1iiaa8mDjQrvwF/FYs7Ezq1EiR
         UD9b2YeYJPMGKbP99a4CO2DUdafwP48N2eGkFFcn4zdO8fQu3CVfLNPxagbHGVNi9Aid
         LKTgkD2YpIKAt4xYqDBLxTKiuI2Bnpd+xENAUnjYKhH1WdkmL3iv9NjHp+q8EXfYVfUM
         wFr6J8H/b6wmAOQ8UXn2NwQkBoN2rvU1BFiqJmNOisRwwkoqxs3IS/K9cTWqDBvwedN8
         E8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d90t2HT4axfU/qrUeGEIoyPWhawGVIFewaicVqJDUqg=;
        b=OxMPV6oWVnWG4QJlJaqDrsSlNmbkFKcRlwKfBqt4yY7kbp3i5PWxFTzQ3JxQs2alL/
         LSRjbdxbie6AVGmGDCE3ZQNh/+Qi7MdcrhHDVLBdLYblJHozblizbIWma0dWXzicGMRZ
         QrFjcl9go8+XYqjwSYDlM7kHy5T+6GKKx8vd7au3HjtxHg4wBJYgXRGLsCbqf2prC2a5
         zX14aLecKAvtZ9xZYCdTzLfo9ImBXXXNt4MXqmoQzkhVcoGjPaPNkUJD0qfkW1tPg1Wy
         TZfUEl9muhh7DZulSgcE7inEF8FzLpeNbrWfGvq3s+XYRuRQHg1cFTU+PF2k5ti/ABqW
         0LuA==
X-Gm-Message-State: AO0yUKUVwD9djoJ57yvBG9ZMQSqyMjJtXi9I8Sp7XfMxav8Hn2GVJgA3
        lU1rQZCIw+spBEj0r8J+bS2ipsns3Y/cZP9FQOqNTw==
X-Google-Smtp-Source: AK7set/ciBNiEBP0CiIy5i+btLQY0D92zzz0gwoYZYEZs0myOJXaIQEqBAz/mNtne8bob6i5oJYojtdtlEmDw9U92cM=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr1098028ybd.24.1674826166163; Fri, 27
 Jan 2023 05:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org> <20230127093217.60818-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127093217.60818-4-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:29:14 +0100
Message-ID: <CACRpkdbOZLhQ1DTNJowNXF=O-Nvpqcb_A+PwkPWFiUSQUbkR9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: serial: restrict possible child node names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
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

On Fri, Jan 27, 2023 at 10:32 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The re-usable serial.yaml schema matches every property with ".*"
> pattern, thus any other schema referencing it will not report unknown
> (unevaluated) properties.  This hides several wrong properties.  It is
> a limitation of dtschema, thus provide a simple workaround: expect
> children to be only of few names matching upstream usage (Bluetooth,
> GNSS, GPS and MCU).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Fair enough,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

However I think V.35 WAN devices (high speed serial network links)
should actually be using this? They are just some fancy serial port
after all. Cf
Documentation/devicetree/bindings/net/intel,ixp4xx-hss.yaml

No big deal I guess since they are mostly an anarchronism and not
on the table right now.

Yours,
Linus Walleij
