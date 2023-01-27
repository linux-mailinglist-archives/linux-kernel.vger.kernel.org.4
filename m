Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1167E68F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjA0NZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjA0NZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:25:06 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B647DBFC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:25:04 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id a9so5956907ybb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YfmZdMJN/D3xI4YTB54xIsWSAze0zkG8RrFJPkBL4AQ=;
        b=d2yyXte/yKIliOx/+8dSFRH8+M3Ex72UVdCuqh3m2tyi3rrRYlzuFLuFuOaXo8UJua
         gElqKdzCZZxnNL7BluA63zU1vXbJTTdCGK01yYehPr6WfmZLwmosoPiS95G7b5lmagCS
         L/upqPf5qIY2pjLEDKrUW9EdvBvPWpcC2GegAPRzTI8cGzevNc5TRFXyVw8hHFy7XJzN
         TH3bv0sOG57U6+65n9Xq6fsYWtTWYlZhS/Bzf440xEraF0lC2iKIkZMz3ndkI1DvtaHw
         EQNdQGri5E5aTQGN016ehd0p8PTqoPCqtOXzj5K3ayVZ69ryCa5toREYxDUTePUi+iWo
         LVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfmZdMJN/D3xI4YTB54xIsWSAze0zkG8RrFJPkBL4AQ=;
        b=Mxk8hZpddteqeQ1aT4doPAoX1WsEUHKJ3dHntDN7LF6tjJ748agqz0V6mx9zfiRBez
         v+H/1mQTsA5bsyIPHEHZ9cwCGvnV9UEHcdIUoJBiJlK53xKN1QWo+Gn0s7oJmP+BK4PE
         ssqTsUaPdRQobU6A3wion3FcuzkMdNmlOPTxgHEv2UQ1LNlwKF9oYex9vrhMB1E06e9p
         ql2PeGOlhdc6EkdpeAWpM17X1UxbjGRYOp3tY0du8SeDsJFHonm7/w98ez8+K1hfXRaL
         0L+VXal6uR5/mvEqatff+ijEx3qt/frrbT+9wxb4CR5duKJ81gdzx0B/iNML/Z+wvU3E
         8JFg==
X-Gm-Message-State: AO0yUKXC5VgpLO56lzkM2eydvV6YwDxsdSeH8PRYCdhfWysIenYRNlTC
        TFbofD3opxh6FR3RnbeS3gQzj7OSVU/BOdgME0qufg==
X-Google-Smtp-Source: AK7set/AyCr5YILgHa1njAbv5GENd6K1HRNPT5FGDcIp6NDqNoyOABScAptxZu4MVa9CTfeWH7nQwPnr2nr1FbGyMhU=
X-Received: by 2002:a25:d1d1:0:b0:80b:4d84:b25 with SMTP id
 i200-20020a25d1d1000000b0080b4d840b25mr1325238ybg.584.1674825903381; Fri, 27
 Jan 2023 05:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org> <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:24:52 +0100
Message-ID: <CACRpkdZUD1rw5j=Kik9KMt0w=JzS_T06FOGnyUA9GWmWZyQjcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: reference MC peripheral properties in
 relevant devices
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

> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
>
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
>
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
