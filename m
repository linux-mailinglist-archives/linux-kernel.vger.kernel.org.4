Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBF72048C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbjFBOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjFBOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:34:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81A99
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:34:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so1420695f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1685716480; x=1688308480;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mh32AefeMMikefo4GnmhNXDOVxpzlJj5DaZUcMsa5o0=;
        b=LXWoieCAyBJ2+K0+1+5yS9NQxQ8likoHP8OVjdwd0g+UxVGnfaBVwC2JZ7D5QlYnhY
         LLM+Uhougx1RczKC0pO+B+YLqnsfl43IOkAfsVPfsRPVFvPqeQytk1cyWMmI+M/ms/RZ
         TVJ2KKeEySCO0nHbrSo9CyRA3BpJkX2EWQEwOFI4lSSx4/eU/UaIWvvDi4O/BHn1Sy8k
         rbTh+GHyGlplxjpNSG92+rtHQbjPs6mljUpb6wDyKQ/3PszcPwQYdCKvQpTUOE6cnnWA
         sA/BACfmakFDPdffsMVKYVMyTxjN92RmMS3nGT243N2wyAtIaCTECGYZeU0CpgrcSk6m
         SnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716480; x=1688308480;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh32AefeMMikefo4GnmhNXDOVxpzlJj5DaZUcMsa5o0=;
        b=KxkB55XZQBVtLhhET7tybGytfQcJMPR7ypB5nnysaOfjf8fHeZ9C1aSbEkovPvBmqm
         htpsUunJhphekUE4nRU8TV3EjTpW29vb4ysEbAg2m6D5/EtjOiQYGKxobxCJQHmvmhBx
         LqWIC+/VyZpRUS8mHYviHjvD45i8sfDe/rvq1eb8BNDFYYQOvyOZUxQSlDWP6lxU+RbF
         4qcEj8H0CLQGBtoAZwl5Ba3sLK8JzyOmmuf7LM86bv90ByWttv0vFjjTjGlK8uw29a8l
         x+u1Lv8MT1lkjVTgtePar01K+Jv4DOF6Pn2Va/aV+Vvqbhnh7FUdh22fRRBdgO3FU0J8
         ABGw==
X-Gm-Message-State: AC+VfDwfd4hHc3ftJnoB7nlEpk3dXDns6xwIvydEEpdBV8SHf+Wc/tB6
        brbgM2Nh47FcS3701U/6mDprwQ==
X-Google-Smtp-Source: ACHHUZ4Q4CRLY+qqnMRdLxgAmfjgYx/BaUO1YyxkfmId5OxzCb0ED50kKdVr0LqsYnOhJDCPbbDDjQ==
X-Received: by 2002:a5d:48cc:0:b0:307:7e22:dfc3 with SMTP id p12-20020a5d48cc000000b003077e22dfc3mr103508wrs.63.1685716479790;
        Fri, 02 Jun 2023 07:34:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:c196:937f:1927:fe24? ([2a01:e0a:b41:c160:c196:937f:1927:fe24])
        by smtp.gmail.com with ESMTPSA id g9-20020adfe409000000b0030ae53550f5sm1847392wrm.51.2023.06.02.07.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 07:34:38 -0700 (PDT)
Message-ID: <e8431649-6389-bea3-58ab-9764dba83b3e@6wind.com>
Date:   Fri, 2 Jun 2023 16:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
        linux@leemhuis.info, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/06/2023 à 20:32, Mike Christie a écrit :
> When switching from kthreads to vhost_tasks two bugs were added:
> 1. The vhost worker tasks's now show up as processes so scripts doing
> ps or ps a would not incorrectly detect the vhost task as another
> process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
> vhost tasks's didn't disable or add support for them.
> 
> To fix both bugs, this switches the vhost task to be thread in the
> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
> SIGKILL/STOP support is required because CLONE_THREAD requires
> CLONE_SIGHAND which requires those 2 signals to be supported.
> 
> This is a modified version of the patch written by Mike Christie
> <michael.christie@oracle.com> which was a modified version of patch
> originally written by Linus.
> 
> Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
> Including ignoring signals, setting up the register state, and having
> get_signal return instead of calling do_group_exit.
> 
> Tidied up the vhost_task abstraction so that the definition of
> vhost_task only needs to be visible inside of vhost_task.c.  Making
> it easier to review the code and tell what needs to be done where.
> As part of this the main loop has been moved from vhost_worker into
> vhost_task_fn.  vhost_worker now returns true if work was done.
> 
> The main loop has been updated to call get_signal which handles
> SIGSTOP, freezing, and collects the message that tells the thread to
> exit as part of process exit.  This collection clears
> __fatal_signal_pending.  This collection is not guaranteed to
> clear signal_pending() so clear that explicitly so the schedule()
> sleeps.
> 
> For now the vhost thread continues to exist and run work until the
> last file descriptor is closed and the release function is called as
> part of freeing struct file.  To avoid hangs in the coredump
> rendezvous and when killing threads in a multi-threaded exec.  The
> coredump code and de_thread have been modified to ignore vhost threads.
> 
> Remvoing the special case for exec appears to require teaching
> vhost_dev_flush how to directly complete transactions in case
> the vhost thread is no longer running.
> 
> Removing the special case for coredump rendezvous requires either the
> above fix needed for exec or moving the coredump rendezvous into
> get_signal.
> 
> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Co-developed-by: Mike Christie <michael.christie@oracle.com>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
Tested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
