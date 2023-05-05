Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FD6F8995
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjEETkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjEETjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:39:45 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E2469A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:39:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-61b5da092dfso10492036d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683315580; x=1685907580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6BqLpqsqpfv4e6MRMY7gBjrDbHLmMrEtwfllMgszTw=;
        b=OjZbBTcfGOQAnlSXtPwCAuc+ky8ALtIYzA9WpYBwiKNrPvoibiC3t0jK3gh8lkyHCV
         I7PqXmoVMTlkgVny0PKfZnI2bMDwQve5OkO2TDvJ/heMmyYd158XR5k5E4Yg8FlLyZIE
         jbsWZALi/50JOayWZBQHA0Mvr9ctCyv2fch9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315580; x=1685907580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6BqLpqsqpfv4e6MRMY7gBjrDbHLmMrEtwfllMgszTw=;
        b=AZOkVPr6IEZxs1B0mVY71NWoIGRUtkgBOQPIE2PNmLCdoMSZLYO2OUMYJWtVaZuPla
         s7nDrC3tYDqyuB4+opX2Zc9xyOZyV//s1weodbnBHDV/ynJRBuTyEjFUp1SY3leUvdF5
         YO1yhIwc5IR8l+SgZ62MukbCdvLAogslnY+7mZyqGj3ERMwRoWWjk71bpRpKvo9lVAYK
         0OSj5tjQ337yMW7MQGhZiBLrHl5BK6oGAlxjWDAXdGiBTxA9xnsry6eBx/yq6B8hW9Zt
         MKBIUpgTQCsg70fWP/1HKqf7VINDDgEKPwPk0g1RBGFuyeCANP8Vvp9GLy9aMxLFY6Na
         N7VA==
X-Gm-Message-State: AC+VfDziWWAYCCOdI7jgHMB46GZXFZOenLH/BDE05O5MetIrHRxJA/pP
        9YN+T44rPrnqh+LNimtbkqmXazRr69CeoMqvMV0=
X-Google-Smtp-Source: ACHHUZ4sL0e5LUqXusK8zAVq+1JZOQ9Ih7SpSisWHVue2HXLyx7MjYodDozdQjwiEDJ0GtrOJMx5gw==
X-Received: by 2002:a05:6214:5299:b0:61b:6fcd:34ab with SMTP id kj25-20020a056214529900b0061b6fcd34abmr3982129qvb.0.1683315580300;
        Fri, 05 May 2023 12:39:40 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id o16-20020a056214109000b0061b5ad0290asm808144qvr.67.2023.05.05.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:39:39 -0700 (PDT)
Date:   Fri, 5 May 2023 15:39:38 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org, linux@leemhuis.info
Subject: Re: Introducing bugbot
Message-ID: <20230505-blunt-corncob-6e6e95@meerkat>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <20230505085218.60c62d75@kernel.org>
 <20230505-lent-swoosh-4897e2@meerkat>
 <20230505123226.731d8ff8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505123226.731d8ff8@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:32:26PM -0700, Jakub Kicinski wrote:
> Interesting. Obviously that assumes the bug needs a fix, and we're
> talking bugzilla so lots of clueless people lobbing non-issues at us.

This is why anyone can create a bug on bugzilla, but only a subset of people
can enable bugbot on it (by setting the bugbot+ flag).

> But also - Closes: is a legit trailer now? I thought we only allow Link:

It's a semi-legit trailer and is going through -next:
https://docs.kernel.org/next/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> In any case - I'm guessing I just don't have permissions to close the
> issues via web. Is your preference to iterate on the bot or maintainers
> to request permissions in BZ (how?)?

Yes, it's not a power granted by default, but people just need to ask.
You should have this awesome power now.

-K
