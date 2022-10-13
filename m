Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C419F5FE3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJMVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJMVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:10:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6FE4E182;
        Thu, 13 Oct 2022 14:10:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0E23D7F9;
        Thu, 13 Oct 2022 21:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0E23D7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665695400; bh=5NvNZscNrtBbU2FXoDGk7TD0BmIyNwMHrPrknAmZ4Ro=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WbBfHw3rbPX2ZOMz6NTLY0qmGq+Al78r1vl8cJf2H1GtD5lL6AYCu9QGmS/IS/UOW
         GFZGpxVFEKf0MBWT8ep5Fe/H2bwp5wCMQeNcSK21mPSjVF8p5Uc/elZda3gbxetIk5
         t0mbapzGN+qxyi92xSpbob+4WR/1xkgPyWN+lN4G7l1QOn8bb0gDz4SkQnmWz/iwoq
         HXdWdSU9PXtYaQ5XSq4UwlnNxrQvI6LLjZbTEWybzGRd5P3kI1zpCJ52sWmbIknZYv
         7z4zT7juqFjvwD+Q1yk9l+xLoPdLpFCDBcqj73XhWM5dpJUTH6KJD1W2i0WPE+UWFJ
         QhX1Kh8woB9kQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        carlos.bilbao@amd.com, bilbao@vt.edu, ojeda@kernel.org
Subject: Re: [PATCH 0/2] Documentation: Start Spanish translation and
 include HOWTO
In-Reply-To: <20221013184816.354278-1-carlos.bilbao@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
Date:   Thu, 13 Oct 2022 15:09:59 -0600
Message-ID: <871qrbig60.fsf@meer.lwn.net>
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

> Spanish is the second most spoken language in the world. This patch set
> starts the process of translating critical kernel documentation into the
> Spanish language.
>
> Carlos Bilbao (2):
>   Documentation: Start translations to Spanish
>   Documentation: Add HOWTO Spanish translation into rst based build system
>
>  Documentation/translations/index.rst          |   1 +
>  .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>  Documentation/translations/sp_SP/howto.rst    | 619 ++++++++++++++++++
>  Documentation/translations/sp_SP/index.rst    |  80 +++
>  4 files changed, 706 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>  create mode 100644 Documentation/translations/sp_SP/howto.rst
>  create mode 100644 Documentation/translations/sp_SP/index.rst

I'm happy to see a Spanish translation of the docs, certainly.  I do
worry, though, that the desire to create translations tends to exceed
the desire to keep them maintained and current over time. Is it your
plan to continue to maintain these going forward?  Is anybody else
planning to help you with this task?

Along those lines, a MAINTAINERS entry for the Spanish translation would
be a good thing to add.

Thanks,

jon
