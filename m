Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD7611A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJ1Sdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJ1Sds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:33:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16786241B0B;
        Fri, 28 Oct 2022 11:33:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B94F760C;
        Fri, 28 Oct 2022 18:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B94F760C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666982027; bh=JgRPKdDOJTD3cZEutGoGOcnPFgVvlBkF5Yc8qJPY5mw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J8kDaFCHTFi+J1qpYsCxgNLmx09lPFbQSySz7UlEJ5Gw3z74vH87Y1jywXVEpQ5pC
         SA4AMtS+WWKb+cbBG/+73Ekg4TP1xoSpbsOgk30h8kdyBwX/UP9pvcxjkPQ67A6YiV
         E7DAaYAxUjIgFU+CzAQkdjJxGirnZJEM1g6v7U85vhc/Jtw7A9SCfS7fBCXrBPBKcu
         5/Gef1bOS7ojxvwUh1U2/vY38LfC86gjSRy0ASbsrb2UURqlqGcxlb7RPL+8vnhJJ0
         IBqZg1GAmfkpmmdCxYnr5G2fBJScbAPm85McgpZ8UjUTfqau1jE0nJ8XaXRx7CEW2T
         eaNze6/n37Ybw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Li <me@lirui.org>
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/no_new_privs Chinese
 translation
In-Reply-To: <20221022120557.381115-1-me@lirui.org>
References: <20221022120557.381115-1-me@lirui.org>
Date:   Fri, 28 Oct 2022 12:33:47 -0600
Message-ID: <87czab6bn8.fsf@meer.lwn.net>
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
> - userspace-api/no_new_privs.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  .../zh_CN/userspace-api/index.rst             |  2 +-
>  .../zh_CN/userspace-api/no_new_privs.rst      | 57 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/no_new_privs.rst

Applied, thanks.

jon
