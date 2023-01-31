Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4AF682AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjAaKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:38:27 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900537EC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:38:26 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id r12so2830685uaf.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FR83tVbeEjgy0Oli/8j0skm7nFq9FbEOCLhEuugDSs=;
        b=iPwvJeD3/p11kF8yQm7dA7l1EVnHenYYsiI9kgvUR9O9fzvF5c4qnNVYzdDhuxfV1m
         jnO8Zdx1d/OqnSgRdnALXjOe6dgV62gQdzs2xzJdsgpHfKdWtHGSZTaa161CiLgDA4u8
         Ja5B7v8itoRQ/vyLlxry3k8Xk3TYHnqBThLY8xdrNRV+DGiQxKVXd5dPiZODRTdwIl+4
         I3R09u9fEPW2zK3Z3Zil9LYc/oIZSH3YNlgFKib38wCwsp+v29jTUUbvCqOwegR4u96p
         8iib2zWZyLnl66bKwamVgC6fQlHT1rxuC3XZFfItd1UhWeSz/X5Bpnhy4LRy3UCStn3i
         /t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FR83tVbeEjgy0Oli/8j0skm7nFq9FbEOCLhEuugDSs=;
        b=kC3GVcqm+JFM2qhBjQgEJt076iZ+rv309Mp8RNgIZYzjeeoQjj+UZ+4MPXvtMv5Zd9
         1ZR3WOvuSPIxdqObXhNKts9sXW1nX8FWmU9PophSiYNyt8rUnx9BfpOl2aVUNbp2ym4b
         llpNKvWxqQYfXxUbw3ta390pGjMrW3LvQr541CBL+qK1r1kdi+YX86PK6WFY61IE03PA
         Nr6874xLIuKrpAiETD1gC4HfYxH3FqBOYP3GYo2Crc1EtMUbLParuUbLK0GmOSLiU4do
         ixKWL+MJiX29Wy1uQEn2qxW8JkHZoRNuUkQC9mPZLghi8xnsUn4oWvaRgXKnZC4VKILk
         C45w==
X-Gm-Message-State: AFqh2kow8m7MwdAUuSD/eQ0oaVzrAtWJJhL1wg+/2ZJ24+J1ipjoV6mX
        thcaiDYAghr36F4OoPUbPyqBGCIKndEJh1OOgYG2jw==
X-Google-Smtp-Source: AMrXdXujsX2E+/qfekYVe5Lz/ZZ/t3PCFqnvxcy2/1V+Q6bxKEu1iYi8q+tAShzmpJoFrGBbN2ArTl8HwoeBnNFFXPU=
X-Received: by 2002:ab0:31d0:0:b0:419:d115:2773 with SMTP id
 e16-20020ab031d0000000b00419d1152773mr6564727uan.29.1675161505619; Tue, 31
 Jan 2023 02:38:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <eb6f0a014b8d0bfa73a8bbd358c627dc66cf51b7.1675111415.git.andreyknvl@google.com>
In-Reply-To: <eb6f0a014b8d0bfa73a8bbd358c627dc66cf51b7.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:37:49 +0100
Message-ID: <CAG_fn=XP=RducNNBr8oT6P8u5gN3QCpTKyjMSyUbLPO2ovgEhA@mail.gmail.com>
Subject: Re: [PATCH 07/18] lib/stackdepot: lower the indentation in stack_depot_init
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

On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> stack_depot_init does most things inside an if check. Move them out and
> use a goto statement instead.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
