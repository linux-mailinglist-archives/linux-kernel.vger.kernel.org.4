Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670C6E0E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDMNU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjDMNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:20:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3EAF0E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:20:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y16so195976ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392006; x=1683984006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEYIJxcj5kmzNVXSipi1HyC65eTywMQLwhS5DFReugM=;
        b=tQ6wJTzCLuhE8bfXNSfUCszgAi37G4ZhBl+WQz1oQmfYFytFaCY0Oh67v858OE5AXc
         V/JHLD2pK/I9YKCATu0KIGtLbNWE+Q4heAs/kqfaHUmI+5i3p7MmPvVs8uOMudb2y5hb
         NFjcqWCUQ3ML208RfeF96TWVB3hDsfVakdBsNxx8dS8iY8IFSlM8p8+as1svnuhRaWdi
         wdZeobyTFV5I8AlGyW/GyMaYIYeTLYK0ZXwQBQ/2lLkEAXiWME2lJnddrQATjTz/yPU9
         P65DG16JWYVuRUJjLfxf8rgu2YfakSB1QAyGLkDPIE/PFPLFeyzSl5CbqARP25pGuIRE
         T4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392006; x=1683984006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEYIJxcj5kmzNVXSipi1HyC65eTywMQLwhS5DFReugM=;
        b=cSkl8r9opKNzSXNfG2fal9wR14CdoYx7+uqNv2zSOma+hB6jJ87r2wL9nqbiN5s8sA
         9l61lJobN5kbQauBT1Kn+efheJpX8/1B6goDHfSABy5vbx6M4D3RxWCIv7VgVcJuccQj
         xLIxQ+aoqKzuoJuUC2b/DVagnEl+zowN63BHmYzHRLwOs+HXP+rEbSymQ1tdGKxD0vGF
         B5rgg8Qm2J2/piYcgI4rPqXUGkb5qgXtQpTlnzk3U+uCqA3vv0nLPGH5VbDuugcfK1p7
         TXkHhxt1iU32+44rdkxiOxwlXS6R/rNTdCl8aAoUYCqXVsJ63KooWU7LjDU40O7iuW8G
         b1lQ==
X-Gm-Message-State: AAQBX9f9DQh0PejTKGmyszBMG2i2kXGJ/tOMT4KNSDCz6zEM9Ba7EWMs
        vvy8fOm7M1dPpNegs4Jc6xA+pQWcGo17jNM6UZd9lQ==
X-Google-Smtp-Source: AKy350bze9rRwSEH8mQHkOzRLi/0g5jEhOn91d5G//UCGeCd2mlUYHNEOpMVXezcQc9ZFgn8VYY0YoReb5GDXy4TB7Y=
X-Received: by 2002:a25:d003:0:b0:b8f:32c4:c6f8 with SMTP id
 h3-20020a25d003000000b00b8f32c4c6f8mr1775428ybg.42.1681392006415; Thu, 13 Apr
 2023 06:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412145300.3651840-1-glider@google.com> <202304130223.epEIvA1E-lkp@intel.com>
 <20230412140601.9308b871e38acb842c119478@linux-foundation.org>
In-Reply-To: <20230412140601.9308b871e38acb842c119478@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Apr 2023 15:19:29 +0200
Message-ID: <CAG_fn=Wqf0E0Uo8wA5pdhgpreKZB7TPU-DiyERyG=T7bqqiJ9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, urezki@gmail.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:06=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 13 Apr 2023 02:27:19 +0800 kernel test robot <lkp@intel.com> wrot=
e:
>
> > Hi Alexander,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on akpm-mm/mm-everything]
> >
> > >> include/linux/kmsan.h:291:1: error: non-void function does not retur=
n a value [-Werror,-Wreturn-type]
>
> Thanks, I'll do this:
Thanks!
I sent an updated version of the patch series, which includes your fix
as well as a couple more improvements (__must_check annotations in
particular)
