Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426865BD003
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiISPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiISPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:03:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1643337A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:03:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 956BC5C03A8;
        Mon, 19 Sep 2022 11:03:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Sep 2022 11:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663599825; x=1663686225; bh=fywcV89B39
        93E+BZ10dDpiTceGh8dwxED9SuRuVsowc=; b=K2A98Oai+ww33ScM0/2e2A5Ggk
        Jwdvi3PPhQf4Bg512W5jT81hgNfr0IxRNYZ5TSrBSggrTl3prEQZ6dMU/Ijlp23c
        CgjIEClzA960//nLukC9/PPjBZx7jrd0bJHzGu+YGMWpm83QMqgwOEhmAKgv/oSm
        6BBKH41IdINT1vmvHtENCOLLW6pQrTYW9zozGJDk6SNVtAfq+h3p3zIbR0jgGcvb
        u6Ri4FRNUSIpoeYP+aomflFg4YjepodsF2XlIslIZ5j4QToXCHcBgrFId6E+bv90
        IKdtxPARdMBykz6n4xlufkz/SBoIEUEnONLaGOqxT7IEUSzZ0r7j8oCmHxlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663599825; x=1663686225; bh=fywcV89B3993E+BZ10dDpiTceGh8
        dwxED9SuRuVsowc=; b=R5RMjHrvMGGGPbQpTX1Z0xN+DJED7wpUK1xy0miA5qB7
        NfugZW8FQksdMoY+S2Kz+YZraGO+oQrZBZfQlZyRMyEuC0A4jmf5ndWBed6b86tI
        xTeDGzeK6qj92AzG3EYK4k9Xevcf9wR1Kn/GMDU5bhBawnqbdok944i2INbSs8Gb
        WtwejBI7PeoJ4Jm9/ixLurfgEEUvGpdIXQ0YPEQfUHHQV5eu+YmnFfnv4WJIRuZc
        ozWrsH5FE79+zJzq2SL/7hFm3tJ8kB2OSEc1Gx0Er8e8+goQbJ2damKeX14bO63O
        JiEzcBOoybanvLldqG859FhddvB1BX5BRbhB5uNP5g==
X-ME-Sender: <xms:0IQoY5w58hOsdITkaKnlzVgHpZeqSB5p7EMvRQUzKkUE_EBAei45gg>
    <xme:0IQoY5TLqsn3N-TUBLpvjkL0TNjGGUXOVmibJCC5XGxo30NccLbbNskN4EHrPyJhv
    hnkY-RIcC-fgOz_YkQ>
X-ME-Received: <xmr:0IQoYzX-b0woRbX4XxNAUoiTjwHYEav_vJnXmkP0pqRyrWDwIKbeFvIbKDKYjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:0IQoY7hG0r1AtTmRFS69dm2_BpCE9FRUD4mmDLqUJQ47vsCZkEhHvg>
    <xmx:0IQoY7Aw9btLyo6CS1yJ2Qke60W0fYUWCvIdL-HeOLRdTmlj3QwYpw>
    <xmx:0IQoY0J3SlSayEFjNFefBjlhCGmH8hYL_sNSQkUv9DULG-THnJ89HA>
    <xmx:0YQoYyPD3T131zmMyt2kJM_nix7ygp11W024FKB1ZknU6Rf-LXduwQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 11:03:43 -0400 (EDT)
Date:   Mon, 19 Sep 2022 09:03:41 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <YyiEzbTDZ+g9iAas@tycho.pizza>
References: <YvpRLJ79GRWYjLdf@tycho.pizza>
 <20220901140647.1125079-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901140647.1125079-1-tycho@tycho.pizza>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On Thu, Sep 01, 2022 at 08:06:47AM -0600, Tycho Andersen wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> In my very light testing this resolves a hang where a thread of the
> fuse server was accessing the fuse filesystem (the fuse server is
> serving up), when the fuse server is killed.
> 
> The practical problem is that the fuse server file descriptor was
> being closed after the file descriptor into the fuse filesystem so
> that the fuse filesystem operations were being blocked for instead of
> being aborted.  Simply skipping the unnecessary wait resolves this
> issue.
> 
> This is just a proof of concept and someone should look to see if the
> fuse max_background limit could cause a problem with this approach.
> 
> Additionally testing PF_EXITING is a very crude way to tell if someone
> wants the return code from the vfs flush operation.  As such in the
> long run it probably makes sense to get some direct vfs support for
> knowing if flush needs to block until all of the flushing is complete
> and a status/return code can be returned.
> 
> Unless I have missed something this is a generic optimization that can
> apply to many network filesystems.
> 
> Al, vfs folks? (igrab/iput sorted so as not to be distractions).
> 
> Perhaps a .flush_async method without a return code and a
> filp_close_async function without a return code to take advantage of
> this in the general sense.
> 
> Waiting potentially indefinitely for user space in do_exit seems like a
> bad idea.  Especially when all that the wait is for is to get a return
> code that will never be examined.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> [tycho: small fixups for releasing fuse file + nocred flag]
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> Reported-by: Tycho Andersen <tycho@tycho.pizza>
> Tested-by: "Serge E. Hallyn" <serge@hallyn.com>

Any chance you're willing to take this patch? We're still seeing this
a lot and it would be great to get it fixed.

Thanks.

Tycho
