Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49722611A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJ1S3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJ1S3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:29:00 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD61EB544;
        Fri, 28 Oct 2022 11:28:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A8BB60C;
        Fri, 28 Oct 2022 18:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A8BB60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666981739; bh=8uJfkxcjmwrwp6oqALKbmrqEDzrWBbWor3WgNDeNADY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=b5jSsMcLi27O5oQunvhZPC4SIiLOnG1X9oA/hcv2Hb0A83cf6BqO2Hnookw0WcdxS
         RQK7fH4LN0/WngjZPjG19gMZIsAb1IEQiC4F/KH3EFsCOrILUkHsvUZEqs0dtA0pJI
         qK0vvLcjmrkSVwXP6R+zrzCFshefGGs2y9sHksrjeEKqXJ5lfNRVqe3a8PRb/Jpcmo
         UC4ii2Kd6s4iCqsil4XYG56VuBhYdCPoSBp3lCXomcr3c9QwGtDqMVFEx/aWEaV0Z4
         Y33JTFyRywWf3doaR8Yu7JLSiLgtFdj9kmLKPsRvJccks/AxQvgyDL4awLO7BJWFCa
         AKl65WSW8R/Dg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Li <me@lirui.org>
Subject: Re: [PATCH v3 0/2] docs/zh_CN: Add userspace-api/index and ebpf
 Chinese translation
In-Reply-To: <cover.1666185911.git.me@lirui.org>
References: <cover.1666185911.git.me@lirui.org>
Date:   Fri, 28 Oct 2022 12:28:58 -0600
Message-ID: <87pmeb6bv9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
>   docs/zh_CN: Add userspace-api/index Chinese translation
>   docs/zh_CN: Add userspace-api/ebpf Chinese translation
>
>  Documentation/translations/zh_CN/index.rst    |  2 +-
>  .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++
>  .../zh_CN/userspace-api/ebpf/syscall.rst      | 29 +++++++++++
>  .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
>  4 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst

Applied, thanks.

jon
