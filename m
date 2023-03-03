Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE16A90B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCCGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:03:55 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68074158A1;
        Thu,  2 Mar 2023 22:03:54 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bk32so1007901oib.10;
        Thu, 02 Mar 2023 22:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ2aViFV8G5fD3sj6zvP1zwzM+rkvacAu8VneaLs+F0=;
        b=MPIeoVXSgZQNc49dEdm+5PyxfuyNRWHFy6hY3TPROVGUTnXybd0lj8Feor6Dn14i2I
         DTjAJyXWKQ7LK/dRZ95078fw6kSk2XPI48BkUnUyDsNkC37GQ71FarEh+iKd29Aeu3Dq
         /84zs9wM7/QI4C/5Wirt0SD4iaVkvG9Nu1wD+NUZACxFLqwkx2ECxQX1+xK/uOG8K7+o
         gC/68ag2oH6pq3iqbFkKwhaYTDnFSiCqYhPuBuqPRKQ21tWM4mYP8P7eYUUU8URN2w0w
         iXUKb1GnLiEZzGCR/FXRWm3kONerrmdEYzZT9QD+qyG7OJPJQ/GOptdYbTBJhytkGMfE
         2jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ2aViFV8G5fD3sj6zvP1zwzM+rkvacAu8VneaLs+F0=;
        b=5h/1KYrrWQCCFPnou8E16AHAAJVQqq3c8B22wAf/N4sfdVDUfmLwcZcWj/+g0J1zYc
         vwmUG5zTN2VugBmbeltQsAgEZ7KlAFaZH9qaRn7O7kli56uLwm2XDNbitLlLi29budcs
         TGsGRFTwcXvrVLnOwkKO5DZdL1NYu34RbK7HUVIhdVP2WMtm5GFgWeTrkiyK7GWhVU11
         i0mlhV2F8GrcZXqmi6iovKQq00uMojUfBiQkemTHh7z5ZPqndTwv4TRdZ5HvkGiRQ+sF
         W/eTg8JhfX6XhGLjAHgGjc+9fCRgJZtULcPnA7+J0q5scv1C/8nrbq3nKsdJOkEEMQ8c
         4/+g==
X-Gm-Message-State: AO0yUKXTGgTwqgW3JP2ibT4fzRMgpf4ALaW3dLFmsE8lBjnVpayNbeN7
        NeGhD/oiDALeRoJM+0VVwvOYuV1IXWuptwdDDhk=
X-Google-Smtp-Source: AK7set8YxDCWPYK7rU1INZGaYhKhWrHNXMzEGlkkj1ToCKsyEYhRAP7UvN+4lrZyv7g91f2zNpmwjk+BtkPXi5r4J8s=
X-Received: by 2002:aca:1c0b:0:b0:384:2a27:8567 with SMTP id
 c11-20020aca1c0b000000b003842a278567mr198832oic.2.1677823433805; Thu, 02 Mar
 2023 22:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-5-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-5-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:03:41 +0100
Message-ID: <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com>
Subject: Re: [PATCH 04/20] pinctrl: ralink: mt7620: split out to mt76x8
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Split the driver out to pinctrl-mt76x8.c. Remove including the unnecessar=
y
> headers since is_mt76x8() is not being used anymore.
>
> Introduce a new compatible string to be able to document the pin muxing
> information properly.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/ralink/Kconfig          |   5 +
>  drivers/pinctrl/ralink/Makefile         |   1 +
>  drivers/pinctrl/ralink/pinctrl-mt7620.c | 257 +--------------------
>  drivers/pinctrl/ralink/pinctrl-mt76x8.c | 283 ++++++++++++++++++++++++
>  4 files changed, 290 insertions(+), 256 deletions(-)
>  create mode 100644 drivers/pinctrl/ralink/pinctrl-mt76x8.c
