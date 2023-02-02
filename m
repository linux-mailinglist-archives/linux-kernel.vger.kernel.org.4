Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E88688572
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBBRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:33:35 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BEB9003;
        Thu,  2 Feb 2023 09:33:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CEF037DE;
        Thu,  2 Feb 2023 17:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CEF037DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675359204; bh=Z8ouCrwZGf5TPEAW7UNG69yKQc0d40zGiy1VZrJBEvU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FCFUGwFVlhJFXnKTURiyGkFMYRg+uJdc6bwqUGMsZSGyMlvmCX6CxKuLfj1bYe+PH
         baJA5LsOWOlnLkboxDjHC6zBmMDVhSm7JeXf/BGm71rmRSE3LgrK16zCjQSRJwpXXe
         CZY3g7rs6O+O81JTETOEfTEl5qr8n/aZHeP9T1D9gkYxvyj7x0cd4Ky0FWDdq/pbOz
         DjfHJMmV3xhA2uQi5kqwi2WHEcWzeGZqFWmf3HsYWMP8H3ukAadp3z0D8tJN2pKuBB
         B1hLHn3q2MPL8e8m1+LtwYTE+xAsKEDqH6n79JGoaT4BuPXihV/APpvPZcAIWfJQMa
         B8zM2scFPySsQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] docs/mm: remove useless markup
In-Reply-To: <20230201094156.991542-1-rppt@kernel.org>
References: <20230201094156.991542-1-rppt@kernel.org>
Date:   Thu, 02 Feb 2023 10:33:22 -0700
Message-ID: <87ilgkvuot.fsf@meer.lwn.net>
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

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Hi,
>
> Following Jon's gripe about top-of-file labels [1], I went ahead and
> updated admin-guide/mm and mm docs to use file names instead of labels for
> document cross-referencing.
>
> [1] https://lore.kernel.org/all/87r0vh9n17.fsf@meer.lwn.net
>
> v3:
> * fix more missed references in zn_CH translation (kbuild)
> * add markup removal in Documentation/mm/physical_memory.rst as the
>   first patch in the series to keep Fixe: and Acked-by: tags
> * rebase on docs-next
>
> v2: https://lore.kernel.org/all/20230131144220.822989-1-rppt@kernel.org
> * fix missed reference in zn_CH translation (kbuild)
>
> v1: https://lore.kernel.org/all/20230129075018.207678-1-rppt@kernel.org
>
> Mike Rapoport (IBM) (3):
>   docs/mm: Physical Memory: remove useless markup
>   docs/mm: remove useless markup
>   docs/admin-guide/mm: remove useless markup

Applied, thanks for the cleanup!

jon
