Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91A6F8F8D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEFG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:57:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47CAD14;
        Fri,  5 May 2023 23:57:52 -0700 (PDT)
Date:   Sat, 6 May 2023 08:57:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683356270; bh=qfP1uGBATJXPyIAjGfTIHMkkkfcGfotoiwlxjMWok9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oT9Ok1fy263u636kVgx+NMETMgaV0aRO9Fehf8aNE2NrvWrEdJ/Swye8PFE4puwtH
         LGqI+7lywvW+bBPlbQUJ3yRsOKHNzvP40hEnI0Ch5rRwOaqur63qu8lJTMscsX/8Dr
         drFX75pJ0md5WNadAemfyry0Nt/wTv9QvbW70DBs=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/13] HP BIOSCFG driver
Message-ID: <b87d1a4c-9624-4df8-98ba-f2560b7df18b@t-8ch.de>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 17:00:30-0500, Jorge Lopez wrote:
<snip>

> Jorge Lopez (13):
>   HP BIOSCFG driver - Documentation
>   HP BIOSCFG driver  - biosattr-interface
>   HP BIOSCFG driver  - bioscfg
>   HP BIOSCFG driver  - int-attributes
>   HP BIOSCFG driver  - ordered-attributes
>   HP BIOSCFG driver  - passwdobj-attributes
>   HP BIOSCFG driver  - string-attributes
>   HP BIOSCFG driver  - bioscfg-h
>   HP BIOSCFG driver  - enum-attributes
>   HP BIOSCFG driver  - spmobj-attributes
>   HP BIOSCFG driver  - surestart-attributes
>   HP BIOSCFG driver  - Makefile
>   HP BIOSCFG driver  - MAINTAINERS

These could be reordered a bit to be easier to read.

* Documentation
* bioscfg-h
* bioscfg
* biosattr-interface
* *-attributes
* Makefile
* MAINTAINERS

Also currently the subject spacing is currently inconsistent.
Something like "hp-bioscfg: foo" would be more in line with the rest of
the kernel.

> 
>  .../testing/sysfs-class-firmware-attributes   | 117 ++-
>  MAINTAINERS                                   |   6 +
>  drivers/platform/x86/hp/Kconfig               |  16 +
>  drivers/platform/x86/hp/Makefile              |   1 +
>  drivers/platform/x86/hp/hp-bioscfg/Makefile   |  12 +
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 982 ++++++++++++++++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 523 ++++++++++
>  .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 +++++++++
>  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++
>  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 +++++++++++
>  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 +++++++
>  .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++
>  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 +++
>  15 files changed, 4860 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> 
> --
> 2.34.1
> 
