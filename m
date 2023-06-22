Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CA73A23E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjFVNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFVNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4710CE;
        Thu, 22 Jun 2023 06:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEAC61861;
        Thu, 22 Jun 2023 13:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC87C433C8;
        Thu, 22 Jun 2023 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687442124;
        bh=pqYOp0fAMV0fvGdRk8XPmUStDAC8bSsKwEgZxN0+ydE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMR2QYKjTUseNO18aS0xW0RbmIB/6rMBIV4jSxps+7cBPZMnha1AcFYM3OLdQuVf/
         nZ6APgx/jJd2/BKlyPdFTk0KmAqrd6pCxhpMhjUQY9iqg4IuRxW3lBpldzjybopu2K
         98+q6es09PSqLgUn8R22h0AiRuCbGbWS5x7ntYXoSdRGKw0Z4sGjEcRTzIfjfzU62P
         oYCh+6UvCGwXOvJWfnjOsxhKH0fAQV04gm8lxrdZrmhsT4/xiB17Sk6M69A3EGt9Mf
         u9Q6OyHk6X3JWOlBjTgogFg+yTzrhIz3Pxx/xHIO/hDIfBV+OaI7/GxWqcu+XzuOGW
         x85DviKyjsCLQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b46a06c553so87191371fa.1;
        Thu, 22 Jun 2023 06:55:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDwzWA+qxRb9gY5sa0YYJspMvXPFXlpTcvNjvNkv29o4tnvLZRe7
        4JiKfPlSJiF64zr7HOLqkCykapKFpOGbMVqxSw==
X-Google-Smtp-Source: ACHHUZ7H8P6hxaIXKmZ9Ipo9trtsDWfJFpsYopy5n3W1UI1coggBqqRP5Kv0EImV+65pi9ltrrV/hTRoBka/Hk4LxMg=
X-Received: by 2002:a2e:84d6:0:b0:2b4:94ec:e4 with SMTP id q22-20020a2e84d6000000b002b494ec00e4mr6609402ljh.22.1687442122145;
 Thu, 22 Jun 2023 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230622104810.30055fb1@canb.auug.org.au> <afeb9fad-0d3b-48ac-82da-218dcd8010e7@app.fastmail.com>
In-Reply-To: <afeb9fad-0d3b-48ac-82da-218dcd8010e7@app.fastmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Jun 2023 07:55:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzcqYrbGBU75BQ9jHpOXpn5XyMtxZt0yj-ar2LomkaXA@mail.gmail.com>
Message-ID: <CAL_JsqLzcqYrbGBU75BQ9jHpOXpn5XyMtxZt0yj-ar2LomkaXA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 2:19=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jun 22, 2023, at 02:48, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the arm-soc tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >
> > arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning
> > (spi_bus_reg): /soc/spi@10680/flash@1: SPI bus unit address format
> > error, expected "0"
> >
> > I am not sure why this has only shown up now.
>
> Thanks for the report, I also just ran into the same thing.
> It's probably instroduced by 89e73afc3f540 ("ARM: dts: marvell:
> align SPI NOR node name with dtschema"), but I don't know why
> there was no warning before.

The dts file was not getting built before. It is enabled in commit
86684c2481b6 ("ARM: dts: Add .dts files missing from the build").

Rob
