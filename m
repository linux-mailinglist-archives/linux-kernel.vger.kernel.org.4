Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727D602D57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJRNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiJRNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:48:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EACD5EE;
        Tue, 18 Oct 2022 06:48:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2C0412D7;
        Tue, 18 Oct 2022 13:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C0412D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666100902; bh=VtE0W9gKmiji3m+fBP4JE6QV2uJ5JjdMxX9jo/Mx+Ek=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZdOy1taLoW3g3bN2YMjLwgeGRII+Qg3vJgSQL2YkJ7v/ANgVj6T7xzfePkj46ORkq
         1JnEbGcN11QqFKsaVQn7FiBEQov+ryevQLPu5sUk4DrMzIi8O3hoKcsXLypAW1CxTD
         zWgHF9XrkHovqPhJXfOx2/ulc6bZOay9OKzj5sRrYyHnkrV3HM9SKQ8rrlx5PVzHvm
         gWpXqBhVEqxsaG3v8FzwSntFKHTFSZgA3qDACbG1+bHLKtDcNiqiPQFfr8KY9Tp4S8
         HCd3eIaceWLARP3GsBrAlqtTrRYmgBIIRBeC0yuUlSIK5tvtTzJR6o0qU/sk9gU9H1
         MxdXE0RXorskQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>,
        Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Fix kern-doc markup for functions
In-Reply-To: <202210171909.65FFFB5601@keescook>
References: <20221017035732.1968394-1-keescook@chromium.org>
 <6f8aa670-fb4f-3ff9-bcd9-8490e752b349@gmail.com>
 <202210171909.65FFFB5601@keescook>
Date:   Tue, 18 Oct 2022 07:48:21 -0600
Message-ID: <87ilkhdyze.fsf@meer.lwn.net>
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

Kees Cook <keescook@chromium.org> writes:

> If the Documentation/* changes look okay, I'd rather carry it in my tree
> since I'm going to be poking at more functions in there soon.

That seems like as good a path for it as any.  Feel free to add

Acked-by: Jonathan Corbet <corbet@lwn.net>

...if you want.

Thanks,

jon
