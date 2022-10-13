Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1575FE2CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJMTiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:38:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07546169127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:38:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq16so2914924pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkBt85ltE192jcvG6qgnLMVWSfWOI1gb3TC1BL8yO0Q=;
        b=D3R9bdxZfs82fVG7s8SaCMMHNTd0Du5eqFzinXZIhwvUO+lauCTZp4wi4JZeN6hXKc
         D0Ke9pdNnV3p0vDLple0mMzoxHRbUwLCX9ZL3Eea87M6fhCp0mvP1Ox3SXabtjTC1L3H
         bRbuJgNTnyTY2VrjT3OHN9qfMqSIDIregEMTVc3qRl0LduJyfwVFLYho5NZPUcnWoxdf
         RT+S3O8aqaVhxho/qWiP+VWAKhsaFoHFkh0cPBEgxNsXfgu33WWIgMArFB/ysrNBKUgX
         /bzTtGyXSRrKGSip+2mkYpjRQ2zoJRV+qLSTAD417FsijnEGM+OZUJIMNGGpZw+E792J
         vJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkBt85ltE192jcvG6qgnLMVWSfWOI1gb3TC1BL8yO0Q=;
        b=svt6onQ5j3Xd54oqaKR2V1bdM51YH2+JG8oYVj8ce+0iCTfQGr0pMmgI4F2R9lKu6g
         qJVgWltUMUo+gAWyH3DdwUZJvefOu7kuI0Tnn4H1mNRkZTa07ZXI+1a5xcI2by18wBgq
         y613IVU/c/QJoWwlYtPYMVkZbrSj8Xa/1JXRF81/GJRAeu6//LjJ0KEhyzpjXGoAmbo7
         f5LmbWGHMVxDjscjymXb51als0Y5mNtXwR3/2BlECmE822bbxGL2aPYYmxsly6JE/nNL
         wWYjKIIbqP5crsat3soGPK73j0vXqaouw0aEaheQqR23EhDy/qZVvjItn4zbsTh0pBjp
         cBmg==
X-Gm-Message-State: ACrzQf2G97UGEV+PGP47Fxtz2gwz4K9RL3bfpQOFW3N4JgvHqZGEq5S/
        w5iDbvDSvvxeC0NadhmZ9fH5p7vGWmkLIA==
X-Google-Smtp-Source: AMsMyM7vVQ6SNh3mHqvjtTpDtNGdC1dhO6tkPcUWMk6i2Z/bgbOYFa9hKHJ6nApuAuTq1DjEFzMiVg==
X-Received: by 2002:a17:90b:3555:b0:20a:c2d5:d361 with SMTP id lt21-20020a17090b355500b0020ac2d5d361mr1570829pjb.50.1665689890476;
        Thu, 13 Oct 2022 12:38:10 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm213165pla.192.2022.10.13.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:38:09 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:38:09 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 11:39:47 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: Move from git://github.com to https://github.com
In-Reply-To: <a5380bc2-08f9-1f09-343b-0e1a86693721@gmail.com>
CC:     Conor Dooley <conor@kernel.org>, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     f.fainelli@gmail.com
Message-ID: <mhng-216dc4fc-3a64-4ccb-b428-bbb13ce30199@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 11:20:51 PDT (-0700), f.fainelli@gmail.com wrote:
> On 10/13/22 10:02, Conor Dooley wrote:
>> On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
>>> Github deprecated the git:// links about a year ago, but it looks like
>>> there's still a handful of them in the MAINTAINERS file.  Conor pointed
>>> this out about the RISC-V KVM tree, but I figured it'd be better to just
>>> fix them all -- I've got a bunch of insteadOf so I didn't even notice
>>> the deprecation, but new contributors probably don't and might get a bit
>>> confused.
>>>
>>> Reported-by: Conor Dooley <conor@kernel.org>
>>> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>> ---
>>> @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
>>>   M:	Scott Branden <sbranden@broadcom.com>
>>>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>>>   S:	Maintained
>>> -T:	git git://github.com/broadcom/mach-bcm
>>> +T:	git https://github.com/broadcom/mach-bcm
>>
>> This link is dead, I can't find a repo with that name on their GitHub
>> profile.
>> @Florian, should this be updated to the stblinux repo instead?
>
> Yes this should be updated to the stblinux repository, thanks! If you
> want to split on a per-maintainer basis, I can take the Broadcom entries
> separately  through the Broadcom ARM SoC pull request, else:
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I'll split them up and send a v2.
