Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4805F68C009
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjBFO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBFO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:28:06 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BA16322
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:28:05 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id c15so9697208oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R7RryzcBt3IOpQ6ZmiIpG+DlyYLOytGf1SpVP5mZzI=;
        b=iCm5zxRRBDKu3DIWweJEAnXoMlLiwuoUjqGoHjQRVNiJooyapVzcvH0ufex7sKqizi
         4YP7g+ulOfWQtqU17cOEJ56Ef+UpaRf3/mtqINseNkcdFnhZguVHpUUc14GxMgpsazgY
         hMVlxDoc0OjrVkauRy1r19G08rWHcdt3geFQXUn4/653NdP8RAGYbdNoAUHTOioRSLVf
         FFn4jzb4ysUtRblkTFu90+4/XK4K8bB9L6RIM/RL6079LjnSH5r4rk/070qlEIshOcjz
         fXzvUuwgSu9EaqpXoNk0IrP0yydWwMgCYbyd0aZyB3pBMkAxbjPU2DuE8ogBlUOTWgKR
         nxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R7RryzcBt3IOpQ6ZmiIpG+DlyYLOytGf1SpVP5mZzI=;
        b=fYL38bWlhkcGeq7IB2oC+045SkIb4NGLjC+deWj+As0bxzKrd9m7ywaB/T9v8jlU3Z
         ZdzCi4tp5zfnu2L+ICqcnHkc6Tkwky4iw1VIfiCxGcGsFw4QkqVxRnJJ6iHKPhpl0TLd
         8A9BzJpL4l3fFvZn1PA7XbAxYARTdAcVwngPwGaJPDdmbEamU+5oG75qPudSaYO8tTWz
         DFhs6Rtyqa4yP/hdLw4jETIexC8Tt6uqRBuABd+CnIk6dim0fBrV872wqKqopOEXecWr
         CixGzr44/o+CFNyxtoaEwr68t9saiaRwefnmombGOVbyJ8EUE3WB4Ep2x8Z5/xLvX/dV
         xQJA==
X-Gm-Message-State: AO0yUKWm6mdp/5unfT0D/zwtmXg1WouYeP8f8N+Lo+apoAtZgt7hJkkk
        zeRKT8jChsIqbiZVKzA2zdQKScE1zF8=
X-Google-Smtp-Source: AK7set99Fqd/79QuCyUvp68iUFPqafjYHiMmwNNeakoGY1bKZWy8TMOb74kwmiC72kVZjnEH63v5Xw==
X-Received: by 2002:a05:6808:1812:b0:364:5ea0:c3f6 with SMTP id bh18-20020a056808181200b003645ea0c3f6mr10826981oib.20.1675693684777;
        Mon, 06 Feb 2023 06:28:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dp11-20020a056808424b00b003781a8bcb64sm4183548oib.36.2023.02.06.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:28:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Feb 2023 06:28:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc7
Message-ID: <20230206142802.GA191238@roeck-us.net>
References: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 01:32:30PM -0800, Linus Torvalds wrote:
> So the 6.2 rc releases are continuing to be fairly small and
> controlled, to the point where normally I'd just say that this is the
> last rc. But since I've stated multiple times that I'll do an rc8 due
> to the holiday start of the release, that's what I'll do. And we do
> have a few regressions outstanding that Thorsten is tracking, so just
> as well.
> 

At least there are no new problems, at least none affecting my tests.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 504 pass: 504 fail: 0

Guenter
