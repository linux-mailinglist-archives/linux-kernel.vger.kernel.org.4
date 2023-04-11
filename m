Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A596DE722
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDKWSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDKWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:18:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF7468A;
        Tue, 11 Apr 2023 15:18:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 96B0C5BF;
        Tue, 11 Apr 2023 22:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 96B0C5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681251517; bh=pWHfpVwOwf5n3ID70f/fj5Lxx0kk9E1xO6NqssJ6gKw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SqO/XtR390LrIWR23vpBVf/esRFsFA+woe8EHAEfH65ZfOOhYoVRug3Q/dJ3DiXE6
         2qqwCB/0FDL1CXudJxKnGAvN+5Jvc/LMYbDl6B1sUF0B8NzYlPsSdKNYKWtTXfqYKh
         QBIKmYhI30LwIpjIAgIdrwpdPs/TApJCPJ3YLQfJCSur8NBtj9uoUBToN6gXBd7NSQ
         D1mIQ0HwL5MLqTIYYBrWS4gYd9Li3iHTDf8gka2SgIj5R1drdXMhBd7Lsw+vgnfogD
         ttTaQcQTqNwDYZWSaZ6YUFwCErTBhqq+apuHUzbpiRw1uygsfEp3MPApNlltnSvqx0
         +tMWK+dgU9/PQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
In-Reply-To: <20230411151953.182c6a92@canb.auug.org.au>
References: <20230411151953.182c6a92@canb.auug.org.au>
Date:   Tue, 11 Apr 2023 16:18:36 -0600
Message-ID: <871qkqawqr.fsf@meer.lwn.net>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> The following commit is also in the jc_docs tree as a different commit
> (but the same patch):
>
>   3a9421482150 ("dma-api-howto: typo fix")
>
> This is commit
>
>   2ca956cf8834 ("dma-api-howto: typo fix")
>
> in the jc_docs tree.

Michael, I'm a bit confused by this one...you sent it to me, but
evidently didn't want me to take it?  I can certainly drop it...

Thanks,

jon
