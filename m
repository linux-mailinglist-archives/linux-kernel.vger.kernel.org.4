Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D1666678
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjAKWxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjAKWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:53:20 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40FF5F;
        Wed, 11 Jan 2023 14:53:19 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6DA336E3;
        Wed, 11 Jan 2023 22:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6DA336E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477599; bh=x1XZcOGFFxb3AGQxq0nyRrX8T+BsLHoWv5t7PpetJ7Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RmN5/XE/jLKvtqCEXHQ+OHT/vJhQF0Y9lRT5hsqhdffvdJ115Qo8CXtoIf1egAmsx
         +rLb6F/xhLc7m5roRFnnHNzLUVrbsF761D/LpwU34Acz0eUFFoJzNHoRztirVSMrzU
         XpXEmGGAECwY0iGvIQINTQGCZWVqZg3zuFWOurNAuhd1O/oRu+HY7xeR2IDuQSu5ks
         zNbGb1q8nxvv6+vdF+QPaYUgtUhVJsSpKE0OBZ7Ru0lKUkBWH3ZsI9WQbdEBpei7Yz
         xNz5E15WK1s7Lfu2Kk93T0tMJOR8x/lj+by/fjdwVt/8FqX/RX+CPpUVrgZsKoTfm7
         bXlro4x7kH1dQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] doc:it_IT: align Italian documentation
In-Reply-To: <20221231130849.4675-1-federico.vaga@vaga.pv.it>
References: <20221231130849.4675-1-federico.vaga@vaga.pv.it>
Date:   Wed, 11 Jan 2023 15:53:18 -0700
Message-ID: <87h6wwwun5.fsf@meer.lwn.net>
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

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Translation for the following patches
>
> commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for process substitution")
> commit 5372de4e4545 ("docs/doc-guide: Put meta title for kernel-doc HTML page")
> commit 4d627ef12b40 ("docs/doc-guide: Mention make variable SPHINXDIRS")
> commit 7c43214dddfd ("docs/doc-guide: Add footnote on Inkscape for better images in PDF documents")
> commit 615041d42a1a ("docs: kernel-docs: shorten the lengthy doc title")
> commit cbf4adfd4d19 ("Documentation: process: Update email client instructions for Thunderbird")
> commit e72b3b9810dd ("maintainer-pgp-guide: minor wording tweaks")
> commit ea522496afa1 ("Documentation: process: replace outdated LTS table w/ link")
> commit 93431e0607e5 ("Replace HTTP links with HTTPS ones: documentation")
> commit e648174b53f1 ("Documentation: Fix spelling mistake in hacking.rst")
> commit 602684adb42a ("docs: Update version number from 5.x to 6.x in README.rst")
> commit 489876063fb1 ("docs: add a man-pages link to the front page")
> commit 0c7b4366f1ab ("docs: Rewrite the front page")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---

Applied, thanks.

jon
