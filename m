Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8374566C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGCHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:51:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7BC5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:51:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-313f61890fbso4581354f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688370668; x=1690962668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fS/IGGRRITwIPRcoIR6LDhq8Lu4B/gXKK5zsRtePeA=;
        b=DdvTlJ+dtiJCsFyLdnYP5xkCkkKypgTEbA86g9KlFE6MNjI6Zg/e77/svNL8AxL7or
         wKSJS1fv9nflviz+nJ2oYa75SLer+3OCd0N6oQleC505bLia+dIz+v3FhxWdBpjB8dLR
         qAl95eI6/+iRfB1kcSTEmL7pbzowOgK6B5et20aP1+9TJKcZnnuZKpRMs83ePEnpF9s5
         UxCJuccPtrOR6KWLWMf6YnYpaRduMh7VfTf86HEuwoREyoKnxBAObyElpRPkRI5I4EPb
         ps13JfoxszIZEG5LNSyruQzCTtAZyzQnlj8XdYSYSpvp9W6OTJ7KC5BQnhxsLqFCG7UF
         6CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370668; x=1690962668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fS/IGGRRITwIPRcoIR6LDhq8Lu4B/gXKK5zsRtePeA=;
        b=W2z1F6S6pUDuVokYl6j+vEsoeYf721XtD1fvVhOY5SekiAALEAy2NZXWDf7JzSI6Re
         61veAecQ5wiMmJ+bAUqS/U6EWeqjwhK606iTdSAfQ6QB1p6afw+pvmxLHAGdI7hYiBBk
         6dTB2N2xN/06FjXZFS3jH5kH9CTZeRlFB1DHCWs4Cte3hftnbeDwYgE7JzLDWvmsaPEe
         8zn9uVA5sYZIhiYSoc6qT3Csdpnb80zRRgdLBEDITK3b+PfFXwr9BpBdnhAurZckCVS8
         Kt0h5hEvj08pJ+Ci97UxAAHgOE0Ifusp2Z5iiLzb1Bfyxr5VHWD/n/J9Q7P9DU7mpscR
         rsvQ==
X-Gm-Message-State: ABy/qLZoMbeURbP556Y4GXcr7HK7jAcutCmaOVKa+XoTRqmi/9+qx97D
        FNr4l1ke5wE4r9nuGECgcHTZIWYE/0U+B3ca82mowA==
X-Google-Smtp-Source: APBJJlH9nqm8zH113ZN2JVzKufZ4X+bFV71Z5uEllOB1mvUR+W7B5XHL4I9sgAPAbxKnG9qHeNCgxwmmvSmgPIWpbBk=
X-Received: by 2002:a5d:4003:0:b0:314:2b0a:dab7 with SMTP id
 n3-20020a5d4003000000b003142b0adab7mr5423229wrp.29.1688370667957; Mon, 03 Jul
 2023 00:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702095735.860-3-cuiyunhui@bytedance.com>
 <20230702-confiding-aqueduct-25c3c2852de3@spud>
In-Reply-To: <20230702-confiding-aqueduct-25c3c2852de3@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 15:50:57 +0800
Message-ID: <CAEEQ3wkaazkV9MrfvWQMSXixtqahgdYVe=GT9ZZJnW-r1AQ1aA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/3] riscv: obtain SMBIOS entry from FFI.
To:     Conor Dooley <conor@kernel.org>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sun, Jul 2, 2023 at 8:42=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> Hey,
>
> On Sun, Jul 02, 2023 at 05:57:34PM +0800, Yunhui Cui wrote:
> > When we bringup with coreboot on riscv, we need to obtain
> > the entry address of SMBIOS through the FFI scheme.
>
> What do you need it for?
RISC-V will be server-oriented, and the system needs to be managed
based on SMBIOS.



> >
> > @@ -34,4 +35,7 @@ void __init ffi_acpi_root_pointer(void)
> >  void __init ffi_init(void)
> >  {
> >       ffi_acpi_root_pointer();
> > +#if CONFIG_FDT_FW_INTERFACE
> > +     ffi_smbios_root_pointer();
> > +#endif
>
> Please stub this function so that we don't need ifdeffery here.
OK, I will update it on V3.

Thanks,
Yunhui
