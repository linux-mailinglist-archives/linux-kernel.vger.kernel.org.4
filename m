Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81C6D070F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjC3NlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjC3NlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:41:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46B9F;
        Thu, 30 Mar 2023 06:41:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1C2F736;
        Thu, 30 Mar 2023 13:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1C2F736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680183672; bh=nO26Xu/p6Q24gR40+zVob63N6d/dg8KmFM/GexFfZLg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C8qjl6M2pGRsRVORPqLI20zJKclZsCBVJ9EPZw86FmE9K9pHoFUWhaOIvB5f+CZ78
         qxpVSyLRJu/kJGN0SZ63CgCRqHVszFE/6Gs4toa84oyIuroOpvz868mE1A6/g3TEu1
         rERAzfe+N+dwGuplI0XV7YbLppAqaTN0n0MqDBgId6ApyqY3tUTXmHC0bAbCTWVadj
         vFO/wj0LtF7Cg6R0n7uCGA4U69+1JVOHel9Jw+WNRNj6r/MuXmrPqpeqFO0mQGuRiI
         f3VB/sC6Nxdvz/8YGnLOMnmv+JI0B6m7U/V9ghAVl6/3Lz6UhMVrKrUTa+FQgpihsi
         KYzHttTImapeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Subject: Re: [PATCH v2] Documentation: Add document for false sharing
In-Reply-To: <CALvZod48Fwua_VJvnzHatF-J4YRWqfMFnYjYN6W0_ioLtPZEfA@mail.gmail.com>
References: <20230329073322.323177-1-feng.tang@intel.com>
 <ZCUPxMQPJ8ETvUbM@debian.me>
 <CALvZod48Fwua_VJvnzHatF-J4YRWqfMFnYjYN6W0_ioLtPZEfA@mail.gmail.com>
Date:   Thu, 30 Mar 2023 07:41:11 -0600
Message-ID: <87h6u2gxvs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt <shakeelb@google.com> writes:

> This is too much and unneeded nitpicking. The patch looks good as is.

Agreed.

Bagas, we've had this discussion before ... several times ...

jon
