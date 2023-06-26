Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2873E22E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjFZOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:32:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91044E74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:32:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-312826ffedbso3876104f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687789961; x=1690381961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xifpWCjzQTN6wRfQL9oeo1fgrnPC7xl+aGU5N4Yu6A=;
        b=RVPxNZgu36KUFT5H8FgT+jHwoc06ROYIC9YqiemtZ5d40LXR39skaMUiMgV4EA768/
         ADZ/bbDHZ5XvnvKFxBJzae9FuiIsNGxKe8fmFnOK1Dzh0TArvqizeXoNF9u4+302W6ba
         0VxjXyUzgcKCnJGjgQ/nv8cNE1odKGCUPryU92WObg86FpOId32kNMIdaTbvY+nsyWYK
         XI1cseZM2C26APa4YnVVN5WfVCVxOWBLkGUtHBCQlUqL/OtJpQCEc3hUQUPe+Q+pHKfL
         34npT3MEvrsNBE2pmyQCTio1783XIupfVLOmnsRvbn1N9XppwGfgNhttduphLK9KFHf3
         LDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789961; x=1690381961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xifpWCjzQTN6wRfQL9oeo1fgrnPC7xl+aGU5N4Yu6A=;
        b=fDWXdo0fDMVHQP0kIB9E2DFU26QwkBLtQjm3eNKVst2Fqhyblh3XnUgELSFji5IG64
         +fOu8P0SFExUSHamuhWGjUCbRxddX5/Pszt8UtdkSXSkizRxK7tKEW6aGPXFSiZ89N3H
         QaooEVsdlV/qWH7HXpW+aGjSWJYutOO9Cmo+zPLiNxweN2Jsb7ft3cwbX1r+BQV3QWzS
         hsD1cWqewjtTI9xjxx1rnTkgxhcDj9MsA1UXNw5ULuYFmUcRahx411orBlGEZb0MA/1h
         FT3DUNnQlKgEGdR54o5eYUx7h6SJD5ef1JUB454bkUothNVpvX50JbvLqiXuAqeN6p+w
         xRuQ==
X-Gm-Message-State: AC+VfDxPCRy8DvrlvAASGiaGljuvD1zv46UTGCHtrTKgF0rWv+w3dHB3
        2XYKCwAIOb+7V+qwr2cAlevg7nedKqvX/KkBP4vvbg==
X-Google-Smtp-Source: ACHHUZ4IgqEOhodScx0AEA+jCLvvL6P5B9+0OYCeO04Najnk8I35USY/Zjm7Rv0b4Mem2ps/tw2L8geqfmafNkXiry0=
X-Received: by 2002:adf:e98c:0:b0:313:ed13:38d1 with SMTP id
 h12-20020adfe98c000000b00313ed1338d1mr3990360wrm.25.1687789960902; Mon, 26
 Jun 2023 07:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
 <20230623095547.51881-2-alexghiti@rivosinc.com> <87o7l6mgxg.fsf@meer.lwn.net>
 <CAHVXubhk2xf59XbNiRYKdr4J1yadpeX0KMgW1cFMR4GRN97MYA@mail.gmail.com> <877crrl1jm.fsf@meer.lwn.net>
In-Reply-To: <877crrl1jm.fsf@meer.lwn.net>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 26 Jun 2023 16:32:30 +0200
Message-ID: <CAHVXubit1pun1r-TC48TxR0esfDo49=PYFE+c10HBKqQ=AnZxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Documentation: riscv: Add early boot document
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
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

On Sun, Jun 25, 2023 at 10:39=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
> >> Please don't use :c:func:.  If you just write setup_vm(), all the righ=
t
> >> magic will happen.
> >
> > The magic indeed happens with virt_to_phys()/phys_to_virt(), but not
> > with setup_vm(): is there something we should do when declaring those
> > functions?
>
> If the function in question has no kerneldoc comment, there will be
> nothing to make the magic link to.  In other words, if you want it to
> link to the documentation, the documentation needs to actually exist :)

Ok, that's for another patchset then, thanks for your help!

>
> Thanks,
>
> jon
