Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204AF6ADCE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCGLLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCGLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:10:38 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C04EC7;
        Tue,  7 Mar 2023 03:07:40 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536bbe5f888so237915527b3.8;
        Tue, 07 Mar 2023 03:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678187260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezWI+YqtGSWosoo4M5sZg2WqWcmUK1NfNwH+n8V7ZCM=;
        b=LuDiyIoNJ4vTfsKW2ge6iUNxEd8mvXODtJaI+szTJxwEO66HxU/s4bmVVK9dcwXnm/
         QWRZVbOXaDFcQX6RimoGoGiKuIIajLYc26PZAdg2UmAFnv/KaKOeURvisNCgZi+ESOA9
         oPUkR4U14jLYUEa/RDk+t3dJMMMJCVlxth1Nko993D9oFNnePQksBikmXx7bPM+WpXOF
         yiUveNKPhjRWZZiWN+G2Ir0L6M7AS3DJJ0NS6Xq6vQDyXHeN2icq9w7ifGGK8wOAfApj
         OLcYmBP0kNbBpEvna/hpD13FRhHyIFOArYIjr9skWceDsiBLwkvUtQIGWRnfH6qZw+1+
         lwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678187260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezWI+YqtGSWosoo4M5sZg2WqWcmUK1NfNwH+n8V7ZCM=;
        b=vPdwsRX4VTkPKGAnvFsOmSSBVwZJRy918AqKHBGRTflTsodOWVAKNEtkNIpZk6zny9
         edlzy5iZpnIY5bvOuVAa6Io9NUrfgNYDesUglp1klJEhCeCbUqEYJBDoqDduwXMUoKJ0
         BkEb7hDf23V7qwx/D8zqc+Cn6A8ZWlQfBcLuCeSvY3EzYSl5CYDptOU0UOUm9Ba+1SRu
         tIVQF9joDlr8SpzCSx979FGlw/CbxAwGfkV98Gd5LT8DpnfWbrxh18AfpGOAXbSg961+
         /+chhS3gS83ciVCK1wnVRfNj9RTlkBk0+meAZwPkhkuI4bpby0r0xcPqR+5xyK0bvpoq
         SnVw==
X-Gm-Message-State: AO0yUKXFK6omXCfnxAJ6ynCnCzLVEMtbBoe8ELWBFXvzZqqUcDjjgUOB
        MqT9z9duh2xdrKmKJMX8roscKecUhViRH3P8q7g=
X-Google-Smtp-Source: AK7set9mt9UYnbLiU961T5A6R3gBGXlq8VmcrLo/C8E0ADEMyOzY+pN/ywBe+SU5kncac16bq8sQPDmSAjiKbFf3Oew=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr8435908ywh.10.1678187259869; Tue, 07
 Mar 2023 03:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
In-Reply-To: <20230307102441.94417-1-conor.dooley@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 12:07:29 +0100
Message-ID: <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, Mar 7, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> I have added SoB's too, but if that is not okay Gary, then please scream
> loudly.

Note that `Co-developed-by`s always go with a `Signed-off-by`s, i.e.
it is not possible to add just a `Co-developed-by`.

By the way, like for the Arm patch set, if you end up doing a v2,
could you please add the `BINDGEN_TARGET_*` in `rust/Makefile` (GCC
builds are really experimental, but since they are there anyway, it is
best to be consistent and add it).

Cheers,
Miguel
