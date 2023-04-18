Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5746E664C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjDRNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjDRNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:42 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2814462;
        Tue, 18 Apr 2023 06:47:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0296E49B;
        Tue, 18 Apr 2023 13:47:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0296E49B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681825650; bh=PT2NCMZmHfmFhFO7WyZGuotWhtVsbEgq9Kzj+l34a7M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qKmHPEkMmP0pBZDYzLk8DxuAtMJRzraMP4DqyUhUdaT6/RVJStVzZDawwe4MX/Nu1
         S5edW14rv/szYB5dh02gjIgPXvYSgH2DREbewUipFAPlDBbx3f3H6+JUJGCAUYydeI
         2sbUSQNLb6iZsC4hHH3fUMaV9RF9qgsT6RjcyQI036ZXmYvD0ElTbfJoJ/031GoFQa
         NMi4dr7qeTtDNEYt4xVhnmvxmco0HrNtkmRMCDw3aMqUYsFvAyZCacn/aoFZzuNMbp
         immz4RPN+fhTfvn+hX6X2Ft0IN1hVX7ZniZRGFymKJT7mqQNSjLi6Ep+eR45MS7BoX
         qZ6NXu97r9h0A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Yangtao Li <frank.li@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: f2fs: specify extent cache for read explicitly
In-Reply-To: <4517330a-00a3-220f-2fc5-a9ef4aba5ea8@gmail.com>
References: <20230417044100.56409-1-frank.li@vivo.com>
 <4517330a-00a3-220f-2fc5-a9ef4aba5ea8@gmail.com>
Date:   Tue, 18 Apr 2023 07:47:29 -0600
Message-ID: <87354xe1zi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 4/17/23 11:41, Yangtao Li wrote:
>> Let's descrbie it's read extent cache.
>
> "Clarify the fact that extent_cache and noextent_cache toggle read
> extent cache on or off."

Please stop nit-picking patches.  This is good enough, though I might
fix the "describe" typo on the way in.

>> -extent_cache		 Enable an extent cache based on rb-tree, it can cache
>> -			 as many as extent which map between contiguous logical
>> +extent_cache		 Enable a read extent cache based on rb-tree, it can cache
> "... . It can cache ..."

Bagas.  Enough.  Seriously.

>>  noinline_data		 Disable the inline data feature, inline data feature is
>>  			 enabled by default.
>
> "Disable inline data feature, for which the feature is enabled by
> default." (submit as separate patch).

And please stop trying to make additional work for others.  If you want
to improve something, submit a patch yourself.

jon
