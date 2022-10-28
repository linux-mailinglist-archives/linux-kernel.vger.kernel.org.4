Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503F611A24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJ1SdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJ1Sc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:32:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A8242C8F;
        Fri, 28 Oct 2022 11:32:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0822360C;
        Fri, 28 Oct 2022 18:32:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0822360C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666981975; bh=GytfI3KnLzhfu4180U79pN4OF0jl4kO5qY4Qhst1Cj4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aE7V4SyB6trV1lxHwuxN0X/xSUB8LVVI2OcA6c/iDIu40Fb6gSGnzJZk8ijDFowCN
         F0qq/EDWWZZPoTzk38t4pNYAS+e+PHe2MF6KoLNayIse6e1/lUXtiYaUDo9qQZ6fxW
         4EeP8nT7GK9XPuen01VSfOkEVQC6JEr4XcnrfVTPCAjuB7a/AGlE1tSW4wPFA0M5vL
         PC7HP2gwRbCCLk/ccnrh0NEYvZfF0CrKGE9F1DsLFQtC5iHlaHXrTmh/wR+/7y6qi/
         U3tQEoU48rXpIcFdCNi6qG81DjFKjVzcuduj2RHj0/CeqG2vYijeLyJTErPR5svb9P
         TmA4kpGDjlguQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Li <me@lirui.org>
Subject: Re: [PATCH v4 0/2] docs/zh_CN: Add staging/index and xz Chinese
 translation
In-Reply-To: <cover.1666328379.git.me@lirui.org>
References: <cover.1666328379.git.me@lirui.org>
Date:   Fri, 28 Oct 2022 12:32:54 -0600
Message-ID: <87h6zn6bop.fsf@meer.lwn.net>
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

> Translate the following files into Chinese:
>
> - Documentation/staging/index.rst
> - Documentation/staging/xz.rst
>
> Add staging/index into the menu of zh_CN/index. Also fix one
> translation in the zh_CN/index file.
>
> Changes since v3 [1]:
> Add missing reviewed-by signature for patch 1 and 2.
>
> [1]: v3: https://marc.info/?l=linux-doc&m=166627656723013&w=2
>
> Rui Li (2):
>   docs/zh_CN: Add staging/index Chinese translation
>   docs/zh_CN: Add staging/xz Chinese translation
>
>  Documentation/translations/zh_CN/index.rst    |   8 +-
>  .../translations/zh_CN/staging/index.rst      |  26 +++++
>  .../translations/zh_CN/staging/xz.rst         | 100 ++++++++++++++++++
>  3 files changed, 130 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/staging/index.rst
>  create mode 100644 Documentation/translations/zh_CN/staging/xz.rst

Applied, thanks.

jon
