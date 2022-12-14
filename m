Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC964C123
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiLNA0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiLNAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:25:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2015FF8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:25:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso5452972pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkhwTELNviBJt4KKaWThjN1KoC/lySaQISrCOJ56+sI=;
        b=XDBWLXIEbtHnQNkEFxWRj1y8VIpUYZWcaAQ+fW2/lfGYWwpALXjfV6yAqBHUL/sKh7
         2JLQtI3xUgT97uZyxN2VfzMHkHBGBJ2G56836atarOWHyktRsxyPGUDCiBTIcPrxjWKp
         4v6I/HnZ2/H+ncRnCnJ/ZzzSaZEK6g50NmjHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkhwTELNviBJt4KKaWThjN1KoC/lySaQISrCOJ56+sI=;
        b=DI4oQrM7bmR0ffzJbYhOKUzYOh12770KFEpWUpmc8XphdArW7+/zmu1ehxHVgCHvvB
         Dw3kEubGxiRDrKge+P6jTbYSp5YGcXCp4/GFeWGt4ApYyVrh0iIjpgMLnVmBXP0odreG
         yayDeum5u5yWs1ta0EIe/nDRB/8c9zaRyMUGlFhO7wpNydOqr5teJtkDZeYcOCTmYy8u
         U6ZfnJUklBow9ctpv2jUlIlQzmQT3t9hTPSk/ANtokfXX1rZY3jno9BpNu/OJMe7EFQi
         VAPz+pKEEOm+gA4JDCTF9EuPXLrV2wLee4Fq6D9b/PwNhH0MhpmBsv+baklz5Kf/yFes
         wnRw==
X-Gm-Message-State: ANoB5pmuws4Jhrbmdw/f3zdTLJP8JwATsFNpJtHRi6umki4pqHywWmhV
        ZcMwqaTAOugfsKPyu3tNC8cWvg==
X-Google-Smtp-Source: AA0mqf5uegftvDafiprhva4ZzjYmUt1OusSDYFAkM3Il7bquEsKE9KE6XaofbT2iAZyU+xQHtVsxJQ==
X-Received: by 2002:a05:6a20:a681:b0:ac:1266:bda with SMTP id ba1-20020a056a20a68100b000ac12660bdamr29926220pzb.7.1670977549302;
        Tue, 13 Dec 2022 16:25:49 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id az4-20020a056a02004400b00478c48cf73csm7429960pgb.82.2022.12.13.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 16:25:48 -0800 (PST)
Date:   Wed, 14 Dec 2022 09:25:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: zram: zsmalloc: Add an additional
 co-maintainer
Message-ID: <Y5kYCGKMC5xTyYb7@google.com>
References: <20221213170731.796121-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213170731.796121-1-minchan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/13 09:07), Minchan Kim wrote:
> Move Sergey to co-maintainer for zram/zsmalloc since he has helped
> to contribute/review those areas actively for eight years, which
> is quite helpful. Since Nitin has been inactive for several years,
> it's time to move his name into CREDITS.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thank you!
