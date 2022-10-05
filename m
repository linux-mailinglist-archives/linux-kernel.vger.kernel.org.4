Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21675F595E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJERtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJERth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:49:37 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED70302;
        Wed,  5 Oct 2022 10:49:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32FD05BF;
        Wed,  5 Oct 2022 17:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 32FD05BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664992174; bh=eSxeeKM2XeqBnmSi3M9iG87VYg0x5e8WIN95Gd/AeUs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JHgKQ2pET8T5hkjYYcD7ZGpueZ0eGaMeN37HRTmlh3F6RXB5G+69JK+GhplCQZ4WT
         3khGFzGywaNf7p+L99Csq28VoXEHSM22yGBSvUKzloebFDhO49JfdvE1IVKGlZMjS3
         dM/pBLKUn5yZUcDZFVGTSvVp2c3hDFZnowMTEbLJiWNays5O7lCELc3kx8ETJc4DZm
         pUsv555BbHKkfDZ70x/2PcNfHi0abDZVwi11+COmltr747tUNkGsLnyeIDrHdRw0UI
         wTYCmw0jWgdWdiRVfM5RcjZ23nyawC5xOLtaE/fbJuDf9xdlfqQLv4TvXmPeWGUyJe
         e44Y+4YX0ezNA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/5] docs: Switch the default HTML theme to alabaster
In-Reply-To: <87o7uqqj6s.fsf@intel.com>
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221004201222.281845-2-corbet@lwn.net> <87o7uqqj6s.fsf@intel.com>
Date:   Wed, 05 Oct 2022 11:49:33 -0600
Message-ID: <87h70i9n4i.fsf@meer.lwn.net>
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

> I wonder if the right way to do this would be to define our own theme,
> which would mostly just extend alabaster, but would have small tweaks
> [2]. Where are the Jinja experts when you need one?!
>
> [2] https://www.sphinx-doc.org/en/master/templating.html

I've pondered just creating our own theme, it's not *that* hard to do.
It's another thing to maintain across multiple sphinx versions, though.
I'd be more enthusiastic about the idea if we had a $SOMEBODY who would
commit to doing that.

Thanks,

jon
