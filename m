Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09845ECCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiI0TZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiI0TZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:25:26 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD85A82F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:25:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4E5592CD;
        Tue, 27 Sep 2022 19:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4E5592CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664306724; bh=hm1pn6IwiHYS/BojC7LqQUhE+b88DFYu+8Kiy4+hfkk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B1UmYf3gyZRM/9vF+J/Zvtc7xtogiUUpJmc+LCeUtg2Evfie7+nAPfF8VanpyQRRI
         pQFBc8z3rTQUX6ComHqjG0XZdS8wlZfDoh9bpvPDx9JgTyH5iBJbD1CWsWRK0bIfX3
         7JMNoPtLd3lVYVxOVdWXH4yUHSNfkq0ip/QJ3Gewt8RIT6nLKJkEMoPFM9Shs+UUQc
         ZxuVD6vDUiI4uyPtS9Z3gwWZV7eBWJwS8J7+RMOJYOZHnUstmPX8b1dJJMNMglbe09
         KuNi9d9/yqC0GP1vWo0zA4C4q+8HK7pnyBWZNrrx+WF2Q4YJZx1wVyDen1XMUI/5Wc
         W11BMLU0H7zQg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
In-Reply-To: <YzI/3MjHgbXFHoHG@sirena.org.uk>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
 <878rm5rbka.fsf@meer.lwn.net> <YzI/3MjHgbXFHoHG@sirena.org.uk>
Date:   Tue, 27 Sep 2022 13:25:23 -0600
Message-ID: <87czbgoc0s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Sep 26, 2022 at 04:54:45PM -0600, Jonathan Corbet wrote:
>> =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> writes:
>
>> > This also reveals that I missed NBD_REQUEST_MAGIC
>> > (needs to go, same reason as NBD_REPLY_MAGIC)
>> > in the first pass, but that's unrelated here.
>
>> I've been trying to make sense of that merge myself.  Is the right
>> solution that I should just drop 32ba63d4b2e1a ?  Manfred, thoughts on
>> that?
>
> That'd certainly be a viable option too.

OK, I have dropped the conflicting patch.  Manfred, if there are changes
there that still need to get in, please resubmit that part and we'll get
it done.

Thanks,

jon
