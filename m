Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A7E611523
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJ1OtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiJ1Osh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:48:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75C1F9A28;
        Fri, 28 Oct 2022 07:47:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0623260C;
        Fri, 28 Oct 2022 14:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0623260C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666968454; bh=UtbBjtOCDmxG1fiAjntsLrhrfFgg1H/OVy+mHU9Tdic=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YPUMK7NbZEWiVJxDd81wBZav9MFex8t217mE4PTTWDl1Wycu8GM6Ea9a1vRzQ6K4s
         LB7lTKlSS1ZmpG7NdF0hatynkN3t1WCNrag2zPTpYp8Msw6DjzzGxXOLTagWQfStM5
         OpzNr69zoX0ZplnOKZjT7c3Gdpe26YiCH/GCuvVKjggGKnoYVlW8q52BozogUqaHaf
         lqbfUUsSLqzTySycQ7oJUAd39iZ6MnYN5bJxYZfwTw6xy6OrG5GkA6RIbXH+7RLbyz
         i9pvY3yXqHCvRhxsT6z+QxdZ90sNaW8G8ij9tPpOZYwQ1kmZ7kWl3ddSJDgLnmf13s
         uYKklGhEZ+f3w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>, bagasdotme@gmail.com
Cc:     Brian.Starkey@arm.com, benjamin.gaignard@collabora.com,
        christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        jstultz@google.com, labbott@redhat.com,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lmark@codeaurora.org, mark-pk.tsai@mediatek.com,
        matthias.bgg@gmail.com, sumit.semwal@linaro.org,
        yj.chiang@mediatek.com
Subject: Re: [PATCH v2] dma-buf: cma_heap: Fix typo in comment
In-Reply-To: <20221028065907.23954-1-mark-pk.tsai@mediatek.com>
References: <Y1tSWo+eRvkVofbv@debian.me>
 <20221028065907.23954-1-mark-pk.tsai@mediatek.com>
Date:   Fri, 28 Oct 2022 08:47:33 -0600
Message-ID: <87k04k6m4a.fsf@meer.lwn.net>
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

Mark-PK Tsai <mark-pk.tsai@mediatek.com> writes:

>> [-- Attachment #1: Type: text/plain, Size: 349 bytes --]
>> 
>> On Fri, Oct 28, 2022 at 09:44:17AM +0800, Mark-PK Tsai wrote:
>> > Remove duplicated "by" from comment in cma_heap_allocate().
>> > 
>> 
>> This patch isn't typofix but duplicate word stripping, right? If so, the
>> patch subject should be "dma-buf: cma_heap: Remove duplicated 'by'".
>
> Okay, I've update the title in v3.
> Sorry for the horrible commit description.
> Thanks.

Your original commit description was just fine, you just had the bad
luck to draw the attention of somebody who likes telling other
contributors what to do.

Thanks,

jon
