Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A725FF130
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJNPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJNPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:22:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479EB7F64;
        Fri, 14 Oct 2022 08:21:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n73so4109978iod.13;
        Fri, 14 Oct 2022 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCDNypmMNoD4rk1iAOBzVd/TrsABOXumr1g5KMaJ5tM=;
        b=b3Liv8cfA/cYjf+fCQ6tUzRam9M5BsPpGTBn2BiJp2CL4wl1Zs9jHNpxnJNqp+uL0o
         XJOC1WHsKP2k6jqJ5R4bIymSZ5sHkm84jEefRo/0ZJ8PKBlZ5rXuSVXGFzZh4vzd7a3d
         qilY6nK9jxBwvNvFlecrfn7X922DFIQAHsWb4ER83L/kPlx7mQVLWcOsgk+nPdpXRq5z
         jBwYut4T8h6LGrA2KUUbb81wjGO9FtX2f0glNDBWZzJoGpWLmf+1CUfcMuPjpRkbt+aq
         Wy9G07fi1syzFM9ysbvi/9zEPC6TNlkQ8h1PMjRMka8lWSH7unnv7e4Y3k6A9pX2yPxy
         /TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCDNypmMNoD4rk1iAOBzVd/TrsABOXumr1g5KMaJ5tM=;
        b=RtpeNGzcJ43xptgO4IrQMTDk7dBcxlnMwxNTc8N/xSnRUgd+WrW3wz09b1/5WLI0rB
         JXwYzmSJKz3iDjYTTM8mXTLbzaeWC5C1M/NItdgteZdjzFzTPVIemEeDH19MeLkXK+w2
         eqR2cIcx1F6d9PNw/1P1jiWH5z4FjtQblW/KgKq7pZNAqgsq9QAafQLl+9tpY6mT+ui9
         IcJ1Z2zpXxSG0elyiSi+QXRnpeCdRhD83QiqkJFN2YoeI6ERCbXgFIPaIglryoX191Ti
         cfIPDsh8XeHP+XBtSXTakurHcVJJgc6Q0D2JqWCwf6pZwxAzhWS198vmOiskOgrYbYuY
         0QQA==
X-Gm-Message-State: ACrzQf17IVjtD6zBM/9q0gB74tvBUGEMYPLWsjIn01+wQEeZmH/UsZQ4
        Jr4jlGVJJeJ7YY77OqG7TVV6nbjuRx9IdB6UugQ=
X-Google-Smtp-Source: AMsMyM4+Fy6nl+lahIwtdrltwhSd/oNKs4pqSaib3jRIj+2LJxp7D3K7ZCAidFt1h4WSU6xs530VTWfR1wmDVyi9AsM=
X-Received: by 2002:a05:6602:1509:b0:69b:35ba:4720 with SMTP id
 g9-20020a056602150900b0069b35ba4720mr2513530iow.155.1665760876706; Fri, 14
 Oct 2022 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com> <20221014142454.871196-2-carlos.bilbao@amd.com>
In-Reply-To: <20221014142454.871196-2-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 17:21:05 +0200
Message-ID: <CANiq72=DuRw_0AiC7LtWA7n_0Rpsz3cExXj4YX4zu4o8RxugJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

Since you Cc'd me, I guess I can give a quick review. :)

On Fri, Oct 14, 2022 at 4:40 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote=
:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Traducci=C3=B3n al espa=C3=B1ol
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think these should be as long as the title.

> +La propagaci=C3=B3n simultanea de la traducci=C3=B3n de una modificaci=
=C3=B3n en

"simult=C3=A1nea"

> +est=C3=A9 actualizada con las ultimas modificaciones. Si lo que lee en u=
na

"=C3=BAltimas"

> +Una traducci=C3=B3n no es una * bifurcaci=C3=B3n * de la documentaci=C3=
=B3n oficial, por

I am not sure if the spaces are needed.

> +ejemplo, nuevas traducciones, actualizaciones, correcciones).

"...", "etc." or "o"/"y" before  "correcciones"?

> +Las traducciones tratan de ser lo m=C3=A1s precisas posible pero no es p=
osible
> +convertir directamente un idioma a otro. Cada idioma tiene su propia
> +gram=C3=A1tica, y una cultura tras ella, por lo tanto, la traducci=C3=B3=
n de una
> +oraci=C3=B3n al ingl=C3=A9s se podr=C3=ADa modificar para adaptarlo al e=
spa=C3=B1ol. Por esta

"adaptarla"? (if you are referring to "la traducci=C3=B3n" or "una oraci=C3=
=B3n")

> +la forma, pero todav=C3=ADa transmiten el mensaje original. A pesar de l=
a gran
> +difusi=C3=B3n del ingl=C3=A9s en el idioma hablado, cuando sea posible, =
expresiones
> +en ingl=C3=A9s ser=C3=A1n reemplazadas por las palabras correspondientes=
 en espa=C3=B1ol.

I think the sentence wants to say it is common (in the community?) to
use English, but terms will be translated where possible. However, I
am not sure what "en el idioma hablado" means here.

Also, was this based on the English version or another translation?
i.e. this sentence does not seem to be in the English one.

> +sientan mas c=C3=B3modos. En principio, estas peque=C3=B1as diferencias =
no deber=C3=ADan

"m=C3=A1s"

> +La documentaci=C3=B3n del kernel de Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think without the last "de" would be more precise, but I have heard
it this way too.

> +bienvenidas; de modo que, si desea ayudar, =C3=BAnase a la lista de corr=
eo de
> +linux-doc en vger.kernel.org.

Ditto.

Cheers,
Miguel
