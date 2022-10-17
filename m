Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406160076D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJQHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJQHMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:12:30 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B8F4AD6C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:12:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 13215320025E;
        Mon, 17 Oct 2022 03:12:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 03:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665990743; x=1666077143; bh=V8eZeviXGL
        1+uINoLCcYBas9La4PrZ6COoSZQFiUw6U=; b=gF/szDUmOCYaOJsLcF0gV9YwiE
        RejMOa/YEn5grDKnOf41ezS6IAKEe/RL2NPZRpXq2vxK2/kKNhDQAe+6y8CsezF5
        4fBXGau5SXE8dbSy835I7yBtCe6kaLNtvYUa3FjtKliF6EnxYDIeQuotZ7GvsaMW
        PqF7YunGiI9fPSGh7SXafMNYO1d2WSYF3u34EhLk0TNVgulOFu0JkDiFvwzkRTZ8
        SJqN1i4jY946BI8kdUqDxehdd6qwvEHJeem+zLWZ2s/mQKCpGBDXoBp8DCrZtryz
        X6w+o+UGCDja+pSOiDN6txX8PcumVHlBXANKbaJCjlrS0z/dhs4Mz7osCJ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665990743; x=1666077143; bh=V8eZeviXGL1+uINoLCcYBas9La4P
        rZ6COoSZQFiUw6U=; b=D7I0ggmGlkV1vClLcb8pSO9TaKx7tjfEN6Qvf7HgLEEC
        ZrL5xiWg7GFA6nHdjgsYQ0cKhU4eniGycXXZOpO0hSV/tdohkUQxsRL3p8G9x+Mb
        +P1fdN+n7SUY/Mfk+IenaIrOBktLjuxE/6UNl4Q9+8lhdH27+6iBFlHlVJgnr3Kg
        BWFPPdWjc2d/3Gok1L+suV+wSGC8DEK5mgwGplNrJd9U3HpCHcd2xkRb3uIPfdp5
        4jlvsEvS1cZZPtTFC+QPKPa4s6xmM1aTFD872iEQxLRmuREI1rOFM/zOMLyx9ZZx
        KGVgR9Q6d071sjmAtBuPIA5F100REkTqMKyy+Jwj7w==
X-ME-Sender: <xms:VwBNY5JKV85VuGcJBtQ-q5J7jZdhGyHSivIOgl1Llv7qFTuo7yNG-Q>
    <xme:VwBNY1IIuOpWzGpyI_91O-kiid8ke-e_5X0JRkl2hzVydz8KOxWnOV14C-Z3NRfR9
    7ufvHLfuJmIub7EzxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VwBNYxuPzQYCle2hKVW3u3kssMsSmO405AQZjck6Op8R0-FVsi7THA>
    <xmx:VwBNY6ac3y_ctLrLk-OowoTCcNbK9HPPUAvgqLzKLg3Z0aUwYYxH5w>
    <xmx:VwBNYwabPuKvQrVB1nL1Ej86rLi0eEVkp-X5y4vLq5qt65YN7t7Oow>
    <xmx:VwBNY1N4VEjbqqK9fyXcSM4tLJ_13q0ZaDp3iUS5Tx23ozV7CX69Lw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2FD9AB60086; Mon, 17 Oct 2022 03:12:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <506fe4e5-a203-48e6-84a6-f70133be15dd@app.fastmail.com>
In-Reply-To: <20221016133418.2122777-1-chenhuacai@loongson.cn>
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
Date:   Mon, 17 Oct 2022 09:12:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Add unaligned access support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022, at 3:34 PM, Huacai Chen wrote:
> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> Loongson-3C5000) are configurable whether support unaligned access in
> hardware. This patch add unaligned access emulation for those LoongArch
> processors without hardware support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

What does the Loongarch ELF ABI say about this? On most architectures,
C compilers are not allowed to produce unaligned accesses for standard
compliant source code, the only way you'd get this is when casting
a an unaligned (e.g. char*) pointer to another type with higher alignment
requirement.

> +/* sysctl hooks */
> +int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
> +int no_unaligned_warning __read_mostly = 1;	/* Only 1 warning by default */

The comment says 'sysctl', the implementation has a debugfs interface.

> +#ifdef CONFIG_DEBUG_FS
> +static int __init debugfs_unaligned(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_dir("loongarch", NULL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	debugfs_create_u32("unaligned_instructions_user",
> +				S_IRUGO, d, &unaligned_instructions_user);
> +	debugfs_create_u32("unaligned_instructions_kernel",
> +				S_IRUGO, d, &unaligned_instructions_kernel);
> +
> +	return 0;
> +}
> +arch_initcall(debugfs_unaligned);
> +#endif

The debugfs interface does not sound like a good way to do this.
Overall, my feeling is that for a new architecture we should not
introduce this at all but instead provide a way to diagnose and
fix user space, since we do not have to keep compatibility with
broken binaries that worked in the past.

If the ELF ABI actually allows compilers to produce unaligned
accesses for correct code, there should at least be a more generic
way of enabling this that follows what other architectures do.
We are already somewhat inconsistent there between architectures,
but I don't think anything else uses debugfs here.

     Arnd
