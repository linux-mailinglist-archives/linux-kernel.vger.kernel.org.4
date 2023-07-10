Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7874DCFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGJSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGJSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329EAB;
        Mon, 10 Jul 2023 11:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C421361181;
        Mon, 10 Jul 2023 18:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294D8C433C7;
        Mon, 10 Jul 2023 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689012233;
        bh=6jWr+jA+0JNwfJGO7rMuTRMnUOpHYMJXNBO85uDITqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQsgoUiMLpkyP7vtJuEwEAMo3jCKKGy1US+o+5BaYt/MSKqNLZ/CM5qUqIzUtsyyV
         OQNFweG5QBYir79Liyb5oPFoFoMg3O8QA3XlWRKQfjxaF9VZn5r1NNsRWBs2C8+8H7
         v8HktTDdM7+9gWIlJwzjpBoXTSKyXOMNWE7tFv++0jKN3K8K68xmnNyzrbYiwAthCj
         QJJ3f+ALPYssacJ9DhEli5f5puxP9OmQ/8zRHwVQHrk1B4Xg91d1XhtrDetYGM9gO+
         wjZYFU2l6PLAnCQbkVZWErL9rbekt6CcQ/iUaj0SsW/cu+XueqO6cE3P45BhKwOTBS
         RJcTwii+BGEmQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so78318131fa.1;
        Mon, 10 Jul 2023 11:03:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLawb4UpVUETWCcOKX3s6zQuMTNZt19lkkmFwcIgykNk/sxONxaz
        Bf3bsv2/fzYhMpXnEqPynci/QF+ZHJ1QXiKX2A==
X-Google-Smtp-Source: APBJJlFV86eCbBcABOMtsF7FRn2kX3cRrkY/rjIhBwqAFjzhX7m8M9va+DiWdMEGyh1uipSuuLjcUqWkTHuIPrYkNWI=
X-Received: by 2002:a2e:95d4:0:b0:2b6:d89e:74e2 with SMTP id
 y20-20020a2e95d4000000b002b6d89e74e2mr11255205ljh.7.1689012231160; Mon, 10
 Jul 2023 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210646.868758-1-robh@kernel.org> <20230710-underling-angelfish-c47d363a59f5@spud>
In-Reply-To: <20230710-underling-angelfish-c47d363a59f5@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Jul 2023 12:03:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5mtgCAfFZOZTUjqFLW0DM5A6exD+PbznO71A8SDyyTA@mail.gmail.com>
Message-ID: <CAL_Jsq+5mtgCAfFZOZTUjqFLW0DM5A6exD+PbznO71A8SDyyTA@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT schema
To:     Conor Dooley <conor@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 10, 2023 at 11:57=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Jul 07, 2023 at 03:06:46PM -0600, Rob Herring wrote:
> > Convert the OmniVision OV7251 Image Sensor binding to DT schema format.
> >
> > vddd-supply was listed as required, but the example and actual user
> > don't have it. Also, the data brief says it has an internal regulator,
> > so perhaps it is truly optional.
>
> ov7251.c:
>         ov7251->core_regulator =3D devm_regulator_get(dev, "vddd");
>         if (IS_ERR(ov7251->core_regulator)) {
>                 dev_err(dev, "cannot get core regulator\n");
>                 return PTR_ERR(ov7251->core_regulator);
>         }
>
> Looks like the driver's probe function disagrees?

Doesn't the regulator framework return a dummy regulator if missing?

> I was going to ask how it worked, but the one user has
> status =3D "disabled"...

Saw that too, but figured there's some other include with that
overridden. We should really add a built .dts output target to avoid
trying to manually walk includes.


> /shrug, what's here looks fine to me, whatever Qualcomm person cares
> about the driver can make sure it works for them I guess.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks.

Rob
