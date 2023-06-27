Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAE740301
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjF0SPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjF0SO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:14:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4253584
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:14:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so3405091e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687889661; x=1690481661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0QHGC18vxO2QHVl3y7SYla7+m+avkHqGb8W6MMkPEM=;
        b=tKmSEzN1MUFr3JgDwykDdV9fxf49FUdmPMJCMp/pE+IqGWeDxE9B2caQO5GppGpcoJ
         iMPDOWikOyl/q7Yb8ZAzj5r3MzMNi8HiDhfDCxIXzOrykSuB9Afm/G5g/vgmIXxaxSnj
         se452nyymxHI2AWS91cvYN3clgF1WZRhn9l4uEI7mIPjXRMccF4omvSmCo8MeZn1oVqz
         OvDtldD183qgXBU8Log9dVDb9iwsOSzBG3KUuA6oPN6smKDFen8WWfIlu/ZethCG2uVU
         VrRZUVljz2LRfZ+5sdKNJ0CP8kHFlCWV7TIc9SetsYG8dVcFVVtXB7BKP7L6oO7nzVJj
         L8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889661; x=1690481661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0QHGC18vxO2QHVl3y7SYla7+m+avkHqGb8W6MMkPEM=;
        b=GUNkkcFF6DYCJqDi2/oMqbaKGYn4aFCFbRy6deay1QcR95293YUFRzMVtPXnWxxZoK
         gt10iopwuVNJ+yE6W1dvgb3vA+yZ3wcSiUNhFGtFEAizVGL+Xbsan8wgVcqYZKs2M4p5
         r/5OqbaTbbns7Ua/tCjKMXGaS3PW313jp9qOJfPlQtEr8GWZ5EFnnbOF3Jdj4T7mPgo0
         OleOF3f6qYT5GMFbVCnGB293QiSB7Q3NrCDg/TyCNVfTDu1Ud8djQVT5PcbRz/6LV+Jm
         rzFU2c+ZV+LeK/qNW8neUAkUbdNzvd+eqArYIpGjv/5U97fJtvUE5c4k/eKTdOi7XmZX
         0v9A==
X-Gm-Message-State: AC+VfDwtT86Kcc4LxC60nmFVowhfgid+C1bFOzJwb3e319ISY5Ohr+RV
        bU+Ltiw4oUSIxmzR/jtK9+qoO7GrerO0aM/k9tqjog==
X-Google-Smtp-Source: ACHHUZ4yOkXhNDmqb3f8bSYcYTCluoaVOfNxpRXYi2CuLecvu7rdFhicIm/u539x+9fkWlRMNbVMdC8U8UV1YOusgxQ=
X-Received: by 2002:a05:6512:3d06:b0:4fb:7be5:8f4e with SMTP id
 d6-20020a0565123d0600b004fb7be58f4emr4407689lfv.6.1687889661101; Tue, 27 Jun
 2023 11:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230627143747.1599218-1-sameo@rivosinc.com> <20230627143747.1599218-3-sameo@rivosinc.com>
In-Reply-To: <20230627143747.1599218-3-sameo@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 27 Jun 2023 11:13:45 -0700
Message-ID: <CALs-Hsu1Zktm_yik8q7qArsqH4PiJgUGQyDnLtZs+1aqB+DGWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
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

On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> Zbc was missing from a previous Bit-Manipulation extension hwprobe
> patch.
>
> Add all scalar crypto extensions bits, and define a macro for setting
> the hwprobe key/pair in a more readable way.
>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
