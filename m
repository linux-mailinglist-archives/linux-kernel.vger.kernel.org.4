Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3885FB8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJKRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJKRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:03:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24481A8CD6;
        Tue, 11 Oct 2022 10:03:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A10BF7DE;
        Tue, 11 Oct 2022 17:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A10BF7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665507826; bh=7SPpThsSne6HOPQsZvAflcaMv2i/yR+2HVsHav8VrDw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fMb/ivf6MO8J3zv1MvYo6s1lrBd/3OCGvar0gnT22FldPpjLE9VcI77v95rpaDqKO
         I/vSH7RQ/QPRlKHA8ndDcH259gqgDK9qSz55ApzsOe1Na3E7kRSr74Gz+S66lI52T1
         PE8bFE9ybp8Y0T5bvY1cqTvkSJCcIvHohlxs5ABUauri6p3hqBsP49Gk4CqqOeLrGQ
         oo5dnQP0V/nCwu8UQxNffiebvqB2QSCNOw+rqO95WcwaVN8yU9gwSgTOlNnNLZDuvh
         0rcWLwLLHIWfm8aXDspUMQ3tvk7oSY3U4u6XaKFTkyPe7DxCCsf6EOxT92RGj4VuM6
         kyyan2BONXyqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] docs/zh_CN: Rewrite the zh_CN/index.rst
In-Reply-To: <cover.1665467392.git.bobwxc@email.cn>
References: <cover.1665467392.git.bobwxc@email.cn>
Date:   Tue, 11 Oct 2022 11:03:46 -0600
Message-ID: <877d16pa19.fsf@meer.lwn.net>
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

Wu XiangCheng <wu.xiangcheng@linux.dev> writes:

> Follow Jonathan's steps[1], rewrite the entry point of kernel's Chinese
> translation documentation.
>
> [1]: https://lore.kernel.org/linux-doc/20220927160559.97154-1-corbet@lwn.net/T
>
> v2:
> 	* remove blank line
> 	* fix typo
> v1:
> 	https://lore.kernel.org/linux-doc/Y0EHBw9C1UpVA49k@bobwxc.mipc/T/#t
>
> Thanks,
>
> Wu XiangCheng (4):
>   docs/zh_CN: promote the title of zh_CN/process/index.rst
>   docs/zh_CN: add zh_CN/arch.rst
>   docs/zh_CN: Rewrite the Chinese translation front page
>   docs/zh_CN: add a man-pages link to zh_CN/index.rst
>
>  Documentation/translations/zh_CN/arch.rst     |  29 +++
>  Documentation/translations/zh_CN/index.rst    | 169 ++++++------------
>  .../translations/zh_CN/process/index.rst      |   1 +
>  3 files changed, 82 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/arch.rst

Series applied, thanks.

jon
