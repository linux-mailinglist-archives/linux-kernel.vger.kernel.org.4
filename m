Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75F611A31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJ1Seu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJ1Ser (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:34:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F81056B;
        Fri, 28 Oct 2022 11:34:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BEDFA60C;
        Fri, 28 Oct 2022 18:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BEDFA60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666982080; bh=Vmdct1O8NVVyoM/GlLyujP/EuDony6SKKZFoO2GTU9E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aSE676p5/VT2E0+gAqGbBSvUQtgQKeCt4fu1J9kI9UciNUR8CQ1iXphmZpCL401i+
         +Won0AI0FJTy2xJVvtGWOZET9+GbDkHpqf6z40VNVKdvv3TXt4+A1O6iRVc1VraPXM
         keH8PJFTN4jsGt7sgjm2i2TOPsqHeqg2ez/GMD7M+L1NtOyAcdmAWfN2YEqJgKZjHW
         YomjgVzWbINeURM5kIghsl1Y2Hqtj/zEdJoTR5RcBIWKpIMDDpBezfvizo44Or7w00
         U/Z4PS3IKzbTb2YIDMu52tWjUPuZgD6OOBhTThi2LmKYUwIU2dNfBr29SDG46lnvJj
         bRY0Az3ZvrONg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Li <me@lirui.org>
Subject: Re: [PATCH v2] docs/zh_CN: Add userspace-api/sysfs-platform_profile
 Chinese translation
In-Reply-To: <20221026070732.72818-1-me@lirui.org>
References: <20221026070732.72818-1-me@lirui.org>
Date:   Fri, 28 Oct 2022 12:34:40 -0600
Message-ID: <878rkz6blr.fsf@meer.lwn.net>
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
> - userspace-api/sysfs-platform_profile.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
> Changes since v1:
> - Improve some translation.
> ---
>  .../zh_CN/userspace-api/index.rst             |  2 +-
>  .../userspace-api/sysfs-platform_profile.rst  | 40 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst

Applied, thanks.

jon
