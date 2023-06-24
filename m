Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF873C72D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFXGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFXGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:52:36 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C828F10F2;
        Fri, 23 Jun 2023 23:52:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BA1F1320069B;
        Sat, 24 Jun 2023 02:52:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 24 Jun 2023 02:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687589549; x=1687675949; bh=a/
        EUr8yu4224Jcr2ZvrVOQExf0qZ5UTKToXEGFugzcg=; b=oMGDtkF1UfB9lj9skX
        Gn9NYSEl1E2jO7vl3RBeHW4pwP+7lkUx5WtzD7+2/oqNu6iCr4XXvXf/JsqcPjr9
        WhppI28dhxnqHX48qGTI5ei2xN81jcT0vgY5J3cFeH/rxj/VAab7rX23PbeBOVrm
        Jzban893bHOGKghR6/5IBdMLy0OaA/d/O/Oci0GjV2whZWIGjlK0ELv2BtTmHYTy
        ibDosSlQPf6ws2/E//8On6i3OypDHGri/mrvaS1et+Aru7lnFimoZdUjOpNFEh6I
        Lb6VVrjDzvqQZtCbmzyJeiDUBB4X3vOy7zWyr68i+1BeQNq76zUFJig+zNy2k342
        n4fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687589549; x=1687675949; bh=a/EUr8yu4224J
        cr2ZvrVOQExf0qZ5UTKToXEGFugzcg=; b=oLY8cpNv9M9p4pLZr2uuc1daW5Qtj
        +NA8A/ne8rO8tarjHtN7GnZM/MeCdF14iXISKUV030szwwRajjbO7iDy2FbjeHi6
        ZIEkygYw8QvDmELPrz57H/9Qq6d75VbjFng55u8zoYDgNdlL1j/5p6XuNTtWwe+D
        95fC2MQ7Dn4xS9tFrbguR6UYnsobs+YJ1gOBFybwyd1+ttYjpZPBbY91V+d18QNV
        sVD9MQ/s8TfUqAiFW/mEyt+Hp3gh6haWwzjwqkgFDPzaEBJKlIGi6AQYp8fKZfB1
        j4Q27rZ0laMHsy/sy7nEx3c89FKQN5n1Gf4HujdDG5rLb1x6KoepmM5gA==
X-ME-Sender: <xms:rJKWZHT1OMJ7zkmnx5glrOzeiFgbktYS2l4P_xRfcMfPRe7iJ_zJPQ>
    <xme:rJKWZIzWrAXVRHcwQdwyH0zewJgPV9yRkAyrjdFyqYAKFvHNPSFFxCBm8Wmzopdjz
    7BnHXqgOJXeHw>
X-ME-Received: <xmr:rJKWZM15yduAXMf3KQkuYcXzvZc6Iij61OcHePpD1Sb6H_XVnMn3jLuMepryJ6XnM-dQ7QvX9d--4JQuE3BKU-L0JUtQLlej4R9Ayw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:rJKWZHB2FuyI2LZ7nnzR0wI0eiTXaLm8St_3jICY0_LfCZZa7eRsXA>
    <xmx:rJKWZAjSfD8Y4HvlusIWg1PTrPUdmd7r5SfTh7DLLz3VjawI21G3Mg>
    <xmx:rJKWZLo5Hz0_-DGcCRLPDRSc98zpoP2uYUzf4p9aLIgt9qhoF54bbA>
    <xmx:rZKWZL3ZJRGYSeN8dauK41_X4Rm_2jOJwWMu_GDIR1Lo8Npma9jEUA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 02:52:27 -0400 (EDT)
Date:   Sat, 24 Jun 2023 08:52:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Matt Gilbride <mattgilbride@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Asahi Lina <lina@asahilina.net>,
        Alex Gaynor <alex.gaynor@gmail.com>, asahi@lists.linux.dev,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        linux-kernel@vger.kernel.org, neal@gompa.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>, yakoyoku@gmail.com
Subject: Re: [PATCH v3] rust: xarray: Add an abstraction for XArray
Message-ID: <2023062410-unburned-humorist-4e8c@gregkh>
References: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
 <20230623172005.2432028-1-mattgilbride@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623172005.2432028-1-mattgilbride@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:20:05PM +0000, Matt Gilbride wrote:
> Hello Matthew,
> 
> Could you please take a look at this patch? We also need `XArray` for ongoing work in Android's binder driver.

There is nothing here :(

