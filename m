Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E20601089
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJQNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJQNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:52:53 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D121A232;
        Mon, 17 Oct 2022 06:52:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E045B60C;
        Mon, 17 Oct 2022 13:52:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E045B60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666014772; bh=QSNmydHKDESmT1NqsfW/Jpi8LhtNWYPwSj/TqSdJ0wg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qMi45jR0DW9fdkfib264+H/n/J1/ClsQ7/tqFeg5AU2UH9JMugeSj6UMmSeCbrvrK
         Rkgrivvd4+8DkemcwIYPcwoZ3myzvu7eZ3geI5yUEE5WxCiuMKH9ZuASsX97bxgIXK
         4om3gEEj0YV7h6HoRA+K8CUCKHlCo1glrbGvs+M4Yq+WJhQf0Et2r6wEkJVaA69YCZ
         suK0GmG/BvR2XY6yOX85Nshr9t/i7SnE6EtSt67PcxBr6d7JhPJXePqHd/lAmESLm0
         FRbbuaDUykbNKC4oIb7FzMjY4+/kbxzZFYoI8hLx+lGsIN1DgwMI9us0TmS2xWGMTp
         iC230DtBVqptw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rui Li <me@lirui.org>
Subject: Re: [RESEND PATCH 0/2] docs/zh_CN: Add userspace-api/index and ebpf
 Chinese translation
In-Reply-To: <cover.1666009558.git.me@lirui.org>
References: <cover.1666009558.git.me@lirui.org>
Date:   Mon, 17 Oct 2022 07:52:51 -0600
Message-ID: <87pmeqftfw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Li <me@lirui.org> writes:

> Translate the following documents into Chinese:
>
> - Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
> - Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
> - Documentation/translations/zh_CN/userspace-api/index.rst
>
> Add userspace-api into the menu of zh_CN index.
>
> Rui Li (2):
>   docs/zh_CN: Add userspace-api/ebpf Chinese translation
>   docs/zh_CN: Add userspace-api/index Chinese translation
>
>  Documentation/translations/zh_CN/index.rst    |  2 +-
>  .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++
>  .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 ++++++++++++
>  .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst

Why are you resending this patch set after one day?

jon
