Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2036946FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBMN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:28:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43C3C1A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:28:02 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r6so4443120ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gb42UgzE9IFoAhtdlpi/Pyg3SPeN3v0rXrGEsBRa7g=;
        b=E1gJIgM6i6uNiQH0mH5azStrG+CTBCFXiugvdVofaImLpgmmoQl25g07MB++1ebtKA
         O9rtt8vd8IgANh3/vKCJm/LuIZPCRs47liqNZBTb4EifwhmgLDz/TRm0e1O0ffP+0EQy
         H5O9Sz8Z832xb9P0EM8cVDKqQOvDGz7eIuUXnsa6bcb6QGZ017P+l1Cmh+KD3aBIY8hW
         KmLAJ+grPxdOYDye0pwQ3yeJkfwgD+wGMMDm/b49EGObdvOruBjs9KfuxJ43fo0A51fk
         QjMTPftW/hpR8L2j+oaMwetoZmKtqdWAj5LRBSybiH0p7iNWpUblEHod+C53kE+mQWHd
         WTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Gb42UgzE9IFoAhtdlpi/Pyg3SPeN3v0rXrGEsBRa7g=;
        b=HwWMDgbzCcz1CVhvpdTltpKAP10S77DgF4WAzQ6NeyGVDYGYX3+g69U3RLT45Lg1YW
         ityZn/Xk/S3+q6dkJrFMWs0KUKvpFMM3FAHm5jqiAOdl/07uvvJzYIrMrON+21fllTSq
         HE3GH2BGzwF+IJ5Gz6nd9rPt9gLF84/c2eG2pY9BZ7am/fWVFrmVkl8wFiZoFkn8TJn5
         /7RseFLozqe3TbKe+mdqVDzX7ju7Il4SAjhyVbpqwNs0zqmD0z79uc/F4EBbKvkYFxlG
         c+hUxh4iBuunD7mMg2CQAM6nKCMfwAwVpUQy5bqL1I+3Tb5US7/h4j85TWqLLZC+mvUO
         n5yQ==
X-Gm-Message-State: AO0yUKV7keNx+txZgEQrpeOAZlDXUqs0uVXiI6Mz+x5BDIbzdXHKLlpT
        VV6Cbhk1B4JsBxEOHfGbUNlbGhKz3udQAH9ZVKB6lg==
X-Google-Smtp-Source: AK7set/caV2aIlg9ftVuB/YHkIPLKFmE8k3eaOUWPmmRwFcqA2fyNdrM7os82ZP6zYAgzpZuJfPAc02pjSIi4nnjG9M=
X-Received: by 2002:a02:a794:0:b0:3ad:3cae:6378 with SMTP id
 e20-20020a02a794000000b003ad3cae6378mr12315762jaj.16.1676294881849; Mon, 13
 Feb 2023 05:28:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <fbfee41495b306dd8881f9b1c1b80999c885e82f.1676063693.git.andreyknvl@google.com>
In-Reply-To: <fbfee41495b306dd8881f9b1c1b80999c885e82f.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 14:27:22 +0100
Message-ID: <CAG_fn=XEP2ETd5c8Pz2Eri2mHpDzewnBLWoQC=_Z3VKke9w_0g@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] lib/stackdepot: move documentation comments to stackdepot.h
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Feb 10, 2023 at 10:19 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Move all interface- and usage-related documentation comments to
> include/linux/stackdepot.h.
>
> It makes sense to have them in the header where they are available to
> the interface users.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> + * For example, KASAN needs to save allocation and free stack traces for each
> + * object. Storing two stack traces per object requires a lot of memory (e.g.
> + * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
> + * stack traces often repeat, using stack depot allows to save about 100x space.
> + *
> + * Stack traces are never removed from stack depot.
... from the stack depot?
