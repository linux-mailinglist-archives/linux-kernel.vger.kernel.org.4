Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AC5F6879
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJFNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:49:28 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2737754B8;
        Thu,  6 Oct 2022 06:49:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 343975BF;
        Thu,  6 Oct 2022 13:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 343975BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665064167; bh=3yOrPKvm0I0vrMoU1xDUguybCRr2Y2rZ9sRGcj/GPVk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M15Npdr5zFEbg/WWNkF8N2xj7UcbZfJnAEJLjSocyILQCMySxGl730RpoCX/REsgK
         DWpc8fliCdPbtMTvdl/kMbn1XdjOLDUcmqMh9TO3MYNPx7utf7fL6qKrLMJv8tKzZS
         MpRhh5h9cCyJdVoAxix2R0clJgwQ/DaJU5xIme1E6X4S/am00CgjQBB6BZJTH6ovNF
         WF8dgpZ3GpVo9N8UZURMPazjRZKC/oKz3MNNwAIOh6fo6+k9Aw6+eOHSUMSOYYlFU2
         XLHH/KOypBOs42hjGNQayoDbLXxU4uTChRNs3QNW4rebEHbwDbYR5ajQlhIID6XzDb
         oB7/IBuoH8sTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH RFC 0/5] docs: Improvements to our HTML output
In-Reply-To: <87tu4hp5pg.fsf@intel.com>
References: <20221004201222.281845-1-corbet@lwn.net> <87tu4hp5pg.fsf@intel.com>
Date:   Thu, 06 Oct 2022 07:49:26 -0600
Message-ID: <87k05d83kp.fsf@meer.lwn.net>
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

Jani Nikula <jani.nikula@linux.intel.com> writes:

> I admit my wish-list replies to this thread may seem a bit obnoxious,
> when I'm not prepared to contribute. Sorry about that. My intention was
> not to block any of this, rather muse about what the future direction
> might be.

Wish lists are good.  As noted before, if we're depending on me to come
up with the web design, we're in trouble...

> Overall I think this is an improvement.
>
> There's only two things that I'd like to get addressed, not necessarily
> now, but eventually:
>
> - As mentioned, the main div width as pixels in the alabaster
>   theme. It's really crappy on wide 4K displays. Only a quarter of the
>   full screen width is used.
>
> - The function/struct/etc. main descriptions are now displayed in the
>   gray background, along with the "declaration", instead of white
>   background. Is that an intenational alabaster feature, or is it
>   something we do to cause that? Seems like the description gets a bit
>   hidden there.

Both of these should be relatively easily done with CSS overrides, I'll
look into it.

jon
