Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC6681E45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjA3WnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3WnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:43:05 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286641814B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:43:03 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-50660e2d2ffso180832207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TZHpce+LkRMQa6vx6q9obcgDlv0XoFb3aljOsKv7qU=;
        b=nCBrIiE+L+vdLXic+BhlJTEfwEv/ysg8qF3ePyjPsY/A6pPFUyJ9yxWfviS5IS9XZ+
         aTkrqx4WuQWd2ry/CmUYytg0ONmjJ++XzlyAcGDLyhrZ4/IX03EskCTili/5UQq5yKge
         +e1rwxjmS0vI2LeI41+8f4VGz+I/dUip0S2eGn72UYX+dBh2W8CPEuyvYqHBwUzQTY52
         5vUM6PPZirJQEM/wFGgVbRt8dqUJz0ZaVONsNu44LnLGVX5dLOGLew5RenS7kd33ruoM
         AeG1hFJb4M2UAk+s92c6xRoPBpxkWpcN0CqUVNQ0xsATgHZATATevhE+7nH+bY+9BJXI
         PhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TZHpce+LkRMQa6vx6q9obcgDlv0XoFb3aljOsKv7qU=;
        b=qiaTlpC1ynAcLJAdVsiaL3iyRjxlRdx0Scqkg5ct5iBndH8OzbjmAp31xM1M0mmJ+o
         2awLksQSEV8I7yCqktqkCo3GRp6SeD7pIKL9rLEb483qj5bviYzEP6KDpUJ0Q96m2zzn
         JeWioJM02Q/q6APlNDbqRvL27gHB1rXuedQ3SsuRlWPIN4sLLHVBohDaYocrFbEmBMPE
         i31Ud4T1caZWtw4A3WQMYD0giGJydhzaVZ3seTgtuOLOskzH4jP6izPFDVkDjEHDHszZ
         jmwSFPTVFgdA0v/yfRg9c9f99DnIrVu4olXBJcv4pYEi/j6Ewo7kaqcEXjem7CdEF9ST
         Spxg==
X-Gm-Message-State: AFqh2koxf+qLHUx78cVVsZCYdfpNSJJgkeC+tUGzEh4znoHaygzzYFFV
        a5Ij3p6AYgSHIV3PAYQVwX8T1vSfQjU7Zxim6pxf5Q==
X-Google-Smtp-Source: AMrXdXtQIx/gOYQWR7Z9y8qC4zSuzlnGWFfiiT/LekYqnnNUbvQG32KG8P3YQVm2xu2If9pxmW9DcUUds+3TfNO/91s=
X-Received: by 2002:a05:690c:39b:b0:4f3:8d0e:edce with SMTP id
 bh27-20020a05690c039b00b004f38d0eedcemr4580998ywb.185.1675118582401; Mon, 30
 Jan 2023 14:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-4-krzysztof.kozlowski@linaro.org> <CACRpkdbOZLhQ1DTNJowNXF=O-Nvpqcb_A+PwkPWFiUSQUbkR9A@mail.gmail.com>
 <755d4a78-0b23-a381-c422-d12b0063f06f@linaro.org>
In-Reply-To: <755d4a78-0b23-a381-c422-d12b0063f06f@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 23:42:51 +0100
Message-ID: <CACRpkdZWqea+RT75g5CkCzT9zMOj419GMJeydgpZGSLvC9Xoog@mail.gmail.com>
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

On Sun, Jan 29, 2023 at 4:48 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/01/2023 14:29, Linus Walleij wrote:
> > On Fri, Jan 27, 2023 at 10:32 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >
> >> The re-usable serial.yaml schema matches every property with ".*"
> >> pattern, thus any other schema referencing it will not report unknown
> >> (unevaluated) properties.  This hides several wrong properties.  It is
> >> a limitation of dtschema, thus provide a simple workaround: expect
> >> children to be only of few names matching upstream usage (Bluetooth,
> >> GNSS, GPS and MCU).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Fair enough,
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > However I think V.35 WAN devices (high speed serial network links)
> > should actually be using this? They are just some fancy serial port
> > after all. Cf
> > Documentation/devicetree/bindings/net/intel,ixp4xx-hss.yaml
> >
> > No big deal I guess since they are mostly an anarchronism and not
> > on the table right now.
>
> intel,ixp4xx-hss is not part of the expansion bus node.

True, my point is that WAN V.35 devices in general should be,
so that the pattern properties should include wan.

But we can add it later if a user appears.

Yours,
Linus Walleij
