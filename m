Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6445B672454
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjARRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjARRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:00:22 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7441458BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:00:20 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id l125so17048745vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVS0ttI/4bB+mxtYXUXdE9Vy1l0C8qSZnW3LXzS45yM=;
        b=XDeY55Q6iWV3pDYpheM1QUBJdMuDvKiPLlLDrBKxY2OrVKXgCTUHzOXYin7LwtCEwo
         aE595vrT732LnIndSSJmoMG1YzzDhi6nRZrU34VkQjZyy+nnMaS8H6IxDmgBQyAQJzOE
         z95duu7DtZbNBtBJrXJ9BAhrWSCjw9mxcsX4/caB+OaY4LPkBcwvItrDXd6g4Zq2In2z
         4Ab8gr/ZBkeVJfAZ7If9LEoEU/aZXNpBJVPudQ+nGRaXHEAWh0WOF4nhMyj0kZh2t00a
         efXvH7i1NW/F9SXBCm8GVKxMr14j6F9xs375H9DbnhnClUBdso7Flp7qaZOH4V2JZNd+
         0BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVS0ttI/4bB+mxtYXUXdE9Vy1l0C8qSZnW3LXzS45yM=;
        b=NP6gOr+Mf47Tuf13vZo0sQPvSbq0Rw9cpSsSYPZPhVg4sOIwakFxHOzYaGoMzGtt0e
         zy3E4LB04DokvY1dbCEONnaQKezFv6EgZqNPC/v97QK1gBXmz9yoywKi+Dz354mlUU23
         57KWEe4886NQ9KTpVW6hUNX8oHxIVzEbbJ/nwusKiS/2Zzvc5X3zXYbs5Zuh96E2MIuV
         lGRpjJ63mSPlav5/iDl1eDw350+n/BCxm/csAf1yKL5DggS4+pHBKPhYLoVyfzCEt2Ib
         E+A0ni4fcK6c+VRJcL8v0q411J1UWhsvesSWebOSpfEdhv4vVkQoY+Ug0ShGFWNzsSYu
         BgDQ==
X-Gm-Message-State: AFqh2krqK/Bz9DQ+ojL3KLLuMcIYY4TFE0wiiDpCN25ze/DSynp2RQUl
        YWC3LjryHRtm1VHpRIbBNEU=
X-Google-Smtp-Source: AMrXdXud3IrhSSd7y9EKMeFVoOK7kAjqlf/wSvqtUPI8QnK9N0g3Ouj/pyZ5R2fAE63zGLiPMrCvWQ==
X-Received: by 2002:a05:6102:a49:b0:3d2:3263:e637 with SMTP id i9-20020a0561020a4900b003d23263e637mr5847959vss.30.1674061219721;
        Wed, 18 Jan 2023 09:00:19 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006ef1a8f1b81sm22314218qkg.5.2023.01.18.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:00:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8625D27C0054;
        Wed, 18 Jan 2023 12:00:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Jan 2023 12:00:18 -0500
X-ME-Sender: <xms:oSXIY7Q3VMy3hdQoHQuYI95EPpkR3SDqWgyCWkr26QffjDnpp3dFKg>
    <xme:oSXIY8yLzWOrY0mOERccesfLWU5fjviix6PVCHrjHGtGQK56dzu5ZAXYJEZxKnwTR
    dnbKBcvlMp5P91MDQ>
X-ME-Received: <xmr:oSXIYw0mjunHp79DQs4gtcZiQD73Xk4QbaogGofcUfao5SIuyuUzCt31w6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:oSXIY7BNlcaItw3kV14cAbwbJlJm1M53KTMuI6mcI5nfYyWxSIgDpg>
    <xmx:oSXIY0j44SsyFdPqGdf5a0fyJW3-49feVyJd09hpT_KMC0fZxLciVQ>
    <xmx:oSXIY_oCjoeLlqwrp-bL5JMidEkx3CEuJ4tvH7V_ZgeB-x-PzB8BeA>
    <xmx:oiXIY7Tb9FTYxZiGD_LpAGIT0YWKLU3dDAaTlk4uVnpqlYzKq7iM0A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 12:00:16 -0500 (EST)
Date:   Wed, 18 Jan 2023 08:59:55 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        npiggin <npiggin@gmail.com>, dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8gli5C/HqPRYv9Y@boqun-archlinux>
References: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8dWMyBfz1iiaF8M@rowland.harvard.edu>
 <20230118051704.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gYV81O80BtMvWm@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gYV81O80BtMvWm@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:03:35AM -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 09:17:04PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 09:15:15PM -0500, Alan Stern wrote:
> > > Maybe we don't.  Please test the patch below; I think it will do what 
> > > you want -- and it doesn't rule out nesting.
> > 
> > It works like a champ on manual/kernel/C-srcu*.litmus in the litmus
> > repository on github, good show and thank you!!!
> > 
> > I will make more tests, and am checking this against the rest of the
> > litmus tests in the repo, but in the meantime would you be willing to
> > have me add your Signed-off-by?
> 
> I'll email a real patch submission in the not-too-distant future, 
> assuming you don't find any problems with the new code.

I haven't tested the following, but I think we also need it to avoid
(although rare) mixing srcu_struct with normal memory access?

Since you are working on a patch, I think I better mention this ;-)

Regards,
Boqun

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73a..c134c2027224 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -37,7 +37,7 @@ let RU = try RU with emptyset
 let LF = LF | RL

 (* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF | RU
+let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock
 flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses

 (* Link Lock-Reads to their RMW-partner Lock-Writes *)

> 
> Alan
