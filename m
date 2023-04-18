Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30706E69A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDRQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDRQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:36:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE20B450;
        Tue, 18 Apr 2023 09:36:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dx24so30758529ejb.11;
        Tue, 18 Apr 2023 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681835793; x=1684427793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnHeIqQhcqSjPYjup2fw8CkFsVSZdUVKQ9idL5SwNNQ=;
        b=lxLNotAZUnqMNo2fLitBC0+/A8GBfNQHJXspuNy/BTJV4W/m2eylZeo9EpWO1Cl3gZ
         Kanq0WpjBZ5HE0eagBe9swmFzdWQiNzVV5W2m4yxelkZhQ9zBKp4Pwc3taE8Qz8pivZM
         qLREZHFiOy9P0blgdL2BAjbj204BtjoML+UrsLfxkqqpQJqRFNDOrpfPgRw/dwfY2Kz5
         9O3JDpQ9abjVdIKUlsHORVt8w99hmuvHq0j7toKAleOC5qrCwHaxz7fhV3E6lKYzv9Ly
         /iZ4JF3S6qKrADkU4gHmyPmiDJ6spGhF3rzFE/UQTU/WOEctvOmP0vSUpC2TFk0sbbCd
         mgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835793; x=1684427793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnHeIqQhcqSjPYjup2fw8CkFsVSZdUVKQ9idL5SwNNQ=;
        b=MmGpJCn9WHNDMLLqsZnnWAbjPF9yBv14dcZhJoX8ATEXytizUZT84UsvUtwsTa3f6X
         79/QjrbxlintS7fUCXnF3ulbCfn+N/J+NhSlBS/ggSf2kTVG469WxO1IRzAIp4jncGgl
         70TxAEy713t0l/4uIBsbhNzxeS/gZqsKxrL/PWEfiKSqtnc7xXNIu53xaFA8nk25evpm
         i7XznqTfN4SDAfC+RpOnNT7B23X00ax9DivT9s0DTdlmHAaMbr7S8CvrfXxtvtCMbjYC
         FdtIyjgGxtkHRZdPhLrsV8RUdRkA9aBRmRZJxgA2muSXnGyl2Jpo4RCF8cvMuMtlHJXU
         eVPw==
X-Gm-Message-State: AAQBX9cjWPPe7veynJ/KEwHA+DnQsmECtCVY+pkfY5kSTjsMF/KWG6bt
        aRrPrcYFKwdIpoMSEYaOr+2LCUa1xIojTq76ZB4=
X-Google-Smtp-Source: AKy350bks6DT3dUEl+VkmpiZnYFUxlCSlj2fZPlgrvNmenD3X5DPxZAwU9H/urlkcRvbqZzHSy4EoQ7+QqcLKvWjar8=
X-Received: by 2002:a17:906:6708:b0:94a:99a4:58d7 with SMTP id
 a8-20020a170906670800b0094a99a458d7mr11663701ejp.15.1681835793385; Tue, 18
 Apr 2023 09:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144710.1543139-1-robh@kernel.org> <20230418162500.GC1764573-robh@kernel.org>
In-Reply-To: <20230418162500.GC1764573-robh@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 18 Apr 2023 11:36:22 -0500
Message-ID: <CABb+yY3Y8oZYG1y8zfTCC8g7=T0HQp3G3N_iECudo1gduYpy-A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:25=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Mar 10, 2023 at 08:47:10AM -0600, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties.
> > Convert reading boolean properties to to of_property_read_bool().
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/mailbox/hi6220-mailbox.c | 5 +----
> >  drivers/mailbox/omap-mailbox.c   | 3 +--
> >  2 files changed, 2 insertions(+), 6 deletions(-)
>
> Ping!
>
Pong :)

I don't usually reply back that it looks good and will pick for the
merge window. I just do that. So yes, it is not overlooked.

cheers
