Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805586743DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjASVAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjASU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:58:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16724113;
        Thu, 19 Jan 2023 12:57:11 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A6A82C0;
        Thu, 19 Jan 2023 20:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A6A82C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674161831; bh=7I62MX4k00vyzrYytWoP61tqgBIgIfy9B1csmj/7phA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ww4c4ih+5pweh5OwmMzh00UQEC9GeJCHzh4mKDqUjzZCicxXG3gZXJWezdtwn7RKE
         U5maF7WXpCxi0JhNVTxDFbwByoTvkZIj9yzgFj+rg75Vzdi4fiS7nbxP10217Ib7uu
         IkpBPfIpfB/GT7rT9OKB1UG31Zpna98XYKMhfYsEQXCmLNJHaRwdyNdcZlYA21QVDg
         jVVilhkrPgpCv59k3Vt7v/yYs474OdRQxMsecJMvnEzMgqWqEytQT98USxCmi+kD3o
         XyPt0l+qVc7Jy3NC6kygvjCxShPmqbIcHogqUwFp3u343v6HB6ekcyr9EZJmOUaW5g
         NAJgvPIIeenew==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH v2] Documentation: Avoid duplicate Kconfig inclusion
In-Reply-To: <20230114-doc-v2-1-853a8434ac95@pefoley.com>
References: <20230114-doc-v2-1-853a8434ac95@pefoley.com>
Date:   Thu, 19 Jan 2023 13:57:10 -0700
Message-ID: <87h6wm8cpl.fsf@meer.lwn.net>
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

Peter Foley <pefoley2@pefoley.com> writes:

> Documentation/Kconfig is already included from top-level, avoid
> including it again from lib/Kconfig.debug.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
> Changes in v2:
> - Add a top-level Documentation entry instead of nesting under Kernel hacking
> - Link to v1: https://lore.kernel.org/r/20230114-doc-v1-1-efec2689e423@pefoley.com
> ---
>  Documentation/Kconfig | 10 ++++++++--
>  lib/Kconfig.debug     |  2 --
>  2 files changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

jon
