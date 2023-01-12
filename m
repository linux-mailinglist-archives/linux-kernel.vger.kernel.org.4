Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B1666FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjALKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjALK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:29:12 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3E34D56
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:26:44 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4d4303c9de6so82201987b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fG/qOjXUfppGChnP3Lxtdh/yMmyW83w+zHL2i0LLc24=;
        b=WUIs1LZAtLAYFyTenvjo6sLHPTIrx6Ckh+t+2odL1LQlQ3jnwb4mkjaLi29nvciLx/
         FSO7qS6IEnwChhrMTrEOkMwjfi0ke53kXKWPhaFDFMvZHHs5VYAug3N4RAkVzCmVgocW
         cdbL0SueFQoTNjMyV7hWwJxBkYT9vsqWB+UgvHxm3OU6cRYAeNvDzUgvWWSPlENqDI2E
         aiYO6ZKTufJVlRQlynTKTSB3xD9/kiAU5X03ym7XMaJ0s2Z1srijP6a+aH8svR+j/CfU
         QNsPCQtYXIu+BIMdaAI3lKr9oKKHBDPSfhz3aCtD/ei/jx1/wMf+ZSJWEFC0qkHRIDtw
         3piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG/qOjXUfppGChnP3Lxtdh/yMmyW83w+zHL2i0LLc24=;
        b=0D5WMn+0LRjF3sx0hNMnctEGGy7YOPtXLue8zIQYEptjMZ+anSR6iKxtJl4SqQEpeU
         KJc8lNiGnKRcV663fOmPJA0NZFX5Niq5ogZydjfwDmoQs3xKmELtpJPcyPAXcDOTfNwz
         JsNnfRiMvlTENV3H2SImwDRY06tbmSEMltxTxuy85jfQzWvleD4WptD1aXWq4f3jvYHU
         ZOCebpxxHa9kyk9zevXAYhQ07NUxykV4HhEUZ1JeY703J90kOHPABEGAENCui49wywow
         ehprYUG5iD4v0dY7U5wXEwTTunnqA0TFDoFEm2QIT3IB1WjrREBEcsvByYJw8e9n5Mdp
         VHIQ==
X-Gm-Message-State: AFqh2kqe9nlRVioZw6eUc/x05WasH8TGSmjEDjs6/2kKwIu/Tj6DoBeH
        NRVe4l8dFsZIP0ZjrX/oEx2wbiztd6reNJxvkHeBuA==
X-Google-Smtp-Source: AMrXdXvsc1UG/zzCOdBL0lV5XfrXxwWjdZOsYD0tBmWdq+MlumYWj/JWY7nkCbBUjhudSXh2A0Zo+yiebu1ted0dLjo=
X-Received: by 2002:a0d:e60b:0:b0:3ec:2e89:409c with SMTP id
 p11-20020a0de60b000000b003ec2e89409cmr2098736ywe.20.1673519203165; Thu, 12
 Jan 2023 02:26:43 -0800 (PST)
MIME-Version: 1.0
References: <202301020356.dFruA4I5-lkp@intel.com> <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
 <CAG_fn=XmHKvpev4Gxv=SFOf2Kz0AwiuudXPqPjVJJo2gN=yOcg@mail.gmail.com>
 <953dda90-5a73-01f0-e5b7-2607e67dec13@suse.cz> <CAG_fn=Vz47zvCDoUENX5kH7Giena+w=yifWbMo28ayAUKU7kyQ@mail.gmail.com>
In-Reply-To: <CAG_fn=Vz47zvCDoUENX5kH7Giena+w=yifWbMo28ayAUKU7kyQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Jan 2023 11:26:04 +0100
Message-ID: <CAG_fn=UvnHd_gVuqkWEC9RLBUjreD-BC8sb67nLD=bq+SP7Zfw@mail.gmail.com>
Subject: Re: mm/kmsan/instrumentation.c:41:26: warning: no previous prototype
 for function '__msan_metadata_ptr_for_load_n'
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 12, 2023 at 10:15 AM Alexander Potapenko <glider@google.com> wrote:
>
> > > Would it also make sense to exclude KMSAN with CONFIG_SLUB_TINY?
> >
> > If the root causes are fixed, then it's not necessary? AFAIK SLUB_TINY only
> > indirectly caused KMSAN to be newly enabled in some configs, but there's no
> > fundamental incompatibility that I know of.
>
> So far I couldn't manage to boot KMSAN with SLUB_TINY, it just dies
> somewhere very early with the following stacktrace:

False alarm, a reduced config works fine with both KMSAN and
SLUB_TINY. Perhaps the one I was trying previously was too heavy.
