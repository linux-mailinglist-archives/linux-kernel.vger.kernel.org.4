Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B46D699D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjDDQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjDDQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:56:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4925B8F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:56:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so133303216edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1680627361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDkPzCPbOwFeM8pNdOTQrKFLlnDQsoU1nXWtiK+e4mA=;
        b=iqVXNb1R8IhevzghcBO7gutyLdEil8JOM8mrMNUbzoGbutuR4NhoydBe6+ztX7RaJ4
         ZcbQM2+TDOSHPyJg0o9hN/vcHilQk0aOrtGsH3kDLRy6qXniIe+VaEYeA3ejGLWJSUEU
         Q+ZwU6x/YAT/pVpnQApEznh4Qdj6GtTBWOi3A3S6nNa3ZptUSEY0Z8KENFgytfb8SBmx
         2Fc6eOj6GTEc8LBZb08sVY2ZOeR74va24Ca910/PYw/TUfYAwMYEx3bDCkM2IHGk8G/b
         rrYX9wGAkcGnDkUCv5w6XXbhRbtX4UIoLG/qoC2VU/Ad8KTe41EaYV00qzZPoIr/85iq
         tyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDkPzCPbOwFeM8pNdOTQrKFLlnDQsoU1nXWtiK+e4mA=;
        b=4JRftgGkCzTpqOhU73gR3opHu9tyV8AYchRuJbph4k/RVhPYXrsZy0nXyzxtI07vhR
         nu0+gmVIvshRox3i091CPeuKs1qmOLOqsgXg+0u9fuwa7N5kGaox3DTB4WoKuGv2xRTx
         1WjhpUXFriRZICdoFG9AgYZj9hCCLpCueKYuhMceRCFH38YcKsF+VG742158dFwJNU3e
         ggQaZ2w0WQf+9qzm046gj4fTYF+Rz5YUx/fE1tIJ/22k1t8CN5nTSiEyApPIgL4vSkfT
         gOhoVvb175eJD3IsxCaRtsqS7C6eKaRxPLEeFqd8nAypF3qfg5A4gTnnJQB+u56ICMZo
         Nytg==
X-Gm-Message-State: AAQBX9f1B+iAx3sHhMbGAvvLYrIE80CzDl2a89nEryqo5f2hISZyldta
        J9a7cqxq+nqLRltElNdZFhgQcnXOU1wiyOc9iE/FwA==
X-Google-Smtp-Source: AKy350b+i1ZaHEs6KA4tVR+ORII+g9X7ahgaAwofvUDz5ArlGO5oyFewenVOA2gJs50Nil3n4pEW5ATyQv1fgM49iYg=
X-Received: by 2002:a17:906:3e54:b0:8b1:780d:e43d with SMTP id
 t20-20020a1709063e5400b008b1780de43dmr103679eji.13.1680627360948; Tue, 04 Apr
 2023 09:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230404153452.2405681-1-apatel@ventanamicro.com>
 <20230404153452.2405681-3-apatel@ventanamicro.com> <20230404-facecloth-curdle-f2d5d46e1375@spud>
In-Reply-To: <20230404-facecloth-curdle-f2d5d46e1375@spud>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 4 Apr 2023 22:25:49 +0530
Message-ID: <CAAhSdy1Qk2offdz3zn0gNQKbhBy6a5MmRG0i0pgRCDZBH3dn6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] RISC-V: Detect AIA CSRs from ISA string
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 10:16=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks for fixing up the order Anup.

I forgot to mention this in the change log.

Regards,
Anup
