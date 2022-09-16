Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15095BB1BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIPRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIPRqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:46:32 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2002E1DA75
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:46:32 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j8so6244938qvt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date;
        bh=ZNq/7b4Cl4iOkApy7zw7c5nYRY6dXqoJ+Xb6/NdvsSw=;
        b=P3fxNYFHTEFgb0FjUoyunsGPNwDXqZ6YTmT2NlrVWYkje0BuZvi5aZEtf6zO5DviNV
         M+f6YObC9ezjL28lPAd8TnfTGk1ONz/iAPe0ozHY87DnhV2ck73US1yeC3jfNXi67fBi
         mVcSa3176pNCRsSU6cMJ+9COV92wRsGI5l075tfv1hDssf/ZstqetVCZrTpVbMlc7sZ7
         K3jRs5E+mBrYZikcIxxllY2zAOEBjdum2T2KFRNhlukHyAB4mL4oX0siJn9qzaTn6uA/
         bd4TPcngybwP9pK3QEeJ1ZrJs0kVuo/lgHAD13vlnJKasg04tUFLhnAxPtfgh9OSxLpW
         akHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZNq/7b4Cl4iOkApy7zw7c5nYRY6dXqoJ+Xb6/NdvsSw=;
        b=qsZLqlNdY/tiqsZs91MV/fCmiw3So8T27ZUMOCa1k8l6Cb3Q5voJecQiOk/mFjxe4w
         lrGVvNd6gpP7j/Nw1iTYJJPldPMzTCihEHR8XWzm2MWSHWj6MxS9EZdjkEnkmsRX1gK6
         5J8wi52txOgRqSMUvZa7TttgJULTIK9A+MbBCH0eECTiqXFKxYRcFvEfj5bwhr6CRnx3
         BJyXcGR641R3i5gX3z2n/elhnjNwNUJ6HvhbdG9D9BE4hw9nuBZ6MygwvPZNdLbTsVMI
         tv8ffk1ObRCIVALllmDXeLOoZylkHLvQpDaGFOte/+Oq9WkjZDIVL/JkwtdUA4y79N9h
         KKsg==
X-Gm-Message-State: ACrzQf1aq1nJaNMXfQOv7WC/96wTkZAA7X3vDLa7HzkJtawyNLxQC4Z5
        VsQCv8GRBm5hE9FX5spMcKA=
X-Google-Smtp-Source: AMsMyM6WjRt04w9k7SbXBSNVyU2KpHCnYsryj3KneOUvyj3w3J/GoxzKBZ3tpmKjKJywJv2N8cnq2g==
X-Received: by 2002:a0c:a882:0:b0:4ac:bb6c:47b6 with SMTP id x2-20020a0ca882000000b004acbb6c47b6mr5360437qva.32.1663350391142;
        Fri, 16 Sep 2022 10:46:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 22-20020ac84e96000000b0034359fc348fsm6124120qtp.73.2022.09.16.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:46:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0719527C0061;
        Fri, 16 Sep 2022 13:46:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Sep 2022 13:46:30 -0400
X-ME-Sender: <xms:c7YkY5L3J0ziXs2n2cU0z5XH8DQVYFjw9ehz7LmuDy-f_QUO-TudfQ>
    <xme:c7YkY1Kx_3PlFjpHIp91JuElCTJluowDHS30e__dVP8At-HY66e2QXCX0_u-ds-KM
    jfNDd0gAYEgd_Nh4w>
X-ME-Received: <xmr:c7YkYxuEJqjkKHSt1qpN2-EZX3mYF3JeGD6ZRksbIAL6PLGmAhUUrm8bjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:c7YkY6bt3aqo0NQC2Dv20_wd8Plb8Zt7oE7c7p4MsgB8gKAlDUBXUA>
    <xmx:c7YkYwYYTWnod9dL6dBEeZVpeZFz00b9CBjM05jiVlieFtvWYUB0dA>
    <xmx:c7YkY-A61_MKbZGwFWVcXQE09LmezaboFW3ZeQDAdiwIcmNNHCeCBQ>
    <xmx:dbYkY9JzH9sBN4XP4Bp6ZRz3CSp_GgHLYrz6nDKYwMnTkJAnP1uGog>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 13:46:27 -0400 (EDT)
Date:   Fri, 16 Sep 2022 10:46:18 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Message-ID: <YyS2aoPoC2TznZHO@boqun-archlinux>
References: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
 <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:51:14AM -0400, Waiman Long wrote:
[...]
> > 
> > I'm expecting lockdep to continue working without calling printk() even after
> > one of problem patterns (e.g. circular locking dependency) was printk()ed, so that
> > debug_show_all_locks()/debug_show_all_lock_holders() can call printk() when needed.
> > 
> > Changing debug_locks behavior is a future patch. For now, this patch alone
> > will help debugging Greg's usb.git#usb-testing tree which is generating
> > many "INFO: task hung in" reports.

The default behavior today does make sense: if the system has one
deadlock it should be fixed first before searching out another. So I
expect that changing debug_locks behavior would be configurable and we
keep the default as today.

> 
> Boqun is actually working on a modularization patch to make some lockdep
> checking still active even after a lockdep bug is reported. I think he will
> take into consideration about this request.
> 

Yes, this is one of the "problems" I try to resolve while cleaning up
the lockdep.

Regards,
Boqun

> Cheers,
> Longman
> 
