Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7376F1504
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbjD1KKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbjD1KKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:10:31 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12046BE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:10:28 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 3F0CB148325;
        Fri, 28 Apr 2023 12:10:26 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1682676626; bh=BjYzdC0mrGMiUgKec9zWEOTKrhq7GzNxzqsx2+wrQ/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VLcGTRr5GBCntDdDXt8CXevKYL1GJdP4FLe7Qcctmteh+Wu228gRJTzt02qvBxt9u
         0RYcAyG1K5+tTFvBApvs4fvamF+T5t5Z92OPRTzM39Yu+2nfSQsQHb76p/i/UFXwFB
         ot5eBjM9SJN9aWpI8Yun0iFtCKlqGVHYjO3GEn/PfYWoL765LpxhiSdlHDHSAfYjcl
         4/N+YFrcVjPoiyuYTWbuQrPgIXL5Rqv5yuV+PUWf+6aZCJ+OwJEvFFLsdnvWoNZVKi
         DuTZR6PJYKAstsEcQWl4pVYZ9HT7rHZHnePHjiU2sZm2z2YQk32wRKzABMe1xg41ns
         Rj8F/5hA3TyWA==
Date:   Fri, 28 Apr 2023 12:10:24 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 11/34] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Message-ID: <20230428121024.1070cd72@meshulam.tesarici.cz>
In-Reply-To: <20230425140955.3834476-12-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
        <20230425140955.3834476-12-Liam.Howlett@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 10:09:32 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
> information.  In the unlikely even of a tree height of > 31, try to increase
                                ^^^^
Again, *event*. Consider buying a new keyboard if your 'T' is broken. ;-)

Petr T
