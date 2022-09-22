Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB80A5E5A25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiIVEXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiIVEX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:23:28 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88820AE86C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:23:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id E81462B0598E;
        Thu, 22 Sep 2022 00:23:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 00:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663820597; x=
        1663827797; bh=OigcnZP430TIrgw/nzWxgq51e17a3yV3NjehKTHl2U8=; b=P
        0v29TFZCnIaJ7qc+NasbX4Ey+WXDCTrA0TTGxzjkVkdY1mp3xqYT/mskqRxUcffW
        TazKr94OLnz6KlMmiDuGVZe9GQsCfV24HLDJRW+q6Rhb9T8W2ebh9bkIJ+rK7TUR
        2XK9pZWdKlPd05R9tYNAbDqzHwX1gfS/rhY0tmEKZFXI0xD9SPpRcnZIRX5vEtUM
        ibIINIFFej6zmtOklzJHLoDXsRKzG4hUE76xpf8XsyQMQK9wnjyPLif/zEmiDoNT
        QQS5ZR4wMFIzKwpEG+fl6MQ9JZc65wHdgXQ57/hV/y6KLBsN1eT5PuSNszkTJ3wp
        XMfL0kRLVBG2LvMh0X1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663820597; x=
        1663827797; bh=OigcnZP430TIrgw/nzWxgq51e17a3yV3NjehKTHl2U8=; b=h
        EN6jCwKlLnqDOStufdJkCilCTJtpEKLjPjdGqgTZAsRmQXYMLTDKNADvPCjgSNfp
        +bXSRqi+D4xYJNFAyrBO2uqnW7bIxt9/wuTRLgGnd+JOHdiqSxi1ajQxNCaLl2Ih
        oTyt0osaZrIjiYaHxBcy5/abV/MVuIMDJJ11Di7nhYBG3No1v/zend03nB2RMDmR
        IC1XgAnOjmRaT+hom0eJWgYS1NKLhDrkn9tsatJqRW1+zkI22lsognHuYEM7/06o
        /rcBwzlYnrDhoAzdrcrEAHBM0eNNkPIEUEXdNvcu/+Npg+rrDpXAScCTUxyThEXM
        dqCxQ6ythqBeX1U1KITBg==
X-ME-Sender: <xms:NOMrY6bo-jOIEXyCT-eKBq-x1B_Lx7sdpYtuhbNdtYwu80KR0Bta5w>
    <xme:NOMrY9ZO2ENp8dQsYMt6xLgG4xGmFjOHcdrv17UWvBVb1hJZkjvX9HOOmf-9n5CpT
    _aZZzwiiFqQ19t2ZQ>
X-ME-Received: <xmr:NOMrY08tlnKzW4syyaF0MDFd05r3kuzJEz3Xx7xig5qAu4tgUzGb69KXCe20_fJxFtYZQzzT3LUgorQRYwCSmWz4GQNlAqtxF3Ai6fY5QhoYuaKNl-sJYhwc_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:NOMrY8qwXUIJKVA5nogmgBykhnNUtIqRcDLCQ3Z3XM7G2cRXxBRIOA>
    <xmx:NOMrY1qGNdE4cx8T0dYO-hkK_OmxsUtRHVx933NaQUhuiRQUpyItQw>
    <xmx:NOMrY6SsXZLbDq4nVpIUg8LjADZR_hkQG3bp1d7wtb70KfYOscx1fQ>
    <xmx:NeMrY_biQAkQrdXq6J8kaJ9E7QhTa3P3t89ZEAm945kFTX2I67bSApEnC2E>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 00:23:15 -0400 (EDT)
Message-ID: <a91e3e67-d077-050c-48a3-1466c2deb7c4@sholland.org>
Date:   Wed, 21 Sep 2022 23:23:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 05/17] riscv: Add has_vector/riscv_vsize to save
 vector features.
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Dao Lu <daolu@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Ruinland Tsai <ruinland.tsai@sifive.com>,
        Han-Kuan Chen <hankuan.chen@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-5-stillson@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20220921214439.1491510-5-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 16:43, Chris Stillson wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch is used to detect vector support status of CPU and use
> riscv_vsize to save the size of all the vector registers. It assumes
> all harts has the same capabilities in SMP system.
> 
> [guoren@linux.alibaba.com: add has_vector checking]
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/vector.h | 14 +++++
>  arch/riscv/kernel/cpufeature.c  | 19 +++++++
>  arch/riscv/kernel/riscv_ksyms.c |  6 +++
>  arch/riscv/kernel/vector.S      | 93 +++++++++++++++++++++++++++++++++

This file is not added to the Makefile until patch 8.

>  4 files changed, 132 insertions(+)
>  create mode 100644 arch/riscv/include/asm/vector.h
>  create mode 100644 arch/riscv/kernel/vector.S

