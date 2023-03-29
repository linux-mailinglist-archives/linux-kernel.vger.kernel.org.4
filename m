Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD066CD4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjC2Ij5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjC2Ijy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42312E;
        Wed, 29 Mar 2023 01:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7567361B83;
        Wed, 29 Mar 2023 08:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFC5C433EF;
        Wed, 29 Mar 2023 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680079191;
        bh=MbbUjNHksY2NgnrDrVZWYsUNCTFADXtE1DM3qUt1vac=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U3pWhUEsCZdsFHNnsoF8CTUf1dF+whckB1hNS7ZpzHvQnuzTdJpXuX230Yk+jEEAo
         MoJbiQ11NWC0py1mnPzpQ1z+DfWOqeVt7XoPZHwrrVUTHsBLOQ3OnD7rKVHXxYzZpI
         n0J+Mjt//J2WMBMPm+wFhAp+kbMY71sipyK5qsMhqFK0AE0wXXv6xPSWSqNKRGzm1W
         DMXi4rjMs0+2qeK3+Vbf6Gz/eNJ6AJchF1dhfDORCFvrbcB/RKdaSxwj7gTZExpRoS
         cvogxrNNJ4YaG9bMVlkMijUBn9QaIx0FtHsS1VHb5OV7HXZKhxFg/uIUBrm/jJi1L6
         z6guRXp4sjxDA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: Linux 6.3-rc3
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
        <20230320180501.GA598084@dev-arch.thelio-3990X>
        <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
        <20230320185337.GA615556@dev-arch.thelio-3990X>
        <87pm91uf9c.fsf@kernel.org>
        <20230322163637.GA918620@dev-arch.thelio-3990X>
        <87wn36ctdi.fsf@kernel.org>
        <20230324151150.GC428955@dev-arch.thelio-3990X>
        <87o7oicgwv.fsf@kernel.org>
        <20230328190745.GA375033@dev-arch.thelio-3990X>
Date:   Wed, 29 Mar 2023 11:39:45 +0300
In-Reply-To: <20230328190745.GA375033@dev-arch.thelio-3990X> (Nathan
        Chancellor's message of "Tue, 28 Mar 2023 12:07:45 -0700")
Message-ID: <87h6u4t0ha.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

>> >> And maybe request a similar llvm directory under pub/tools to make it
>> >> more official? :)
>
> We now have https://kernel.org/pub/tools/llvm/, which is about as
> official as we can get I suppose :)

Nice, thanks. Bookmarked and I'll advertise this to wireless devs
whenever we have clang warnings.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
