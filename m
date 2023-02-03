Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569A689183
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBCID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjBCIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:03:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D51B306;
        Fri,  3 Feb 2023 00:01:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v17so4683026qto.3;
        Fri, 03 Feb 2023 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc7Xh9yuox+AZ7mX/sAoplAbR6gr2cJ5FgTsBxboy74=;
        b=MTBn3C/Oox57zcfqxepxI7CXCPyjjZyyTXr8oHzGEGS904EHjRipTSqVV8+e1O69D2
         KEQQ42pQQxM8Taqzvb3AO5Xx9dDMliYcsPaChPj5Ym7/a2/qQLr06+JH6FG4/gWk5QDn
         dLi2+LnwvAT9P3iXEOHQa9uAp9jf4kYCWqWl+Ir7VcpOLIpduQ536L/1c65xEyESjWm6
         pYm0IPtGeEnf3kukL6aa2+AWHSWAz9Nb6gHmBORtZ+KuZYol035ymKr3fJsbWegXx6ra
         OCXydSgGvk/HcJeP07KVSCbrpLwTUd2euILFdwT+LMzKj7QwcKqVMEKhBc5Ro+OhsFje
         qDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc7Xh9yuox+AZ7mX/sAoplAbR6gr2cJ5FgTsBxboy74=;
        b=X/uAnn2Y9Knv+aWcZ2N+s4ORiXBKRLGOH+imGsErGo2S5xoq7YpIm6fYaeWOL6mlZz
         sQ9AS7IoXXmXvXxdroWCS9FYWa4zAou2v8nUsqWtdtcejZ9T2EJtPOwjSHo2KwvGZNcU
         iITXEWZrtLleQUYsMUyDqkZh7M6H8TMQWePQBaXuk62JF0TzCNviSbzZxeAOYqJHYWW/
         B2G7M1fTUjOlHYsoKEtFBz1IG+Xzz7Yle9W3VLaMxZTpaIp4hT7wR5UDEvzXsCtEp9uj
         sF1LQT42JiyhfhpcvjrFsT/KYQ/1O/ElHV0IPtWe2/S6WaV+kbuXMhUdbSakv8j6Ls8X
         LJ0Q==
X-Gm-Message-State: AO0yUKXpbT6q5SbR9p/IdvKp3lrhH7ZVNT/weG/rsUCJJ/ZyozOE+Ta8
        Oj0EHLr829a2r8D3dWaVop4=
X-Google-Smtp-Source: AK7set+zCDAm97GhxYZe06v6HPw8d0RUGW9xczfBBGvmut3tTjEedm10W/DpLz+FhrbzLgT1Rryexg==
X-Received: by 2002:ac8:4e90:0:b0:3b6:9c63:5ca1 with SMTP id 16-20020ac84e90000000b003b69c635ca1mr18425299qtp.43.1675411300176;
        Fri, 03 Feb 2023 00:01:40 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y21-20020a05622a005500b003b9bb59543fsm1172432qtw.61.2023.02.03.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:01:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1F68927C0054;
        Fri,  3 Feb 2023 03:01:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 Feb 2023 03:01:39 -0500
X-ME-Sender: <xms:Yr_cY4KcdBS-MGpnCLe24vlXv8AY25vK_O548r-0VXsE_yh_HZBS2Q>
    <xme:Yr_cY4KLEcbXOkuw5WINyD6Y_dOxGLEVw-O1FKKZSWtuoT5YnUrF8ygc6ryg-9sjF
    sSwvgQGO5zPcRNs7Q>
X-ME-Received: <xmr:Yr_cY4uKB2gcpJuqOoDangJhh0YsvzhUSJex-9x9qLWFk5M2kBWk3-I5P5AqSN6AKSfi89ZVpvlVNXHAqG0-dIFpYw2D3a7AJ0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Yr_cY1ZLtpgm37sDNDZ0bK7IDKAWNjpsDEIo4Bv7ttCYeghTJJNjrw>
    <xmx:Yr_cY_Yb2RD2W0zJe6T8iF4REKaoGs88FudQSKRIdD7JqG_mohw3eQ>
    <xmx:Yr_cYxCIPteuESns17E0vPHEQBIVVlJPu1zlXqkUS4wXNa0_Akh8QA>
    <xmx:Y7_cYzSimOlJLvqgD3td92-eQVgg6LoY7zWOPBTHR5HRQ4cfMvgR2g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Feb 2023 03:01:38 -0500 (EST)
Date:   Fri, 3 Feb 2023 00:01:37 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9y/YVK1bcZgFCU2@Boquns-Mac-mini.local>
References: <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com>
 <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
 <Y9y58cy1GKZLdyjb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9y58cy1GKZLdyjb@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:38:25AM +0100, Greg KH wrote:
[...]
> > Needless to say that ArcInner::count() can guarantee not reading 0
> 
> How?  Because you have an implicit reference on it already?  If so, then

Yes, roughly a reference ("&") in Rust can be treated as a
compile-time reference count, so the existence of "&" in fact prevents
the underlying data from going away, or in Rust term, being "drop"ped.

To get a "&ArcInner<T>", we need a "&Arc<T>", and as long as there is
a reference to an "Arc<T>", the object won't be dropped, that's the
proof of the underly object still being referenced.

Other folks may explain this better and accurate, but that's the basic
idea ;-)

Regards,
Boqun

> why does reading from it matter at all, as if you have a reference, you
> know it isn't 0, and that's all that you can really care about.  You
> don't care about any number other than 0 for a reference count, as by
> definition, that's what a reference count does :)
> 

[...]

> thanks,
> 
> greg k-h
