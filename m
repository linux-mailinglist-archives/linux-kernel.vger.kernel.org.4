Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8564DA49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLOLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLOLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:30:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A75FA5;
        Thu, 15 Dec 2022 03:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95CEE61DA2;
        Thu, 15 Dec 2022 11:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CDEC433D2;
        Thu, 15 Dec 2022 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671103849;
        bh=Nhsq9EwuWdUHCHQ1oKOOCcbZzOAeZ9yikbOc2qNSucE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S7/vajs7OQ829o5woYBdBs+p46PqaG896EX/Vmy0yKmoYKVVzh6a4ovDWn1PgvE3N
         BN4MQoVbLQJuQPtI4SJR8/B9QAbqm4F4l1O/men0bD51plkQvAqsTgqt8vihrwj5Vj
         6T95KO3NLIYDP8ubTe/bG8lssJ3CZ8GCqFcyIIxyqEopjkic/OMKn9E8LJAO9qVjy0
         JoyMArXIuSnSlaKiyJ9ySHSg6usf3zBU2hQbaNIjoRE9JvVeoimVudjpmvAldf8Zzd
         9B0Mq17n5/jCC0uS73mDJLG19UoY62B1jmCc23ETbmySfw0ZyUkHCXUhtjSZpj5lN8
         ZdcMOkIqgo0zQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v2] riscv: Allow to downgrade paging mode from the
 command line
In-Reply-To: <20221215081948.1256610-1-alexghiti@rivosinc.com>
References: <20221215081948.1256610-1-alexghiti@rivosinc.com>
Date:   Thu, 15 Dec 2022 12:30:46 +0100
Message-ID: <87359ggazd.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Add 2 early command line parameters called "no5lvl" and "no4lvl" (using
> the same naming as x86) to allow a user to downgrade from sv57 (the
> default mode if the hardware supports it) to sv48 or sv39.
>
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>
> Also, as those params are treated very early in the boot process and we
> use standard device tree functions that may be kasan instrumented, we
> only enable them for !KASAN configurations.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
