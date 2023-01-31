Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B3682C52
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAaMMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:12:08 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA428850
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:12:07 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k4so15832990vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwKtXvIpXGYzIeHgL+KLVHN88KKoCUct+MmNeO+2FwU=;
        b=cXTGjj9hz82FI7LsZRvgQ4QoPzXdp6g6kta2a0Yz5aoj3hfjGZuCa8uO3OibwzyvIY
         Ao3uoC50OSMqj9bNe0/jO9YG1DEOlmhUXtBdlG7e7Vbxqrh1QyaCAyBsX/+ffUbV5sPd
         EJLcpmLmqU6/Mf88gOtPWd6TUNX7jaHgYANJx19Z6qGXG+cn5wHU1k+kdknHnT5zBUZn
         xvvWvkIDyYs1ma8EyTNfpEf068g8tmBE+fiJ/xxxUa+ZO5vmrL8VP7WqA/BR9mTF5BPW
         3AWVffCcIJhJA8w3gRwQSa4lruB6GgLq18n/EW/JfA95dd3B5tHdEumCclDCEIJ6X1/5
         uFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwKtXvIpXGYzIeHgL+KLVHN88KKoCUct+MmNeO+2FwU=;
        b=Z24D7+FuYVM7TOX+oRgOmAsvTqlzlXyLrdK0kSuZzglpFHpbyQvFZpt82iztXJ2oB/
         kXNKYWZ5ClzJciJDiNEknO+oJjhXhL9xj3xXFQHf22ZsvdZIz+l0rcZXqPPyKTn8CkbO
         Bvv6zxo8YiZYRahLN/hLanPGdsjgZPGYhu+o1gsj3lEstscsn14NhGqARph/2v3b0+sX
         TMc/bL2iJl2fjfKXz5t/gkOXXhCK31cIVK5bMLuT1avLhbFpBaeuW6ZXI8syIppHQAlt
         MEICgjGnbG1Z3MfCGkTc0WKfR5i4568GtIIMzgigk0tY/vSkwPa1dSFHc4B0xF1Wv7Mo
         woWQ==
X-Gm-Message-State: AO0yUKVYJ2NsgwSTyFs/H1QAquXXlYV8cF+Sdzryr/7Bj/4Ks6NfquNt
        H1nCcHREvqNsSADCmlDqhbRVnElp3C5dRZ6WGRFwZw==
X-Google-Smtp-Source: AK7set/mFcDjxeWaqyuAxnPCpi1I8kiD2k3zh/lyipwuTfGuJc0AZnWRXW7F+vNuv/o89K3kxbvZNsMQoqa3NEfePgA=
X-Received: by 2002:a67:c31e:0:b0:3ed:1e92:a87f with SMTP id
 r30-20020a67c31e000000b003ed1e92a87fmr2324410vsj.1.1675167126314; Tue, 31 Jan
 2023 04:12:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <d9c6d1fa0ae6e1e65577ee81444656c99eb598d8.1675111415.git.andreyknvl@google.com>
In-Reply-To: <d9c6d1fa0ae6e1e65577ee81444656c99eb598d8.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 13:11:30 +0100
Message-ID: <CAG_fn=XRQ_wn5+TO2Djh7bXH_jLKpHgPLabDyXuFBTaOd=9v1w@mail.gmail.com>
Subject: Re: [PATCH 12/18] lib/stackdepot: rename handle and slab constants
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

On Mon, Jan 30, 2023 at 9:51 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Change the "STACK_ALLOC_" prefix to "DEPOT_" for the constants that
> define the number of bits in stack depot handles and the maximum number
> of slabs.
>
> The old prefix is unclear and makes wonder about how these constants
> are related to stack allocations. The new prefix is also shorter.
>
> Also simplify the comment for DEPOT_SLAB_ORDER.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
