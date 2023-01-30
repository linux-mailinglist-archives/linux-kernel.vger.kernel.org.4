Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE4680F31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjA3NkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjA3NkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:40:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB132798E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A262B8111C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A7C433D2;
        Mon, 30 Jan 2023 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675085998;
        bh=ZzMJHiJqebQ4kw2ICADhTnCs7qv1ooggE4O4Ys2so2A=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=kkcfAE4xV2OwZvZNAvnlTSdqRlG7NZuDW360eUuImqzOenxJ7F/xCdZnz01Nx+Dn1
         FjWlaLA+i9gIdp3y+Ivag/A44HAAqlhusKcw86pXqZzbjYqSF+QBqQMGKsEIZyh2YW
         nZYNeensFF1z9DXFVebGL4j8tAd0+bDARyq2kwIzTkG/cKOKaQ91FxHmhSqpRa4kRT
         8vxplFkRgneROPalvQ6BDQYGxVNYfRCNmTbNdboncb8OQ23L49Y/PHBsExetngTAh/
         Unf8HCjVVms1/WxirkX5TktYV/QlFp2HHHJ5baQpYvTtdTwOn42Ruc5CCd7Rst89K1
         5HqvN8UokyTTQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 19B5027C005A;
        Mon, 30 Jan 2023 08:39:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 08:39:57 -0500
X-ME-Sender: <xms:rMjXYx4zrqbuOBbDysFcZf448EGOhOqy164N3jEES50nNqJMQrr02A>
    <xme:rMjXY-7TtuVhbVrjXb7TmZw7KUOvmRYdIV_aQtLjpj12667PB5XJlq08Pi4rZUaQ0
    h8gy0imPaiVkrpj5Oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepleevgfduieehfeeltdettdfhfffgkedugeeklefftdeivdfgveeiteet
    keehffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rMjXY4doCMzzAy0JUwcM74XsJUmJ9ZgDqJWwe4ykZZyJcYFPjcyk6A>
    <xmx:rMjXY6I31SBiHtZK2sgRRQbJR_rDc8gNbJA7cOzGsfnrDlw7nXnj9g>
    <xmx:rMjXY1IAYIzB6OV_3oIqAXaXiNNUzB6XhSgnKD78Z1UbmArW6WjpNw>
    <xmx:rcjXY6o1VfsA1BB3-XxVxD7t4wnVZE0DasIfsilqm5cj39nq3WatGA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EEE14B60086; Mon, 30 Jan 2023 08:39:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <b6333b49-ab8e-4f1b-9da5-454dd7d6d6bc@app.fastmail.com>
In-Reply-To: <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
References: <20230126163719.3585002-1-arnd@kernel.org>
 <20230126103811.56d71351.alex.williamson@redhat.com>
 <20230126174044.GA15999@lst.de>
 <20230126104515.3fcb3abf.alex.williamson@redhat.com>
 <20230130073324.GA590@lst.de>
 <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
Date:   Mon, 30 Jan 2023 14:39:36 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>, "Christoph Hellwig" <hch@lst.de>,
        "Alex Williamson" <alex.williamson@redhat.com>
Cc:     "Tony Krowiak" <akrowiak@linux.ibm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Finn Behrens" <me@kloenk.de>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023, at 14:34, Arnd Bergmann wrote:
> On Mon, Jan 30, 2023, at 08:33, Christoph Hellwig wrote:
>> On Thu, Jan 26, 2023 at 10:45:15AM -0700, Alex Williamson wrote:
>>> The culprit is already in my next branch, we just need a fix that
>>> includes all the cases.  A respin of Arnd's patch would be preferable
>>> to keep the fixes in one place.  Thanks,
>>
>> Arnd, do you plan to resend the patch, or should I take care of it?
>
> I sent the v2 last week, it looks like I forgot to add you to Cc there:
>
> https://lore.kernel.org/all/20230126211211.1762319-1-arnd@kernel.org/

I just tried again and see that neither my own script nor the
normal scripts/get_maintainer.pl picks up the hch@lst.de address
from the Signed-off-by line in the "Fixes" commit, though it does
pick up the addresses from Jason, Tony and Alex. I have no idea
what is going on there.

       arnd
