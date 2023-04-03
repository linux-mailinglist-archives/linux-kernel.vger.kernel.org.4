Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110346D54DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjDCWsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjDCWr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:47:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC34422C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:47:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A6D915C00C4;
        Mon,  3 Apr 2023 18:47:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 18:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680562072; x=1680648472; bh=HjLIyLDWon/8S
        zB1xJHwySrY+xLuVrMidxaaGOH0+x0=; b=duj8NO5bS0tduhnEImsV3OGpKvPtx
        LkHspA/V3FTxfMRMsc1Q4r3z8oagaSROm4nnFVdgXH3fMnWlkpybvOGeoTHOraFv
        63duZK16O8IzJodwSXkLzT/qNO00w9N87kNwInOsj18WnHbbNCSb/7ifUeadOpu8
        ufYnrMX1VRxyhOyUrGcGXTx4q85MYzrfOwvCMvz5ujVIU3+QbUogn5k7WeVE3IxB
        XpaqUZZdEiaAWOyc++RTTiQ/sg21v0/39eLw8tP7QAR48Vpv5SZmVzFtCsh2EAZc
        wCIh6MCQe0Lc8Suf/yDOXVZG5mXEzWKPYNPjBzhmbOaAa65YcpPjp2MMg==
X-ME-Sender: <xms:l1crZAmH4vCgBpWQw0J0jUJz7ggNXZzJcXy20QY65R2M1ssd0KuCoQ>
    <xme:l1crZP2wB6iA3gJLmBkraX8D8l29JanWKccD6P3JAKXICpoNzNKAIDSRCnRszTBQa
    obfU76WR1SFMCzNrRA>
X-ME-Received: <xmr:l1crZOoB5vqkCcvG_bD410gSFH8WR4oftFVqqMCeHvYY7kvXMFVJ3bEAZiogxE8hH9M7jB5VLgOJG5kQVcdgyPWrpKPTBnv8y0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:l1crZMl4Qm7aRC2byvLiZPqTPmIEo7LrOjQzvyHs5ldj_iHomi0y3w>
    <xmx:l1crZO3HYY5dpqIKWc4Hz419GE54U2d46OR99geV64Dcx_InhuyuQA>
    <xmx:l1crZDuqo86iazpisFqW327fKojW0Lg4FgebHZmpNGn446G75jFjPg>
    <xmx:mFcrZD90-uaUt1cBb1Rh4XeQwAsI6GRbD_F5j_ANqeAuf2K0TJW0Hw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 18:47:50 -0400 (EDT)
Date:   Tue, 4 Apr 2023 08:50:59 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Brad Boyer <flar@allandria.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] nubus: Don't list slot resources by default
In-Reply-To: <20230403061827.GA3406@allandria.com>
Message-ID: <e887a8c9-4310-a6cb-62d2-39db7d75d452@linux-m68k.org>
References: <62e815b947d6d602def8294040529db80278c561.1679801822.git.fthain@linux-m68k.org> <20230403061827.GA3406@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023, Brad Boyer wrote:

> On Sun, Mar 26, 2023 at 02:37:02PM +1100, Finn Thain wrote:
> > diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
> > index f70ba58dbc55..d2d2b580f646 100644
> > --- a/drivers/nubus/nubus.c
> > +++ b/drivers/nubus/nubus.c
> > @@ -32,6 +32,12 @@
> >  
> >  /* Globals */
> >  
> > +/* This parameter makes slot resources available in procfs. It's deprecated and
> > + * disabled by default as procfs is no longer thought to be suitable for that.
> > + */
> > +bool populate_procfs;
> > +module_param(populate_procfs, bool, 0);
> > +
> >  LIST_HEAD(nubus_func_rsrcs);
> >  
> >  /* Meaning of "bytelanes":
> 
> Would it be better to give this option a name that indicates that it is 
> for nubus only? These are effectively a global namespace. Other than 
> this, I don't see any issues.
> 

The name of the module here is "nubus", so this parameter is specified as 
"nubus.populate_procfs" in the kernel parameters. Without the "nubus" it 
doesn't work. I should probably add a comment about that.
