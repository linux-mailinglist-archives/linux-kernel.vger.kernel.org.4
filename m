Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B95BD3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiISRfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiISRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:35:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7E742AD1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:35:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b75so285678pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=HuIbR7/ykiRWb44NTEFpaX0ksPF00/slbuNRkuNnZs0=;
        b=XzXdG+HT7Z2Fcj1whEzjVz0+JJeYSqZ1o95SbEZqWj249JjKXuUsIv+t7ppf2Upe6G
         ZIVMB6MvQMApvcHiYBmD9jvNSuRVz18cD6UEu/gX4Xq303Pcr+/OrGvuggEQqzoX0Gjo
         JY/AZY6BsShLOECUkEh5Wgtp1/9t+ewXhrd3+8M4v3skdyRH/zwsd4yXb69TT7fxVsWU
         d5zOsR5Ess21X9npTOekfXDC0reuVYIJyMrSJ8FUZ+OcCKnNu9tzeMccFW3mbW66mnDh
         koAc6W8h9y3MC8qJU1PjX3R8yX1of/YpzSTtm01Ax66V0+RtR9R9iGCZNblHXtx3X1Ie
         QsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HuIbR7/ykiRWb44NTEFpaX0ksPF00/slbuNRkuNnZs0=;
        b=O+ssTtEfem820bBd5gCpbVzpH+TDT4SFe9IXftvcVHsFq1RcBg/R17//Lt9Fo6+/Bu
         smuYfQ7tXcjg3cYQ8SkH02RvZCNMqfXRocCB5kRY4AaROY7HesFwMj5iEuDkthCcr+9T
         f6S263LGH7Jsz00897q+A9mRuEI9UgXQ43oRK4Y7acRiPJgNNroCYGumt4HLJeDOusSU
         a5OuTh0xE6hrZQ9UD9/sYP+xLrmqoHQL2OnQqH5EzRA8ii99wHWaqfgirthoFLuJQnrz
         x0v95uKxcZ3T56RikOVwb26uE52JonYPy1yhf/ZXrcQ+IpNz7SaA1xc/TzhCS11298RF
         DVXA==
X-Gm-Message-State: ACrzQf31YT3gRLOdrkGJ3xCNC9S3vK5Rtl1T4lXl3MgwyihB1D8Ns1Ho
        kDa9FUAoCf7WnLSekV21oe7MZ9N3BgnPfw==
X-Google-Smtp-Source: AMsMyM5/h6Hb8n+oTsWerH7KYegujzSE+mS3NtqLVwtPpxf/59p9EJqAWNegoaW1ehRh+W81Txjq+g==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr19569562pfh.40.1663608935977;
        Mon, 19 Sep 2022 10:35:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b00176d6ad3cd4sm20317667plh.100.2022.09.19.10.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:35:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Sep 2022 07:35:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kernfs: fix use-after-free in __kernfs_remove
Message-ID: <YyioZk1fLVFZHWwn@slm.duckdns.org>
References: <Yx+m9knwzSFDwyPJ@slm.duckdns.org>
 <20220913121723.691454-1-lk@c--e.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913121723.691454-1-lk@c--e.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:17:23PM +0200, Christian A. Ehrhardt wrote:
> Syzkaller managed to trigger concurrent calls to
> kernfs_remove_by_name_ns() for the same file resulting in
> a KASAN detected use-after-free. The race occurs when the root
> node is freed during kernfs_drain().
> 
> To prevent this acquire an additional reference for the root
> of the tree that is removed before calling __kernfs_remove().
...
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
