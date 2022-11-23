Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B8636637
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiKWQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiKWQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:55:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A66D4A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:55:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso2350552pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7o2lRyP1u0L6Fq95IcwGop/aV4o6vtFSNMdoJas/GU=;
        b=PjKSO4qnH1yVhQ9C2RaXNiSFcPl8KoTOcxcYdVQl3fWzFyQSE1HTtvD40meg3gddeg
         ucp5HSue/wnL3ZIBaGyE14U8LHRlb69CU+Dj0jbBRl5D57O+TGUtqEZDS0OHiz99j02B
         jm8pPTwCMXxniejrd3c8pto7YeOIY4cRIst9U6nQiIc8JdGqPGqOkt2nZ8WJc8TD06iE
         qZonMI+cDvb9916l1t1JXQ1dThRjn5UMvKTvDm2Vr65a+eYffV++3L/J10SiR0GxRA5I
         GJDACam8hExAQCkgIGPoZg4mV5u4DCuwC0zALp/d9USgS9/tgt8PD73njWG/JejAnv6O
         5HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7o2lRyP1u0L6Fq95IcwGop/aV4o6vtFSNMdoJas/GU=;
        b=cGPdbOYmseKkTUnyfSET5hrI7956j37YpUjV40+GegLfwUjmPa88rDeVo3GS8hIPNz
         E2bQ9CI+NFEaev6ZYe9KFCNuHuor/GFNkwH8hk6AjIpFbJFMpYnj4Fs9OhOY+7BnLvEs
         WakRI/88RMmg1AjALo06HD8DRawg6mCQDW8Re7yFK6IcTqNN2JdmNigE1i2AGPbhiK9U
         KQTxtSgnNPbJSh+WKaRpNCYsgz4zAwPv9mAo/fntl8IkqSU5PZJe5AdjlnVRQ1xlJOyl
         zQ1XmN+vVd/qsNPyeyU6CfuYn9FMXQ01JOX6yPaViNENTo7xseIsBKLbuwSmS0jfM5W+
         AIfg==
X-Gm-Message-State: ANoB5pnptOzekJXr+GNthcQDc+xO+7dloY3z6QGBquBcEAltq3KNfIGH
        qmRuUWIi249YqCqmOuMVNG4=
X-Google-Smtp-Source: AA0mqf5WaLsMhcj3aHdeQxqL37oq3cWg2tRCMdBBcw9zzgJdA/uEKFpG1vOmTRMl15PvcH2AdMMw0g==
X-Received: by 2002:a17:90a:cf0d:b0:218:9a43:952a with SMTP id h13-20020a17090acf0d00b002189a43952amr21731015pju.240.1669222533680;
        Wed, 23 Nov 2022 08:55:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b00186b549cdc2sm12132706plg.157.2022.11.23.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:55:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 06:55:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix potential null-ptr-deref in
 kernfs_path_from_node_locked()
Message-ID: <Y35Qgw4Q8XYD5Did@slm.duckdns.org>
References: <20221123020419.1867-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123020419.1867-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:04:19AM +0800, Zhen Lei wrote:
> Ensure that the 'buf' is not empty before strlcpy() uses it.
> 
> Commit bbe70e4e4211 ("fs: kernfs: Fix possible null-pointer dereferences
> in kernfs_path_from_node_locked()") first noticed this, but it didn't
> fix it completely.
> 
> Fixes: 9f6df573a404 ("kernfs: Add API to generate relative kernfs path")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

I think the right thing to do is removing that if. It makes no sense to call
that function with NULL buf and the fact that nobody reported crashes on
NULL buf indicates that we in fact never do.

Thanks.

-- 
tejun
