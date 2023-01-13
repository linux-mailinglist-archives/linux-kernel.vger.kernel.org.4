Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDC66A3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAMTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAMTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:48:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80649D2FB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E32DB821D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57596C433D2;
        Fri, 13 Jan 2023 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639279;
        bh=MxrRhT/WYvWGZu5rhwM+fbTk91iiJ1dhq93LmwQbfg4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SceHxS8W8zx1CKDpGsM/n/Lm9XgsaOVoTerzlAlDYQNxr/GDpPPKcrcWINDF0PzJu
         NzSVqaZu/xHg/ZNvfOkmKvNtAlF636MegwQXV8v8QUH+z7faZ0T+7aIZrdlpOZmZop
         Z1hdcBJSFqnNoY2UTl8SwSD8pmglUYDoEJxsQ1hT67rbsPh3DHdz0OrgkETIynCrHP
         V2Vr+UvAeGJoF7HOb0h2IS/zoWP3tcZt1Vt6C9BevQgJu0wZgbB7TYpfo+7uiOW5VD
         pV4FtBClu/RjQP8VaAJea4ESij6Kwp/UjyVyRXn0JdM4wirRtxX1fIgQL7jTbk+PRq
         3D2XbN6SXBaqQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Add "Code:" to RISC-V splats
In-Reply-To: <87h6wutoxh.fsf@igel.home>
References: <20230113144552.138081-1-bjorn@kernel.org>
 <20230113144552.138081-2-bjorn@kernel.org> <87h6wutoxh.fsf@igel.home>
Date:   Fri, 13 Jan 2023 20:47:56 +0100
Message-ID: <87wn5qxllf.fsf@all.your.base.are.belong.to.us>
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

Andreas Schwab <schwab@linux-m68k.org> writes:

>> Add "Code:" output to RISC-V splats. Mimic x86-64's byte-for-byte
>> dumps.
>
> RISC-V insns are organised in 16-bit parcels, it probably make sense to
> present them that way.

Good point! I'll spin a v2.


Thanks for having a look,
Bj=C3=B6rn
