Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07000696420
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjBNNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBNNCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:02:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78C171D;
        Tue, 14 Feb 2023 05:02:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y1so15574059wru.2;
        Tue, 14 Feb 2023 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sBul4mgzs45bE2WzuID5dXHTGBIFUQ/hKqlFkOwGiAc=;
        b=BNlMqkCxB6wVRpny4TkhAV36P3pHCVa75zArBFzcfTykR1B/pSlGuLrUg5yV+S+luX
         Iqd0Eq7e7ruG+Vi2BJxQ9jzD94Q+TsN7yZ4Ghht7bnxAUIRcCzgGRAwdNs6MGKl/alc0
         IkltwGUTsQt8qIzLnt3jEM2WwmwmnKigqNsInawYfgwQlIclRZM7SQWxDPnf/ouomKp9
         Tqe7g3Xyqyu4B2Vr/bpWImqTvQslQQyFjYiXRg9v5h1alwHIr4wyiC6SnM6SW4kRH1vy
         APleaNg9titz/wA4y42tzLJ+pRlAQNdzuRhzP0jL6LKImCa7TE88uhdY5KL7GpeaoYbQ
         LtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBul4mgzs45bE2WzuID5dXHTGBIFUQ/hKqlFkOwGiAc=;
        b=D1OQioK9cY2/ppbN+Ao9mqCsuDA/fGmrErecsbT++/aJ9JzxDSm6KYAP2hIRdu01j0
         WX9OnJmv9+sHeKZPS8kxQyMaI7cnF4/+3pk62zV03ouKJVD9ZXwnzBqbPIPBmBghztg9
         t0X3bWd0OSeQFmfOOLFZkehxFsqmZlE1tIli1xlcT6LaMpygwU/ie2WRsoc4Z3iQVwg9
         ARmhaY55EcgUQwlR1i2iuJldKSNqtihpoHZRpzbmaYZI7NJN4jK1ykMco5OfrgTJnkYR
         A5q7ig+fJfg0QYf7/FcSxTpcIJS7f53nfqYKAo+0dy4KwJotnyBfdPKIYehAeKqxATbe
         FdBQ==
X-Gm-Message-State: AO0yUKVZt12d5Fbytnjk5nSknql37WIRum1AV+1sSXqcG/n1nSJfqOyr
        nrnXPjDUj4dHXoY5VVzu6yk=
X-Google-Smtp-Source: AK7set/5JzZC9z60wMQR6fIFUfEKjuQDAdJ1gaPUmOgHOtcDI3lkfCyOKYhZ/oNcsE8Jtt6Z5kDP0Q==
X-Received: by 2002:a5d:6885:0:b0:2c5:5451:9d7a with SMTP id h5-20020a5d6885000000b002c554519d7amr1847991wru.46.1676379748503;
        Tue, 14 Feb 2023 05:02:28 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5411000000b002c558f58c5bsm4997034wrv.28.2023.02.14.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 05:02:28 -0800 (PST)
Message-ID: <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Feb 2023 14:02:27 +0100
In-Reply-To: <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
         <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

thank you for the quick review!

On Tue, 2023-02-14 at 11:58 +0100, Krzysztof Kozlowski wrote:
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: cirrus,ep9301-i2s
> > +
> > +=C2=A0 '#sound-dai-cells':
> > +=C2=A0=C2=A0=C2=A0 const: 0
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 minItems: 3
>=20
> maxItems instead

reg and clocks are required, I suppose I should include both minItems
and maxItems for both of them?

> > +
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: mclk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sclk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: lrclk
>=20
>=20
> The clk suffixes are quite redundant. Don't these inputs have some
> meaningful name?

They are actually meaningful, as they are usually named in I2S, please
refer to the EP93xx User's Guide:
https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
page 71, for instance.

--=20
Alexander Sverdlin.

