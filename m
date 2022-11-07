Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE061FA9B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiKGQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKGQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5178516584
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE01EB815A0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F495C433C1;
        Mon,  7 Nov 2022 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667840095;
        bh=KsObuJWXvLhwuEZHFp5QrxHieh8AflkZRl9asmg0/ho=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HDLs2rV+veNGR/93J9a48Z2nfdcfUPYMYO/w0ExZeEA8ALJvqtekBQv2SlLgLHNlP
         tQz55MGLqMyW7Gh61ziOjkrQt95I9kO3+Ov7/jn5evHwVzG9Q8FgQDxYAtbnF3bpBZ
         gksxNByuoHmN7N+hprCfA6zX/R6jxYtaXeH2Kmfui7Amnb74aKeja9kp1LQkhPF+E6
         6rH+4njXMHZgQJOhe4iQz6Z7rjE/W3sFQbrNlhSlsPDGbbiRLMKIthJXzx5tdFtLbe
         pEsi/HQzjlbEPAGC/uucdFATTD6gHrCDn0mgdUXVUD8RBXcPpFd8AnHpcg0p3n4Rzd
         aD3rrbKco0j+Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Liao Chang <liaoclark@163.com>
Subject: Re: [PATCH v4 0/8] Add OPTPROBES feature on RISCV
In-Reply-To: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 07 Nov 2022 17:54:52 +0100
Message-ID: <87y1sm1z8j.fsf@all.your.base.are.belong.to.us>
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

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaoclark@163.com>
>
> From: Liao Chang <liaochang1@huawei.com>
>
> Add jump optimization support for RISC-V.

Thanks for working on this! I have some comments on the series, but I'll
do that on a per-patch basis.

Have you run the series on real hardware, or just qemu?


Cheers,
Bj=C3=B6rn
