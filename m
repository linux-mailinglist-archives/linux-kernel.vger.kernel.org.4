Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D371911D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjFADNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFADN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:13:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7633126;
        Wed, 31 May 2023 20:13:26 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39a53c7648fso235141b6e.1;
        Wed, 31 May 2023 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685589206; x=1688181206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEz3Hdwc/Pbg3mN7hwMGGRbpBDgnZmUWsX+o5KaEGHo=;
        b=lxggee3BHOZkL/1h1VdyUfR4ifEcYw0TVyqByADfr7zKwcm9KCliBGOtPX6wut63MU
         3WuySIDl5HSEjvia86sngMuCKlz5bqUkAsQvzQFESIA4ABIZbjUUOPlQMfIw2Qts3jgY
         s1j7WkKT17tBVFhXRmrbIqj/882rNyRpg81oVBymYT4BG8/grRK5Jr18tjT0qe37+hVq
         nccNfRvl2DbJa8l6tl1AfK0DEfOZn/fo7J6bsjZYDGcWNasA5g/FJBUixodKgMXpsLWT
         JxbNXNHAYlUlxlttaQYUaxqZs7KNumDHu8OrsK4ynqtqKJtA2Lqnpp4k8bLr0fExS+o0
         Kk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685589206; x=1688181206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEz3Hdwc/Pbg3mN7hwMGGRbpBDgnZmUWsX+o5KaEGHo=;
        b=X8xoE/O+dUoarqz3kz+Xk7CeQJ8ml+dqTOAy3EOyan2IA0hZ5ZR5nDGKhEad+J4h/y
         1soDxC3wXCqad1R/tGTde7QA70Rkqulo4k4wUkuBB7lbD4nah/PzjPWFagM6IMA9YMVr
         dHzJRMakgxY7TKjpErLlwKToD8U/+HPSdLcuNgasf1lzHLOxOQzs5SWuZPQXA0f+8Khk
         LI0tsaNaiYIh0L0RuojuYqmTY/Zy1K1+PSfFX1+zYqbPLzg8HEnqF9jXt6bQdMdtnPcd
         QTGt12mZNB21TVf+i9JHHXlCmjNeEbD9fYMsYAtjY0FDNHCe+0GT3s0cNRl/qNFcyMEZ
         fl/w==
X-Gm-Message-State: AC+VfDxWZzRnL3AvN6Ys2+ifN0M3aw9fiylzu32Uoy94mHRzHY48Wv/6
        LooLMV5EA/lJ8YL5Ff5TGZjrndDWUHinPQ==
X-Google-Smtp-Source: ACHHUZ4ayVbQaaNYn425M9Jc9gzcf1WkrX5vIPSFR9zop410em218mM8H/REIM5eTMMSQcZJ0h8Isw==
X-Received: by 2002:a05:6808:3311:b0:398:2484:f783 with SMTP id ca17-20020a056808331100b003982484f783mr5668395oib.7.1685589205996;
        Wed, 31 May 2023 20:13:25 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b0065001705ea5sm3099614pfh.193.2023.05.31.20.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 20:13:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 82D3E106A05; Thu,  1 Jun 2023 10:13:22 +0700 (WIB)
Date:   Thu, 1 Jun 2023 10:13:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: organize subsystems
Message-ID: <ZHgM0qKWP3OusjUW@debian.me>
References: <d1e4436e-b428-0f49-ecf1-079955aaecb2@gmail.com>
 <20230531101715.3256681-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531101715.3256681-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 01:17:15PM +0300, Costa Shulyupin wrote:
> as requested.
> 
> Add classes:
> * Core subsystems
> * Storage interfaces
> * Networking interfaces
> * Peripherals interfaces
> * Embedded interfaces
> * Other subsystems

This is v2, right? If so, please properly version your patch(es).

> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 87 +++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 55c90d5383ef..20655f6092c2 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -10,6 +10,22 @@ is taken directly from the kernel source, with supplemental material added
>  as needed (or at least as we managed to add it — probably *not* all that is
>  needed).
>  
> +Core subsystems
> +---------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   core-api/index
> +   driver-api/index
> +   scheduler/index
> +   timers/index
> +   locking/index
> +   cpu-freq/index
> +   mm/index
> +   power/index
> +
> +
>  Human interfaces
>  ----------------
>  
> @@ -22,46 +38,71 @@ Human interfaces
>     gpu/index
>     fb/index
>  
> -**Fixme**: much more organizational work is needed here.
> +
> +Storage interfaces
> +------------------
>  
>  .. toctree::
>     :maxdepth: 1
>  
> -   driver-api/index
> -   core-api/index
> -   locking/index
> -   accounting/index
> +   filesystems/index
>     block/index
>     cdrom/index
> -   cpu-freq/index
> -   fpga/index
> -   i2c/index
> -   iio/index
> +   scsi/index
> +   target/index
> +
> +
> +Networking interfaces
> +---------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     isdn/index
>     infiniband/index
> -   leds/index
>     netlabel/index
>     networking/index
> -   pcmcia/index
> -   power/index
> -   target/index
> -   timers/index
> +   mhi/index
> +
> +
> +Peripherals interfaces
> +----------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   usb/index
> +   PCI/index
> +   hwmon/index
> +   leds/index
> +
> +
> +Embedded interfaces
> +-------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   fpga/index
> +   i2c/index
> +   iio/index
>     spi/index
>     w1/index
> +   peci/index
> +
> +Other subsystems
> +----------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   accounting/index
> +   pcmcia/index
>     watchdog/index
>     virt/index
> -   hwmon/index
>     accel/index
>     security/index
>     crypto/index
> -   filesystems/index
> -   mm/index
>     bpf/index
> -   usb/index
> -   PCI/index
> -   scsi/index
>     misc-devices/index
> -   scheduler/index
> -   mhi/index
> -   peci/index
>     wmi/index

There is more to be sorted, though (and mind patch description, because I
rewrite it):

---- >8 ----
From 81bcb6042497a829ec4e3880cb75fc5c7e7e4e2b Mon Sep 17 00:00:00 2001
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 31 May 2023 13:17:15 +0300
Subject: [PATCH] Documentation: subsystem-apis: Categorize remaining
 subsystems

There is a FIXME that says to organize subsystems listed in
subsystem-apis.rst. Fulfill it by categorize remaining subsytems
by purpose/themes, while sorting entries in each category.

HID devices are already categorized in 3c591cc954d56e ("docs:
consolidate human interface subsystems").

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/r/20230531101715.3256681-1-costa.shul@redhat.com
[Bagas: rewrite patch description to be clearer and categorize a few more subsystems]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/subsystem-apis.rst | 123 ++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 35 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 55c90d5383ef88..2c0b18a66e4e00 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -10,58 +10,111 @@ is taken directly from the kernel source, with supplemental material added
 as needed (or at least as we managed to add it — probably *not* all that is
 needed).
 
+Core subsystems
+---------------
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   cpu-freq/index
+   driver-api/index
+   locking/index
+   mm/index
+   power/index
+   scheduler/index
+   timers/index
+   wmi/index
+
 Human interfaces
 ----------------
 
 .. toctree::
    :maxdepth: 1
 
-   input/index
-   hid/index
-   sound/index
-   gpu/index
    fb/index
+   gpu/index
+   hid/index
+   input/index
+   sound/index
 
-**Fixme**: much more organizational work is needed here.
+Storage
+-------
 
 .. toctree::
    :maxdepth: 1
 
-   driver-api/index
-   core-api/index
-   locking/index
-   accounting/index
    block/index
    cdrom/index
-   cpu-freq/index
+   filesystems/index
+   pcmcia/index
+   scsi/index
+   target/index
+
+
+Networking
+----------
+
+.. toctree::
+   :maxdepth: 1
+
+   bpf/index
+   infiniband/index
+   isdn/index
+   mhi/index
+   netlabel/index
+   networking/index
+
+
+Peripherals and devices
+-----------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   PCI/index
+   hwmon/index
+   leds/index
+   misc-devices/index
+   usb/index
+
+
+Embedded systems
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
    fpga/index
    i2c/index
    iio/index
-   isdn/index
-   infiniband/index
-   leds/index
-   netlabel/index
-   networking/index
-   pcmcia/index
-   power/index
-   target/index
-   timers/index
+   peci/index
    spi/index
    w1/index
-   watchdog/index
-   virt/index
-   hwmon/index
-   accel/index
-   security/index
+
+Integrity
+---------
+
+.. toctree::
+   :maxdepth: 1
+
    crypto/index
-   filesystems/index
-   mm/index
-   bpf/index
-   usb/index
-   PCI/index
-   scsi/index
-   misc-devices/index
-   scheduler/index
-   mhi/index
-   peci/index
-   wmi/index
+   security/index
+
+Virtualization
+--------------
+
+.. toctree::
+   :maxdepth: 1
+
+   virt/index
+
+Miscellaneous
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
+   accel/index
+   accounting/index
+   watchdog/index
-- 
An old man doll... just what I always wanted! - Clara

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
