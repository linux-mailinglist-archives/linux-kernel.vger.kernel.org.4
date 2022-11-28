Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACD63AD31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiK1QCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiK1QCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:02:43 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD816309;
        Mon, 28 Nov 2022 08:02:40 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 876CA379;
        Mon, 28 Nov 2022 16:02:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 876CA379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669651359; bh=7i7wS7n1iNB3O3V/BGZeYW0Xaz/gx2if4CCL3DVLhhc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jbIQnTmhG5GzjZwodpCnNQCl1nizYAvrfSypgkPm3cNwGg8GMnzn4IC+STkNlC2sM
         1mXAku3OGIrTg++cyvBLp9zdFRwo4S3hgLBm1eQ1spatcjA99wFMLiTnSzfOLU/xQg
         gVXZhwgO35ZLuAQ5BY6EGBhWfqizdTCRTHi19Fz6ygv+woBAFrazM14gChnW8RZgaF
         Yh63gqy4m9Xb2DOXnRv0pAOq63WptnZT9Vo8remXeVEyt6FyH48aCfECfGzQfy3mo4
         +pqpbyjN1cFGhtk4i3W3LXSKy7V+wtATxORYghRCSVhOfvzes3kavFYNI3PnfMGKxm
         7De6B6QDDKhtA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, lukas.bulwahn@gmail.com,
        ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH 0/6] docs: Update kernel-docs and progress translating
 Spanish
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
Date:   Mon, 28 Nov 2022 09:02:38 -0700
Message-ID: <878rjv6p9d.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> This patch set:
>
> 1. Updates the maintainer of kernel-docs.rst. Retires its outdated
> resources and adds new material. More context on [1].
>
> 2. Makes progress translating kernel documentation to Spanish. In
> particular, it creates translations/sp_SP/process/ and moves documents that
> should go there. It also offers translations of kernel-docs.rst and
> coding-style.rst. 
>
> Carlos Bilbao (6):
>  docs: Update maintainer of kernel-docs.rst
>  docs: Retire old resources from kernel-docs.rst
>  docs: Add book to process/kernel-docs.rst
>  docs: Create translations/sp_SP/process/, move submitting-patches.rst
>  docs/sp_SP: Add kernel-docs.rst Spanish translation
>  docs/sp_SP: Add process coding-style translation
>
> [1] https://lore.kernel.org/lkml/20221118170942.2588412-1-carlos.bilbao@amd.com/

Series applied, thanks.

jon
