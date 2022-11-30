Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA263DA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiK3QNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiK3QNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:13:45 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270D1173;
        Wed, 30 Nov 2022 08:13:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C601A3200940;
        Wed, 30 Nov 2022 11:13:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 11:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669824819; x=1669911219; bh=6rNwOE8DeU
        XOqrm/Kv8c4D9qT8aLyNOPDcz87qvtpV0=; b=bTDLd0LmS+taWzPqET6R468smt
        ICpm5PaW9y9FF9OX9WWDBtiDPCqlaBa2hLWfZdeSeOo9irnuayXDqGjh21/JSEDJ
        SjRa10tBk9bWBCl6+V1h3osSzo2XY1d8pOA0QL8+siqwrzKeFDJK5XDddQeKITaz
        W2L/KO+o8HJAayx0MGw7d1xi7dC6+qUcSXVCM4UIlk2F2gu1vXF9/Mo7BpTRbYD+
        vR2q14OKEp9anR5mJx84UueAJxlyl2W8cmtD5HsxokNS/jjEVxzi9GaEbMVqdrkn
        dPs4mMbqZWqwPlpxxdFMRKRPYk6GtQqr+hnZz2SY7bOmUFo/lveg0NgEvVJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669824819; x=1669911219; bh=6rNwOE8DeUXOqrm/Kv8c4D9qT8aL
        yNOPDcz87qvtpV0=; b=alGiynL0TA91iv2tpMX0NO/ThMKI94ZgXZK0nPeZLsB2
        J9Jm1w0fRKWyoBnnYY9uLxef6Qxbtf6XB+UAq9YRn/7T3057pwW6C2GJS1Xauwa/
        V1SZBzDDCkbSMHcnQmmse1iStOugP5CiuhBFwP/L1bnGHHCuoVJIFfMupBv2ZfwE
        FKogwX/v2NSThUvGukI2WTH2QntNfQxLojtzT1k2cjSrFYEoh1oJcQxNioWvtU4i
        /vaoBpsd6OIAQr0lLeVpcH3OX1SH8sDeCBHTqe6pZWcyfu2lYTeCSVJ6s06RZ/bG
        IO3FCHHnr2O+XuTaLcsjVccRv/Q7IKDxetuK8ISktg==
X-ME-Sender: <xms:M4GHY6cO3AM7unfeJbFxhoSPwNRza2DVkFpcMN4-E77M_f7cFgPueA>
    <xme:M4GHY0NjxvUB_r2RHvnkuHrIMfC71iarmrn3GI05pG4w4IANCc6VMcooTB-dBWbNa
    Q_hJFMjQ-gg3D7oDfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:M4GHY7jNynUKD_DT8MF6EJ2ds_yRdFF0iWJeptOAlxD2XXQe9oABVQ>
    <xmx:M4GHY39TsNaXxsxgJpYcqSX_4RupMOzuRehE6o53QaOkHuo-9gtnKg>
    <xmx:M4GHY2trbyuVJJkddnJYpVuxSvGHvyWCLJ0WAFw9NwOeVPVdz8wNuw>
    <xmx:M4GHYwJSDXZSIDajwEIU2vgxcucjE6iT7ybXYUq4jNfd579k7rCN7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F365AB60086; Wed, 30 Nov 2022 11:13:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <974d7fcb-efbb-4508-a4cb-4b5328669c14@app.fastmail.com>
In-Reply-To: <CAHmME9oGffi539nEAJkOjC-2yAR+0Ra+wQw5oG6Y6+CRr5e62g@mail.gmail.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-4-Jason@zx2c4.com>
 <878rjs7mcx.fsf@oldenburg.str.redhat.com> <Y4dt1dLZMmogRlKa@zx2c4.com>
 <Y4dvz4d0dpFzJZ9L@zx2c4.com>
 <16ec2a7a-c469-4732-aeca-e74a9fb88d3e@app.fastmail.com>
 <CAHmME9rpdCGLQzfsNkX=mLHfWeEWi4TyrOf_2rP_9hsyX9v6ow@mail.gmail.com>
 <574ad32d-566e-4c18-a645-1470fc081ede@app.fastmail.com>
 <CAHmME9oGffi539nEAJkOjC-2yAR+0Ra+wQw5oG6Y6+CRr5e62g@mail.gmail.com>
Date:   Wed, 30 Nov 2022 17:13:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     "Florian Weimer" <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022, at 16:47, Jason A. Donenfeld wrote:

>> > There's padding at the end of the structure, yes. But both
>> > `generation` and `is_ready` will be at the same offset. If the
>> > structure grows, then sure, that'll have to be taken into account. But
>> > that's not a problem because this is a private implementation detail
>> > between the vdso code and the kernel.
>>
>> I was not concerned about incompatibility here, but rather about
>> possibly leaking kernel data to the vdso page.
>
> The vvar page starts out zeroed, no?

The typical problem is someone doing a copy_to_user() of an in-kernel
structure into the userspace side, which would then copy the
padding as well. If the source is on the stack, a malicious caller
can trick the another syscall into leaving sensitive data at this
exact stack location. Again, I'm not saying that your code is
vulnerable to that type of attack, just that making all ABI
structures not have holes is useful for auditing.

    Arnd
