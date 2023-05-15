Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014F702ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEONzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbjEONy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:54:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612FE6E;
        Mon, 15 May 2023 06:54:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75773a7bd66so970121685a.1;
        Mon, 15 May 2023 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684158897; x=1686750897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7iUEE3IomJ+ikRUsoHtPetHJ4Aka31Yyf22ym5Ly0M=;
        b=UGBa+D7/Sl3g/ecSCiKAFQhaNSJ3tLTHTCTI9pwNSJl/uGjZEXhvlThxGlWYaS1F7p
         3r7HnGis2uWxfysF4gNENYYMy/ugHI8XJPEzONQ7bjb9uBINsDU5CjIaw41SXUzhKX9o
         ek5ZQYHvVYYtMhK8iuB21dDsnd8fDcIdzNaR7l0J0fJsrwOX9jY8QnMEco1CuZZop3qu
         +F3SuAk0LSFrRN+LwTf/LiNfvtQKLnSfo2Zr+k9njw9RueE3aYhyChOytFu+isl7vgUj
         Q7Nd5/+e10mPFbnDFrnsF4bLKpkk8CdaxJbwMYZdtGqNtaL8DDj6Ry/JtkKGFqTd8Vqu
         oMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684158897; x=1686750897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7iUEE3IomJ+ikRUsoHtPetHJ4Aka31Yyf22ym5Ly0M=;
        b=D2DQx8ZzvRCS+JexcYg18g1/GLBLka+tBIEgiSChWmp1ixUVAuUJJHigz6HdLAa7l5
         h0z24/wQTUeIjTDLdKsNH1F8/1xIFdPPiqYNBk9/D3vEO0bXZVdic0Fn0ZJrOb1UrBLC
         dbkPplUttvQgdL+5yFZAmEfI2o69Rq6myrHTqzX1NkVCEpzmz+Xoh8yQwFLKI8mMWIU0
         LHJN/2tDOOGXmqfrn0Rjo/OFM3k+H/g+K7/fi6mYd413szIn1SHhGamdgmSIlJaGcVVe
         7Cj4QpDoBq5V56R4ht/LLeNifcLRhdC5lgtXCAup4LLhfWAB2rvTM6NKdC13GVgVxUdz
         b/yQ==
X-Gm-Message-State: AC+VfDxYV4a229kNELb2jvMp+e9/laLPPPfP3p29BOlfZ3ltpho9FTD0
        NXovb+nyWO+BMikfOr65zLyrmn+shz5SLVemYuke2BvXVhA=
X-Google-Smtp-Source: ACHHUZ56WsJaI7Cbkjo81KnAqvlpaNUjs70qdGndrszxo6sIjHdABUI7K4yxOBWQlAA1vW7wWpM+HEPfCjBzBcYpzlQ=
X-Received: by 2002:a05:6214:509c:b0:5e0:7ecb:8ffa with SMTP id
 kk28-20020a056214509c00b005e07ecb8ffamr48753692qvb.1.1684158897598; Mon, 15
 May 2023 06:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230426071045.20753-1-zhuyinbo@loongson.cn> <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFkPZhF8QqScXAmH@surfacebook> <049c871d-c658-24c1-91e6-701098f5fc28@loongson.cn>
 <16913b76-0256-492a-ec90-d367f2b52cc3@loongson.cn> <ZGH4SPsu40Mt-Z8f@surfacebook>
 <109a8453-2172-a2ee-8672-8efb489e3dd9@loongson.cn>
In-Reply-To: <109a8453-2172-a2ee-8672-8efb489e3dd9@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 May 2023 16:54:21 +0300
Message-ID: <CAHp75VemyP8-yBS494zQLiQqnH+SPPjxVsrn1J-Rbj9=SqRm1g@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi controller
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Mon, May 15, 2023 at 3:01=E2=80=AFPM zhuyinbo <zhuyinbo@loongson.cn> wro=
te:
> =E5=9C=A8 2023/5/15 =E4=B8=8B=E5=8D=885:15, andy.shevchenko@gmail.com =E5=
=86=99=E9=81=93:
> > Mon, May 15, 2023 at 04:14:00PM +0800, zhuyinbo kirjoitti:
> >> =E5=9C=A8 2023/5/11 =E4=B8=8B=E5=8D=883:18, zhuyinbo =E5=86=99=E9=81=
=93:
> >>> =E5=9C=A8 2023/5/8 =E4=B8=8B=E5=8D=8811:04, andy.shevchenko@gmail.com=
 =E5=86=99=E9=81=93:

...

> >>>>> +config SPI_LOONGSON_CORE
> >>>>> +    tristate "Loongson SPI Controller Core Driver Support"
> >>>>
> >>>> Does it need to be visible to the user?
> >>
> >> I try to set it invisible that by removing the SPI_LOONGSON_CORE Kconf=
ig
> >> or removing "tristate "Loongson SPI Controller Core Driver Support" th=
at
> >> will cause spi-core driver doesn't be compiled or compiled fail issue,
> >> so I will still set it visible to the user.
> >
> > Making a symbol selectable only can be achieved by removing the descrip=
tion
> > (near to tristate directive), have you tried that?
>
> Is it like this ?

Yes.

--=20
With Best Regards,
Andy Shevchenko
