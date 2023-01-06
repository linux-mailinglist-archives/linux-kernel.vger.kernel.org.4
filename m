Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43166603C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjAFPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAFPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:55:18 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C165AE3;
        Fri,  6 Jan 2023 07:55:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B56EA1BF211;
        Fri,  6 Jan 2023 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673020513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEq7hIKT0a2IddjeblncUpOT0+Vv9GyxbJZahF32HwQ=;
        b=Sm7g3iYV12qVzkFbT03mayB48DX0Kjowrm5cEiwxhRu+zSEbBSv4kWlNRVrwLixP/h7xmS
        ZYVhROV+6uoYm7/k8JPfGkeiGMVeKagjE62gDCRfWNmH+h6Hidizh/0K/jEtwLrg4aWn6W
        GkMNOp8wou5/bIWym1SOFf/aaQaxbBaf498mzku28JqsiDA2bowdmbTHeXfTA8ja2sl609
        BYG9Meu2YZQayBRTcbth47Q9FMcJ8MdSShl7FRKvrC/24mjjH1+IGflHzEqCldFBbg0uPy
        KOfsqQyp1O5N4sOZvnFASdJKRXelcqr7Rh4sPWzRTwLzcQkPs/KL6sGztEegSw==
Date:   Fri, 6 Jan 2023 16:55:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     arnd@arndb.de, richard@nod.at, krzysztof.kozlowski+dt@linaro.org,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        pratyush@kernel.org, michael@walle.cc,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
Message-ID: <20230106165506.0a34fa78@xps-13>
In-Reply-To: <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
References: <20221226144043.367706-1-tudor.ambarus@linaro.org>
        <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
        <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tudor, hello all,

tudor.ambarus@linaro.org wrote on Fri, 6 Jan 2023 17:45:20 +0200:

> Miquel,
>=20
> Since we don't have an answer from Arnd, would you please queue this to
> mtd/fixes?

Are MAINTAINERS changes accepted through fixes PR? I see a number of
experienced people in Cc:, I would like to hear from you folks, because
I never had to do that before. If yes, then I'll do it right away,
otherwise I'll apply to mtd/next. I'm all ears :)

Cheers,
Miqu=C3=A8l
