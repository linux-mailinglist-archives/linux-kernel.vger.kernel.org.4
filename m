Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAC7383B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFUM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjFUM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:26:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ABC19AA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:26:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f86dbce369so5034021e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687350373; x=1689942373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAxEtrTul+wf3f8dEFp4/Q7FFB8r2eIvIayoUR9g/ZM=;
        b=b9LUq6j+hdbkpoJSBrNH0/KADs7q3gFnZs7RZQATTyniuD4k3QVf26bF1PdrGuwV0P
         lTg7gDPJSZstw6QFsyoCkJzfwnsn1b+Zq9kqYBTd4VL6/xq4Y38F5E4qA1vEaBMDILLG
         6cHmAWXfVpaWBTjLEtPHyaQlmzjW2SV+5OPlRbzGNWTCcvvm4RcxWUb5sn2f5MleyZHK
         wwGyWvXYK+s1YwRjGQEkgJGgzysXfvKdIX8mWxxoqoSc6MDnq4/+K7OlcbQCzuHWuP9j
         z/W96xQ6YkmZHdhJqtKzZYY/3rS7FMTOeBDPni/AJyW6w2z3sQgR1GcW4TRHYMsn5kt8
         5lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350373; x=1689942373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAxEtrTul+wf3f8dEFp4/Q7FFB8r2eIvIayoUR9g/ZM=;
        b=lG9FtqKQrUsYuVJIJ3ZCQNMk37EHYWg0iblx2Tr21WtKQeWbOJovhGtokunyqhq8OV
         Cu+hlqpSbO9udLljR6JTnpMqQHrBl+31jQnoOJytpO6zW+Os1Rz/5XvuaXDWV6xP95mm
         d3dNuHw7ybsHN6MmC2SLCEfjn44YERpiEnTuHuYT8N7LNPmcpDhM3BgCe5Rca9lY0WOe
         tTLKKzNyzO0cob4jchELVyr4Zgi5yDoOI4T5d2jRWGVRwT5r10fRMzJYfWxlen5W2LCS
         vdybAuFAs7VZf3JHA9vuFI55whYX33UyoRgXGhP6Ej8xDf5p/I9vhLb2ia1woTAj7wgE
         Y24Q==
X-Gm-Message-State: AC+VfDyhiZAYfNIOkA/yBl4Rk09Cz4/WeglfYiLfjZzQzTrYN4dIq1t7
        ZC/q18OFwQLHrpYuoVANepmE6WjpI8/0n3eb9QwboQ==
X-Google-Smtp-Source: ACHHUZ6N3p22LrxTtwaeVDb6/+PRpFjpQi/CKHQ3GAb3Hnbw6nTuPi9Jwf3ZtTj4jRyW/WLvv7JW+bhhMgB3yrYMB/g=
X-Received: by 2002:a05:6512:b84:b0:4f9:5efd:f459 with SMTP id
 b4-20020a0565120b8400b004f95efdf459mr462871lfv.9.1687350373015; Wed, 21 Jun
 2023 05:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072234.9900-1-alexghiti@rivosinc.com> <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-attempt-unstirred-567b0352176a@wendy>
In-Reply-To: <20230621-attempt-unstirred-567b0352176a@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 21 Jun 2023 14:26:02 +0200
Message-ID: <CAHVXubhJXUODDnfRJAzAKcutMvz_amP3wAf+4QBKxXzcd_r7Yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 2:15=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Alex,
>
> On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
>
> Thanks a lot for writing this & implementing the feedback :)
> I had one or two minor comments about rather long sentences, but there's

Arf, sorry, which one? So that I can fix that in case of a v3.

> little point I think in respinning for that, so I have ignored them.
> Other than that, didn't spot anything new on this second reading.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.
