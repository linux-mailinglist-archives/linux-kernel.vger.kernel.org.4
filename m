Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A75FF17F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJNPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:36:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51572A417;
        Fri, 14 Oct 2022 08:36:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6359B35D;
        Fri, 14 Oct 2022 15:36:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6359B35D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665761803; bh=JtRRNL01IJG8KRadM+8lM76wAHeKVUe2u8UMrU8vtmE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r8jDfjapYw3nwvM3/GJ/GzAkihMfV797mWovQ5WS+0jzC9B6KOTleax8voAYe7rO2
         FRZFnFvWwvbBJ/2IgtVo5Eqxxmo6oQCd+vptvqo6wsMI0M011Fg3HYb37LMNZkydfA
         bNfNMPt9Bam5oAH3I7VjYUh63H93styUl+DpF7NMmgkw0iQzK4C89lMwxdCW58occq
         y7jAwEy9FkEfHLQIqYDR54winL/InEtQp/bvseHhr6LngrtxvtuIDFgeqWM+z2Uldu
         BbAfjAW4mEus17Ri08ZyHF4VbLVQ38bwDm88Y/RQ+uZ+hHwJE9vBGySJTmhFw7PBx0
         MOSY3AIW8MiOA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
In-Reply-To: <735f9ddc-01b4-f9ab-8d28-6d10630c994d@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
 <20221014142454.871196-2-carlos.bilbao@amd.com>
 <CANiq72=DuRw_0AiC7LtWA7n_0Rpsz3cExXj4YX4zu4o8RxugJA@mail.gmail.com>
 <735f9ddc-01b4-f9ab-8d28-6d10630c994d@amd.com>
Date:   Fri, 14 Oct 2022 09:36:42 -0600
Message-ID: <87bkqeh0xh.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Thanks for your feedback, Miguel. I will wait to see if John has anything
> to add before I share updated patches.

I am, alas, not well qualified to judge a Spanish translation (leggo
facilmente quello italiano, invece :), so I don't have anything to add
there.

There's no hurry in any case, I'll not apply this before the merge
window closes.

Thanks,

jon
