Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259D70A111
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjESUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjESUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7EE5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f475746ae0so21968951cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529681; x=1687121681;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZJNVK9YHaPAbF2Jn7/P/L0YwULKWY8OB/ImBEt7x7E=;
        b=YdZl+ccDAxVN2DMCdmj00qkO2tPC+dQvZPSNysED3Ax005/f9zrshUY9gqlpSJpvZz
         CbY1/Z1WXLDwGjr9GT9k+W7giHhNlVtgqbG/reHlnILf+tJwzFYqh+VMwoQoQOrhXKpD
         vvRsI/G9E6nZTTyncWvYrjLPxXw4Bb06c/0ZnZU+h/IcHGh7aImsPAeb357JkizagO/q
         UgVgFDJk7/Ir+kLhuhUG6wjFqtWlE2qdbWp+phlaNT3FQnsm1iDHw/GU5GlF98TNsCIw
         BTUJdqjyrilhNPhORDCW9XDDoIkamEDcckugIhTjePRsb1mUdVD5Fiu6H1Qovd5+sZoL
         D0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529681; x=1687121681;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZJNVK9YHaPAbF2Jn7/P/L0YwULKWY8OB/ImBEt7x7E=;
        b=iGd0KwNMcLgtHMc2arT9odrpFVnw+0M72jklaP9pB5pEaqRQUgh3RWuAHKsZ6X4s9X
         r89+jlm4yrXw/EUGbR5SBLEi1oYtiym0/hi0Lg/d26M/DFnicKTYUD7aublXhl3/hQTD
         J9UtlQt+XRG8Jz5wuBCil3Lx4q9D2OREE7uTJfLRGrZeglYIxBwJ4cDS3QfilBY6pmsu
         nJZsCgVGu3R8IWSy/s3qckVNRCmXx3j9daq8o9tdspv1tDPyJ27fE8pV37xLUQ4zxPQt
         mGjHuKuKEUPKhCMo4KPiCo9Qt3bfyRHVQjn8K5FU9SwqR6QBU9sdm3QFBbiAU7qgZRPq
         DG8w==
X-Gm-Message-State: AC+VfDzffyxXaKNod7+atL9zpVRZkURYfUh/iHsi+MbwePgjoszO5Bwu
        CMcYZ7LFDVJDm+SqbCJuPhU91SCOJv1AVr8m2Q==
X-Google-Smtp-Source: ACHHUZ55ceatKrdBNbR/Jk/XfDh8VQ2nP21sDg5bmFTKmCUsyk2VfM7aQx9hdwV/FwNQmnBAFYnrFA==
X-Received: by 2002:ac8:4e91:0:b0:3f6:9c1b:911c with SMTP id 17-20020ac84e91000000b003f69c1b911cmr1581546qtp.44.1684529680910;
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z8-20020ac84548000000b003e4c6b2cc35sm124639qtn.24.2023.05.19.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:40 -0400
Message-ID: <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 4/5] audit: check if audit_queue is full after  prepare_to_wait_exclusive()
References: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> Commit 7ffb8e317bae ("audit: we don't need to
> __set_current_state(TASK_RUNNING)") accidentally moved queue full check
> before add_wait_queue_exclusive() which introduced the following race:
> 
>     CPU1                           CPU2
>   ========                       ========
>   (in audit_log_start())         (in kauditd_thread())
> 
>   @audit_queue is full
>                                  wake_up(&audit_backlog_wait)
>                                  wait_event_freezable()
>   add_wait_queue_exclusive()
>   ...
>   schedule_timeout()
> 
> Once this happens, both audit_log_start() and kauditd_thread() can cause
> deadlock for up to backlog_wait_time waiting for each other. To prevent
> the race, this patch adds @audit_queue full check after
> prepare_to_wait_exclusive() and call schedule_timeout() only if the
> queue is full.
> 
> Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK_RUNNING)")
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

I discussed my concerns with this patch in the last patchset, and I
believe they still apply here.

--
paul-moore.com
