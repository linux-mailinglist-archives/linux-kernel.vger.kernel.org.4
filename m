Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2D65513B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiLWOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:16:33 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83638186F8;
        Fri, 23 Dec 2022 06:16:32 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E78EF4E5;
        Fri, 23 Dec 2022 14:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E78EF4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1671804992; bh=2To79WNMTF4K2+fkid8avf169IweySAkg3+yKw0TyYo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=blnjTx6Luu5jxoHHHqqqEhrSVJY3AocV2e6LZRXSggmhh4QE3rKtiLbqhYMCwVmJP
         z6LyNSuLmWZUq3Ez5BqefVzKlpjzKTDuQLKzhGfG9GmnJF5HducAh+uTckpxjPYHBi
         Q8THCAHlLWjGHoE+Xiil55euKp98gqsvcRnhGD26mUQEaudii2jjznpuCRpKoUkHTc
         qmL/a57NYZrQaodlFqHwcyzrKeDt0iDFQiZ4bWk2M7l5+UZuJC0mMEZhCtxX6uhXvw
         0ImFiIu/nP6alzxOI8LNPZL6+E+UWTsB6nY1NzRCS15b6mvhbiNeXMhVx2XfkEkfzJ
         VSScmSK6j/P6g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221223093351.GA8028@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
 <20221222160920.GA10193@lst.de> <87zgbfma5w.fsf@meer.lwn.net>
 <20221223093351.GA8028@lst.de>
Date:   Fri, 23 Dec 2022 07:16:31 -0700
Message-ID: <87sfh6mchs.fsf@meer.lwn.net>
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

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Dec 22, 2022 at 01:54:35PM -0700, Jonathan Corbet wrote:
>> I'm not really a fan of adding more top-level directories; one of these
>> years I'd like to try to move things in the opposite direction.  That is
>> a battle for another day, though; for now let's just go with this and
>> get the document merged.
>
> I though about that, but could not thing of a good subdirectory.

We can paint that shed another day :)

>> That said, I suspect you'll add a build warning about the new document
>> not being included in any toctree.  Fixing that would involve adding a
>> basic index.rst to the new directory and adding that to a file like
>> Documentation/subsystem-apis.rst.
>
> The new document is included in
> Documentation/maintainer/maintainer-entry-profile.rst in this path.

Duh sorry, I'm not quite sure what I was thinking there.

> I also did check for new warnings and did not see any, even if that's
> a little difficult with the rather chatty shpinx output.

Someday we'll get all those warnings gone...I hope...

Meanwhile, if it's useful:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
