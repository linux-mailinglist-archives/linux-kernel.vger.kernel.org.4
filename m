Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1835E893A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiIXHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiIXHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:35:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894EDDD9F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:35:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d11so2018542pll.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OHAwfxUVRgLPl57Qt8T/liUnNNQhzNx0gxOFhvVSyOM=;
        b=MqDL1gnfsv33k99sO3TMsiTJOAfmrNWHyTsQVd9ovh73plHBNAO4OpBuwUgjhitYCa
         sEQP+ldMXvmyOtz/TmNem5jwT7S9ZIBd8qS9Goy75aDznBLWPEfIiiUWFyxZy4hf955L
         uiI/No+xMYPVmCm03n3haIjkBhAalbguZkYZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OHAwfxUVRgLPl57Qt8T/liUnNNQhzNx0gxOFhvVSyOM=;
        b=YAU5deO3lFyzySngC//X3O/3ySdhHb5KouhL7IjAPek5fcwrXJRRUZYTY0pvVGU3/G
         pk4cT9m8sbH3ffS1z2lUQqbOrm8taFHdnZ1fOJcRNkltIL8/aH1KvImqXnnsNnKDtsWk
         83x3KQwUIRKcx32pedqiRHkdbXUbCHQSwJmqjPzcou+T0AEMgfmfFb/sv6iW76JR90Zb
         1XNOwmirUCMjHV4e6SiEs0SI1yNwSe9NLVeURNo/aZdpMjEGwrFuAcqU8fGtWN9aRvf8
         6XOaRUS0VlKrYopsCcM9iS4ZV0p6jAPhI2VX2lU4ri1SKyhugW9NNDV/BNHefFzjmQTH
         vARw==
X-Gm-Message-State: ACrzQf3e06bGNkbVDGqU19mDtRR2SEKkKO/X4EJkmYxI/B08MHoXu/Tu
        e+mDuDg/kxoF4ZdQ6hxzRwhM/g==
X-Google-Smtp-Source: AMsMyM7SWSZQrgS1WvIIxziVWMa4tp/CJN/V9VXSExGRi7a1zSWbGK4VzUPUX6KIZxtblDWudiAylw==
X-Received: by 2002:a17:902:d482:b0:178:1585:40b6 with SMTP id c2-20020a170902d48200b00178158540b6mr12431474plg.134.1664004941643;
        Sat, 24 Sep 2022 00:35:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090a684e00b001f2ef3c7956sm1123853pjm.25.2022.09.24.00.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 00:35:40 -0700 (PDT)
Date:   Sat, 24 Sep 2022 00:35:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in ovl_fh_to_dentry
Message-ID: <202209240034.48B1CF05@keescook>
References: <000000000000763a6c05e95a5985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000763a6c05e95a5985@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:05:40AM -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    483fed3b5dc8 Add linux-next specific files for 20220921
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b13f30880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d14351a171d0d1c7955
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14283ac4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156da4ef080000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1cb3f4618323/disk-483fed3b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cc02cb30b495/vmlinux-483fed3b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> memcpy: detected field-spanning write (size 93) of single field "&fh->fb" at fs/overlayfs/export.c:799 (size 21)

I've send a patch for this now:
https://lore.kernel.org/linux-hardening/20220924073315.3593031-1-keescook@chromium.org

-- 
Kees Cook
