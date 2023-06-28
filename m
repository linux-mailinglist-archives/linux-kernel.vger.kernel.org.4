Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C074182F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjF1Ss0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjF1SsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:48:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBE1FE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:48:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c38a4d22b39so57415276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687978102; x=1690570102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnnDEXrg/gkS/C7srVAqIZGcztE6wO7dbfqWYSxKCy4=;
        b=6PAR7Npi8ERaYChyaM+1wl8PfqDVMWaRkcCtpbbS/XEKjfr05+Ro0K9USuAb+eufOr
         h/ro1Q/tP9CLLoTUmmxV82f/liy3cZ8icxTWd8VGrVlLveNRXYIAU5OJUYVxyLnr0gUW
         Y7Z4iD2RQxrpBUuHeLTIjq81we4+waGdJq22oRpgLgIFNaF/9M6mDK4Ina4I4pW5Hlbs
         WzGX7hJ0qxX4xionOv44NTJgbFmWU1NLe9t2hnUr+yVLrdnIc0/P5Fvctariw9dj2Y1V
         iQdGh8OWi02JgJkSM0Brhi5vSoesDVRTmcjISQf8bxjhPgYvpJqyhUGW6F+e6l3CMznh
         1TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687978102; x=1690570102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnnDEXrg/gkS/C7srVAqIZGcztE6wO7dbfqWYSxKCy4=;
        b=guR35paUTbZ/rAY2xpP/l9drEWio3DhQk2T3xl20jMdI+OqaL/E3+JNPdIMH2srfGJ
         GShgcz98r+2QH9f+cjNbSWCzdK9Df2n+lPWt9BouOltdPNS63I+39AMk2ishgYxSmTeW
         Oqf7ZhnrCROO19iL2QBwsFgdBD76m48eRHJ2yiEB1oUGsG9rNmadBn8eavqVKmcV5c91
         5IW9/ZdwM+iaN58/KSuvdNW5+2O1/lPWnFq+95LOkiewbE9XaVEOqRI+7Pmtqyea1DGh
         CbR0HDiFTmjoa7FL/ttTjQdRvXbodHsGYs8pg2/B62NNccRs/E2CP/ByhM6pzIvIjsSW
         0nBw==
X-Gm-Message-State: ABy/qLZHe85hcc2H+caSPEXeCiUP7y+2zFTIeD9ChjA11ZADmD3CdG7Q
        1VbXXcgQIPlRSPidY3/1jl1TiNkij441ZmXBIw==
X-Google-Smtp-Source: APBJJlFwj3ft8PJXuauN4m6BQgeng7EycnUWJJ8yZOOIAcurN18/szcbl9SlfQzQQsFl+u7T/7Men90wScQkVVCVkQ==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:ee8e:ae51:26:66dc])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:781:0:b0:c39:d6f6:481f with SMTP
 id 123-20020a250781000000b00c39d6f6481fmr7552ybh.10.1687978101888; Wed, 28
 Jun 2023 11:48:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 11:48:20 -0700
In-Reply-To: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
Mime-Version: 1.0
References: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628184820.1375994-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Kees.

>And yes, Greg's questions are all good -- fixing syntax and adding size
details in the commit log would be appreciated.

Sure, will send another patch to address this.

Hi Guilherme, thanks for testing this patch.

>But when I tried to increase the record size in ramoops, I got this error: https://termbin.com/b12e

What record type are you testing? I should have mention that this patch is only for pmsg use case on ramoops (I mentioned it in the original thread but need to start a new one due to format issue).

>Also - Kees certainly knows that way better, but - are we 100% sure that
the region for pstore can be non-contiguous? For some reason, I always
thought this was a requirement

Right, that is why this patch only touches the pstore ram path, I am not sure how things will go if it is block device backed.

Thanks,
-Yuxiao Zhang
