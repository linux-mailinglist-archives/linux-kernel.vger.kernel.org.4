Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8296866F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBANbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjBANb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:31:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC609646BC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB205617A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F378BC433D2;
        Wed,  1 Feb 2023 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258248;
        bh=hW9YSSvo6XTKUbdfhWOHMd+CyfDtp/89LVYuABWaklQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gYvrReJsPQ2IrxHz3DF+PZgAELs7rB3Cy7WmL7zV1ME4P6u0niWZmFBOWvxNbV3/9
         yHYd1NepBQsQpCGQJvCZ+kcBQMC7nPdzcWeGTklPl0UEt+gYLy17g6YlIMtwOA0+iv
         5c+UjQkCEND+oS9/OGpoeYATE+zamj17oV5ODzmv8Ua7JrBSoylkGRWCVlFtnZtIDM
         OU1KY+J+cITlh4MFuh7XQZVgeVC2bS93boHaSJS8fByiKZ+tNuphE6Oh1p60TvJs9d
         pz8CtP6WNPGnuXJL83XpV4caCTo0PoECBL+UciUXRHbInOJnMPEr2MoiFaBbGs2iUh
         vMWB8cwRhJhZw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com
Subject: Re: [PATCH v6 12/13] riscv/kprobe: Move exception related symbols
 to .kprobe_blacklist
In-Reply-To: <20230127130541.1250865-13-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-13-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:30:45 +0100
Message-ID: <87tu05tsvu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>
>
> Due to the generic exception entry and exit code is part of the critical
> path for kprobe breakpoint and uprobe syscall entry, set a kprobe on the
> assembly symbols in entry.S result in kernel stack overflow crash, hence
> it has to explicitly blacklist it, requiring a new _ASM_NOKPROBE() asm
> helper.
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
