Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC416876BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBBHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjBBHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:48:04 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663984F84;
        Wed,  1 Feb 2023 23:47:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F42A5C017E;
        Thu,  2 Feb 2023 02:45:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 02:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675323948; x=1675410348; bh=txkTe9/GZE
        SDTDDVEPfL4ADemETE8Vmr+PO/kEN4j4A=; b=fq8754XQ+nyGH/mWEOhRSr/J47
        2IxNK1LP52dkJmfw5emJqRs57EkQ5JHP1UZ0H0JRaR/WbSrzuvK2CEHn7j++EDMU
        LfyU4XFV3eBedHA6VJ3OAHuPPdtAzGbysHSY8i1u74M9WNSH0AVLeycyjEg6idcz
        EGklPooKPPRaaSFkAdtShFzn/4YMJ5tu5B2XqrvlOlQNWYIfccGpRHu5q/7Yt1ZV
        R68oftg+Ka7V7AompfB4G2Tf41dcN9vd/TgJRitugcQaITfdmeiurV/unTrDTY09
        l56o8snzDN2OHBZVBH/IIIFKfCakYTHQKIqa2ak+0TJkOlJvJMd5RYx7dltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675323948; x=1675410348; bh=txkTe9/GZESDTDDVEPfL4ADemETE
        8Vmr+PO/kEN4j4A=; b=rtZVrA3hJGNjaTokuG2nnfMBQtrvXVS2pw2iociZgG4u
        xUGvr81FabDsnU6YkOTUZSvuRkAuukNTtSxFafgkbFS+VGMgaf2aI9ADCRVqwi6o
        y16qmRZNk8WeEMpIU7x0qjy0Bp9oaTSPaOoHPWIgDbIxKkR7B0Pxo/6WtFCWUFQS
        +boZ9mghufTI4By9otY/uFwFiLQnZ4DO4FM7sa/3fWKBxaRzGkOBx1y61hNHHXUa
        bDOHBK+mOzxyl+imjXe9Zu1DAek4lwUZHkFQ2I2RfvUuaIpsrTcuvU1astjzIkx7
        IO8Mcw/t1j6FmQsULcwHvzFdkfmM93whwUIWDD79Mg==
X-ME-Sender: <xms:K2rbY5ERQ8U9ajf0QRUgG_CqxdaX_IFIoKOHW2JAXbFHKB6KO5D9yw>
    <xme:K2rbY-Xc-Hb1SMbm3JtaeymiBjV-lsXIrRnLaqXdtfTn5M7OaTHBW6S2jC6XdgakR
    hsvo9uIUnJqo8lKGwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:K2rbY7Ij6G4vFP-KV81Zi02oeaHZIK5bURc3zumKqtULgj5FBdoxgA>
    <xmx:K2rbY_GK5FED-2yRirtbltu5CK7ysoGNW3AzRhoX8jzh1CksZDwFjw>
    <xmx:K2rbY_Vyk4MN6aOoQaWjiFO2a9rl_ecu8LPVN6lNvidO49DwUPefnQ>
    <xmx:LGrbY1fZ8XPA9HDRfMAFBORaMa8BTu0oT1P0FwF9ap1ZUyBZwFOJEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1B3DB6044F; Thu,  2 Feb 2023 02:45:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <980912a0-f5a0-4dea-9b5b-565d05bc4a6c@app.fastmail.com>
In-Reply-To: <20230202053113.2782-1-rdunlap@infradead.org>
References: <20230202053113.2782-1-rdunlap@infradead.org>
Date:   Thu, 02 Feb 2023 08:45:29 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>, linux-sh@vger.kernel.org,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] sh: implicit access_ok() needs an #include
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023, at 06:31, Randy Dunlap wrote:
> Building arch/sh/ has a build error/warning that is fixed by
> adding an #include of a header file.
>
> ../arch/sh/include/asm/checksum_32.h: In function 
> 'csum_and_copy_from_user':
> ../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration 
> of function 'access_ok' [-Werror=implicit-function-declaration]
>    53 |         if (!access_ok(src, len))
>       |              ^~~~~~~~~
>
> Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> v2: add Subject: and patch description

Thanks for the fix!

>
>  arch/sh/include/asm/checksum_32.h |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
> --- a/arch/sh/include/asm/checksum_32.h
> +++ b/arch/sh/include/asm/checksum_32.h
> @@ -7,6 +7,7 @@
>   */
> 
>  #include <linux/in6.h>
> +#include <asm-generic/access_ok.h>

This will work correctly, but it is not the intended usage of the
header. Anything in asm-generic/*.h should only be included by
a particular header, usually the asm/*.h with the same name or in this
case the asm/uaccess.h header.

I think the correct fix here is to include asm/uaccess.h instead
of asm-generic/access_ok.h.

      Arnd
