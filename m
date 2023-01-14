Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064166A76D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjANASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjANASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:18:10 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C52526EC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:18:09 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bp44so20573705qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKT6Jyn0vegt0kR4LKLQ0ILIcSuUkGIYOHtcvaoWHv0=;
        b=NCB5c8oqUMOINCFtJeTt9mCtyRETsgMlAvmjdFpR1ZVH11ttUYQbMpvk1mL6Qsasta
         sRm22kK07ft74kQgkdUph3tjWD/aFvioAyc97OsnUCLdpy6GAPbK6fjABRwyvr2/medY
         E0Z18NfiPqxFjrL8DNe4h2CFjKdL/A7u6YYhrlw+kzukkxZibyeGRn4daqhzsMwf25/l
         jauLDuJZZzr0MV/46UjnPflzcHLTtjkynlUnGX0BoUEkxAUcmxcGHwUtCRfaAQFMX9uQ
         CO31weqoKXABEfM++wszv9tEdd4V0fx0EnRea9UJ8bSfpPVrTWDZuXoIXMYhhqmP8UBa
         gxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKT6Jyn0vegt0kR4LKLQ0ILIcSuUkGIYOHtcvaoWHv0=;
        b=y9efbPO8VqLQDQXQk6IiyqCnhay5oGm7758JTkH469werXyjRk4GQiWip8Dz2mR8mf
         2bcfUexEQqr/39tsB8Jq7bD+sqZuhl2cT9iXAffQKYb3z7Vm6/zKh3qoygXI4Ld0KArG
         QW9EYIpINTjpST56PNKUSSA6Iyxr19k4kX1RVQMd8m9fooNLZex92Q29EfZzR0H1HT5H
         DCldJnOEfNag8QIbP7C2UCina+RCLFTfa09e82/5xfybZIxWaO4x2GwxQ1xRjOZFH00Q
         JkeY4KQjY9Pa8/hXAdeJDYUfPogxDwSVvyA+ws2YS7RPArquTJZ16AlmhP2ZggHFz8Ou
         2StA==
X-Gm-Message-State: AFqh2kqMT29X2fj7D9l9D3sOTw04tNguZvGybLEI4/zavBI+JbTpYbBC
        VCpMXQGhEQwKy4ge87yeewQ=
X-Google-Smtp-Source: AMrXdXv+6CBlJbBKdnPCkoKW5oQ9ZMHU+YpWxYUOcqAizF16zBDzaGvD8/x+EXnoIDEAyMA25OTFBg==
X-Received: by 2002:ac8:43d2:0:b0:3a8:137e:2963 with SMTP id w18-20020ac843d2000000b003a8137e2963mr23183028qtn.20.1673655488414;
        Fri, 13 Jan 2023 16:18:08 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c14-20020ac84e0e000000b003ae450e43acsm2941352qtw.12.2023.01.13.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:18:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5881127C005B;
        Fri, 13 Jan 2023 19:18:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 13 Jan 2023 19:18:07 -0500
X-ME-Sender: <xms:vvTBYzHizRO0J86xEMaLtPxvuAfGj6LUnsiXXPclTiO4keLYji9PpQ>
    <xme:vvTBYwVxA7P3e2T0rPmBg_yOFz_2Ny0FycrnyUil3wi6jsJL8YBn3ZRu_W_smjsbD
    483Hk4hWYXQg921lg>
X-ME-Received: <xmr:vvTBY1L1_c3M2tAxzj6PRwCQPTIliCmZgxVkxy0Dk4LySHdrgj7DM2Eao_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vvTBYxGMBGitZqYEYuPixGdttjb1xPagj1_Rbzp7f3VdoeV1u98vhw>
    <xmx:vvTBY5Wttnk9Q1Yb2fttzlhRUwjmRsU1AWIMn3cL7bxPGFALVeqGwA>
    <xmx:vvTBY8Ni_q4LENmqyE8liG8hPcvUjqx00EWuuXpiQWOkN4aRtQtTww>
    <xmx:v_TBY7I1rCyrgGJa8XSRRidnly61v8HqLYbrfDjF6MoU4IuWClLNEg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 19:18:06 -0500 (EST)
Date:   Fri, 13 Jan 2023 16:17:59 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] rcu: Equip sleepable RCU with lockdep dependency
 graph checks
Message-ID: <Y8H0twLVEnM6jkgq@boqun-archlinux>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113130330.1027-1-hdanton@sina.com>
 <20230113235809.1085-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113235809.1085-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 07:58:09AM +0800, Hillf Danton wrote:
> On 13 Jan 2023 09:58:10 -0800 Boqun Feng <boqun.feng@gmail.com>
> > On Fri, Jan 13, 2023 at 09:03:30PM +0800, Hillf Danton wrote:
> > > On 12 Jan 2023 22:59:54 -0800 Boqun Feng <boqun.feng@gmail.com>
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1267,6 +1267,8 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
> > > >  {
> > > >  	struct rcu_synchronize rcu;
> > > >  
> > > > +	srcu_lock_sync(&ssp->dep_map);
> > > > +
> > > >  	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > >  			 lock_is_held(&rcu_bh_lock_map) ||
> > > >  			 lock_is_held(&rcu_lock_map) ||
> > > > -- 
> > > > 2.38.1
> > > 
> > > The following deadlock is able to escape srcu_lock_sync() because the
> > > __lock_release folded in sync leaves one lock on the sync side.
> > > 
> > > 	cpu9		cpu0
> > > 	---		---
> > > 	lock A		srcu_lock_acquire(&ssp->dep_map);
> > > 	srcu_lock_sync(&ssp->dep_map);
> > > 			lock A
> > 
> > But isn't it just the srcu_mutex_ABBA test case in patch #3, and my run
> > of lockdep selftest shows we can catch it. Anything subtle I'm missing?
> 
> I am leaning to not call it ABBA deadlock, because B is unlocked.
> 
> 	task X		task Y
> 	---		---
> 	lock A
> 	lock B
> 			lock B
> 	unlock B
> 	wait_for_completion E
> 
> 			lock A
> 			complete E
> 
> And no deadlock should be detected/caught after B goes home.

Your example makes me more confused.. given the case:

	task X		task Y
	---		---
	mutex_lock(A);
			srcu_read_lock(B);
	synchronze_srcu(B);
			mutex_lock(A);

isn't it a deadlock? If your example, A, B or E which one is srcu?

Regards,
Boqun
