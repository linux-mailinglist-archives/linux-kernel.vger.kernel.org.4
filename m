Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687006A037A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBWIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjBWICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:02:46 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0194D60B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:02:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 400415C00AE;
        Thu, 23 Feb 2023 03:02:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 03:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677139349; x=1677225749; bh=Ns6fBcefCS
        Z3zA9z91vMNr9dPlillPJFIb1WJ0gDUyE=; b=DZ6L2apMSULrhf333hmaIHBh+6
        6bMFLpOkrWbtJn53kuYB22GJCp96NlbHOwbtW3T+2ByJexSehK/SHuGpQGwbfsdQ
        8c8bxsVLQWa50W4yHVdFCo3xXCuEqUWSc8Nk3bN7B50nWVmw9QhIeT2DmA/lejpB
        6itBQ2EXL9Samgj8QmMo74I5n2tJM0hQXte3JbyKau5xzeuFj4B666xmEcMpOf0d
        NjFLuI5FmULG8E3W/iR+445jcxRIR3jLgDh4nFl1U1EbcpTKZRmRt+0PtYrjB0IH
        3a30DPwvJH+TIoOR1oxoPOchB3kByO59iUeYWLD25ZvNwzL6uaCN08t/2AEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677139349; x=1677225749; bh=Ns6fBcefCSZ3zA9z91vMNr9dPlil
        lPJFIb1WJ0gDUyE=; b=iQCgn8ptvVOkSbVg0uzSxybA1Fut8KG/5VSshQqcTj9I
        1ZmPaBFeHNo5KiI0yiom/U+z3gjGeg0n8UKxR/J66xcZvzp4mO8IAb1O2HMwJ+3Q
        uWp/Hh1PbPmuhHunk9ELTO0+Lc3wx5+pV8+68r4q9/B5M67QRqZsKNR1rzM+jBIj
        2JPKo4keb5T0UjKvrhicHzbJlsA+jo2PSHMH45ySpNjCRw5UnzVeXqKYht+m4yc6
        pwGxmvlOhfnkeBFuMTWyq280+e/Pr/EDjCr9KRgp/30mswr3lDEvX8WCHbxpjCDw
        M0dIIi17AM2WZqqp6WGMMFB8yqM+eOoLrl/QR+6ulw==
X-ME-Sender: <xms:lB33Y_Atj9ufiSafQ3QV-huzvs-FroK1aYU2z0cNfT7ordcRaCl2mw>
    <xme:lB33Y1hLcuAhTeTD9MKuuJ1Le5RPm4JEsgr8GB6mSa-l3wWxxQ3ja9fmvb67s90vk
    7EGGA_HqFwPWAvRWWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lB33Y6l82_wzZDX5LAeo7bdUWgGRIvrQ9m49CVYoBeP2ffXhLgqgGg>
    <xmx:lB33YxxWI5qe76L9nftN5PZ2tWo3xGHeTuPrQ_hHlQwpRImCk4nv3w>
    <xmx:lB33Y0SWfEYBJoO1BvxmQrL-bbke9-zkXNRP4RbzMAqQB-bQ9hlGwQ>
    <xmx:lR33Y6d3vIQ8Am_prpdLphLlyk4Uk7EddkVFsAD6VmgMcDjbdGNZZA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3DDAB60086; Thu, 23 Feb 2023 03:02:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <c06f37e0-e12f-4dcf-8e79-bb73957dbd34@app.fastmail.com>
In-Reply-To: <20230222092302.6348-2-jirislaby@kernel.org>
References: <20230222092302.6348-1-jirislaby@kernel.org>
 <20230222092302.6348-2-jirislaby@kernel.org>
Date:   Thu, 23 Feb 2023 09:02:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, "Hyunwoo Kim" <imv4bel@gmail.com>,
        "Harald Welte" <laforge@gnumonks.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>
Subject: Re: [PATCH v2 2/2] char: pcmcia: remove all the drivers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, at 10:23, Jiri Slaby (SUSE) wrote:
> These char PCMCIA drivers are buggy[1] and receive only minimal care. It
> was concluded[2], that we should try to remove most pcmcia drivers
> completely. Let's start with these char broken one.
>
> Note that I also removed a UAPI header: include/uapi/linux/cm4000_cs.h.
> I found only coccinelle tests mentioning some ioctl constants from that
> file. But they are not actually used. Anyway, should someone complain,
> we may reintroduce the header (or its parts).
>
> [1] 
> https://lore.kernel.org/all/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
> [2] 
> https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com/
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "Hyunwoo Kim" <imv4bel@gmail.com>
> Cc: Harald Welte <laforge@gnumonks.org>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for cleaning this up!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
