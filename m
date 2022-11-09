Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25786234B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKIUjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:39:52 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106917A92;
        Wed,  9 Nov 2022 12:39:51 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23FE6735;
        Wed,  9 Nov 2022 20:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 23FE6735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668026391; bh=10w+VI1YIATg4JMAlFUPmIWEJWr+aNG6o3y5mkVQN3s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZS4CQtz8oEbXaCvKm8LDsY49NhTZhfCMUDZH8xESSgEdok5uJynuKkErf04J4U6MC
         jFKjFcyCj2DKmCytVseuu20Vc2MIUgNSVnMj/8+KuFhNLIdJs2NaJ9Q1GgFANFSvo+
         maH4iri6Ha3Cj2II9fIzCrTJYS4FekYk9g5kUuo7Yp9qYp2Jk8QbrFzPaPCxWWo2xE
         BtO4Aju4kWuq6HAjCM7yDuKhSFt7Br4seDdgun+WtMqId6YlUW3ZsEfhC0T2d9ojew
         ehMMRoduuCtSwGTEKC3byBNWqRqip5VRetZEqRoLNdHdpr+uFxgwu7265NQUkunpbu
         uSwmU3QwnKJJA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Li <me@lirui.org>
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/futex2 Chinese translation
In-Reply-To: <20221105041741.288094-1-me@lirui.org>
References: <20221105041741.288094-1-me@lirui.org>
Date:   Wed, 09 Nov 2022 13:39:50 -0700
Message-ID: <87k043kgkp.fsf@meer.lwn.net>
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
> - userspace-api/futex2.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  .../zh_CN/userspace-api/futex2.rst            | 80 +++++++++++++++++++
>  .../zh_CN/userspace-api/index.rst             |  2 +-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/futex2.rst

Applied, thanks.

jon
