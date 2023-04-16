Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09586E36E4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDPKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDPKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:02:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697CE69;
        Sun, 16 Apr 2023 03:02:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e3so10629348qtm.12;
        Sun, 16 Apr 2023 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639328; x=1684231328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZxoONYjpiy9MbL4YVRp8r9eBFiaHPQlZt2qQpuRD4E=;
        b=dQmdjtW//P7QvRzA1jFWg/37TrB91+CVHWJc7uOBy7vtwvOCFesVXJJFUUNR0Okvtz
         1n2croOfOLaaYQG6dneCb9LUqgG4SD7keQYz8A/4ofuVJpBCpJwcUIMACAYe0rOwzBuQ
         XdfooiY2KlxVs05fT/BCO30VDjxsJZRFLbGTZOlA0+EcFCkOXiG3j/ZAkf9pQIeiOLgt
         kkpL6CfRQTvHpAokWVtJGXiQsXeW8ekJf0GK3FB6UcaRtpHP9uKd9YHzJPVGtUYaxFZ0
         VTBsTtqEtiY+Fhh8rn5nzk6MY9ItvL6J0pwQklkGRIPPM33JFwRm4qX2C0IliDIB24pD
         7Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639328; x=1684231328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZxoONYjpiy9MbL4YVRp8r9eBFiaHPQlZt2qQpuRD4E=;
        b=Z7Fr/4RdwV9/4yczHtEHLyM7f39bwnpAYMLSKu4bz/6XVWMI9o1Do1MjmqoVnJqc9T
         u/J4zikorj5dcoySfqJnDYU+QiMcnx5jmOCjtHu7kVqOefXL+41MQb4plI0PrLocJ05e
         mTZzdxnzEZuqnvpucopl076Cu02XXWwpOvoGqQrOZ6f6jiM9Go3yXCLgYaGCW3rVnu31
         l5/tEbxVP+xXXbfuQbvBEocuz1W7zxuWZPXcBRQWMurGlzLd+P67asLeLiu3RRC5XHE6
         pDBaK9o5tDDjdUED+/KcbncmgagM6sJ7+950VlguwAFPV0qZ25km8YBf0jF+E+aIafmT
         co3Q==
X-Gm-Message-State: AAQBX9ffotBkknIBjLoFluVFRbYyli675BiqDRyhZYK+Med8NLtqoz5c
        0bZJJbd997lQo/Ub8WWCTqsLjdgJDRfhjp0Ovhz7Xa6isLs=
X-Google-Smtp-Source: AKy350Z47+6bGxd1xRNHZnacl2G7aVI+x9MNtKPtsyKz0oTUv0XV1DinXFuPbSmxP5mkntBADuGSYGcFlwRkwkGdGGQ=
X-Received: by 2002:a05:622a:1a9b:b0:3e8:f79d:bdfa with SMTP id
 s27-20020a05622a1a9b00b003e8f79dbdfamr3499947qtc.0.1681639328272; Sun, 16 Apr
 2023 03:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <ZDuhnLPczec5qJnq@yoga>
In-Reply-To: <ZDuhnLPczec5qJnq@yoga>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 16 Apr 2023 13:01:32 +0300
Message-ID: <CAHp75Veaqp4O1jcBHZZh2L5ReMU1+2vH+FfRzfLyY8CdwZwq+w@mail.gmail.com>
Subject: Re: [PATCH] Staging: media: atomisp: include: mmu: include
 <linux/processor.h> instead of <asm/processor.h>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     hdegoede@redhat.com, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        andy@kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:20=E2=80=AFAM Anup Sharma <anupnewsmail@gmail.co=
m> wrote:
>
> Fix following checkpatch.pl warning by including
> <linux/processor.h> instead of <asm/processor.h>

Missing period at the end. But the entire patch seems unnecessary
since it's all about x86, and we have more arch headers there anyway.
Anyway it's up to Hans. Also see below.

...

>  #include <asm/intel-family.h>
> -#include <asm/processor.h>
> +#include <linux/processor.h>
>
>  #include <linux/i2c.h>
>  #include <media/v4l2-subdev.h>

This seems a bit chaotic with the ordering of the headers here.

...

If you want a good patch, you need to understand what headers are
_really_ being used in the header file. Then drop unused, try to
compile that and fix all files that will have missing headers after
that. This will be a very useful clean up!

--=20
With Best Regards,
Andy Shevchenko
