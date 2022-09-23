Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6442B5E7C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIWNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:39:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC4A98C5;
        Fri, 23 Sep 2022 06:39:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 71C5B7F9;
        Fri, 23 Sep 2022 13:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71C5B7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663940349; bh=XtwcXAwE7op9aNDWjiJrtgb37mH7+IErYuk6ped7kew=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FZi9/vFOrDm0CaK2TE2Py0RePLYhQf8j5N0LwRMMJygDH6lGG4a8kQc5knsaR3leq
         r4WWT8Qv4siVf0a1IkBmjrWf6N8D4dzVs6C2dpgeaDYo0bWCuFGICNpCYr4B3ambAy
         CIZQHnAQnYaf+xJPSCZIudHQaxExKlsfc9f2WuKeutXFQl5VUVKxmiZ+4YsLf5sTEE
         UyCigETcpxjvsbt6STZota1w2ZgzE4OH6PjmS7XP8vp5ap/kgBDrUwWn8sSSGyj6/v
         Jln9xcx643/aQa4SS7oQaJbtUvDKka0+RljOr2fSM/RP697TVs91xpRJUW5gFNWo+M
         3evwU4IdcDdfQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt
 into the core-api book
In-Reply-To: <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
 <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
Date:   Fri, 23 Sep 2022 07:39:08 -0600
Message-ID: <87a66qp5vn.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 9/23/22 03:41, Jonathan Corbet wrote:
>> @@ -0,0 +1,18 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +   This is a simple wrapper to bring atomic_bitops.txt into the RST world
>> +   until such a time as that file can be converted directly.
>> +
>> +=============
>> +Atomic bitops
>> +=============
>> +
>> +.. raw:: latex
>> +
>> +    \footnotesize
>> +
>> +.. include:: ../../atomic_bitops.txt
>> +   :literal:
>> +
>> +.. raw:: latex
>> +
>> +    \normalsize
>
> Shouldn't warning like "This documentation isn't in RST format and included
> as literal block" be added?

Why?  Who needs that information and what will they do with it?

Thanks,

jon
