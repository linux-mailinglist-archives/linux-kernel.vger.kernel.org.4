Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126974434A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjF3UhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3UhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:37:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F148F30F7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:37:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so1929535b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688157434; x=1690749434;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1Ru2lOmb0NqW9hbm2Sv72Yt+Z+Y9WgQ7hXdVcdty+Y=;
        b=JEYPpTRlCIWdLensKvqlFxFMuCRSwKryhy09mNW8qvn5xo1uXCis8mG6jrxZpYz0EZ
         cVTeRQ7BIPec3vBRm7MdMXcZtbJmYalRW9uB9w1CUAMxMH83w2pEcZWlswSnKxlDLhxk
         KwqQBJqvQMuB67POi/zYaC+mk5FHVIeFnrBAAtqemRp3Ui35iqXfoWZCJ3LP27Sm1liM
         D3NpBSMBA90l16mI5xiABWKK/NsImPhn25kEl+Y0kn4X9OJXtarDNrrsuy1XpPX/dHjv
         4QVrlcwK+EHGdU5TZfjsTNf2USSDadyOqBnj2M2RJQ7eF2PBw0yk0ha1PpoIse0gy3Xn
         7gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688157434; x=1690749434;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Ru2lOmb0NqW9hbm2Sv72Yt+Z+Y9WgQ7hXdVcdty+Y=;
        b=S5mOHC7+Vxv47jqdulOZ9OByJ3x0P/3TVxWCZ0S4prfSZu0COQKafniMt25E1IBoz3
         cXP4tMG7bp88+Ngz/QSW1p/jiveNCIcEV1o+jk0J2gbrh576r76Yj6UbFxqHX3nFPlVb
         VrBW4DTlsWz4sncvdZ+bs2SrObRIYVfGeLrVTO6kycWFbslP00ZN4fSP145VO9lzVO/e
         rr8SjzRKZlQ13gb9prstXCHPRf50qt23wMJAA10HAQ9cRgErCPt4lLjzLGGdpQFpgLwZ
         byHtUX2FdcmfiuiGzBY0dl9ojq9RnVpaXtNyd0g+hOHV7D14eCTH6brDDhmp6+W7NhZC
         rCKg==
X-Gm-Message-State: ABy/qLaLNbaURKS9m26xMrEava4ZiYzK47DwdK04yNzSX3ODOxfkZPh1
        1xvnjiHHfrSJNkA4SLPWyMVtnw==
X-Google-Smtp-Source: APBJJlHOzysRvFqwFy04EuBbQxV+P9VXkB2haEL3mC/IgKKQMu6vNqA+hYF0AO/FQAlXnPZGuIcffA==
X-Received: by 2002:a05:6a00:148b:b0:682:4c9f:aa0 with SMTP id v11-20020a056a00148b00b006824c9f0aa0mr4706127pfu.29.1688157434337;
        Fri, 30 Jun 2023 13:37:14 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00679efed4108sm7632414pfn.33.2023.06.30.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:37:13 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:37:13 -0700 (PDT)
X-Google-Original-Date: Fri, 30 Jun 2023 13:36:30 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
In-Reply-To: <CAHk-=whzdoWP5TRA=p=monXZmzo1Wd-gH8GRpcEUKh74nmDgZQ@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c1a8b2b3-f9ce-428e-9079-019db0613d58@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 11:54:35 PDT (-0700), Linus Torvalds wrote:
> On Fri, 30 Jun 2023 at 11:47, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> Awesome, thanks.  I poke around the git merge resolution stuff, but I'm
>> never 100% sure so I usually just look at the resulting output files and
>> then just paste in whatever git says as a heads up ;)
>
> Yup. It's one reason I really prefer to do merges myself - I just have
> done *so* many of them over the years (and did them long before git
> made them much easier) that I can usually do them in my sleep.
>
> Which obviously doesn't mean I then necessarily always get them right,
> but I tend to have a higher success rate just because I'm so used to
> them.

That's great with me, I don't do a lot of merge resolving so it's always 
a bit of a special thing.

> Regardless, I like seeing the heads-up for merge conflicts in the pull
> requests, if for no other reason than the fact that it sets my
> expectations for what I'm going to see.
>
> For example, sometimes it means that I decide I'll just go make a cup
> of coffee before tackling the merge at all... Not for something this
> trivial, but you get the idea.

OK, I'll just keep doing things this way and hopefully it stays fine ;)

>
>                 Linus
