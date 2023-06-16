Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459747324AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjFPB3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFPB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0926A6;
        Thu, 15 Jun 2023 18:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC03A61376;
        Fri, 16 Jun 2023 01:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A63C433C8;
        Fri, 16 Jun 2023 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686878936;
        bh=Ska3k0W+hkdYi+l/Z5d9+NYh1dwYFpkhTmWNf3VmqZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3nvgszhyVulqop8ji5FoK//jhcyaqPoCBTftcxu3O+WLlgf6Qt+gBaBTdmHGkHwW
         p59LjBIdI5fdtPDjWMqZMzeq2TPOaYLFEHbk2f/wy3xfQHIwdr3V2JHBUpHKMpyoDV
         CG5YqxXtmwZoah4AdlpH3970R1njWrVqfF/dXUqefGcoomaJDP63dsIe9gJ0VDqsXr
         yBe9UQBkpm9O/OtlruCRGBuLgaf1MD9+NQy32Yoh8knnCz0ctYjOuVTKYHpnWkWuW7
         zbF5DnuQRBshz66h6YoBjSX0vCYMEcJNONyjyWm/LdimQDWikWXIY6s9qqlkptMjWh
         AiJ5NXBuXT3EA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2B9640692; Thu, 15 Jun 2023 22:28:53 -0300 (-03)
Date:   Thu, 15 Jun 2023 22:28:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, peterz@infradead.org, irogers@google.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Subject: Re: [PATCH V3 0/8] New metricgroup output in perf stat default mode
Message-ID: <ZIu61WSa17DvVtgt@kernel.org>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 15, 2023 at 06:53:07AM -0700, kan.liang@linux.intel.com escreveu:
> The patch proposes a new output format which only outputting the value
> of each metric and the metricgroup name. It can brings a clean and
> consistent output format among ARCHs and generations.
> 
> The first patche is a bug fix for the current code.
> 
> The patches 2-5 introduce the new metricgroup output.
> 
> The patches 6-8 improve the tests to cover the default mode.

I cherry picked 1-3 and 6, and pushed to the tmp.perf-tools-next branch
at both my usual repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf-tools-next

And also at the one we're transitioning to, and that Namhyung Kim has
write access and will update while I'm in vacation in the next two
weeks.

git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

Tomorrow I'll do more tests with it and then transition to
perf-tools-next in both git repositories.

Please prefer
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
from now on.

- Arnaldo
