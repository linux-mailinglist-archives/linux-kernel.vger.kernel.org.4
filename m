Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180D70F15F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbjEXIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbjEXIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9918D;
        Wed, 24 May 2023 01:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8719663B0D;
        Wed, 24 May 2023 08:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE400C433EF;
        Wed, 24 May 2023 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684918100;
        bh=KpjFPbvFSlimb9DAWRgMaEI2jvOp9NyA89GNu7e4BY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=es/VwHVqsLur6WIp9leg0DG2PHZH82FJQLXe4vwZjMOwFkc4J4WljkFO1rk0ubqui
         U2hskEoeGmhEmKnUV4wOsJuJZWTJzyN5fm6rPkktSGC1QHabMlAw3D32kCJlaEn0Sa
         +5RxlOZRzyJvU8hugMxyI9Opi7c0RoPb+8gSoTVG6vEII12Z2f/ApSSlTcQc1EWUz5
         8lFf/jbMnpfDuJVHWDWosMna5JC0nVYO65PK3XxtdoB4079MespPQNmj9gcaMDHoNg
         Sr0eaLG7YbatumBu9CyCSNNpsftZ7wFEx1JkjtfnIc6bqfJMUMfTGnFJXi15T5BP51
         +m/Bbvn61UwqQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5523bd97c64so3646863eaf.0;
        Wed, 24 May 2023 01:48:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDyApT2wUWhyAA4LcIt8tlxMVNVPaFBhTXr6awI5LHmzA+0p1KO2
        P1qmgHHOZy3lsX5crun1Q5K3UERrr8fTQUPqLU4=
X-Google-Smtp-Source: ACHHUZ4ZU7eeRyrC+6EILQ9/5BEfv306QfM/OBd/JWy60IPMJtRWvVOjhiiwd3pOr7t3XzKsWVm6EELrEZPuCunjp34=
X-Received: by 2002:a4a:d24d:0:b0:541:87fe:5b75 with SMTP id
 e13-20020a4ad24d000000b0054187fe5b75mr8497737oos.1.1684918099244; Wed, 24 May
 2023 01:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230511043852.25803-1-bagasdotme@gmail.com> <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
 <1955521c-b3eb-d084-71c8-31db72753932@gmail.com>
In-Reply-To: <1955521c-b3eb-d084-71c8-31db72753932@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 May 2023 17:47:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATG=XFvUh-gLNpYyncU47-7mRahze3LBLzQKk=2zSZ02A@mail.gmail.com>
Message-ID: <CAK7LNATG=XFvUh-gLNpYyncU47-7mRahze3LBLzQKk=2zSZ02A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: module-signing: Mention
 default_x509.genkey template
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
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

On Wed, May 24, 2023 at 11:40=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On 5/11/23 23:55, Masahiro Yamada wrote:
> > On Thu, May 11, 2023 at 1:39=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
> >>
> >> Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
> >> adds default x509 keypair config file template, but forgets to mention
> >> it in kernel module signing documentation.
> >
> > What did it forget?
> >
>
> I mean not mentioning the template.


f3a2ba44e93e2c192a872f2705fe66dbf39708d6
is equivalent to what Makefile previously did.


You could manually copy certs/default_x509.genkey
if you like, but you do not need to.





>
> --
> An old man doll... just what I always wanted! - Clara
>


--=20
Best Regards
Masahiro Yamada
