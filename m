Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E374A0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGFPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:17:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE64C173F;
        Thu,  6 Jul 2023 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h7r9TfPQc3eLtstTBRhHVXgqEs3WPGyFsX8wAUte2AI=; b=b2bso8W40HKnZb9jOzWxH9qmgF
        yboDtFNU4H1GqQcqGFi1nxtKbaEEaGkS3qWOmN41k1YxJ8E9DyJt/SykuBj8iTbrZBog7uGn2EWkS
        939wg3pbvB7+ccqwtmqTmkItEJ6n5UMFZ63DfLs/x8uekyyMoEUxTFlxu/bMPhIBV/VcyEKNHltln
        haB8OWvPuwZ16tz/HoFw8RUDf/M5YZXMNMeThzPuLspcnti/r28VzHqg6q9/G8e1rcpCKbqeCN7oR
        DJE7oBeUnIn+YhMNkRRA3yJQi9XpeZsdKz49rpoCVIm+xnyky4rRq22HEttVP69Codlm0or5mk1J9
        xi2v2zOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQiw-001yxB-01;
        Thu, 06 Jul 2023 15:16:50 +0000
Date:   Thu, 6 Jul 2023 08:16:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sh updates for v6.5
Message-ID: <ZKba4SLzjjhHgOEs@infradead.org>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

thanks for taking up the sh maintainership!

Any chance you could do an inventoy on which arch/sh/ platforms are
currently working and maintained and which are just bitrot?

sh still has a lot of platform specific code that feels іt is rotting,
but some of that might just have been due to the lack of active
maintainance.

Once platform that I'm particulary interested in is dreamcast, which has
a rather oddball block driver (gdrom) and some very odd interaction with
the dma-mapping code.

