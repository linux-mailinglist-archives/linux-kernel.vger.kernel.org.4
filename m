Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2E6CDA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjC2NUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjC2NUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:20:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3224C27;
        Wed, 29 Mar 2023 06:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 327D9B8229F;
        Wed, 29 Mar 2023 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0FFC433A4;
        Wed, 29 Mar 2023 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680095976;
        bh=61C5WGy4QvCm2FTJiTSg1nDFY4dmTI5++Uz90gJ1gFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTJRLQWwbJMJ451CrUEUTHD/r2lxT2aFS+xui0h4FKP5StmPPLld1R5dN5jaIJJFu
         th+VYmee71giaaVSwN1wUZ/hrx++VfYm9YCOhTWNbHuEI8cDT97ols0QA7/Fiqlx/e
         yqYk329EgH1v1kGzqXqdw+SPqbVEmUaFcLJXF64bj+ch85GGICLNWO1w3UoaYDTQno
         /zusUhiQHzbVp2M0l2ur7fjcdqbJv+JpXY2KVsCJ/TQZcBRVla6StTWhBV+dfykFSs
         et9Zau7JXHzF2RPCh2tuxEs6FoOkRJa+Hdj3VLIaHg0l87acSN2Lw/x5dRAOaeS82V
         nZp9bZdzgsnxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 465FF4052D; Wed, 29 Mar 2023 10:19:34 -0300 (-03)
Date:   Wed, 29 Mar 2023 10:19:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
Subject: Re: v4: Re: [PATCH v7 00/15] coresight: Add new API to allocate
 trace source ID values
Message-ID: <ZCQ65pLbikC83Jqf@kernel.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
 <5b7df6df-0c2d-6953-0f50-e85745cb1f4b@arm.com>
 <2864f28e-dd2f-5a9c-922f-5c044a864beb@arm.com>
 <e3df35fe-a00d-69ec-32ee-53c949909cab@arm.com>
 <6a71acac-c478-6e5d-3165-4ba9526614db@arm.com>
 <5556dc65-79ef-e8d2-e5b4-046594af78ea@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5556dc65-79ef-e8d2-e5b4-046594af78ea@os.amperecomputing.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 09:44:47AM +0530, Ganapatrao Kulkarni escreveu:
> Hi Mike,
> 
> On 27-02-2023 03:56 pm, Suzuki K Poulose wrote:
> > Mike,
> > 
> > Please could you send all the perf tool related patches as a seperate
> > series, with all the tags to Arnaldo directly at -rc1.
> > 
> > Please add a cover letter explaining that the kernel changes are
> > available upstream.
> 
> Looks like, Perf tool patches corresponding to dynamic trace id are not yet
> merged in to perf-tools-next.
> 
> Without these patches, the mainline perf tool breaks for the coresight for
> higher cores.

I'm pushing what I have to tmp.perf-tools-next while this + other
changes goes thru my container set build tests.

- Arnaldo
 
