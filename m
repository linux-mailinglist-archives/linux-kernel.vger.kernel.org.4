Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7ED6818A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjA3SUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjA3ST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BF7DAE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 896635C00A9;
        Mon, 30 Jan 2023 13:19:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 13:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675102789; x=1675189189; bh=8FutbuCl/D
        NR6Qsqy22oynbrQgR9pREAJal0Upg9trQ=; b=QVVyRlo9wMicMWSz+RpRPUi5j1
        aOeVdg+ZgqkfmxSpvHIBB4EJSroOwPVaRMYGAyivkZbHJ8yruyBKBZNvUiginpw6
        nu+0c6Ftuj2g5Et50cRwHNDOCo8ejiWv/PKMlPKQW2pmdHflq3Zbu+PAD45BjWpj
        FfXW5ara1qmk1ME2VGYj0pXx7dZJigVu/izAZ0IPKe6DRnoiG2bY9iJHE5YsBJkj
        9RtCx5ciQLzJ8RMy6OxBtBkKrm1LOu6K4EsCKKyvKe/nbyolOIFColtPJcmjwVEb
        ZsxHjP50NisVKMbdhteeF8J1v/Swvx1WzRUgFOpwGYmbwrH8qAuXh5+0pDZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675102789; x=1675189189; bh=8FutbuCl/DNR6Qsqy22oynbrQgR9
        pREAJal0Upg9trQ=; b=EX9Y8/kVjckmt9+F81BT0c82vP2qkKpVWNwxOYUdRc+h
        iwhGbWsiWwftaqsbKW+YvIELYEk3BgNhphf7t8stt2EpFG96LsMcY+bsK0cL2YBb
        E5ydnC9xNEj0q7bi7drA6P9QuW5DIs057sJR2TCXZRmSwtg67hcuC8dqZj6j3lWE
        LNh8HDu0i4q7vm+Ft29mZgVmlFv915ohRNi7Vtt2NlBLDqTr0XGtYEUch+06H5rb
        ZWYAyOczliCWgA1JY9YNK2PY6RY6YJTL4gmRKUITjKM3P6GJn9WEuTN9clGhkPX1
        JvGh0COOiI9wlopWlyFCL1D9RsXsmZhLPVaACXWKew==
X-ME-Sender: <xms:RQrYYyAl0tyXfvr0RqyDj_HXhhDkw0qJB4CzrYpPmT-alAjd5U1vxg>
    <xme:RQrYY8iqShS-BJVesOlWH6tqeKJ34jOYYlrwJqjRlrJAyIWnv-UIu5YdtTLhyX4V0
    kJUNfohb3xs0zDIdtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfeg
    feefheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RQrYY1m_-pDAvLiREiFxn_w0vRAbam-L7479rXhFXoPTgsymfpK8yA>
    <xmx:RQrYYwzbnNtyVg1XwWrq23IrB4QHcE2FAqcEpA0usRTVwQrRk4do_g>
    <xmx:RQrYY3TQ6QHpSvsKQ0StC7Um4ah5Exlg-wgNaCKzDSzOdksA8J6jlg>
    <xmx:RQrYYwR3VBGEYOfemcsuO7BKA4tC_WjKuqg-KQCwquf7n7aXEB93og>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 426DCB60086; Mon, 30 Jan 2023 13:19:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <a40df1e3-ed92-4662-bb9e-106becce63d7@app.fastmail.com>
In-Reply-To: <202301310149.euWWUSrD-lkp@intel.com>
References: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
 <202301310149.euWWUSrD-lkp@intel.com>
Date:   Mon, 30 Jan 2023 19:19:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
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

On Mon, Jan 30, 2023, at 19:10, kernel test robot wrote:
> Hi Nathan,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on 5dc4c995db9eb45f6373a956eb1f69460e69e6d4]
>
> url:    
> https://github.com/intel-lab-lkp/linux/commits/Nathan-Chancellor/ARM-Allow-pre-ARMv5-builds-with-ld-lld-16-0-0-and-newer/20230119-032402
> base:   5dc4c995db9eb45f6373a956eb1f69460e69e6d4
>>> arch/arm/mach-sa1100/pm.c:122:12: warning: no previous prototype for function 'sa11x0_pm_init' [-Wmissing-prototypes]
>    int __init sa11x0_pm_init(void)
>               ^
>    arch/arm/mach-sa1100/pm.c:122:1: note: declare 'static' if the 
> function is not intended to be used outside of this translation unit
>    int __init sa11x0_pm_init(void)
>    ^
>    static 
>    1 warning generated.
> --


For refernece, these are all known problems, the patch just allowed
the code to be built by clang/lld when that was previously not
possible.

After the 6.3 merge window, we can probably go through the much
smaller set of board files are address most of the W=1 warnings that
were previously overwhelming.

      Arnd
