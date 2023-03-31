Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E146D2863
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCaTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:03:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D622903
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:03:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g17so30204780lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680289384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Op2hvo1QpmD4q1fBgDvpflzYt4ille90lJOYkm9McQ=;
        b=I9MBLXscoVftIVV9CjCEAHOLc8es0K+E7ZAIKRZSAuC79s8JCWAbcfd1/wUUY2D1HQ
         qqYcbYBp9j38efRMctWg4KhDrinDHH5RMfqVpMBTCL4Pk5KAEY8YYLgbdBmp5lNBd4WX
         WBc1Yn7iuEmqLxYw2OFLb+mQtYK5mlHl0JUwNLCzNVz+0GIhP2VGQ8Kctjbx/6443Naz
         LZCatuF8uyuce31qb7oKNBD0H88jyGp68xeFcevSTSVJbS9mpFdEBMKyuWIBKJiEr2z3
         maWg/ujFK92UZ5pkT8/UrO2C4mPvcUCyo0eGZRpGS2QfuAbUsDWyZRFIM1W4el2h38OR
         Ai8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Op2hvo1QpmD4q1fBgDvpflzYt4ille90lJOYkm9McQ=;
        b=dRvaUukWDx+O0TYOhn0/Ggvb+XOr3KxZd6TRJNncYAF4Nb5LtgzUXSRlnxZeZqZe2d
         kIW7Lu7Pc7pMpekIz+vMrHudfPVr4wuzlSC/vj9ko5BYwff348uj5oJClS8YlOY+Wul5
         QAL1pjWdJqjNSQgiwqt9q3wO3c+cluk9Kz0kOFn7V+AwhElkGcnH5FthrTbEvmSJfzqA
         81CSNyrbJNXW9siRZZfYy6gOKYGY4TH/WV3XsN6ZyArmyve4dgS01XSH63mjc9crhKIE
         82Yw0ciRTKog4qIw3jtlZkigF6ffCS6SztuYuFTGufWHZqVGR3+AuCq1cQtDRzxujHrO
         QnWw==
X-Gm-Message-State: AAQBX9elICrZSQflOUMDoN7OMFxvLMBeHYV5kVpwjTuWj8KUl1/vE3ph
        kmWU0xJcJzO4NRXa5XlUXTyWjca8sv+AR9sBhWRAjg==
X-Google-Smtp-Source: AKy350bg046U6kUEdMKJ47xgMoqU+o1btrNpujCJ6vXB3o551Lu3oiJA8WifEc5bExAewh/oNaLY16yV+c/9sUrBP2Y=
X-Received: by 2002:ac2:4470:0:b0:4eb:304f:66ea with SMTP id
 y16-20020ac24470000000b004eb304f66eamr823973lfl.13.1680289384305; Fri, 31 Mar
 2023 12:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230331182727.4062790-1-evan@rivosinc.com> <25837ca5-b709-4d20-912b-ab13e6353069@spud>
In-Reply-To: <25837ca5-b709-4d20-912b-ab13e6353069@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 31 Mar 2023 12:02:28 -0700
Message-ID: <CALs-Hss-W78x04LS7X_RiTmU19Xv6d3f4x5rgeEhV7TVy7_CEA@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: dts: nezha-d1: Add memory
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, conor.dooley@microchip.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Trevor Woerner <twoerner@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Mar 31, 2023 at 11:27:27AM -0700, Evan Green wrote:
> > Add memory info for the D1 Nezha, which seems to be required for it to
> > boot with the stock firmware. Note that this hardcodes 1GB, which is
> > not technically correct as they also make models with different amounts
> > of RAM.
>
> > Is the firmware supposed to populate this?
>
> Yup. Samuel intentionally did it this way:
> https://lore.kernel.org/linux-riscv/8a2194bf-93bd-de4d-8d39-0cd72aabb0a9@=
sholland.org/
>
> Since I don't like using the firmware provided stuff to more easily
> test I do this in my u-boot boot script:
>
> tftp 0x54000000 d1-fitImage.fit
> bootm start 0x54000000
> bootm loados 0x54000000
> bootm ramdisk;
> bootm prep;
> fdt memory 0x40000000 0x20000000
> bootm go;
>
> Hope either of the above are helpful,
> Conor.

Ah, I see, thanks for the pointers. I've got whatever firmware came
with the "dd and go" Fedora image I found on the internet somewhere,
which doesn't seem to do the memory node population for me. I've been
hesitant to rebuild the firmware as I don't want to break the Fedora
"safe OS", and if there's a way to get mired in some build
environment, I seem to have a nose for finding it.

I'll probably just keep the patch locally in my tree, and if I'm
forced to update the firmware for some other reason I'll try removing
it.

-Evan
