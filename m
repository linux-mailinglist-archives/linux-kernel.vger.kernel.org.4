Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB7662A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjAIPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjAIPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:47:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DAEBF7;
        Mon,  9 Jan 2023 07:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6A161194;
        Mon,  9 Jan 2023 15:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC07C433EF;
        Mon,  9 Jan 2023 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673279149;
        bh=0nPNyYWdXzKuN9gUoFP3yifRcZrORypALWjfOptcB7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLKI1beTl7Osq5tXGAYh38r725biv7BCMOZa3FMfeXUmtLZKCyxJOXayZOXkk8/u7
         RteTSjBGxqiCQ3451CLbsyWBc+sqBsrT0fo4vkSNcjNtjfGLn49zFw1jTySSr/mvoK
         tymfhB74+1L+X1b4rpYOIECU855+566CAnAOL8iW4HbNlcyQ6iF5RH5L2Ri/JuHYnY
         q2mAlsX3hpb8sdgXmIjfb77f2H50jftsNGcYJz8YWuqUmYwbuSH6GcYb4+h13OsnNd
         7AL+DQspU0fem/ulThpwLPGkMquALuOhMsnFYAERUkuG3a9lyFAH+FMLN4gBzUWnW0
         dq5el/4Rf7DJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9E4640468; Mon,  9 Jan 2023 12:45:46 -0300 (-03)
Date:   Mon, 9 Jan 2023 12:45:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Google Summer-of-Code 2023
Message-ID: <Y7w2qshoCEjKKVlz@kernel.org>
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 09, 2023 at 07:28:26AM -0800, Ian Rogers escreveu:
> Hi,
> 
> The Linux Foundation will apply to be a mentor organization for the
> Google Summer-of-Code again this year. That application process starts
> on January 23rd. For the perf tool applying as part of the Linux
> Foundation, we have a good record of getting the contributors we ask
> for as part of the program. Contributors are very welcome! For the
> program we need mentors and project ideas. For mentoring the workload
> is to review changes, to attend the office hours with the contributor
> and to fill-in the 2 evaluations. For the project suggestions,
> anything goes. I've included links to last year's suggestions at the
> bottom. If you have ideas for projects then please reply to this
> email!
> 
> Last year there was confusion over whether people working in industry
> could be part of the program. Our answer was yes in terms of support,
> but they wouldn't qualify for the GSoC funding. I'll try to make this
> clear on our wiki, if it isn't already on the Linux Foundation's.
> 
> We'd like to continue having the requirements that applications have:
> 1) what the project will be,
> 2) a weekly time plan.
> To make the program run more smoothly this year, we're also going to
> add a requirement that the contributor has sent a patch to the mailing
> list. The patch doesn't need to do very much, say a documentation
> improvement, but I'd like to be strict and say that any application
> not meeting this bar be rejected. Thoughts about this, improvement
> ideas, and thoughts on what are good requirements are appreciated.

A project like perf, being out there for quite a while, accumulates tech
debt, such being a fact of life for any project.

This being so common, I'd encourage people to try and propose to fix
things not of their liking when trying to build, cross-build, use these
tools.

Being able to at least voice what you dislike, and possibly get some
money out of trying to fix it, out in the open, what an opportunity!

Go and try to fix things!

Thanks Ian for year after year to go and take the SOC opportunity to
improve perf.

- Arnaldo
 
> Thanks,
> Ian
> 
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
> https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf
