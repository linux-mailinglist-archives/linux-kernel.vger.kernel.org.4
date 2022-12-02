Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E922D640DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiLBSu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLBSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:50:53 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED15E2A8B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:50:52 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u10so4008187qvp.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f09DtKOTqTopcy08MmhslbRENN/ahZVzCjh6S6ZbMus=;
        b=LHVa9yAOdvQcDoXjttD4pVpQGaABdfahJNuM0jZRoDb31bYL8Wb8OkVU8YOlv5PJ/d
         gMW7ADfWXJwTa92JfK2M9kY0QxblcU2E/LUjFZFhdHPZWV3ADQIniXiHzogSy6HRWMh/
         24N+4JvW17IW+N8FFpWRzu+fYkxhB/8MP+EillauyEhIAUg393r0qA5ne619Vlu0sc9+
         80+KlSX1usqqrhT7P1IyMp/nH/W7ZmAd/q/Oq/zhPEYdgh3FAJyHhKaCXmttvoV1vciT
         vbk0kr/2NsIBOxafJV2c0wGhHmZZr3o3dbBHKfzhjJEqoYqmU80NHXbJJNy+IGarTNmo
         lCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f09DtKOTqTopcy08MmhslbRENN/ahZVzCjh6S6ZbMus=;
        b=jL0pvb/PqeXwTOsbjDDSi0hsLjydBVi7X8frS6rwIj1EEDrx725KQFAGmcYbnsfqU2
         Bsz1JHW8dTN7RgC7q0yAlqJ7Sr0iubRO5QCJ5lx+SsfL2bMrDz/X+Sb1SL3yBVDA37/M
         jzYnKxf6oDZKzGVG/X0c2Fu9PEXaSy3gZNmS7J3Qo7Xtifpm6/yCNjz1qjKDrmD3UjSh
         dNVmHnymH74ErF8Mc4DEaKocILXR2YaF7oouxDEx5U2+Mg1KTBfXOpjRGbwRj3A3j7VQ
         Du3J+9jmoqxmvXuydhZSfJjebLoP8oqcOy9Ov3H0s484ZKsFTuX5XOJwtxbetyq2VeaN
         upkA==
X-Gm-Message-State: ANoB5pn/C/3RxY7nt8SjbghHh/+R9ezfo/RqJcJMdkS9JW3ruWiknD0r
        ezn8IGU7OEiUk08jpTha7Oc=
X-Google-Smtp-Source: AA0mqf73U5sNVSgsIhEvGF7T+vk1gjRDvuYpqAaYZOyvW0nQcLPlE7K38xZyji91wqpHsyHAZgxIpg==
X-Received: by 2002:a05:6214:3504:b0:4c6:2732:d4f7 with SMTP id nk4-20020a056214350400b004c62732d4f7mr67717648qvb.83.1670007051472;
        Fri, 02 Dec 2022 10:50:51 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006fae7e6204bsm6241806qkb.108.2022.12.02.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:50:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3285E27C0054;
        Fri,  2 Dec 2022 13:50:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Dec 2022 13:50:50 -0500
X-ME-Sender: <xms:CEmKY8Ml368f4XZk0tX9kYMTqyI7TVTYPtfXEnwQbtMaJQImfjnPEg>
    <xme:CEmKYy9iqo_JuqBtBp9Sjq_PXHlSSUu8x6S4Io6mtJthCJjoARdnYHS6nLcbvWQc_
    6jnxYdnUK2-24fMig>
X-ME-Received: <xmr:CEmKYzRgdnyZbNlCqth2zvihf-1NVghfUPhBrLWX8TMGD4DOeHIZBELCOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepteffudeijefgvefhffehledugeeufeetgeekiefgfffhteevvdeuhfetfefg
    ffdunecuffhomhgrihhnpehstghhvggurdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:CEmKY0saqWVOfc5q8s_DUi5n6JGbbMblLy5VFXQZEcDHzbSLh6lGeA>
    <xmx:CEmKY0dYB7p72CSRI2ssYjpm7_30ju2DJC4XbA5nQ7eOynazSYMDew>
    <xmx:CEmKY438ykK9podXWEEjFL68fCE97woDfv_2mhJ2qfyNtbWpBqo8hQ>
    <xmx:CkmKYzArtxNfKzAswZFhacsk1XhFKbYKuhg4I-H-LCM4ls5EtdrCpfbXU5A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 13:50:48 -0500 (EST)
Date:   Fri, 2 Dec 2022 10:49:38 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4pIwqK7SWft1xCl@boqun-archlinux>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:51:00PM +0100, Jonas Oberhauser wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> 
> As reported by Viktor, plain accesses in LKMM are weaker than
> accesses to registers: the latter carry dependencies but the former
> do not. This is exemplified in the following snippet:
> 
>   int r = READ_ONCE(*x);
>   WRITE_ONCE(*y, r);
> 
> Here a data dependency links the READ_ONCE() to the WRITE_ONCE(),
> preserving their order, because the model treats r as a register.
> If r is turned into a memory location accessed by plain accesses,
> however, the link is broken and the order between READ_ONCE() and
> WRITE_ONCE() is no longer preserved.
> 
> This is too conservative, since any optimizations on plain
> accesses that might break dependencies are also possible on
> registers; it also contradicts the intuitive notion of "dependency"
> as the data stored by the WRITE_ONCE() does depend on the data read
> by the READ_ONCE(), independently of whether r is a register or a
> memory location.
> 
> This is resolved by redefining all dependencies to include
> dependencies carried by memory accesses; a dependency is said to be
> carried by memory accesses (in the model: carry-dep) from one load
> to another load if the initial load is followed by an arbitrarily
> long sequence alternating between stores and loads of the same
> thread, where the data of each store depends on the previous load,
> and is read by the next load.
> 
> Any dependency linking the final load in the sequence to another
> access also links the initial load in the sequence to that access.
> 
> Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

s/Reviewed-by: Reviewed-by:/Reviewed-by:^2 to save some space ? ;-)

Joke aside, I wonder is this patch a first step to solve the OOTA
problem you reported in OSS:

	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf

?

/me catching up slowly on that topic, so I'm curious. If so maybe it's
better to put the link in the commit log I think.

Regards,
Boqun

> ---
>  .../Documentation/explanation.txt             |  9 +++++-
>  tools/memory-model/linux-kernel.bell          |  6 ++++
>  .../litmus-tests/dep+plain.litmus             | 31 +++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index e901b47236c3..8e7085238470 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -2575,7 +2575,7 @@ smp_store_release() -- which is basically how the Linux kernel treats
>  them.
>  
>  Although we said that plain accesses are not linked by the ppo
> -relation, they do contribute to it indirectly.  Namely, when there is
> +relation, they do contribute to it indirectly.  Firstly, when there is
>  an address dependency from a marked load R to a plain store W,
>  followed by smp_wmb() and then a marked store W', the LKMM creates a
>  ppo link from R to W'.  The reasoning behind this is perhaps a little
> @@ -2584,6 +2584,13 @@ for this source code in which W' could execute before R.  Just as with
>  pre-bounding by address dependencies, it is possible for the compiler
>  to undermine this relation if sufficient care is not taken.
>  
> +Secondly, plain accesses can carry dependencies: If a data dependency
> +links a marked load R to a store W, and the store is read by a load R'
> +from the same thread, then the data loaded by R' depends on the data
> +loaded originally by R. Thus, if R' is linked to any access X by a
> +dependency, R is also linked to access X by the same dependency, even
> +if W' or R' (or both!) are plain.
> +
>  There are a few oddball fences which need special treatment:
>  smp_mb__before_atomic(), smp_mb__after_atomic(), and
>  smp_mb__after_spinlock().  The LKMM uses fence events with special
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 65c32ca9d5ea..5f0b98c1ab81 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -76,3 +76,9 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
>  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>  		LKR | LKW | UL | LF | RL | RU
>  let Plain = M \ Marked
> +
> +(* Redefine dependencies to include those carried through plain accesses *)
> +let carry-dep = (data ; rfi)*
> +let addr = carry-dep ; addr
> +let ctrl = carry-dep ; ctrl
> +let data = carry-dep ; data
> diff --git a/tools/memory-model/litmus-tests/dep+plain.litmus b/tools/memory-model/litmus-tests/dep+plain.litmus
> new file mode 100644
> index 000000000000..ebf84daa9a59
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/dep+plain.litmus
> @@ -0,0 +1,31 @@
> +C dep+plain
> +
> +(*
> + * Result: Never
> + *
> + * This litmus test demonstrates that in LKMM, plain accesses
> + * carry dependencies much like accesses to registers:
> + * The data stored to *z1 and *z2 by P0() originates from P0()'s
> + * READ_ONCE(), and therefore using that data to compute the
> + * conditional of P0()'s if-statement creates a control dependency
> + * from that READ_ONCE() to P0()'s WRITE_ONCE().
> + *)
> +
> +{}
> +
> +P0(int *x, int *y, int *z1, int *z2)
> +{
> +	int a = READ_ONCE(*x);
> +	*z1 = a;
> +	*z2 = *z1;
> +	if (*z2 == 1)
> +		WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r = smp_load_acquire(y);
> +	smp_store_release(x, r);
> +}
> +
> +exists (x=1 /\ y=1)
> -- 
> 2.17.1
> 
