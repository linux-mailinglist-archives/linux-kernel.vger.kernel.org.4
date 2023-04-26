Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A56EF144
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjDZJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbjDZJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:35:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A930C4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:35:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so4202440f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682501713; x=1685093713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce4GYxtRqPUN978KLBinEzPZHPyR7Q5Y4N3uHGTI18A=;
        b=bLgsuL5jnXn0H97jLHgVAuTV95orbxH7cNIsemG9NrrG6IMhLYAz9O1E5xjggiipxp
         IOvDRWCbVbcckyOEToIxL94M7eb18SCYRYO/U7sLqmNDO+rtvt86wnlufjQ0cSt4OTFG
         2CwqJW0l8480m+WXJZ67om2DVZxgNOZHKL0Qj2b4CaxTF7RMt8ughdnVbcIx+FOKWiAT
         GADrcGHsXDnT+VDhsJfwRyYuP/i0YGwBYX2zJ4Xx+LLaOum74DNi8gnPaPacoisGHxTB
         sAdHiGV27a3cgs9b4uEx9GPGEE5XdnJcnr7LGddx8MFsrZ1MUPZQYllntxDoCoTddPdU
         UoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501713; x=1685093713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ce4GYxtRqPUN978KLBinEzPZHPyR7Q5Y4N3uHGTI18A=;
        b=ezWAB+4kDQfZYC9HieoVgOGVswBfc+1vpydWZWFIwOoj5ELsGn3mIlomO+/4YvUBmo
         FhmgNR7kuamx/UVPZb8FkibS8pzqse52zbkd2u34ZF4gzGKBhIeygFMxEwa0Fhj2KvCZ
         jBtVpOnKuG1pfvIoMXYO4dMDlyZfDjiFXd9EwUl88YFtkCuZNHuVLBTZ9qAUxFNj9bcP
         /3GKSe4tgbe/T3lZFU1FDRox+CvVX8Ha2jOfE0tFrkRpmnFcSm3dv7uGxYPzwfQjTYm5
         O4foG5f3eeFBy+rF+I3yCrTxnW3pm5E64NlgE1pWdtrKRGqaG54Ga6vj6f3De5ueUBK/
         ew1A==
X-Gm-Message-State: AAQBX9cDNWJOlai9VtZp5I6cmr0HQ3ziaFkdqihIjaZ4iiKXoixlcFV4
        Rw7luLAM4jz5fiZb9AyFdd4O6mKKeWfU7HgsFsZkkQ==
X-Google-Smtp-Source: AKy350ZiTFT8VbpJ7VU+tRYZY2yvBJbF6WDlwkpXHMmIbM/NI3aAxc53ixNJkvIm7Aa8XMKoTY7YhKqL3k2O/rmidwk=
X-Received: by 2002:a5d:4611:0:b0:2f6:987f:a0f5 with SMTP id
 t17-20020a5d4611000000b002f6987fa0f5mr14112922wrq.5.1682501713638; Wed, 26
 Apr 2023 02:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 26 Apr 2023 17:34:55 +0800
Message-ID: <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, cujomalainey@chromium.org,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rminnich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Apr 26, 2023 at 3:09=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hello Yunhui,
>
> I am not sure this is a good idea: this is clearly intended for arm64,
> which cannot use ACPI without the EFI memory map, which it uses to
> cross reference memory opregion accesses, to determine the correct
> memory type attributes.
>
Not only for arm64, but also other arches, such as riscv.
For memory-related nodes, it will be done in the early scan of the device t=
ree.


> What is the use case you are trying to accommodate here?
>
Some bootloaders do not support uefi, such as coreboot,
but need to support acpi, smbios.


Thanks,
Yunhui