> > 
> > Kind regards
> > Suzuki
> > 
> > On 20/02/2023 16:24, Suzuki K Poulose wrote:
> > > Arnaldo
> > > 
> > > Gentle ping
> > > 
> > > 
> > > On 31/01/2023 11:49, Suzuki K Poulose wrote:
> > > > Hi Arnaldo
> > > > 
> > > > On 24/01/2023 11:36, Suzuki K Poulose wrote:
> > > > > Hi Arnaldo
> > > > > 
> > > > > Gentle ping.
> > > > > 
> > > > > On 19/01/2023 12:00, Suzuki K Poulose wrote:
> > > > > > Hi Arnaldo,
> > > > > > 
> > > > > > On 16/01/2023 12:49, Mike Leach wrote:
> > > > > > > The current method for allocating trace source ID
> > > > > > > values to sources is
> > > > > > > to use a fixed algorithm for CPU based sources of
> > > > > > > (cpu_num * 2 + 0x10).
> > > > > > > The STM is allocated ID 0x1.
> > > > > > > 
> > > > > > > This fixed algorithm is used in both the CoreSight
> > > > > > > driver code, and by
> > > > > > > perf when writing the trace metadata in the AUXTRACE_INFO record.
> > > > > > > 
> > > > > > > The method needs replacing as currently:-
> > > > > > > 1. It is inefficient in using available IDs.
> > > > > > > 2. Does not scale to larger systems with many cores and the algorithm
> > > > > > > has no limits so will generate invalid trace IDs for cpu number > 44.
> > > > > > > 
> > > > > > > Additionally requirements to allocate additional system IDs on some
> > > > > > > systems have been seen.
> > > > > > > 
> > > > > > > This patch set  introduces an API that allows the
> > > > > > > allocation of trace IDs
> > > > > > > in a dynamic manner.
> > > > > > > 
> > > > > > > Architecturally reserved IDs are never allocated, and the system is
> > > > > > > limited to allocating only valid IDs.
> > > > > > > 
> > > > > > > Each of the current trace sources ETM3.x, ETM4.x and
> > > > > > > STM is updated to use
> > > > > > > the new API.
> > > > > > > 
> > > > > > > For the ETMx.x devices IDs are allocated on certain events
> > > > > > > a) When using sysfs, an ID will be allocated on
> > > > > > > hardware enable, or a read of
> > > > > > > sysfs TRCTRACEID register and freed when the sysfs reset is written.
> > > > > > > 
> > > > > > > b) When using perf, ID is allocated on during setup
> > > > > > > AUX event, and freed on
> > > > > > > event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> > > > > > > The ID allocator is notified when perf sessions start and stop
> > > > > > > so CPU based IDs are kept constant throughout any perf session.
> > > > > > > 
> > > > > > > 
> > > > > > > Note: This patchset breaks some backward
> > > > > > > compatibility for perf record and
> > > > > > > perf report.
> > > > > > > 
> > > > > > > The version of the AUXTRACE_INFO has been updated to
> > > > > > > reflect the fact that
> > > > > > > the trace source IDs are generated differently. This will
> > > > > > > mean older versions of perf report cannot decode the newer file.
> > > > > > > 
> > > > > > > Appies to coresight/next
> > > > > > > 
> > > > > 
> > > > > ...
> > > > > 
> > > > > > > Mike Leach (15):
> > > > > > >    coresight: trace-id: Add API to dynamically assign Trace ID values
> > > > > > >    coresight: Remove obsolete Trace ID unniqueness checks
> > > > > > >    coresight: perf: traceid: Add perf ID allocation and notifiers
> > > > > > >    coresight: stm: Update STM driver to use Trace ID API
> > > > > > >    coresight: etm4x: Update ETM4 driver to use Trace ID API
> > > > > > >    coresight: etm3x: Update ETM3 driver to use Trace ID API
> > > > > > >    coresight: etmX.X: stm: Remove trace_id() callback
> > > > > > >    coresight: trace id: Remove legacy get trace ID function.
> > > > > > >    perf: cs-etm: Move mapping of Trace ID and cpu
> > > > > > > into helper function
> > > > > > >    perf: cs-etm: Update record event to use new Trace ID protocol
> > > > > > >    kernel: events: Export perf_report_aux_output_id()
> > > > > > >    perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> > > > > > >    coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
> > > > > > >    coresight: trace-id: Add debug & test macros to
> > > > > > > Trace ID allocation
> > > > > > >    coresight: etm3x: docs: Alter sysfs documentation
> > > > > > > for trace id updates
> > > > > > 
> > > > > > I have pushed the kernel patches on this series to
> > > > > > coresight tree next[0].
> > > > > > 
> > > > > > I will be sending them out to Greg for v6.3. Please
> > > > > > could you queue the
> > > > > > perf tool changes in the series ? i.e., Patches 9,10 and 12.
> > > > > > 
> > > > > > 
> > > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next
> > > > > > 
> > > > > 
> > > > > Please could you pick up the perf tool changes above ?
> > > > 
> > > > Please could you confirm if you are able to queue the perf tool
> > > > changes ? Or would you like me route it via coresight tree ?
> > > > 
> > > > Kind regards
> > > > Suzuki
> > > > 
> > > 
> > > 
> > > Suzuki
> > > 
> > 
> 
> Thanks,
> Ganapat
> 

-- 

- Arnaldo
