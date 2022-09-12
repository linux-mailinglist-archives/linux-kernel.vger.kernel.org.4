Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE45B5747
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiILJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiILJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:38:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274333412
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:38:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 202so11792208ybe.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=L26glTbFhqAmwvfLLP9peidpMtq2KDp3MGd0AfFzlJ4=;
        b=ZEpIn2HtG2HD8p3ywDU8Xj2OEJnAn2M5TVkMh4TkO+hrzK3FhHYhH9x2O0wh8RpBOt
         0sWLkOzEeNirwPLV4SSN8SBzy1KG1Zs3miE8YEewo8J82BXQfmTpxftPjt7DvFBLFpku
         IgYQambqUdcTaOkAjtffjNNjbK0r1IaBYcLmmCfifFLkRyzTVXBcDsrSftjxG1nFruhj
         O9ii3s17UArG5vTchSscaMwN2ttpASZI5XAJhqZ5p51kBf8Memy0EI+IzCi+a0ERBYjv
         fuwTcWTK46JGcU5NRJJTNXwwIGc2boLtrVokLltVT123B39AY2lsrAOQdLQxxp5zE53P
         2LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L26glTbFhqAmwvfLLP9peidpMtq2KDp3MGd0AfFzlJ4=;
        b=AVMQ/4JSA6DnJQ6eToZF+d4Qummk//1GZc+XhW/miBRIQ6nl5VD1HAJrRhsr4reGXk
         K8+V8dRS1BQ1480RVYqY2bxtplpQldQMqHkIpy476vGnB1LSkhVupG0lThuxMliD+Qcr
         gqnmNmhzj9y7WAFQ7FC8lMuvHjCJQIJYxcYORPlwHQIvCl9G5ktT9rYWAYaJZTm6CKbP
         Lz6HT/URODh44sEWslOwITkJ8ZQdZ9+4by5GL22BWZiw+80a1y/O9s34o9n+O3pYJzeJ
         gteB4bmFSGKcty/Cwiu0CzxCAABu6E+QRfV2zdEkBQze16+hoGY4Yfk7j2YsWnKJxFuU
         Mknw==
X-Gm-Message-State: ACgBeo2SXrFOliHgml4ikV877QWcijDMwm+amoYST36xsVzL5qmEIsUr
        xxzn3UVaFd5jJjo0pAyeEGyD5gubVDZ/qdG3FI4HFw==
X-Google-Smtp-Source: AA6agR44Kb/ZTH8MwLVWVX/wXVm1Xd2iJRoCm/rTR4YKiKsJi58ZRTRubmn0n8qiN/GfteNcMvUdlROvRXUBCjLgC1Q=
X-Received: by 2002:a25:d784:0:b0:6aa:167e:90bb with SMTP id
 o126-20020a25d784000000b006aa167e90bbmr20854352ybg.549.1662975513102; Mon, 12
 Sep 2022 02:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220906202017.5093fd23@canb.auug.org.au> <YxfFzGObDWsylCK+@quark>
 <CAG_fn=UcWy+gbYLDM2WQZ=BZuVRML17KJ0L+=zsSg7+yDo4oGA@mail.gmail.com> <20220907134107.bcb8b9c22b9ae517e3b43711@linux-foundation.org>
In-Reply-To: <20220907134107.bcb8b9c22b9ae517e3b43711@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 12 Sep 2022 11:37:56 +0200
Message-ID: <CAG_fn=V1utoSbPK6Jhnzyy3Fj47k1YS1DZc5M094Bp1GpP5kFQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the crypto tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 10:41 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Wed, 7 Sep 2022 11:18:24 +0200 Alexander Potapenko <glider@google.com>=
 wrote:
>
> > What's the best way to handle this? Send another patch series? Or
> > maybe just an update for "crypto: kmsan: disable accelerated configs
> > under KMSAN"?
>
> I'd prefer the minimal update, please.

As a heads-up, I mailed "x86: crypto: kmsan: revert !KMSAN
dependencies" and "crypto: x86: kmsan: disable accelerated configs in
KMSAN builds" last week. No rush though, guess you're busy with LPC
this week.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
