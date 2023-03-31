Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F46D1E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCaKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCaKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:48:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A981D2C0;
        Fri, 31 Mar 2023 03:48:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e13so9564373ioc.0;
        Fri, 31 Mar 2023 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259681; x=1682851681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53gTPt8VQ/4Gvnr9FAjZvKj8QW8MyiL9p5lRK46Vbpg=;
        b=cDykQG6zQN1kOmUCE4mEeMUDdWK22oSgIrT0IulqoumymiixOHQn+HkOfSBnqkbFmM
         9O2tJJx89o4bd2g2zGiYhkI0ZYkXYoz+EX1FOssnaWRbsIgfaUUG/m2aQIRPCCoTEynk
         QJ7fB4G1gIrNbOKXK1frPQT+siglpgYyCPvkLmPOnVGsQHKhUptf+3+TQetqou8AxRAI
         ibQ84U1ictGxs/FRFRvSlgATvRVfYaDJSPjxWIA3AvQmAXUtIoSClWAUvfBJ5Mi59AKa
         wFgpaF+vbqJZUCMEbWi1PU+Wc9N/1WpnHRn13i6UH5NfacltrnTLV9XZAAFdzFh/Iwuj
         lT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259681; x=1682851681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53gTPt8VQ/4Gvnr9FAjZvKj8QW8MyiL9p5lRK46Vbpg=;
        b=7Qq1ZvdXHD2M2fRf2BLYQRWbVByaAjJxB1U2I/bFlP5sE/iY7j3ObgRBbaLbKVp+T4
         417gCcnVsWYyg/4diaCtEDLCvzMw3VFnbh33Vv7SgHwF2XAJfgsFmckMoDXJvdMgxE3V
         TMWLB8MIuU/6KwhTyWVfpc3Q5Gz87u+9Op5GoUiBIY6Y6QMmoNu2G2hTmHqWaKtB5N4g
         NmK0AalcQJOlJWOyKXw1eZTo+QoqjrKMoOGxMdYdO0ZYUFiiUBXJ8e0Pg1yxqbA/ZYJh
         Plhq816RdKblByNQnlvxQyNR8yKsoGml7gZgfrZy0/MEP7oVibtTsqlv0QUsT4X7zWf8
         4dhg==
X-Gm-Message-State: AAQBX9fiWOIxw/vaNfaes//BgCeoyR9fnz9zfcJQVm5txfqTxADsqS1g
        fHdNYqoJEdtm7Pd3UJUbvmN4gCC0BkfHZWjNTFA=
X-Google-Smtp-Source: AKy350ZtL7vr9o2g770/omLnpYq8CDrreihCksCi2KsRwDpBo8Dx7uLpj0IC5ao3g4zNJvNjshpf+WQ1GAeQruT3vJg=
X-Received: by 2002:a05:6638:4989:b0:3c2:c1c9:8bca with SMTP id
 cv9-20020a056638498900b003c2c1c98bcamr4627126jab.2.1680259680676; Fri, 31 Mar
 2023 03:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <65394572-33ae-4241-8936-0ccc8353d1a2@spud>
In-Reply-To: <65394572-33ae-4241-8936-0ccc8353d1a2@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 11:47:34 +0100
Message-ID: <CA+V-a8u_rc=5Bv--Ong72CDC_CNvt6xfALUWLDYJo36yBUpAqA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

THank you for the review.

On Fri, Mar 31, 2023 at 11:22=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> $subject: t-bindings: cache: r9a07g043f-l2-cache: Add DT binding document=
ation for L2 cache controller
>                              ^^^^^^^^^^^^^^^^^^^
> I assume this should be updated to be ax45mp-foo instead?
>
Agreed, I'll fix this in the next version.

Cheers,
Prabhakar
