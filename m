Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6671B73B2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFWIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:33:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8815C6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:33:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3111547c8f9so470439f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687509187; x=1690101187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKQLqzJpGFVYRDo5Vr6CozDDTDNgiseuOdVj/pwVfV8=;
        b=AddP9aW7AEbqndqwe1COoa1xwBCdAhuUqIV4D8voaogXPxJWXDDSrlT26ibX8/6O39
         GYiDhX8/Ci0Dd2A1JTA9ikD1C/RX8NCjXT1jETZbNX2mqEym9PsMWCcn8jfpR+5Jph7C
         QLKLihc6oBdjM/2XN2yi1OBxhUchwcQBV3QRodNvZaaJhX/deW0LBrDwlHmRyWe2jaZc
         PU/inDp4CJMC23GRQ1Pn2BiKnO/QeyksqkeClbFjG4SZpo22fE6H/I4O4A4ZWCw/BvRk
         rx6wBX7EdMGt1K2OxUXZcH0tEdzJis4cRzYoAxZ4iGuUX08GolnYnNGgHI7+ZrXKkZQR
         oVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687509187; x=1690101187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKQLqzJpGFVYRDo5Vr6CozDDTDNgiseuOdVj/pwVfV8=;
        b=PUfFBglOJIL8ZUJ3laCTM7jifhANcqHzmti4NI1Qs+ugJlA07nwknhfEVy6MDJqRLI
         8Ae2vO+irXhO96fBz67QHfUpO0fUrdML8e/b0PZndkLUJsiJW1Q3Wa8be92TtqDzZCgU
         H53baGTH5ygqafb6QYFkM8ugYvEkbufeI2QyRFSBJ+V94qwWN3/HLR8xsXOVe5SBWfFN
         oTtqJNXnyUx9WzUIpkRre7sBKTFlofqiR5XBlG7AvD/pySHTNfHS3wbPc8O0LOG/Uw06
         aR4Yf30bY6Og565SZ8zdRwRAodqSPhJUX/zn0WH4hkwho/Te/I9g14D8PEhD/Viq/R47
         xPDg==
X-Gm-Message-State: AC+VfDzv3zESmPY2kbJg2zycT1Tyvki5khNWifIUsKqD+HF31awQBcGd
        tMjARBTf8YTPgCmuQgw4LpTve74d+qRDooFe+7+Wsg==
X-Google-Smtp-Source: ACHHUZ4WGdBKq4UxGZuZxTybdXrRMaFiJZBAcDlnLcCtF3LnRXSu1s3keBL1C4sworZTbVFtLRsjJ/tTe+wazDAS4uY=
X-Received: by 2002:a5d:45c4:0:b0:311:822:9c51 with SMTP id
 b4-20020a5d45c4000000b0031108229c51mr17887775wrs.43.1687509187023; Fri, 23
 Jun 2023 01:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072234.9900-1-alexghiti@rivosinc.com> <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel> <20230622-4af59422f118ea634836d351@orel>
 <CAHVXubgJQhShbOfaQeOTxM61g_tUnLBxa-0JK+WE+YQRGkYRQA@mail.gmail.com> <20230622-clone-overfed-21ec0886e904@spud>
In-Reply-To: <20230622-clone-overfed-21ec0886e904@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 23 Jun 2023 10:32:56 +0200
Message-ID: <CAHVXubi786NBEg=Wp=7uy5gAA7zkmMTofX4XPdgWRzWJpq6opg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
To:     Conor Dooley <conor@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 7:41=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jun 22, 2023 at 07:32:23PM +0200, Alexandre Ghiti wrote:
> > On Thu, Jun 22, 2023 at 7:24=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Wed, Jun 21, 2023 at 02:19:50PM +0200, Andrew Jones wrote:
> > > > On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> > > ...
> > > > > +Hardware description
> > > > > +--------------------
> > > > > +
> > > > > +The firmware can pass either a devicetree or ACPI tables to the =
RISC-V kernel.
> > > > > +
> > > > > +The devicetree is either passed directly to the kernel from the =
previous stage
> > > > > +using the `$a1` register, or when booting with UEFI, it can be p=
assed using the
> > > > > +EFI configuration table.
> > > > > +
> > > > > +The ACPI tables are passed to the kernel using the EFI configura=
tion table. In
> > > > > +this case, a tiny devicetree is still created by the EFI stub. P=
lease refer to
> > > > > +"EFI stub and devicetree" tree section below for details about t=
his devicetree.
> > > >                              ^ redundant 'tree' here
> > > >
> > >
> > > Can whoever applies this drop this 'tree' I pointed while applying?
> >
> > Yes, sorry: @Conor Dooley give me the overly long lines you wanted me
> > to break and I'll send a v3, it won't take much time and I'll fix this
> > too!
>
> Look, I said it was pure pedantry on my part, and not something that
> helps with understanding. You've been warned!
>
> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> index 019ee818686d..a52793fd9f6c 100644
> --- a/Documentation/riscv/boot.rst
> +++ b/Documentation/riscv/boot.rst
> @@ -143,11 +143,12 @@ be carefully examined.
>  Device-tree mapping via fixmap
>  ------------------------------
>
> -The RISC-V kernel uses the fixmap region to map the devicetree because t=
he
> -devicetree virtual mapping must remain the same between :c:func:`setup_v=
m` and
> -:c:func:`setup_vm_final` calls since the :c:var:`reserved_mem` array is
> -initialized with virtual addresses established by :c:func:`setup_vm` and=
 used
> -with the mapping established by :c:func:`setup_vm_final`.
> +
> +As the :c:var:`reserved_mem` array is initialized with virtual addresses
> +established by :c:func:`setup_vm`, and used with the mapping established=
 by
> +:c:func:`setup_vm_final`, the RISC-V kernel uses the fixmap region to ma=
p the
> +devicetree. This ensures that the same virtual mapping is used by both
> +functions.
>

Oh my, so pedantic...:) I don't like the last sentence though, I'll
change it for:

"This ensures that the devicetree remains accessible by both virtual mappin=
gs."

Thanks!

>  Pre-MMU execution
>  -----------------
