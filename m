Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25D606CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJUAxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJUAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:53:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B323081F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:53:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so5114137pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4NnxEtWApdLTlR9dqsXWV3qjS06x9nxBie2kvhQzTA=;
        b=Gy4O0avmcUJJgFdKz7WXNhnfbE5l9uZ7Pnyx9pzjzC+JKqQ+iHYKetvKRcjgYiQR4l
         hKMq3YGx9+hZLOdPLaVwa10Eq48SoWTQ7cuWRb8F9UD0dDqyGzaZkEg/NXAjjtfl+4Ad
         2vXdB7n1DAKDPgK/CM/QC8saB42wG2rf+f/3i/6pvKH5BiS49dIFfIDV2AO+X/LpO8VP
         LBIr1IZX+YU5iokFPgRT0zAHzhU+MQQOoTQnSxspSDxItIy6KV21V2zYNtT2Yonc8hQs
         P1MLs+yzZxfmspXWgumuisMxcKZABvlkyvT2/C25IqbI2mWrlwV1HsrQkBCQ2Uo8+Jv7
         L3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4NnxEtWApdLTlR9dqsXWV3qjS06x9nxBie2kvhQzTA=;
        b=mfC5h0R91fDvkrVsZjhgUm829iwWCDXjeqCaihqtRdJnb/iPzmQm66pAcMBx3mPKg6
         AHefWl86Dj4n5SDatqJ5TSshwYj3F9//w0/HKnN7wZf9R1rXs17MsINVDD2Pc9s/3Lnz
         bdeN4ffGaVGTCzCNI1kjhRRoA+5TwE1q4c/ca7OJYksSOAXLLaHmrx1fKxnwSqaqF+tG
         Xf/LuSJSJONuw79pd/cabf4WUZvNJ7wc8qePOaLFuaYgik8TfKXZmhZyrEkOJP3mtEWx
         bQvLLOMKH5PNelSSQEGuQFD4hLb6wK87IB7IYceFlCQmSKngB+hYa+8nZ3DNs84Wbb5U
         mTNA==
X-Gm-Message-State: ACrzQf1bm29Pjf622nqgSUQ/tq4O/KS5uOjxQbOvrwo5vP+Y4alMKDMc
        jhPKW+u96K0wL6XAb2N6oPw=
X-Google-Smtp-Source: AMsMyM4/A6sHIlQBG/4PtWKlIfaZRHPLpuG3yYa9+Wxip2k30wPofK5WC21Mu65ljV/ufPNCGrvJKg==
X-Received: by 2002:a17:90b:1c88:b0:203:8400:13a9 with SMTP id oo8-20020a17090b1c8800b00203840013a9mr19478438pjb.46.1666313630589;
        Thu, 20 Oct 2022 17:53:50 -0700 (PDT)
Received: from gmail.com ([2a00:79e1:abc:1e04:de9a:68c:c1e8:7e8f])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b00183e2a96414sm3734464plb.121.2022.10.20.17.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:53:50 -0700 (PDT)
Date:   Thu, 20 Oct 2022 17:53:47 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kees Cook <kees@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/5] selftest/seccomp: add a new test for the sync mode
 of seccomp_user_notify
Message-ID: <Y1Htmxkt6+MDAq1i@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
 <20221020011048.156415-6-avagin@gmail.com>
 <B33DF09C-9121-4342-926E-B7B1988036B9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <B33DF09C-9121-4342-926E-B7B1988036B9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:04:44PM -0700, Kees Cook wrote:
> On October 19, 2022 6:10:48 PM PDT, Andrei Vagin <avagin@gmail.com> wrote:
> >Test output:
> >RUN           global.user_notification_sync ...
> >seccomp_bpf.c:4279:user_notification_sync:basic: 8655 nsec/syscall
> >seccomp_bpf.c:4279:user_notification_sync:sync:	 2919 nsec/syscall
> >OK  global.user_notification_sync
> 
> This looks like a benchmark, not a functionality test. But maybe the test is "is sync faster than async?"
> 

Yes, it is. I found it quite useful for debugging and understanding that
everything works as expected. I like the idea to check that sync is
faster than async. I will add it and address all your other comments in
the next version. Thanks.

