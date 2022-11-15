Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D762AD95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiKOWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKOWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:04:02 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A322FC02;
        Tue, 15 Nov 2022 14:04:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 887C335F;
        Tue, 15 Nov 2022 22:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 887C335F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668549841; bh=yHmtXJE4u3xVuskor/S9epZ41lE/Z+GuXv2QkpXPxCo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RNC1Ukj79PPumggEbYbMHhePT2ht41ygxiMQdsyI+lrHGxOxEhUDR42QTQpdF8395
         9o7wWLtcZvnJebd/l2M/+CcShke8ns68F1B+z6q/P/3fRjMKQRk7vYOHWk2B46A5Su
         nUaijinRry0rCAFh5TzMDQ9fF/pemv7nWKjFid+DDLRdv2gElGuOWqznsHgXnwbTMb
         +uwu6qRwlrNuai20dZADwG+h/JRlsBt+Znwp2E/gojGzZY6U9bRpySaQDTAb28LLsi
         vf6LH/ZBlYphxStznDMvhtWudF65o8RWz7S1ZtmNzWcTT8ES4e90kElcKS+DxVpg0p
         IBm0mwU9GdfCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process submitting-patches translation
In-Reply-To: <20221107150815.296699-1-carlos.bilbao@amd.com>
References: <20221107150815.296699-1-carlos.bilbao@amd.com>
Date:   Tue, 15 Nov 2022 15:04:00 -0700
Message-ID: <874juzan8v.fsf@meer.lwn.net>
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

> Translate Documentation/process/submitting-patches.rst into Spanish.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/translations/sp_SP/index.rst    |   1 +
>  .../translations/sp_SP/submitting-patches.rst | 894 ++++++++++++++++++
>  2 files changed, 895 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/submitting-patches.rst

I've applied this.  It sure would be nice to have some reviewer support
for the Spanish translations, though...I'm *pretty* sure you're not
telling readers that they should actually be running Solaris, but it's
hard for me to tell for sure...:)

Thanks,

jon
