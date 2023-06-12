Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8BD72C7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbjFLOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbjFLOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECDE1709;
        Mon, 12 Jun 2023 07:14:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b2e1023f30so1363691a34.1;
        Mon, 12 Jun 2023 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579243; x=1689171243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuzmliRM3Z6qQlxotmDo0oeWU8xNbS6I5a97pZAhtyE=;
        b=M7WfC4yCwJ2YDGJJkD823r9fRUt+8aurr+lqzVcujSa3THtOwVpEsauT2ReCI3vaxB
         UzjRvgiCpxx//v8/4/1K3hioZ6pIZJgzdbc4RgMxLyxFxlbrlxxuBsE5nw98I5v8IAOw
         dFSUMAMR2bZA8DxUDhkrgn0RoHpyX/qzMPJaY2pJZSr3iy6nC/F5pnOW+O2Op9tmqw5N
         lgyjDD78zDLCkiJe3AfEiWea934oy4EP7n9HvcfcGQin3Iq6w33c1kcGR2ZUUVwxxBlO
         WFxGwcBmXX1I5hNli8luDPTegSvRPAa7nCsb4QA9k+nl0ZG0ZuzIu6cOMYOZvyipMcpQ
         4R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579243; x=1689171243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuzmliRM3Z6qQlxotmDo0oeWU8xNbS6I5a97pZAhtyE=;
        b=U39Dtib0TXn8BYPlkEDhpPMINzH73bXYgVa/597B+jAq+WvBpVH3tl7Ek3FaGzKzK1
         dABhicvl2YhiufWjxOVSaElVSTSRyHElpL4NTkw+v25E7ENXBGjEZJDQhxsNK6aTpagE
         Bl+5Sv7K/mikdztC72ZZC1ZLCgyFIwGVBORAmjEaJNDXNX+PUYQcbimaEzpEE0w0gITP
         yuXzywZdjGa0Jqbph4hjTM1sNE1yGZCY+cqZpYE+Cq1PQRESjZN0AfXF+3T741t8AJJe
         BMi6CwDrK6bhhlmm9UnpCR4rqzm8hCwhcN3gnVUqFUPHUj7o+9CvD4ZnV6k9EnreNauI
         iR6A==
X-Gm-Message-State: AC+VfDzoSZGNNghYm1L//RCno0NHy30/5dM2jcx1w+FX2gi658H+y+5o
        iQH/ODbVTy99M8vQZcmLn9qzcPR0uF1jBTVv/2Q=
X-Google-Smtp-Source: ACHHUZ6GDjRB6a7GeZmGws/Bjkr9EkSN//3dhbcM8V2dDNq7CI1HSltpWh9yz2Kq73NpxUogHj4+EvOYTQJkwZpySUQ=
X-Received: by 2002:a05:6808:1a10:b0:39c:6a30:cc7f with SMTP id
 bk16-20020a0568081a1000b0039c6a30cc7fmr5331405oib.21.1686579241636; Mon, 12
 Jun 2023 07:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com>
 <20230612122926.107333-8-herve.codina@bootlin.com> <CAHp75Ve8BVO50TqhUV9YWkRBvYARNOAapZ21X=FehaBBfcC2jw@mail.gmail.com>
In-Reply-To: <CAHp75Ve8BVO50TqhUV9YWkRBvYARNOAapZ21X=FehaBBfcC2jw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:13:25 +0300
Message-ID: <CAHp75VcrXhwa19yg328L9vAhCB3vzk4Dy--fEpWd9qZR7oZ-AA@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] iio: inkern: Use max_array() to get the maximum
 value from an array
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Mon, Jun 12, 2023 at 5:12=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootli=
n.com> wrote:

...

> >  #include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> > +#include <linux/minmax.h>

But can you try to preserve order (to some extent, perhaps invisible
here context is even better, I would assume mutex was added
unordered)?

> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/iio-opaque.h>

--=20
With Best Regards,
Andy Shevchenko
