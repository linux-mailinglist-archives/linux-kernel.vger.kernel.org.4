Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11617347D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFRSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFRSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 14:53:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2621BB;
        Sun, 18 Jun 2023 11:53:23 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:53:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1687114395;
        bh=rLTd3jpeF1FaigKyO68fT4DEucsRqZYkjGpFz56TY1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8p6aQpS1h6Vj8KyaE/d+OPQtiY0JJejyn81bL5ZMtRTUhripMvDJhsw8hMX2xBmE
         nMwA3CGF36yE50tujmrVOB8qW98lzXcWPGxE/WDn7rFUv6KXlvkLCEa3kGd5RvciIv
         q4EpoWDpRxIwsqe9QRnIrVK4l/MXxNfFLUvXisCU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v17 00/13] hp-bioscfg driver
Message-ID: <207d43d3-ae23-4b6e-a75a-5632e0dd66c5@t-8ch.de>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 2023-06-08 11:33:06-0500, Jorge Lopez wrote:
<snip>

> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

<snip>

> 
>  .../testing/sysfs-class-firmware-attributes   |  101 +-
>  MAINTAINERS                                   |    6 +
>  drivers/platform/x86/hp/Kconfig               |   16 +
>  drivers/platform/x86/hp/Makefile              |    1 +
>  drivers/platform/x86/hp/hp-bioscfg/Makefile   |   11 +
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    |  312 +++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 1055 +++++++++++++++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  |  487 ++++++++
>  .../x86/hp/hp-bioscfg/enum-attributes.c       |  447 +++++++
>  .../x86/hp/hp-bioscfg/int-attributes.c        |  409 +++++++
>  .../x86/hp/hp-bioscfg/order-list-attributes.c |  436 +++++++
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  543 +++++++++
>  .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  386 ++++++
>  .../x86/hp/hp-bioscfg/string-attributes.c     |  390 ++++++
>  .../x86/hp/hp-bioscfg/surestart-attributes.c  |  132 +++
>  15 files changed, 4730 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

That looks much better now! Thanks for all the resubmissions.

For the full series:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>


Thomas
