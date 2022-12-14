Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9364C2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiLNEDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiLNEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:03:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64727153
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:02:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o12so5566605pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fCrMB9cQt2MX8YzEWi0sGLkBMAE2dTTyW94AFZn9pA=;
        b=fgjO1qQIwaV1ipZKA8klXdP4Ve8zlCH05WM04DBeAuVhT2gV0/NDQjwzHWxvy6vjoo
         Z8Wpdy4M8ga+fRK0sYnPreKKUxfL63DTSNOd+GnpDA5wFIEeY2UZ6ZizffNy5TSem3fD
         OASi7zyrHG3s4Cefq1ZVxzjAlDEwOJdGHqEyh+ePjyV/tbXz8S0ksLLjPOSMBw+VUGLc
         h6l+EOVvIc7rBKKXCwQ0L0ko7MdR1a95ECuIGMulh2iJaSWH0s7Fjmc9D+aOWAorlGYa
         11LUxOEneebX67UHldEWM+Vgc3beULPdhg7ncK0q2+MFuQACLqTCu2dc15pdEWPK5h2K
         FgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fCrMB9cQt2MX8YzEWi0sGLkBMAE2dTTyW94AFZn9pA=;
        b=QIbRRwOfT3TzlXl3ClvOSUM8X/cv2YUv67iWwJSrkRGkiDQyN8O+IKW04UnadVLNZO
         r2LtyW2pI3oV1S2ZSxt8jAhiH5FVnx2aYmqdmaCkNJRHxuE02IiPvmI97eSRjLGNfA61
         08Iucga0ymbFf97k023At+KWg2PoZF1CZS16iVKaxaRkoso+Z24mLumlvNtKFwYB/gIn
         6yZ54QAXdDwtCl/XtszInalFJrkH6lN+evqbibxqKKnWnpbKb1fRxUrbJvuZNLJpuHf2
         RMhODitlTpkE1Jb+4aZOWv7PZnR6H5jrpjTCdbRxKvR4MOaxl+4iHha/6vqWQ+zMIBX8
         geWw==
X-Gm-Message-State: ANoB5plk1E9YoTMf/3pWzDz24B4Y1kxNVaxGZ9BXwjvt+dRqmyXCeTYz
        xsqwQbvzv1Xytrwo/rVZAQpDWg==
X-Google-Smtp-Source: AA0mqf4eQdsVDxhyLdxJPM3HETuo0Ym+0gSGYwMuYtLjp51oYGKdeufiEWmH06tCm5OiFbgvmqG6Sg==
X-Received: by 2002:a17:902:a502:b0:186:7a6b:24d9 with SMTP id s2-20020a170902a50200b001867a6b24d9mr21682666plq.23.1670990578230;
        Tue, 13 Dec 2022 20:02:58 -0800 (PST)
Received: from [10.5.231.247] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902b18f00b00189393ab02csm675922plr.99.2022.12.13.20.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 20:02:57 -0800 (PST)
Message-ID: <1e53592f-b1f1-df85-3edb-eba4c5a5f989@bytedance.com>
Date:   Wed, 14 Dec 2022 12:02:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y5et48VryiKgL/eD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/13 上午6:40, Tejun Heo 写道:
> On Wed, Dec 07, 2022 at 12:38:26AM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> Now we don't distinguish sync write ios from normal buffer write ios
>> in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
>> until write completion soon after it submit. So it's reasonable for sync
>> io to complete as soon as possible.
>>
>> In our test, fio writes a 100g file in sequential 4k blocksize in
>> a container with low bps limit configured (wbps=10M). More than 1200
>> ios were throttled in blk-throtl queue and the avarage throtle time
>> of each io is 140s. At the same time, the operation of saving a small
>> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
>> the sync ios of fsync will be blocked by a huge amount of buffer write
>> ios ahead. This is also a priority inversion problem within one cgroup.
>> In the database scene, things got really bad with blk-throtle enabled
>> as fsync is called very often.
>>
>> This patch introduces a independent sync queue for write ios and gives
>> a huge priority to sync write ios. I think it's a nice respond to the
>> semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO gains the same
>> priority as they are important to fs. This may avoid some potential
>> priority inversion problems.
> 
> I think the idea makes sense but wonder whether the implementation would be
> cleaner / simpler if the sq->queued[] are indexed by SYNC, ASYNC and the
> sync writes are queued in the sync queue together with reads.
> 
> Thanks.
> 
Should we keep the main category of io based READ and WRITE, and within 
READ / WRITE the subcategory were SYNC and ASYNC ? This may give less 
intrusion into existing frameworks.

Thanks.
