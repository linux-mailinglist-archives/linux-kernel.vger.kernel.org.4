Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF70634272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiKVR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKVR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:29:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6B76158;
        Tue, 22 Nov 2022 09:29:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i10so37352783ejg.6;
        Tue, 22 Nov 2022 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g60GIv7bqoFLDqB4xsxYyMezGWJmQQ9+7qMuSM+/H/0=;
        b=W69sl1tdcAYXAsJwTLMIp71G7BaVY9ZcCnGrGlXMFZQeWnI94TdJa1OzcJqsEyw8K/
         e6athJBfF+Nm8vJYG4KgbN6BCqWuLobVLqlsx+szLaJIpwOV5ogKvJCVpObqlaHZoKwA
         okuuVU7GV1ULwXzHiQtsYSoHJtfodCgsHktqvd6XP7DfPQqtdOwWHKHDhTs1WVD5rtLG
         2eqGV+iQ8HMnmaSMEcBeS9bGDdaYsGn1/dX+/TqDxDyYys7ITGRQafS0HplcV4H24bCf
         p7psY1xV3H3w5h/GDBNnyHeSsCJlR1foWeYpUwhEOZ7Vr9ycT565kTaDDDRXY4plypls
         Zr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g60GIv7bqoFLDqB4xsxYyMezGWJmQQ9+7qMuSM+/H/0=;
        b=haXYVwWcY3bBkwxhsQ+yelTHRd5l6uTtCiRazX0mb8mEFWtmPmtxGAfWQhX/3aYcVm
         YtVe59pOpQZLyQOmqIvs+LuyUIPGBgzlfowtcwTBxnPuSeQA85Pe5jKzZ6i6lHQO9unU
         2BmvhTYugI7yqCg/ytdIRWXXRTXnlLFjVx/L7yGpjwca7JNarL3YLo82v77l9KgoF3hl
         Yro7YPR5Jt3EoFljZs05Lxw2gTeeoeQtknwe0KMvB5CjbwNLBso+rZmzQg/8yyW8VM9h
         lsqM1347j0rFfJNtP1dhGxEtr7VN3f5PXK3WDdoi+Zkgs1SQeFFggHDRRSsqiCEz4wrA
         Apfw==
X-Gm-Message-State: ANoB5pnZxAWjF+cUsRY52aaKBYOzSE4xD3TU4YQzxfBPK/kzgp2IHb6i
        OjV+DS1pvLGNevvprSffg8F1uIJ0cs1Nx9SzafQ=
X-Google-Smtp-Source: AA0mqf5d0TDB1i5YEGHsP04BQvzxLd3EV4zfcUIqaiVB8JR3e+tinO5QxuEjzMFt84ihIWGQqujx1l0zmgujMXiPWwU=
X-Received: by 2002:a17:906:44a:b0:7ae:e67c:6c4c with SMTP id
 e10-20020a170906044a00b007aee67c6c4cmr19861350eja.375.1669138162627; Tue, 22
 Nov 2022 09:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com> <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
 <418c7f6f-0bc3-45bb-2abf-e866df6f4b62@oracle.com>
In-Reply-To: <418c7f6f-0bc3-45bb-2abf-e866df6f4b62@oracle.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 23 Nov 2022 01:29:10 +0800
Message-ID: <CAOptpSO6=sUPUwgj1og8088djiNA=Bw9um0p024L=0Gb=-ja5w@mail.gmail.com>
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 1:04 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/21/22 8:17 AM, Wenchao Hao wrote:
> > And the function looks like following after change:
> >
> > static void __iscsi_unbind_session(struct work_struct *work)
> > {
> >       struct iscsi_cls_session *session =
> >                       container_of(work, struct iscsi_cls_session,
> >                                    unbind_work);
> >       struct Scsi_Host *shost = iscsi_session_to_shost(session);
> >       struct iscsi_cls_host *ihost = shost->shost_data;
> >       unsigned long flags;
> >       unsigned int target_id;
> >
> >       ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
> >
> >       /* Prevent new scans and make sure scanning is not in progress */
> >       mutex_lock(&ihost->mutex);
> >       spin_lock_irqsave(&session->lock, flags);
> >       if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
>
> What was the reason for not checking for ALLOCATED and freeing the ida
> in that case?
>

target_state would be in "ALLOCATED" state if iscsid died after add
session successfully.
When iscsid restarted, if the session's target_state is "ALLOCATED",
it should scan
the session and the target_state would switch to "SCANNED".

So I think we would not call in __iscsi_unbind_session() with
session's target_state
is ALLOCATED.
