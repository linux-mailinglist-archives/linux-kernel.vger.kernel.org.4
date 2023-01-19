Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A689F674C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjATF30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjATF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AF72C0F;
        Thu, 19 Jan 2023 21:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4A94B825FA;
        Thu, 19 Jan 2023 16:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28611C433EF;
        Thu, 19 Jan 2023 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145652;
        bh=rFKR1hKMBI+MtzO4V9xJtCxqUhqcAJzkDhj8cS00xzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8trZE7TrGfyonP7IswrV7OueQT1uyfwewfYfh66CVY9NIK5grGPOzqOAtVbZzXkW
         bvaa8xviYC+dbzeEFB4b6rz5eXP2BmbYOtNcp4iBPqK52dIhIRaWdFT9bWbWtBf/UK
         TAmHvBCuDPUb6f7GpCFI5QKuBdaOSghJOj1cfEVyTLnZ+IHeDw30R129Oh2cOw6M5j
         sbpAX1r+svuq9YUfY6a48qe/yO1AS7DLL3ukqWrlrB+19FSDkZD0sgOWIYRqlrlt1M
         1JuBv6BRmiYfHMLhIMktjfW9S40j6vmkqTSomJKfeCFuslvQZYAEKnzJZldVN0QrGE
         CV4svrcc6dSBg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37660405BE; Thu, 19 Jan 2023 13:27:28 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:27:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf tools: Remove
 HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
Message-ID: <Y8lvcO5yAuZTzDuf@kernel.org>
References: <20230111070641.1728726-1-irogers@google.com>
 <CAP-5=fXPg1FDdtRgKtar+x3U91RNpPdYFJUP6XHvK1y10y=O2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXPg1FDdtRgKtar+x3U91RNpPdYFJUP6XHvK1y10y=O2Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 19, 2023 at 08:01:32AM -0800, Ian Rogers escreveu:
> On Tue, Jan 10, 2023 at 11:06 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Switch HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE to be a version number
> > test on libtraceevent being >= to version 1.5.0. This also corrects a
> > greater-than test to be greater-than-or-equal.
> >
> > Discussed here:
> > https://lore.kernel.org/lkml/20221205225940.3079667-3-irogers@google.com/
> >
> > Fixes: b9a49f8cb02f ("perf tools: Check if libtracevent has TEP_FIELD_IS_RELATIVE")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Remove one ifdef in favor of a consistent version check, gets
> debug logging from libtraceevent going.

Thanks, applied.

- Arnaldo

