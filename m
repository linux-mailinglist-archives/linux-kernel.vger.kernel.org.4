Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4945FDEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJMRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:15:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B850CA882
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:15:50 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1322d768ba7so3056275fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AL8GgYhdRbFAY1I/WaSvEhOgWlWOIlrmNR+qKwfbbA8=;
        b=sZzF6YeDDqPexzDlerU/y2iM/SsYbZQlakRSWiK8Tzj+LZablOYaNgr7UT9v9twhQY
         N8iFhmS7wLi9JnDGQkT8BVHP40pjXN6GrTmccYLaOvu4wlsylXCa7N5AQ8jWUB+vnVCj
         IaLxzjGrqHa3VJng/xuw4y6IGrx6WgRuqnI8BS2UbyuQ6Be8weh3PW6TsG9b0zo/uZU8
         WUft3JV+1uBQ2mEXfP5WiFxg1cidYc5HPVw8zUa0GNuL+monA99cRTyKX/LajrG+my8n
         mzOA16Wce97HXrvefJOwiIAYoLESZpo/GsnbNqvdxxZea8Er1b+ke+QeFgtx4jI1mFhD
         ZG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AL8GgYhdRbFAY1I/WaSvEhOgWlWOIlrmNR+qKwfbbA8=;
        b=gCVEGXPwWg1vUNEOBlSUX5BKBo7Lt6skRB7zbIuB36hX4I9bZraW1sZEotFl0dSfH6
         xsImr+ekJo5G7ao1nT5tQXNHpFzxrRiMh50V0zggBc5o53VPfJT0e9zlXDUPp1c+3ZoN
         sbSZNtArXF/6WbQAVTXs9y/9Gt4W57tEz4cVSzyk0k/ehDb+hUwvTV8oVlXGCY5K6U5/
         EYOj7qq65Lf0tqT23fQsZYo00ZcIXxpu2gCIn8fiiS/DchKhhbGDzR9+OkLioTb2Ifgm
         JEaPyRg3J2JGtIwFQNMO0J8qcR2ZxLCv7MwDvWQQVSkjmCmP7/YV+w6d7dtNdstv7AsJ
         yeLQ==
X-Gm-Message-State: ACrzQf1oL6cFIoHj/rth/ar3u+/sygkbhg9i0jvJNZqazlw4m/mAsUIW
        /rUvBEqIXF+tq1Qi+109jnUTAQEe1Z2kML6axOlMaxRBKTs=
X-Google-Smtp-Source: AMsMyM40pcn43Afc/INQuWsfimSqp6ScPvV9jk8gZtST/j2paeNWTCEFvWp9RTkoTB8udAdLoTGcr4WnsXP0r3hpAxU=
X-Received: by 2002:a05:6870:7023:b0:132:538:43e7 with SMTP id
 u35-20020a056870702300b00132053843e7mr405372oae.123.1665681349180; Thu, 13
 Oct 2022 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <202210132122.DnShsQeP-lkp@intel.com>
In-Reply-To: <202210132122.DnShsQeP-lkp@intel.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 13 Oct 2022 10:15:13 -0700
Message-ID: <CAAa6QmTMa76hsaN_RDkkQRpEcH8VV-RqHY=MXWjk36eMX49Ppg@mail.gmail.com>
Subject: Re: [peterz-queue:x86/mm.pae 5/9] mm/khugepaged.c:865:16: error:
 implicit declaration of function 'pmd_read_atomic'
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like this was just due to local "mm: Rename pmd_read_atomic()"
conflict after merging Linus's tree (which introduced another
pmd_read_atomic() callsite). Peter already seems to have rebased and
made the fix - thanks Peter.
