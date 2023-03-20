Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A396C223D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCTUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCTUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:07:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59E14EB0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:07:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id bh20so2183608iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679342857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptvl3VACyvM+tvnPRHUaQKDglzv+zd/V/R3dCmh35lk=;
        b=GMBEF1VIB6A7eVH0C/ygevm/a8yHE7+SaDtQLIsxLIpv1hWRBdntJVgB+ZuBiJ9d9f
         SuAcB/J6NCa5a60oT0oyoZjHam6WfGphYuAJjSs24ixFomtK0Wx7N+GZHy6+H60K64i0
         BCeIJ+lTF829pyRD32G/83Wre+8oFWGiR8XU8mwAn4GZbBNS2W5pgTda7dslaxvTfXwY
         Lr7xPABdCH2MRYOJkzEK7RH59m86LQrDJw5kKKdd3cB8FsTeK2fO2+km+c4mCmNcqhJz
         YZCq9T3G7K8ru5wmnw1VTqpEcWOlrpPa9PjBGjh53xNi4a5e36kURDaYGWtJr8Ve/FpR
         JAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ptvl3VACyvM+tvnPRHUaQKDglzv+zd/V/R3dCmh35lk=;
        b=pm5FU+5oYm4ueMMCkXOVLs0IGGm4PzXry3OOSTNepLJlCvry/5SuzHmJKgB2YHwKZK
         rzXIu65GaajRmbZI1sYFT+fC0F4m9E+6VfctmSVS3C++B1gfshAVuycfvnvKpJZjZvnn
         gl1UJwtyWKvRAkGnVAW8TY5W922GTp8nJzDzD1w8a2mCy4lpDjhWvrU+NaTFDmkhEeFw
         ifLDFVfrt3zkj53eWIexqPUoCuUvS5yQPEBsYdiaBmpFwFixHoAuBHiupS0VvaEuixoE
         ZOafzkKhj3eS5xcvXhKDdImaCQRjSWQTAqKAWLGkI281+XGdeWacHlBwnVF1nZ8Y0QtI
         Yo9Q==
X-Gm-Message-State: AO0yUKXc9R0R4hlXQpS5i48rChbn4SOPALR4dCyAX1DTEmf5EyTxn2cn
        4ZqUmwfyPyFACwPELUifKho=
X-Google-Smtp-Source: AK7set84m7cxe7jFCuxlMWRw8aVZIOdaUziTtCw56uXgBDiYPFSQoxY6Kd7U0rucTzLoqs/g7pgjCg==
X-Received: by 2002:a5e:c304:0:b0:758:1fa5:f086 with SMTP id a4-20020a5ec304000000b007581fa5f086mr20947iok.17.1679342857072;
        Mon, 20 Mar 2023 13:07:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a05663810e400b003c2b67fac92sm3549155jae.81.2023.03.20.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:07:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 13:07:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc3
Message-ID: <14197fd5-26fe-4d1e-9bcc-4012145f0eac@roeck-us.net>
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:50:21PM -0700, Linus Torvalds wrote:
> So rc3 is fairly big, but that's not hugely usual: it's when a lot of
> the fixes tick up as it takes a while before people find and start
> reporting issues.
> 
> And nothing here looks hugely worrisome. The diffstat looks a bit
> unusual in that there are relatively big changes to the scripts and
> selftest directories, but that's mainly due to the git-ignore script
> removal and some kvm selftest cleanups respectively. Nothing scary.
> 
> If you ignore those parts, it's a fairly standard "two thirds drivers,
> one third rest" thing. The drivers are all over, but networking, gpu
> and sound are the usual big ones, with the fbdev code showing up
> mainly just because of a coding style fixup to the logo conversion
> scripting (mainly to use proper tab indentation). The qcom
> interconnect driver also shows up for major cleanup and fixes.
> 
> Outside of those areas, it's a random collection of fixes: the usual
> arch updates (much - but not all - of it being kvm), some filesystem
> fixes (mainly cifs), core networking, tracing, and some core mm fixes.
> 
> Anyway, it's early days still, but nothing here looks particularly odd.
> 
> Please test and report any issues you find,
> 

No change since last week.

Build results:
	total: 153 pass: 146 fail: 7
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 520 pass: 520 fail: 0

Details are available/reported at
https://linux-regtracking.leemhuis.info/regzbot/mainline/.

Guenter
