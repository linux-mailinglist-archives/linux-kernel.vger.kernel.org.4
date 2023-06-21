Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE1738AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjFUQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjFUQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:16:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C14199D;
        Wed, 21 Jun 2023 09:15:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b52bf6e669so48023495ad.2;
        Wed, 21 Jun 2023 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687364148; x=1689956148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJGYiZSmAz4f7DWqK5EepnnOfjeHuHz97IlICgAbfpM=;
        b=rXvFFwpBMa5FmYnwQKryzn7/pRIxWbxqUbuDWOxQy5R5fuAZg6H/lCYrcytisckb9V
         JOpaxzgqsRWoqC9YWvhZwVl2z2eplFB28DwpD7fd5PD2IuLiLmFrxexRL/I4e3IPwnFZ
         iEZXzUZBM6F6NV0AdfajGy9BoRkUWB56UG/XWMsL1z2z5F1i77CAhHoR2lCRMndf//kw
         VLBGg1mE8ZdmAsGaFgqJ8P7IfxuDy4/LtblSTRPIpMYlrG/4m4AoKKE6WkZWZ4gAW4v7
         z+7l0xfPc+roMttREcfno6LCCh2x6ZH9JJFipd+v5VxGB8FWEUlGQgCTP85PKZIuSBj6
         CWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687364148; x=1689956148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJGYiZSmAz4f7DWqK5EepnnOfjeHuHz97IlICgAbfpM=;
        b=drRed/jrkKgL0Dmnw7oBbOh3j1M/qh1DTBH5XIlYcdx7eY9YSUvwuXhiubPmwdEcF0
         whZIUwpJvPWApVfjXqJ1ZW3SsNqCsFIwN05w691jBbLnD6wRgmmPsejrhXam6IIf+/Z9
         qUe8r22JEOncOoSyABBs/vTZcwoblxG3zl+4Z0KF06ElhZcO0w0tjjj8Z0idn8diBiu9
         cScp2bqOhb2UATUe1DAvEVyCSSZlEtpBw5yKtCm/tKw51DfOSovEw6c+mgRPSLhAxLFK
         +mKZA+PJ2ZAnO2piKKefOy5oDYRyz01c34OKwq3QUebS3W9BLSkX4bKmJWr8y55KDwpk
         gsbg==
X-Gm-Message-State: AC+VfDy6fboYFxw3KRhUypUmTMmgjwAy181qyKki5siVZG2+qjLw8TRu
        DQ/LbgPzIlFvfOPy3x6zZz+gKDjFAqk=
X-Google-Smtp-Source: ACHHUZ5w5C/Ax/llbxeWIVIzqLnv+V2hnXxpwlzgpEcMzA+Yr9rTk5qAvHYFGctAC+AfLAN0h7E8Dg==
X-Received: by 2002:a17:902:bc85:b0:1b5:54cc:fcb8 with SMTP id bb5-20020a170902bc8500b001b554ccfcb8mr10779557plb.19.1687364147732;
        Wed, 21 Jun 2023 09:15:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b001b53d3d911dsm3712465plg.69.2023.06.21.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:15:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 09:15:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
Message-ID: <bb5048e7-5e8f-4391-a9a0-ff15b5384186@roeck-us.net>
References: <20230608142428.256985-1-masahiroy@kernel.org>
 <20230608142428.256985-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608142428.256985-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:24:20PM +0900, Masahiro Yamada wrote:
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> 
...

> We can do this better now; modpost can selectively emit KSYMTAB entries
> that are really used by modules.
> 

This patch results in

Building alpha:defconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
ERROR: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.

I don't know if other architectures are affected - linux-next is so broken
that it is difficult to find root causes for all the breakages.

Guenter

---
Bisect log:

# bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specific files for 20230621
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# bad: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad e867e67cd55ae460c860ffd896c7fc96add2821c
# bad: [57b289d5b1005a9c39d6d6567e0ef6115bd59cea] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect bad 57b289d5b1005a9c39d6d6567e0ef6115bd59cea
# bad: [dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f] Merge branch 'for-next/perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
git bisect bad dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f
# good: [6d366ba598334a0457d917a7bf38efd118c5b7be] Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 6d366ba598334a0457d917a7bf38efd118c5b7be
# good: [82fe2e45cdb00de4fa648050ae33bdadf9b3294a] perf pmus: Check if we can encode the PMU number in perf_event_attr.type
git bisect good 82fe2e45cdb00de4fa648050ae33bdadf9b3294a
# bad: [d2fa756910f88c2f5871775483744407cbf67933] Merge branch 'for-next' of git://git.infradead.org/users/hch/dma-mapping.git
git bisect bad d2fa756910f88c2f5871775483744407cbf67933
# good: [1b990bc8edc396a37a3ff1a43f7c329c361ee07c] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect good 1b990bc8edc396a37a3ff1a43f7c329c361ee07c
# good: [cff6e7f50bd315e5b39c4e46c704ac587ceb965f] kbuild: Add CLANG_FLAGS to as-instr
git bisect good cff6e7f50bd315e5b39c4e46c704ac587ceb965f
# bad: [8f3847e175a0044e2212fef772e7fa912270cd6d] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
git bisect bad 8f3847e175a0044e2212fef772e7fa912270cd6d
# good: [3a3f1e573a105328a2cca45a7cfbebabbf5e3192] modpost: fix off by one in is_executable_section()
git bisect good 3a3f1e573a105328a2cca45a7cfbebabbf5e3192
# good: [92e74fb6e6196d642505ae2b74a8e327202afef9] scripts/kallsyms: constify long_options
git bisect good 92e74fb6e6196d642505ae2b74a8e327202afef9
# good: [92e2921eeafdfca9acd9b83f07d2b7ca099bac24] ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
git bisect good 92e2921eeafdfca9acd9b83f07d2b7ca099bac24
# bad: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: generate KSYMTAB entries by modpost
git bisect bad bb2aa9a94b41b883037a56709d995c269204ade0
# good: [94d6cb68124b7a63f24fcc345795ba5f9a27e694] modpost: pass struct module pointer to check_section_mismatch()
git bisect good 94d6cb68124b7a63f24fcc345795ba5f9a27e694
# first bad commit: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: generate KSYMTAB entries by modpost
