Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418F682A93
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjAaKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjAaKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:31:04 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21793F2BE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:31:03 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 22so7159972vkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=biRptAnS/23/d1sfZT7OvK0Nsb2kEXEG2iefSRQIeYE=;
        b=N4W0VQzf/QKJ6ONvniC2q/NvKJd+XXlmKEn46E/k278t7UNFa9Vcja4Q5Uoviduf1A
         62OmwHUqF876n1Ml7aNMGN6Mkfys5arnC0CMD13LwK7oOglYKD9Rj9mphMsOQb5vNxHP
         XFvrqQxNYijZ6oupnsOE7wlEbT2FFAIVqjev1NxAlqah8Cg2rWi4ZrEVlBMbmRC7KyWM
         Mgth4/XThgiKdtx4/O+6GCQdWAuVPXDmGEk7I8xGUWQRUzKTNDG+0/r4uDidaxzIb98M
         pHRVCdCX6jxt9gu0a37ofWJRheHTQyts/ZBrtbXSZKiEe1fugC+AfJmNIxQzIum53dvQ
         K/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biRptAnS/23/d1sfZT7OvK0Nsb2kEXEG2iefSRQIeYE=;
        b=KxdF6sXahGWOG1NQMkLLWSwS661z93moq95Vvrk1XwLdcq8FlrHCmUgjowYbG1DKc2
         EopLdlwoQZLydU8ybQxDDxQgARoy6iKGTqx+4UpmTaayvfg7zafiJO3mvpDWlq+fmy1e
         Jtrk+bmrVjpd4iheVLyRU1TZBXelCfpnGyMx8z5ggeLBxiFz3xqYZ1iCeqDEK2fUdcdq
         BUCBwGmaz7ZIth/BxFhv3eEaYvdWaoEi0L22e4reVYMefiDQWfa0cJCfNir037yQuWvS
         AFe4CF75vhA4Pc8SoCCpVw0Zxe5AxGII+N+EnV4u90GVdZxZaI9AGEwW8Qv2evNgcpz4
         wj3g==
X-Gm-Message-State: AFqh2koejBlE/W/uUwdg2l2bvVlKdOmQ0uepQOiiPMTCTJx4fQwnntx2
        Jum+spuvCB9Dm4t+Dcuay3a806r3NWUow+Wg2CgG/w==
X-Google-Smtp-Source: AMrXdXtA+nQqDbRIGryG5iub+Xzha80yKCFEITt1L/ujGSq+l3Ow5201zNt6pfcrxFe3paPOA51MxPiHEIgf1d0NJ7c=
X-Received: by 2002:a1f:ac0a:0:b0:3d5:911f:daed with SMTP id
 v10-20020a1fac0a000000b003d5911fdaedmr7024011vke.39.1675161062850; Tue, 31
 Jan 2023 02:31:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <be09b64fb196ffe0c19ce7afc4130efba5425df9.1675111415.git.andreyknvl@google.com>
In-Reply-To: <be09b64fb196ffe0c19ce7afc4130efba5425df9.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:30:26 +0100
Message-ID: <CAG_fn=WnxbcbjfKvRGen7fkKyx_9_S+nL9p+8xfeU8N0L93f7w@mail.gmail.com>
Subject: Re: [PATCH 06/18] lib/stackdepot: annotate init and early init functions
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
> Add comments to stack_depot_early_init and stack_depot_init to explain
> certain parts of their implementation.
>
> Also add a pr_info message to stack_depot_early_init similar to the one
> in stack_depot_init.
>
> Also move the scale variable in stack_depot_init to the scope where it
> is being used.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
...
>
> +/* Allocates a hash table via kvmalloc. Can be used after boot. */
Nit: kvcalloc? (Doesn't really matter much)
