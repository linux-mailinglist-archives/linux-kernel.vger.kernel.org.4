Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076746C7545
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCXB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCXB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:58:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D84298F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:58:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so576826plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679623109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW9r55UPaCY84ZkjUjaKnIlqDJ4KkRU/jbyN19wbqdI=;
        b=Z24KaTOLUJ8+ko5tFEDybvJ/JnnivxXrwm57g73uArAWAD8ImEna1l6ZzXy++ykqXT
         e0ZxNHYIRqDluKzEc7XYTjTpXYRH7DVfdoUMeEavDaD34xeIntr0JYeJ/7hLIFMweOht
         aOlsn6wkU3AiswCpQt7jjUVMcxuLQsLQQRI2xWz9cEPuA1W8q64E7bALQu+tcthG0Ji+
         IQYoZOcSjaC+GF5/gudQqh9jYtDPs0Pbhbti0Kyw/S9sPhT2uRucVniRYE2YCcdjH2Q3
         EHOYIutRiwBdWoom9lLfQntd0VaTaOF91KvKE5lidzl8XiRPEiUsuYG/DYy5aZQmOWPk
         PY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679623109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW9r55UPaCY84ZkjUjaKnIlqDJ4KkRU/jbyN19wbqdI=;
        b=CPY6+LK7uYJiRmIS0UHY7wXzhX62UWAaeQeWwNMG54NQC6JX+FUEsQB2W/2Xg+1hTl
         NOI0qzF3/+vCzozLjW9LEmJwITtBBH0+s9Y9pTCGXnF9Df9Uw2u/wZOiEHFH2Ug8FOKc
         4v3DVIFPHZU6sLe8bdhAN1/qeqWaaWKvZXjaSwq1lxwzKh+xflyKWNwJpBSHVkdJWVst
         07iyljmA2Cle+daJR1E7g+wUGpJ6Yh58v1Bzdv8U0D62ODyhZb51824+vMDVwPbMTErO
         lIP354p8VUp1Ov1e9ul7Pvv7h7KbcLaeBHvkvM23g9jstcFg4j6KYT22kAYs9qR0249q
         jhKQ==
X-Gm-Message-State: AAQBX9eH85d2pgJMgj8XY9+uYfNrrIzHNQWGnyCInqapDypldzra0xw8
        jwTJME4TXFtlYK22jeTMZ6OE6rdKFo8=
X-Google-Smtp-Source: AKy350YIi4/qx2CDatunLZxEAqiLbID8O9dBxInSQnU7N5DK1XRFuGxJf3U+W189CWFPUTd/Sb7muA==
X-Received: by 2002:a17:90b:4f86:b0:237:9fbd:31c8 with SMTP id qe6-20020a17090b4f8600b002379fbd31c8mr1067293pjb.15.1679623109346;
        Thu, 23 Mar 2023 18:58:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090ab79500b0023a9564763bsm1865983pjr.29.2023.03.23.18.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 18:58:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Mar 2023 15:58:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] workqueue: Drop the NOT_RUNNING check to flags in
 worker_{set,clr}_flags
Message-ID: <ZB0Dwxs6xen7D/qh@slm.duckdns.org>
References: <20230320092652.16649-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320092652.16649-1-zbestahu@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:26:52PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> We know whether the worker flags are belong to WORKER_NOT_RUNNING or not
> when we are setting and clearing them.  So check the flags not running
> related is unnecessary for both the cases.
> 
> Currently, worker_{set,clr}_flags() are all used for WORKER_NOT_RUNNING
> except for clearing WORKER_IDLE.  Let's change to directly clear it
> instead.  Also, update the comment a little in worker_clr_flags().

I'm not sure this is better. Semantically, the existing code seems clearer
and less error-prone to me and this isn't gonna make any meaningful perf
difference. Lai, what do you think?

Thanks.

-- 
tejun
