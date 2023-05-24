Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34670F01D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjEXIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbjEXIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:04:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575F91
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:04:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25533eb3e5dso562518a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684915491; x=1687507491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCXe9wpGobKobnhNJNDfQmFcDDPhlo9IeOCxeO12Qzw=;
        b=xh4/zjcx9pjBjorqzgTQuGQh0UR/y2zLdeH1lH1EnEo7E8pcw2lp7xSaT9tNGFx45t
         AoLc0aAhQvCXsr4igvu05jiwE8vk3qj5g2hfJU/H/y14QZtx42LhTNuLG0uyISxjNgje
         n+cAMbTwqIZPnreY2sIbzyNc5A17eS8Nc2RcwOdhYeSgrFyoceAMsKjcjm75a+ZKu0PD
         pKV/ZZ5X0Wg/XrlkN6G4qnQtAmV2k5NqPMDGWFCAeK4nzeTFLvP3R5QBuYs296Se4jij
         t+CNq69ZB/+Gq+8skYvAHfOFTgAadLSilLBpTtCzQhroVtEkIJ9mPXW6hdq/x2tWFDJS
         Fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915491; x=1687507491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCXe9wpGobKobnhNJNDfQmFcDDPhlo9IeOCxeO12Qzw=;
        b=Y1kFKrj1oDtZbleqQJa6zvawqZNZGH/+PvJA2KJhD4FSKtN8B/z6PXdpYOSIFBbCvK
         m+eMUwELAEea4GdXj4YBI3YTLTH4aLSkjVzaJrddXjnWjZOnWm26jZXXDiwksGUOks5U
         toe8583/pKo6aTkFQvTa22nztE+iEKApMGk/uzzEvTPvr8vXV07pk1udhXRG4w6ovgyt
         PEGCEt4hONeVvUmStwnfP0ODTviGJB33Jbni7qyML2/xIyieM/iQUvueERQCE7LlBfTK
         //xFhwHCA2LczK4biJf+esRKl6usiEYmTxHfnJoAcRCwCQ4IBlsaxifAjoha1yZQjwVT
         /X1w==
X-Gm-Message-State: AC+VfDw4IuSnhRAZQGXKAtp8rI+RLEac3p+PROWz6xRlEclh53o7bjd0
        fIUZ2vM4tSB/EXCWiUzND5btZQyVxSQi/cIGxfklzw==
X-Google-Smtp-Source: ACHHUZ4l0bcfIYPhFemfwItjuek5lVevwVFOC/bZBLTHHbGE+vQq8hAuOarmLawCYhyiqDgOdkXapuxMlpJG5pjahVY=
X-Received: by 2002:a17:90b:954:b0:24e:10b3:c9cc with SMTP id
 dw20-20020a17090b095400b0024e10b3c9ccmr14368535pjb.14.1684915491339; Wed, 24
 May 2023 01:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230511065330.26392-1-mike.leach@linaro.org> <PH0PR18MB5002D43DD267B8E778EC634DCE419@PH0PR18MB5002.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB5002D43DD267B8E778EC634DCE419@PH0PR18MB5002.namprd18.prod.outlook.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 24 May 2023 09:04:40 +0100
Message-ID: <CAJ9a7Vh1dStKR7XH-NGpF4UZ3tQqzee5NeEahPGT-Mk6MY1TsA@mail.gmail.com>
Subject: Re: [EXT] [PATCH v6 0/6] coresight: syscfg: Add config table load via configfs
To:     Linu Cherian <lcherian@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linu



On Wed, 24 May 2023 at 05:48, Linu Cherian <lcherian@marvell.com> wrote:
>
> Hi Mike,
>
> > -----Original Message-----
> > From: Mike Leach <mike.leach@linaro.org>
> > Sent: Thursday, May 11, 2023 12:23 PM
> > To: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
> > kernel@vger.kernel.org
> > Cc: acme@kernel.org; Mike Leach <mike.leach@linaro.org>
> > Subject: [EXT] [PATCH v6 0/6] coresight: syscfg: Add config table load via
> > configfs
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > This set extends the configuration management support to allow loading and
> > unloading of configurations as structured tables.
> >
> > The existing coresight configuration configfs API is additionally extended to
> > use this table functionality to load and unload configuration tables as binary
> > files.
> >
> > This allows coresight configurations to be loaded at runtime, and
> > independently of kernel version, without the requirement to re-compile as
> > built in kernel modules.
> >
> > Additional attributes - load and unload are provided to in the /config/cs-
> > syscfg subsytem base group to implement the load functionality.
> >
> > The load attribute is a configfs binary attribute, loading the configuration
> > table in a similar way as the ACPI table binary attribute for that sub-system.
> >
> > The configfs binary attribute mechanism supplies a strictly size limited kernel
> > buffer, providing better safety than other mechnisms, and also has the
> > advantage of being accessible directly from the command line, and being part
> > of the existing upstream coresight configuration mechanism in configfs
> >
> > Configurations loaded in this way are validated and loaded across the entire
> > system of components atomically. If any part fails to load then the whole
> > configuration load will be cancelled.
>
> Currently configuration load is restricted to ETMs alone, CMIIW. Do you have plans to
> extend the generic configuration load support to CTI component as well ?
>

