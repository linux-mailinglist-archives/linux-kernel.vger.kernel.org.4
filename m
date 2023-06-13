Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34372DFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbjFMKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbjFMKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:39:32 -0400
X-Greylist: delayed 882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 03:39:21 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD410F2;
        Tue, 13 Jun 2023 03:39:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 572CEC5C;
        Tue, 13 Jun 2023 12:14:32 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1686651269; x=1688465670; bh=94135Llpo4X+SaFFGeVF4swSyy+5MGZ6pEN
        GkoD9PzI=; b=COiv4Xy/HgpKYDWq2SGnRCUqZRQUFU8kPYWDbzEk2OvLpBay6z1
        U9DLvTiXU4YERZPI6gUc/yTgvIS3IuvP8kOSPvWkn0l1qTZfWRmq6dQAE1rGYWjs
        rfhNiyhxUobBWE3nuSRo8jjEj4B/k92UQtD+p5iNsV3RZ2rXDedQVSsfYmZmct1V
        1i9a/nA3TZKOwRqNfaDhUPesBJu+i7OTwMIQIg+Tsdbs6w+eoxvR7O2KGY15QatV
        FKupam9oHEa7NKdfZ9mI8sj3nwndNhxknzH0sDPOKY1frrgvPiBbCEVfLNm2CoOF
        fDNSqJsx/k/uBVAv7jwSk0EVnTe5Zc7lvtze2kFYW6+SPq8dtWvaiAo0iJnpZazF
        DKQHKcEpyV3umm89c+Od2I08Lg333Hwrx07XaFVvBuX2S/1HGgjPDwF0a5rJIzL3
        4tiWp9YngvStOgIqlZBzAMEUkm6PIBuZg5RI9rfHHrqNIgg/dpGyPqZtamL4Z2PN
        P+6LyvORze/gBoc0S1+s/kdCIssBrBXXcNmfsLaF5Qr0eVvc6o//SOmY9LQcNG9a
        JNZYfwgn1dJA+LlYzE4zUktSssF0cvO9ArvH/ZWLfuJT/EXCrDi7u0qcocSedyBK
        Y8L7KIQSw8QWFvSkgoCxlWw/O/niNRKHxPVoVJ95zPQl7o1JI7IgKH58=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PzXKXS9F3agU; Tue, 13 Jun 2023 12:14:29 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 33888A6F;
        Tue, 13 Jun 2023 12:14:24 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 358533500;
        Tue, 13 Jun 2023 12:14:24 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 13 Jun 2023 12:14:22 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/4] Rip out simple_strtoll()
In-Reply-To: <20230610025759.1813-1-demi@invisiblethingslab.com>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
Message-ID: <5606bac989cc4ca706d04faf196fc6ab@vaga.pv.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-10 04:57, Demi Marie Obenour wrote:
> It is not used anywhere but its own unit tests.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  Documentation/dev-tools/checkpatch.rst             |  9 ++++-----
>  Documentation/process/deprecated.rst               |  5 ++---
>  .../translations/it_IT/process/deprecated.rst      |  9 ++++-----
>  .../translations/sp_SP/process/deprecated.rst      | 14 +++++++-------
>  include/linux/kstrtox.h                            |  1 -
>  lib/kstrtox.c                                      |  2 +-
>  lib/test_scanf.c                                   | 10 ----------
>  lib/vsprintf.c                                     | 14 --------------
>  8 files changed, 18 insertions(+), 46 deletions(-)

> --- a/Documentation/translations/it_IT/process/deprecated.rst
> +++ b/Documentation/translations/it_IT/process/deprecated.rst
> @@ -118,12 +118,11 @@ Per maggiori dettagli fate riferimento a
> array3_size() e flex_array_size(), ma
>  anche le funzioni della famiglia check_mul_overflow(), 
> check_add_overflow(),
>  check_sub_overflow(), e check_shl_overflow().
> 
> -simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
> +simple_strtol(), simple_strtoul(), simple_strtoull()
>  ----------------------------------------------------------------------
> -Le funzioni simple_strtol(), simple_strtoll(),
> -simple_strtoul(), e simple_strtoull() ignorano volutamente
> -i possibili overflow, e questo può portare il chiamante a generare 
> risultati
> -inaspettati. Le rispettive funzioni kstrtol(), kstrtoll(),
> +Le funzioni simple_strtol(), simple_strtoul(), e simple_strtoull() 
> ignorano
> +volutamente i possibili overflow, e questo può portare il chiamante a 
> generare
> +risultati inaspettati. Le rispettive funzioni kstrtol(), kstrtoll(),
>  kstrtoul(), e kstrtoull() sono da considerarsi le corrette
>  sostitute; tuttavia va notato che queste richiedono che la stringa sia
>  terminata con il carattere NUL o quello di nuova riga.

This is fine

-- 
Federico Vaga
