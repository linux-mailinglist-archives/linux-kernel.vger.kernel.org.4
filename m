Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED79668ED29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBHKkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjBHKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:40:36 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A049556
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:39:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1DCA132001BB;
        Wed,  8 Feb 2023 05:39:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 05:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675852782; x=1675939182; bh=XvjPcbSB0C
        +tEip/psUaJBFfDTBjjkzGVMt5Kch20xk=; b=GJ+xnWVPgj1OJ9JwQZvdOdMxvq
        rLTS3P6zFtgSd8IEUpzfSxE0ccuG71YVeQ8Yrgevc5IsXiZ16PCIckelT7djfZh3
        V37lk4k0b4C+PWSAxQraalAs7F5rl7hS8CPuhpdRj99sPoiSE/tOnLjNGBS0VXmV
        yXypzNWiricTSC4ucDQaQpGnYXe3O4SkTMm86vFKE3MUqYZtJ65YIwuW7fLYqBnx
        WJLJonVNTPqKBMc3T6Em3sckkuDmsGLCm18+MJu0CUUczi9/LtjnryA4RU/iqRMt
        qhqafG4trQ3tEOq3HiPZw9trTfMFCYS194PKBeOiVuEp1YbMoHHqpPZevMXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675852782; x=1675939182; bh=XvjPcbSB0C+tEip/psUaJBFfDTBj
        jkzGVMt5Kch20xk=; b=bYrNbNtnWmjy/YTNE4mRHrQbCgMHd1jsoj8vF7N4zJfp
        9PCbZfz9V/iunIurEwg0W8NbnGAVp0XxZhYOFmqymt6DnLDQGLfUdlsFJLVm6Kq9
        m00UsYPbOOt8FxEIY3Qc2wc9n+D9aqrWqEhAs6PB0c+swLRZQBzMwC6+IlroXanF
        0eKzkwOVF1FvmkeQ4eW/m6Ll2IsAkrBREfoI2+e6Rf8tagJfM1ABooOkwM37TNVE
        XmbMNTLfyq4wtx/7jcU4hILi80XGRHhiqNCCEjl8TW5HPv14uBo1w4YLgPZxLkUk
        NR3KkWNu6LNH0hQ7UKhe/uXOSUsGCgQDs5djcfNcuQ==
X-ME-Sender: <xms:7XvjY98pHQ1d1GFm5SWZwX662qnO0S-VgrXS0_dJjR3QBSpS7Yp91w>
    <xme:7XvjYxtKkwxl0XLL0aBB6E1hG4mmy5DlxUnQEc5TOtcMUmHX1lj_gSpCwuih4hZqw
    QHHR3yacDCNp-F7cAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7XvjY7Anj2EjVpTJ1a48n5bEUF5WFXgTU7uHJcT9QdUt-Mliydj6tA>
    <xmx:7XvjYxdyv6Ly9cUBSa2iHEHmu-XXy-_WGZ_ZDdMij_XDcSoLicu-5Q>
    <xmx:7XvjYyMCfKfGd2xt17U3kFUZida1pxWuiaV_Bz6yDXrIUvTdfJAXkg>
    <xmx:7nvjY5339qml5ge1kO6AKV7XW_1OcNIHbrOSKmehSXktwnnx5IwvSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BBA0AB60086; Wed,  8 Feb 2023 05:39:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <e09b458a-32bf-46aa-b509-a383e34d4888@app.fastmail.com>
In-Reply-To: <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
 <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
Date:   Wed, 08 Feb 2023 11:39:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "chris.chenfeiyang" <chris.chenfeiyang@gmail.com>,
        "Willy Tarreau" <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Feiyang Chen" <chenfeiyang@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on statx()
 when available
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023, at 11:17, chris.chenfeiyang@gmail.com wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>
> loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> openrisc have statx() and stat64() but not stat() or newstat().
> Add statx() and make stat() rely on statx() to make them happy.

> +#ifdef __NR_statx
> +static __attribute__((unused))
> +int sys_stat(const char *path, struct stat *buf)
> +{

The actual #ifdef check here does what I had suggested first, using
statx() for all architectures, rather than what you describe in the
changelog. I think you should keep the check from the first version,
testing for __NR_stat/__NR_newfstatat and keep the changelog text
here. Also please add something about the possibility of using statx()
everywhere in the future.

      Arnd