Yes CTI support is in a follow up set.

This set enables the load mechanisms - there are two follow up sets -
the first that extends ETM support, and a second that allows
programming of CTIs and other components as well.

Regards

Mike

> >
> > Routines to generate binary configuration table files are supplied in
> > ./tools/coresight.
> >
> > Example generator and reader applications are provided.
> >
> > Tools may be cross compiled or built for use on host system.
> >
> > Documentation is updated to describe feature usage.
> >
> > Changes since v5:
> > 1) Possible memory leak removed.
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > 2) Reuse mechanism for reader code revised. (Christoph)
> > 3) Unload mechnism now by name in standard attribute, rather than entire
> > file
> > 4) Mechanism to check last loaded configuration can be unloaded.
> > 5) Documentation updates.
> >
> > Changes since v4:
> > 1) Update coresight/next - 6.1-rc3
> > 2) Update to lockdep fixes to avoid read lock race in configfs.
> >
> > Changes since v3:
> > 1) Rebase & tested on coresight/next - 5.19-rc3 - which includes the fix patch
> > for earlier configfs works.
> > 2) Lockdep investigations resulted in re-design of some of the code accessing
> > configfs.
> > 3) moved load and unload attributes to root of cs-syscfg. (Mathieu)
> > 4) Additional minor fixes suggested by Mathieu.
> > 5) Memory for configfs loaded and unloaded configurations is now explicitly
> > freed.
> > 6) LOCKDEP nesting fix for configfs base code (fs/configfs/dir.c)
> >
> > Changes since v2:
> > 1) Rebased & tested on coresight/next - 5.18-rc2
> > 2) Moved coresight config generator and reader programs from samples to
> > tools/coresight. Docs updated to match. (suggested by Mathieu)
> > 3) userspace builds now use userspace headers from tools/...
> > 4) Other minor fixes from Mathieu's review.
> >
> > Changes since v1:
> > 1) Rebased to coresight/next - 5.16-rc1 with previous coresight config set
> > applied.
> > 2) Makefile.host fixed to default to all target.
> >
> > Mike Leach (6):
> >   coresight: config: add config table runtime load functionality
> >   coresight: configfs: Update memory allocation / free for configfs
> >     elements
> >   coresight: configfs: Add attributes to load config tables at runtime
> >   coresight: config: extract shared structures to common header file
> >   coresight: tools: Add config table file write and reader tools
> >   Documentation: coresight: docs for config load via configfs
> >
> >  .../trace/coresight/coresight-config.rst      | 265 ++++++++-
> >  MAINTAINERS                                   |   1 +
> >  drivers/hwtracing/coresight/Makefile          |   3 +-
> >  .../coresight/coresight-config-desc.h         | 105 ++++
> >  .../coresight/coresight-config-table.c        | 431 +++++++++++++++
> >  .../coresight/coresight-config-table.h        | 151 ++++++
> >  .../hwtracing/coresight/coresight-config.h    |  98 +---
> >  .../coresight/coresight-syscfg-configfs.c     | 513 ++++++++++++++++--
> >  .../coresight/coresight-syscfg-configfs.h     |   5 +
> >  .../hwtracing/coresight/coresight-syscfg.c    | 101 +++-
> >  .../hwtracing/coresight/coresight-syscfg.h    |   6 +-
> >  tools/coresight/Makefile                      |  56 ++
> >  tools/coresight/coresight-cfg-bufw.c          | 309 +++++++++++
> >  tools/coresight/coresight-cfg-bufw.h          |  26 +
> >  tools/coresight/coresight-cfg-example1.c      |  62 +++
> >  tools/coresight/coresight-cfg-example2.c      |  95 ++++
> >  tools/coresight/coresight-cfg-examples.h      |  25 +
> >  tools/coresight/coresight-cfg-file-gen.c      |  61 +++
> >  tools/coresight/coresight-cfg-file-read.c     | 227 ++++++++
> >  tools/coresight/coresight-config-uapi.h       | 105 ++++
> >  20 files changed, 2503 insertions(+), 142 deletions(-)  create mode 100644
> > drivers/hwtracing/coresight/coresight-config-desc.h
> >  create mode 100644 drivers/hwtracing/coresight/coresight-config-table.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-config-table.h
> >  create mode 100644 tools/coresight/Makefile  create mode 100644
> > tools/coresight/coresight-cfg-bufw.c
> >  create mode 100644 tools/coresight/coresight-cfg-bufw.h
> >  create mode 100644 tools/coresight/coresight-cfg-example1.c
> >  create mode 100644 tools/coresight/coresight-cfg-example2.c
> >  create mode 100644 tools/coresight/coresight-cfg-examples.h
> >  create mode 100644 tools/coresight/coresight-cfg-file-gen.c
> >  create mode 100644 tools/coresight/coresight-cfg-file-read.c
> >  create mode 100644 tools/coresight/coresight-config-uapi.h
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send an
> > email to coresight-leave@lists.linaro.org



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
