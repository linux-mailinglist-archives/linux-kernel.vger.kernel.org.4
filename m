Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464072A0CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjFIRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFIRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB53A89;
        Fri,  9 Jun 2023 10:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545A265A32;
        Fri,  9 Jun 2023 17:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFF3C4339E;
        Fri,  9 Jun 2023 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686330098;
        bh=GhisDNP0xKGx8dJcKdZnge943h22vyo+eQhu7nfZ35w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqlNblg9IneIcVm1V6EWkDGO/PGXI1pBMhBUvqGLQFK2v3HEYyHtM8BmPqFb5eQow
         U9uNDLn9Cjv6v5bW053o/S0bA70GAAfGbkjjdoOBPC5LQu/J+IrLEUAw7YsoRlvsBh
         TRSmOvDya5om1eE47lNil/Hy2mKJdgfTR1GnLXafUzPGe2FFLZW/qBQTObUdGTIR7R
         5v0IJsYC0XIdRMiykQQhukr+LbzGlf/uf4EIJyWkTh40nuBIlnxUlNOL5D5hIzvCxk
         v29sYN8wtfMJ13xS7vKggQTmnRbR3cGfRNbTWTtSxUgp4GGSzlaWKbL4jgcs3agiy0
         G1zIr+EekdV9w==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so22186301fa.3;
        Fri, 09 Jun 2023 10:01:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDwM3EvQyd9YksqZm3RJE8NGOuD94jC+JFuGY07nObQ95ChgDYKq
        obhlAlGnzJMyDkxo2/+JGRFRPkxdYoRRHfHNEw==
X-Google-Smtp-Source: ACHHUZ4J03JLwJf7N3lccrKLGVK9xQF6FlOwMIZBpyBexKFg60td/QrLA6ccUIBjjoXZNgckErhuN4ILbDuKnoGWhS8=
X-Received: by 2002:a2e:978c:0:b0:2b1:ccd1:d3b7 with SMTP id
 y12-20020a2e978c000000b002b1ccd1d3b7mr1397834lji.46.1686330096733; Fri, 09
 Jun 2023 10:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230609143609.209373-1-brgl@bgdev.pl>
In-Reply-To: <20230609143609.209373-1-brgl@bgdev.pl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Jun 2023 11:01:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK77OW3n0PW6zP3FNdmuQHnDp9=wfX4E3ga-VW0_LRHHA@mail.gmail.com>
Message-ID: <CAL_JsqK77OW3n0PW6zP3FNdmuQHnDp9=wfX4E3ga-VW0_LRHHA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: drop assertions for GPIO hog messages
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:36=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> These have now been demoted to debug and are normally hidden. Drop the
> assertions entirely.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/of/unittest.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)

Why is this a separate patch? Don't I get at least 5 days to
review/ack changes in drivers/of/?


Rob
