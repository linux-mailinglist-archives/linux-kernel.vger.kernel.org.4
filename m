Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DE636074
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiKWNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiKWNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:51:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D941B7B6;
        Wed, 23 Nov 2022 05:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE0061CD7;
        Wed, 23 Nov 2022 13:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE0C433C1;
        Wed, 23 Nov 2022 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669210917;
        bh=K6xOp+ZZlKqfNXVv1WAPsdzdApBdk64pGeS3iULK8gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHdFhbTYxGbckNNGQIt6Ekcz9waay3TAJSWURnOxJw+hCzYyCsryF3/v+G0yIQnWt
         xyKlyEtUEfjZIk6ic0Y9kkxCfoQ7VSUs2L4j3Gi9zT6X03WRiDVSOkzm53gLnZiywT
         sFPPt6MFlP8ATzbUzMniqrh2FRFY2E54ebD60+kTFLixNxLNSmWn91m0klYD0nogC0
         n1uk+fmSQQQXt+8P+9YjJQV1NnQONUjhzKby3i5PNh3bhCJZjloTL7ibqw462bY5zZ
         rb9eoMRMl5sxV+pb7aHMe6rEb2TT4yIjvfsq7NfolHLMMc7ubeLpwddb36VCUPbEJ0
         wPJt6lUVdloRQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 598AD4034E; Wed, 23 Nov 2022 10:41:55 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:41:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com
Subject: Re: [PATCH] MAINTAINERS: Update John Garry's email address for arm64
 perf tooling
Message-ID: <Y34jI33Iy50A6/UV@kernel.org>
References: <20221121113018.1899426-1-john.g.garry@oracle.com>
 <20221121125648.GB7097@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121125648.GB7097@willie-the-truck>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 21, 2022 at 12:56:50PM +0000, Will Deacon escreveu:
> On Mon, Nov 21, 2022 at 11:30:18AM +0000, John Garry wrote:
> > Update my address.
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 379945f82a64..2ec6a2709225 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16191,7 +16191,7 @@ F:	tools/lib/perf/
> >  F:	tools/perf/
> >  
> >  PERFORMANCE EVENTS TOOLING ARM64
> > -R:	John Garry <john.garry@huawei.com>
> > +R:	John Garry <john.g.garry@oracle.com>
> >  R:	Will Deacon <will@kernel.org>
> >  R:	James Clark <james.clark@arm.com>
> >  R:	Mike Leach <mike.leach@linaro.org>
> 
> Thanks for doing this, John, and good luck with your new role!

Indeed, tis really nice to see you'll continue working with us!
 
> Acked-by: Will Deacon <will@kernel.org>

Thanks, applied.

- Arnaldo

