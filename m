Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21AA6A3E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB0Jqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0Jqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:46:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECB1817A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:46:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u5so2690232plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiY9acwhUXmm9E/17pYm+aOoOd50FF5ohTkaGe25qyk=;
        b=UnalqxKWf9u923Jm2KHSqj32ehvjUcSk4z/E/mtGassFPdqAfkipPMF7KworlFp21d
         3Miq7QIxvOwx92ShzIZPlcflQvNErfZt2C3G7HYLI4ki4wWB9y+/L+BPH0kztD/WhpRg
         xlsQTVuPgY5kZIGCEJ6z64LqoxwhQsRc+SmHptwqeCScAwKRWUodQkcrm/XMuan/mbjE
         PyEKmsUgM3NaTKAKhubigRse0uqKNI2Rj88SI3Snvuq7TAGKJNxHN8THoPm6c00UP1FB
         9xbIAondQDQMnTBaGQUvWuzWXh9yJxwnUlv4lj6x3gCJZUIvLWGj0cvYLlF8ux+WrARO
         4wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiY9acwhUXmm9E/17pYm+aOoOd50FF5ohTkaGe25qyk=;
        b=dRzBqAbw4FQpYMCSwwzNJb4wgXxPwLIXrtQqN5Vgz+nrcZhMis8fgXHuvDW9t77kKM
         Y5D78/mdOKeztAJSZm36OZc0XjKMsHOo97oCZgOcUtJh0xlPP8HOSdAeu9BguqNboRvl
         +Np1m/kNr9KsFY9Qwgl3dq/15wcqHYcl9neQoundxsvsXGOQl8xYgS7ucPP7F4RiTaHD
         aHsXeDSvdAnbxi5mAKo4NtRqfF83HZdGYQYMRuvAHn9I2TjxoZb08QQMN0SRXue6uxm1
         j6byHQUGRSfkXerfFephXZ00fEvgP3wsFOyHQtu/APj+otUOz9cFyGbyQRQVVG9buCQ6
         B+ug==
X-Gm-Message-State: AO0yUKV3dZ154jFtgj1oBbAsL+cRHA5tisoiSlfqAS0WRvkkfMrKE8wh
        VXxMMNnwckMDPCyPL4J0FXw=
X-Google-Smtp-Source: AK7set8Qucd/QV4vM3ylivB9m9bm+CndKnl8ChjQUYL9fPiF9cHX1a0Izw4RxqwQfRH6ubpv4B7ukg==
X-Received: by 2002:a17:90b:4a43:b0:233:f365:1d0b with SMTP id lb3-20020a17090b4a4300b00233f3651d0bmr24909814pjb.5.1677491201751;
        Mon, 27 Feb 2023 01:46:41 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a648300b00230ffcb2e24sm5659958pjj.13.2023.02.27.01.46.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Feb 2023 01:46:41 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:52:48 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: don't warn ztailpacking feature anymore
Message-ID: <20230227175248.00001dd9.zbestahu@gmail.com>
In-Reply-To: <4c6ada29-234f-623d-c4c6-1a98a678323b@linux.alibaba.com>
References: <20230227084457.3510-1-zbestahu@gmail.com>
        <4c6ada29-234f-623d-c4c6-1a98a678323b@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 17:42:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/2/27 16:44, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > The ztailpacking feature has been merged for a year, it has been mostly
> > stable now.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> 
> Let's update erofs-utils as well?

Ok, I will update it later.

> 
> > ---
> >   fs/erofs/super.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 19b1ae79cec4..733c22bcc3eb 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -417,8 +417,6 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	/* handle multiple devices */
> >   	ret = erofs_scan_devices(sb, dsb);
> >   
> > -	if (erofs_sb_has_ztailpacking(sbi))
> > -		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
> >   	if (erofs_is_fscache_mode(sb))
> >   		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
> >   	if (erofs_sb_has_fragments(sbi))  

