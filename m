Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C37414AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF1PNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjF1PNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:13:44 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CFA1;
        Wed, 28 Jun 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DBTIfrxMdKKM9sBHIVJZO9vzHO75jz/0ZU+aMpxxKZE=; b=momUJtebq9yrc3OXvovd16djTJ
        C2HZNqgjC41tWcLJkC0tbgDnDWHGEw49Oh4Z31tXD0nUhJpCz8kAg9dEcnanu0mDSfUq4o9gVap5F
        VV+KfCoRy7wgdrot4IZ8s5qCAXFDc6d0IUqKAf9zaEKhv/lq3ef7LwcSblm7C8nw2mL2Oj7rwPUkX
        dM65UjPbEl+047Kv+AKU7ZFlitQ06kT8qepIxE88HYf7PQueJZphHs4z5ovkW8EvzNZ45OnsPzViK
        /7sf0rAiDmoRmcXMkyesoJcXXVY1X2QHwa0v97dNpB3Gp1FfxmZdYSPxjUxCCDELjCqaNVCUckCGK
        SdWmijyg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qEWr9-00GTya-Gw; Wed, 28 Jun 2023 15:13:19 +0000
Date:   Wed, 28 Jun 2023 15:13:19 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>, krisman@collabora.com,
        Tom Talpey <tom@talpey.com>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linkinjeon@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Message-ID: <ZJxOD+OZzq3FR1dH@gallifrey>
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey>
 <ZJw50e0pvn/IN5Gj@gallifrey>
 <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
 <ZJxGFBzuhU8t5rcx@gallifrey>
 <CAH2r5ms1UE4vAuakBLuayv1CXw3sC_OcuhtCrz5mV_ftR+=rjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5ms1UE4vAuakBLuayv1CXw3sC_OcuhtCrz5mV_ftR+=rjg@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 15:12:06 up 101 days,  1:46,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steve French (smfrench@gmail.com) wrote:
> On Wed, Jun 28, 2023 at 9:40 AM Dr. David Alan Gilbert
> <linux@treblig.org> wrote:
> > > > Actually, would you be ok with smb_unicode_common ?  The reason is that
> > > > you end up with a module named unicode_common  that sounds too generic.
> > >
> > > I'd suggest make it generic and move it to fs/nls/. I'd run it by the nls
> > > maintainers, but I don't think there are any.
> >
> > Steve & Tom - would you be OK with that?
> 
> Yes - absolutely

OK.

> > (Copying in Gabriel Bertazi, owner of fs/unicode; although this isn't
> > utf-8)
> 
> Unicode UCS-2

(I'm going to regret the next question...)
So how does this compare to the stuff in include/linux/ucs2_string.h
and lib/ucs2_string.c ?

Dave

> 
> -- 
> Thanks,
> 
> Steve
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
