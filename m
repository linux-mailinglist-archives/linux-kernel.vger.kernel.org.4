Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3269F334
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBVLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBVLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:09:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038940F2;
        Wed, 22 Feb 2023 03:09:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s26so28768988edw.11;
        Wed, 22 Feb 2023 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCeMRo7PjxNEY8Jaw+enjYl4j/3bB4uY9gsYSHQ1VA=;
        b=S5GmhVRjcyzYAoKeziNvoiE+80fV4VT+3K8G5vGN6a9QjPQE97S8fC7ef4Pi2BEB7y
         r+/kToKKkK4V3ou6OYZtduwCGvwdsfH4EUET7hTr684QGHuWygVZZyKLQu8k36VUCqNP
         Tgzo+gcDwS/i5URaje4J+ZFhv+KXjorvIVpVVqB39E0UzV9+ekKi8cwMwuofue2Zuj8/
         +wHmJ9Aw0goCUfSElzoDbKJ+gZu6BYm6/UXyxziREyfT91znNSZp7FScbhvKaETNEJiN
         kquZ0ktxHj4C73bthlnRIoLJw1Bh96zBj4fbC24JETYE5TpJRxNzYlxQv+VcdcrYm3wM
         Om0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSCeMRo7PjxNEY8Jaw+enjYl4j/3bB4uY9gsYSHQ1VA=;
        b=NpKw0Qr7NIrQwya4lfrr1WFUWbFXOHAczkd0bVht+aKkrueV6Z+ypCiGjByM81WXcO
         TDLtZ4W722lg3fztua24AfrqF5VoymStqYgW4CAsaYQyLzY461/wrPjmdpaXBneWZhtm
         39kN81MhpOdyOwQkp6SJGbhHhgnzeBOLwYtxaDAe72Boq0F9c3t054Oy/7BBG1sZjsJ1
         RLioTqA17IUZCNXFZGrSXXtOnMO6rOE4oB65Brpr4ne9m8Fo82vt6Ng1INWSEi1Xk0dc
         NqwQMcq25/UQ5qYGU6dHVIGfImY1nAFYgvcuisOvViIP2t2/qqtcy1lHR2ZJ/a1vl1C0
         oy5g==
X-Gm-Message-State: AO0yUKXVHnsX1d4r9fYAbPUNWSzSDLJ5WOpFVoiwB6udztVT1z5gsV1y
        BEiAJEbR51c43Du2D9yPPQ0cwp5a9t86cofk/nY=
X-Google-Smtp-Source: AK7set92VtYSnl/VgVs5LgZtVGb8q5dSEXEV1i840RMD0mT/RbSv6IxD0BOcFT4z6m2f3tZ6zduKzjbHedNQT0Y2VQg=
X-Received: by 2002:a50:9fae:0:b0:4ad:4c0:c4fb with SMTP id
 c43-20020a509fae000000b004ad04c0c4fbmr3633861edf.3.1677064140403; Wed, 22 Feb
 2023 03:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20230221180049.2501495-1-carlos.bilbao@amd.com> <20230221180049.2501495-2-carlos.bilbao@amd.com>
In-Reply-To: <20230221180049.2501495-2-carlos.bilbao@amd.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Wed, 22 Feb 2023 16:38:43 +0530
Message-ID: <CAPDLWs99LUCQ47huoiiZmQfAsHX8Esmepu_hSCXWoqcpEoPxKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: Add relevant kernel publications to list of books
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, rlove@rlove.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

On Tue, Feb 21, 2023 at 11:30 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> For the list of kernel published books, include publication covering kernel
> debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
> book from Robert Love (ISBN 978-1449339531) and remove extra spaces.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 1c6e2ab92f4e..ce461d981d0a 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -75,13 +75,31 @@ On-line docs
>  Published books
>  ---------------
>
> +    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
> +
> +      :Author: Kaiwan N. Billimoria
> +      :Publisher: Packt Publishing Ltd
> +      :Date: August, 2022
> +      :Pages: 638
> +      :ISBN: 978-1801075039
> +      :Notes: Debugging book
> +
>      * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
>
> -          :Author: Kaiwan N. Billimoria
> -          :Publisher: Packt Publishing Ltd
> -          :Date: 2021
> -          :Pages: 754
> -          :ISBN: 978-1789953435
> +      :Author: Kaiwan N. Billimoria
> +      :Publisher: Packt Publishing Ltd
> +      :Date: 2021
> +      :Pages: 754
> +      :ISBN: 978-1789953435
> +
> +    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
> +
> +      :Author: Robert Love
> +      :Publisher: O'Reilly Media
> +      :Date: June, 2013
> +      :Pages: 456
> +      :ISBN: 978-1449339531
> +      :Notes: Foundational book
>
>      * Title: **Linux Kernel Development, 3rd Edition**
>
> @@ -92,6 +110,7 @@ Published books
>        :ISBN: 978-0672329463
>        :Notes: Foundational book
>
> +
>  .. _ldd3_published:
>
>      * Title: **Linux Device Drivers, 3rd Edition**
> --
> 2.34.1
>

Thanks very much.

A request to incorporate a few minor changes (I applied these small
changes on the latest linux-next I could find):

Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
---
 Documentation/process/kernel-docs.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst
b/Documentation/process/kernel-docs.rst
index 1c6e2ab92f4e..f7ecc04b509b 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,11 +75,20 @@ On-line docs
 Published books
 ---------------

+   * Title: **Linux Kernel Debugging: Leverage proven tools and
advanced techniques to effectively debug Linux kernels and kernel
modules**
+
+          :Author: Kaiwan N Billimoria
+          :Publisher: Packt Publishing Ltd
+          :Date: August, 2022
+          :Pages: 638
+          :ISBN: 978-1801075039
+          :Notes: Debugging book
+
     * Title: **Linux Kernel Programming: A Comprehensive Guide to
Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**

-          :Author: Kaiwan N. Billimoria
+          :Author: Kaiwan N Billimoria
           :Publisher: Packt Publishing Ltd
-          :Date: 2021
+          :Date: March, 2021
           :Pages: 754
           :ISBN: 978-1789953435

-- 
2.34.1

(Hope I haven't botched it).
Also, if I may point out, the 'companion' volume to the Linux Kernel
Programming book, covers some aspects on Linux (character) device
drivers, and is somewhat popular.
Moreover, the e-book / Kindle version is freely downloadable (here:
https://packt.link/free-ebook/9781801079518, or on the Amazon Kindle
site). Could this book be added as well?

Book details:

  * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and
Kernel Synchronization: Create user-kernel interfaces, work with
peripheral I/O, and handle hardware interrupts**
           :Author: Kaiwan N Billimoria
           :Publisher: Packt Publishing Ltd
          :Date: March, 2021
           :Pages: 452
           :ISBN: 180107951X

Thanks,
Kaiwan.
