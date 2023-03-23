Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC26C60AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCWH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCWH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:26:44 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200142A6D4;
        Thu, 23 Mar 2023 00:26:39 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id p2so14400690uap.1;
        Thu, 23 Mar 2023 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679556398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUr7UlmILRgh4VkDyJhvzyGiCN05Tdk3CvIGmMn53WU=;
        b=dokpldw5YicRunbxbz9n1vnZnHu8nID4b2NRJD3Ef03uzRcd+VlHQq8xaUdrRh4EjL
         lEF/pFcMCD63rDZYB1ccg8/pS8+PxQ79gRRbS83lKJCCNxSfD8+63kEKJc9BTIzqZsvi
         xbXz3sOElT/O5iXAPTqWydUL+fAj7E068MXKT53RwS8drOEouepsIzIlJ+lp4+wuw3pq
         kD3JonNIAaldonwGiEksD3r3On12CSN1aGq6NcPSPpX9Eu0UeGCFPPvVETqR+CUlztJE
         eqF95IuDY5hvRd1J+MnX2UzrzLxgoi6msETXGsrRbhIxgqXpwq6A+OgjvjOrreK6IaiJ
         IE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUr7UlmILRgh4VkDyJhvzyGiCN05Tdk3CvIGmMn53WU=;
        b=24uGl6mDseDrKp2kdIFRq6eQu/PkriBMeAVHBzj94nuPjFSWKFHAFC28LBv9RKwrcQ
         jaJ5JfvfYy+5kwkyK7byREgYPpTiCBg5JRIKc0WtTQa/6AKbIgCe5xpb0TuPhwnIWdKR
         YyDYH4H8a7tmJSxE+Cz85CULAg2LSB0/le1aHRkUk0pwMlDxSGiEaM8BAPBIacx01zX4
         WNpzk4Gjck23NDcNYYMOtctRjFdmAyMTuJxOMOlwlltKL+eI06bl8o4++4Af2JylrQhg
         b0ok+JaMNweWwBUfU5ObciexoglXX2HH4R605kzoFwdfAsHnwChBEC3iLPW5seDLcbd+
         0Unw==
X-Gm-Message-State: AAQBX9fse3If563JFCPyg2Cg2RPeszyeCNOcGUFO2lTCsgf0R02K0NZH
        VCqYt6WguB3aylepDoOCogBTG8NXXOz1Q1VS+C0=
X-Google-Smtp-Source: AKy350asWDUSxYXtZMZUd3/zjigECR+Iv9x6xfPZpUELYjU28+drtIo0zjSKoy/KxNShgCbmGhn1P96L+GzJBXVAmIg=
X-Received: by 2002:ab0:3c4a:0:b0:68e:2dce:3162 with SMTP id
 u10-20020ab03c4a000000b0068e2dce3162mr5867600uaw.2.1679556398154; Thu, 23 Mar
 2023 00:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
 <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com> <59c05b36-3370-4d7b-b8cc-39d6dc36cdd0@app.fastmail.com>
In-Reply-To: <59c05b36-3370-4d7b-b8cc-39d6dc36cdd0@app.fastmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 23 Mar 2023 08:26:26 +0100
Message-ID: <CABgxDoKMhdhzEpNEC_ciXoa7xeAEbMubapr9b8WvufJdKQqx8w@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi,

After discussion with Daniel, we agree that's an unused and an
orphaned Kconfig symbol (we cannot really argue against it).
We agree to remove it, it will be reverted back for a future patches set.

Acked-by: Romain Perier <romain.perier@gmail.com>

Le mar. 21 mars 2023 =C3=A0 10:30, Arnd Bergmann <arnd@arndb.de> a =C3=A9cr=
it :
>
> On Tue, Mar 21, 2023, at 09:33, Daniel Palmer wrote:
> > Hi Lukas
> >
> > On Tue, 21 Mar 2023 at 12:38, Lukas Bulwahn <lukas.bulwahn@gmail.com> w=
rote:
> >>
> >> Commit 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv=
7
> >> SoCs") adds the config MACH_INFINITY and MACH_MERCURY. The MACH_INFINI=
TY
> >> config is used in the gpio-msc313 driver, but the MACH_MERCURY config =
is
> >> never used to configure anything in the kernel tree.
> >>
> >> Remove the unused config MACH_MERCURY.
> >
> > Because work is still on going to push that stuff.
> >
> > nak from me.
>
> The symbol has been unused three year though, and will
> show up every time someone runs a script to look for
> orphaned Kconfig entries.
>
> I'd still prefer removing it now and only bringing it
> back when you actually add the code for it.
>
>      Arnd
