Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A97427AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF2NsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2NsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79F3588
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879B26155B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77636C433C8;
        Thu, 29 Jun 2023 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688046498;
        bh=PH8aSohWWdvaZRG37bt8dE7ai4BFcS6D37ZmrWwFLC8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rR0dz3VB81cr28RspgXkIZRnrO8hdfjsoi2fqj4OPIF8iqXaTCIHWgZj/nIHkkKyf
         vKLDYfYkjBFiHZhXMfiHCvAulHVZ+8v0U95R5Meb9L8jacwIOcXfq+FfjXyZNSAI5Q
         PeSsCw5mUWjAObNNVvYW4SPi9AsMzF0pmeLaqFDkBIoihQmeQkGYkyQHgN2DtGjYhY
         Nt34OiKeAAyQqh2kegMYjKxPGTZiRscF4JZBVzra7M2FF6/nIHvz+jsLo38oGksHQH
         3ds5n8RvUw7UEx1V9gQBoc3LisVEW0GL4g3wweUb3B07g0WememuSdwV6u6gCvrAlf
         eRelCHxZxsP9Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Denis-Courmont 
        <remi@remlab.net>, Darius Rad <darius@bluespec.com>
Subject: Re: [PATCH v3] riscv: Discard vector state on syscalls
In-Reply-To: <20230629-flight-vanity-c1c86240e7fc@wendy>
References: <20230629062730.985184-1-bjorn@kernel.org>
 <20230629-flight-vanity-c1c86240e7fc@wendy>
Date:   Thu, 29 Jun 2023 15:48:15 +0200
Message-ID: <87fs6amlb4.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> writes:

> clang allmodconfig and rv32_defconfig fail to build with this patch,
> according to patchwork:
> ../arch/riscv/kernel/traps.c:299:3: error: call to undeclared function 'r=
iscv_v_vstate_discard'; ISO C99 and later do not support implicit function =
declarations [-Wimplicit-function-declaration]

Ugh. Sloppy. :-(

Thank you!
Bj=C3=B6rn
