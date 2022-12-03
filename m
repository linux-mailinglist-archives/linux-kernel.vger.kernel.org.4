Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB455641922
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLCUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLCUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:53:20 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417D11446
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:53:19 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d2so5700523qvp.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxFPRJRbyc/DL5Rqw30eer0d5LkISBP1azh5Xmgu36o=;
        b=nkOvxMRjrj6MQS9Ix77eEO1ePuswxVn9/IZSvUlql3VdxHlF8smUrTGnnuyks4+SAC
         0YKI2sDZJ/uC/5HDrrjDn9dBzersmRQD+PEiGhwjFzo/jS6Nl3VIoHgkOM7ykmNsQYFq
         xhkNZTmIkR7MfgpsuZEOKsQzW0S/g8ZzgrT3zb32Ge/rv2HFRnLLmuzUka1dYmoxeO43
         AEmbK68ZyKXhpo0rnB7XOHJ0B4FeRBbWbn5Vp0+u4kj64i/yWMlEAasOjhq6VYiP60zr
         1RqsE7B/35cRsENTGaI9KZ5QdvYa5iUk1adMTp+aMNlziZCFhsprFCUAsINSmulXQZxB
         chqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxFPRJRbyc/DL5Rqw30eer0d5LkISBP1azh5Xmgu36o=;
        b=JKGSo83yckbdamyFrueSD0itozW2UJoHZDRMKw/0yxhsN1A/ZDdvzq2VlDW2imnUdd
         90DcguvYnJpZ6BaiDYQ7+9lXAf2wBZnGNUki9bBufyXmn7WwrMR05afKmUyMS9eYpuwu
         3L9BJH5244W5StwGN6t76He9m1nAxNmBOKShb67Py/4ApTSVUJ9WwkrdLudPdLlvCxkz
         xoGskYO63xj0IPPDPkAjz2dbSRlUNdXOKjXbFNmdJ+meryseI2Dtg2PhXaX9DtOeh/48
         KhAGD5bo+SJEWcbrUOxxzLOhuMI/JqZIlDqph5lZyk5fU8Mo4RN92E6xUgTTJDJq47wD
         u4NQ==
X-Gm-Message-State: ANoB5pnc8EyJYN3FFTa7+jQ/jOZ+OqZMb3H1Vxd3Ir9jEvipxFU5ZZbx
        S0nd8XUFxJB8aZee2OlzLvU=
X-Google-Smtp-Source: AA0mqf4F2SuZmQLD3XdDgz6HW0eE4e0BgrVk0ZU4UkIZYU0nqDY96xRLmggFgG7SIIHsQ7fcIRwk/Q==
X-Received: by 2002:a0c:be84:0:b0:4aa:a0b7:7b41 with SMTP id n4-20020a0cbe84000000b004aaa0b77b41mr54077524qvi.66.1670100798251;
        Sat, 03 Dec 2022 12:53:18 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a290f00b006fc6529abaesm8739156qkp.101.2022.12.03.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:53:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 48E8927C0054;
        Sat,  3 Dec 2022 15:53:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Dec 2022 15:53:17 -0500
X-ME-Sender: <xms:PLeLY_HSWhn6GCCrzoHNyQJtifLGakzvQ-VJEl655QqyQpVHU6IdzA>
    <xme:PLeLY8VyUiGTmoeAzQiFngD8_F_etD0q8LhwNq3wh0uHrQ8_-RzGcjgpEIU5iF5G7
    f4OdfLUuQEAcrF7Lw>
X-ME-Received: <xmr:PLeLYxI0NN5wSOxbdNY-sxv60yY9gnE0-NVb5d7-iUwZGhzXVxqH9sdw_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehjeejteelheegueetlefgudevhfdtvddvuefggfeftddtieeftdevvefg
    leeffeenucffohhmrghinhepshgthhgvugdrtghomhdphihouhhtuhgsvgdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PLeLY9HDfWRK84UxW4mK0lsCUNBKFsde5dBGY8gJ0yp98OlgRLsWbw>
    <xmx:PLeLY1XqacY_9HLtMA-IEkVWNSfCyhZLkWFt-AU5hJMGZvy4z7fdfw>
    <xmx:PLeLY4PA4-Ah85raZngubF6LptBrxptbPFUx5EXQIyes98xB_-hulg>
    <xmx:PbeLY5l43ALpB4HgLMLWCnZS-5nfBw2VFuPhFCroh4uNHuUmDLFm0g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Dec 2022 15:53:16 -0500 (EST)
Date:   Sat, 3 Dec 2022 12:52:02 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4u28nH82tJJdTGD@boqun-archlinux>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:44:05PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 03, 2022 at 03:34:20PM -0500, stern@rowland.harvard.edu wrote:
> > On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> > > On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > > > Sent: Friday, December 2, 2022 7:50 PM
> > > 
> > > > > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> > > > >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > > > > If so maybe it's better to put the link in the commit log I think.
> > > > 
> > > > It's not directly related to that specific problem, it does solve some other OOTA issues though.
> > > > If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> > > > do you think I should link to both then?
> > > 
> > > It is not hard for me to add that in if people believe that it should be
> > > included.  But default is lazy in this case.  ;-)
> > 
> > I don't think there's any need to mention that video in the commit log.  
> > It's an introductory talk, and it's pretty safe to assume that anyone 
> > reading the commit because they are interested in the LKMM in great 
> > detail is already beyond the introductory level.
> > 
> > On the other hand, it wouldn't hurt to include a Link: tag to an 
> > appropriate message in this email thread.  (I leave it up to Paul to 
> > decide which message is most "appropriate" -- there may not be a good 
> > candidate, because a lot of the messages were not CC'ed to LKML.)
> 
> For this approach, I would add this:
> 
> Link: https://lore.kernel.org/all/4262e55407294a5989e766bc4dc48293@huawei.com/
> 
> I could of course do both the extra paragraph -and- the Link:.  ;-)
> 
> Thoughts?
> 

I think only having Link: is fine ;-) And I agree with Alan, no need to
mention that video.

Thank you!

Regards,
Boqun

> 							Thanx, Paul
