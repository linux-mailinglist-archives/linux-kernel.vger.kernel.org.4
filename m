Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A66FB90F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjEHU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:57:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA38171C;
        Mon,  8 May 2023 13:57:46 -0700 (PDT)
Date:   Mon, 8 May 2023 22:57:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683579464; bh=kqExthNR9GzxjMGAmc95qMqSGSf6hPUVTZc/Qo9LbYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoeV7TciRKwlK+YAnRCqSzBWRs3uD6YcBWhTEL5OWw9ro3+rakQuZlHtXAae518AD
         jNQ2GdW+go4tBrVVRQAYx8vvD8xB/mQvN0yp2QQWI1IGXXP73gmBKP32z4r0noHhYJ
         7LPiEYFtu6l9F3hU1Kbp2c5jit/stzPw7xxsW2ds=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/13] HP BIOSCFG driver
Message-ID: <3bff7eeb-72ef-42c0-b569-cd93355ab7ed@t-8ch.de>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 2023-05-05 17:00:30-0500, Jorge Lopez wrote:

<snip>

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

Unfortunately I'm not sure I'll find enough time this week for a full
review of this revision.

I'll review bit by bit as time permits.

Thomas
