Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63026720C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjARPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjARPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:10:01 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC630B24;
        Wed, 18 Jan 2023 07:09:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i1so11361912pfk.3;
        Wed, 18 Jan 2023 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPAIFfeN/dKXaMxGL0E28WKC8ajWRLYrEZ3+YxPDbvE=;
        b=dtCtxOH0Vyv35KHa3JOBZNfrWAavDhforlr/tlOUaJS4eNRkCkZ4b4fzUXmjbl3a3q
         c7OjB0emO8l3WJx68m6vMx5IGJMfjIynFs/tJ7RpnZMYQx2QsGY7YdDWEklR9HsmZgfB
         4UrZOkC62gFhU+HhqyvkQQdZmkNeg3l6MmZa98at2vBGNHkxAG1UzVCT+U3n7jJGy+Wp
         P+q7mOQesr5JxW1aF5NWo9qmh3EfhhZEk0HKcdv5R1uapLuMj2pcIyrgnlcMTICGMUO/
         nrlYwXcV050wJksXAFhQWL6Y2i5a+NiKJYgoUsl5Ruzgx2LEKNB8YHx6cZbBKM7ZDH2J
         b5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPAIFfeN/dKXaMxGL0E28WKC8ajWRLYrEZ3+YxPDbvE=;
        b=yW9lM3A+NhxKYlcbvnhrAG4MTBKq1zt6RG97IwnV93KdeUuoD3wLxP9jQ1jQGqOzEF
         tCFCcLn/2rO8gwYlcZPDywBGNfHyBugwI6qnKe3kxg7/yXAZBcnVNUgHkKo8CjWrpk6J
         qHAI8UpLkRhuIagOskR/ZNo0ZthiKdI+2xiziDw8u7TlB79dudABecU21K0SPSRaFX3H
         2e1lpGVPgIczWx0HWm+XlgncpKYA/YsTaQJvl+Jjvm6T8EsjlkclJhj2o4qL5hO7hBYe
         2VNKYAyLc4VGu/MNQfY99Z8YIxe/zCOrcUF19muZBGdMFfqNzjSGu2MlMKNV3kxQrfTi
         Vr5Q==
X-Gm-Message-State: AFqh2koHKmcm15zcJE3bJOBhWy3eVvXany4xLF8FIh4taFjKTbGC9V4J
        pg6/5QnA1I8Qtexqi/2YuzSry8axSO6HZeEUT6HlMeiV
X-Google-Smtp-Source: AMrXdXun4Pdis6+sGp4ICDMQtfjAyPYpySFKXIwljdbnvnRRRxaDAB485guRI6COAIMlNWNhzd2KiDI1RhevVGRu/fE=
X-Received: by 2002:a63:6482:0:b0:4cf:73ab:c13b with SMTP id
 y124-20020a636482000000b004cf73abc13bmr529068pgb.445.1674054596860; Wed, 18
 Jan 2023 07:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20230103164359.24347-1-ysionneau@kalray.eu> <20230103164359.24347-2-ysionneau@kalray.eu>
In-Reply-To: <20230103164359.24347-2-ysionneau@kalray.eu>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 18 Jan 2023 23:09:45 +0800
Message-ID: <CAEr6+ED_QVYXeu4nMwtr84K_rueEiz_wEufWt3F=xPt7Q043wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/25] Documentation: kvx: Add basic documentation
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 1:04 AM Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Add some documentation for kvx arch and its Linux port.
>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  Documentation/kvx/kvx-exceptions.txt | 246 ++++++++++++++++++++++++
>  Documentation/kvx/kvx-iommu.txt      | 183 ++++++++++++++++++
>  Documentation/kvx/kvx-mmu.txt        | 272 +++++++++++++++++++++++++++
>  Documentation/kvx/kvx-smp.txt        |  36 ++++
>  Documentation/kvx/kvx.txt            | 268 ++++++++++++++++++++++++++
>  5 files changed, 1005 insertions(+)
>  create mode 100644 Documentation/kvx/kvx-exceptions.txt
>  create mode 100644 Documentation/kvx/kvx-iommu.txt
>  create mode 100644 Documentation/kvx/kvx-mmu.txt
>  create mode 100644 Documentation/kvx/kvx-smp.txt
>  create mode 100644 Documentation/kvx/kvx.txt

[...]

> +Virtual and physical memory
> +===========================
> +
> +The mapping used and the memory management is described in
> +Documentation/kvx/kvx-mmu.txt.
> +Our Kernel is compiled using virtual addresses that starts at
> +0xffffff0000000000. But when it is started the kernel uses physical addresses.
> +Before calling the first function arch_low_level_start() we configure 2 entries
> +of the LTLB.
> +
> +The first entry will map the first 1G of virtual address space to the first
> +1G of DDR:
> +  - TLB[0]: 0xffffff0000000000 -> 0x100000000 (size 512Mo)

Maybe should change it to:
 - TLB[0]: 0xffffff8000000000 -> 0x100000000 (size 512Mo)

As the PAGE_OFFSET = 0xffffff8000000000

[...]



-- 
Thanks,
JeffXie
