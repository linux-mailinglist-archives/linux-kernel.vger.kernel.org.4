Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A26FC1B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEII0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjEIIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:25:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F64E74
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:25:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a829411b5so50617097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620754; x=1686212754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/EQwddc6PAPGkUKNCKLrOJreOJCtQZHVsYzRGthXKE=;
        b=pfVlVMEmbHZghrvSkK47tLT4OqSuw+eFKNNvs26XPpeqoHlctw2ioS9vOAsO+27jpS
         n9b51BJOlU99BYyB+WW+JDrHainWUJe7witEUWR3FtEe7Cy+rAcdg2JYC5vbUec13KXM
         Hs7oVIxczypI7BWyCSCWKu2r0AWuA+8aQLyv4LUJbdomkR5tbgZ/I8M5jEmBHyumUR1w
         ze/KPvW941Nj7tgghleqmXqEH1RuthBipkt5ShJTIhbs4uPf7RjaZ+oQQ6aRuxI+I/+O
         vJNcS+lX5VCe7qfFbsML9bqWaTRup379qK7LJ7mXzulmMx4hfoKpx2POvQksLSWZgkql
         5x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620754; x=1686212754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/EQwddc6PAPGkUKNCKLrOJreOJCtQZHVsYzRGthXKE=;
        b=AhYDxMxrauLryKkOn5z9iuNcOLJ7as7it4GVT3BjHsaw0LjFvoYGCKsHMSRTy/Ew+N
         DIDf91PcRT0MbmfNHH8A+fHJkSB00R2nE8rXQsUNnlTRRE994NhC/zp2giQ6G6DKdX26
         Bne1zDIFWM81DfCLwFmqA9BLvh8A6TofrlxZdv8WlT7xOGc0aiT4Yq5C0wHxCJkkWGRs
         Fpq993Ubhxcqam7UECDvWbWiIONaVhd+QEeThlXEtHfQB0HH1SU2ABJ+widBmB4Cnkzz
         mhXW0SU/2mjyGn4wMZ8d0F+26o6vctMfpi65j1Hz+kfVTObhxadQuc+OertNMkmUTZK4
         +/ow==
X-Gm-Message-State: AC+VfDzYzKLIduWANTOvREV76zq6nqYxWEHfcvg8EerABVDDyz7kCjQG
        FUYbTSQab40meU86vF1ba0qIISjFZAnCs/JxkJqlfQ==
X-Google-Smtp-Source: ACHHUZ4vTBpRnFQytZnTZstDKDR0LNcvD2BqlA9e99vRY3QCy6dBn0Wjl7CPUMhIGmlMKt1Sn59yE0Y9VTJfE+79Qx8=
X-Received: by 2002:a25:d6cc:0:b0:b9e:2aa5:b21b with SMTP id
 n195-20020a25d6cc000000b00b9e2aa5b21bmr15268738ybg.15.1683620754395; Tue, 09
 May 2023 01:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com> <20230427123314.1997152-5-joychakr@google.com>
 <ZFj2QraXvNqBRwqM@finisterre.sirena.org.uk>
In-Reply-To: <ZFj2QraXvNqBRwqM@finisterre.sirena.org.uk>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 9 May 2023 13:55:41 +0530
Message-ID: <CAOSNQF1PAh-Z=smRrqscpdPdEjyE-3Qd9iXVWNBZ2NkPv4M9Wg@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] spi: dw: Add DMA address widths capability check
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 6:46=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Thu, Apr 27, 2023 at 12:33:13PM +0000, Joy Chakraborty wrote:
> > Store address width capabilities of DMA controller during init and chec=
k
> > the same per transfer to make sure the bits/word requirement can be met=
.
> >
> > Current DW DMA driver requires both tx and rx channel to be configured
> > and functional hence a subset of both tx and rx channel address width
> > capability is checked with the width requirement(n_bytes) for a
> > transfer.
>
> This breaks an x86 allmodconfig build:
>
> /build/stage/linux/drivers/spi/spi-dw-dma.c: In function =E2=80=98dw_spi_=
dma_caps_init=E2=80=99:
> /build/stage/linux/drivers/spi/spi-dw-dma.c:100:1: error: control reaches=
 end of non-void function [-Werror=3Dreturn-type]
>   100 | }
>       | ^
> cc1: some warnings being treated as errors

Moving "return 0" at the end of dw_spi_dma_caps_init() from patch
[4/5] to patch [3/5] to solve this and sending a V10 Patch.

Thanks
Joy
