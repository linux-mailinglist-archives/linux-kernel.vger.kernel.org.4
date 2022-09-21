Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A45E5441
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIUUMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIUUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:12:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394DA3D74;
        Wed, 21 Sep 2022 13:12:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 55B0B7F9;
        Wed, 21 Sep 2022 20:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 55B0B7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663791159; bh=HCyw+9UYLfNJ7d/Ja91BuDVnp8I7ZyuTH/KCTIXzVbY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gwl5RHBCP2sRiGkW7Q9ibExU4CkooWU1s4ehou7KP46wH6sZYFmm3nES8T/RMyDAU
         TR32ucz2dwWTEu3Wu8ODASBb1B+6dkGbEQTfMkAQJfSzYXhXm2Ke/vOszg3a3ZOOAH
         VF1Wsw9DcU0wjhQ6CBWGJQzKQMQzy7jpbX0P504bh64IGhSbBGZ71kjB+Hu7G9Mxtn
         vfr7QheNxQe3Zh/+MOQiZcRN5cPwtOHgA0LsxYaISmcGYEE7tyr6X7eWhK5QA7eDYq
         Hw93WucxfArzuOY1GNXYMTIvzXMrz98E24J4kYRWKSzAdBKqPFtO4u+fqT517aPW5I
         btMlgHhXuRgeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Helge Deller <deller@gmx.de>, linux-doc@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: fb: udlfb: clean up text and formatting
In-Reply-To: <20220828192501.14232-1-rdunlap@infradead.org>
References: <20220828192501.14232-1-rdunlap@infradead.org>
Date:   Wed, 21 Sep 2022 14:12:38 -0600
Message-ID: <874jx0v64p.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Clean up punctuation, spelling, and formatting for command line usage
> and modprobe config file usage in udlfb.rst.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bernie Thompson <bernie@plugable.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> v2: use some text suggestions from Bagas Sanjaya (Thanks);
>     add a '.' at the end of a sentence.
>
>  Documentation/fb/udlfb.rst |   23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Applied, thanks.

jon
