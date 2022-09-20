Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03085BEE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiITUNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiITUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:13:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7E72856;
        Tue, 20 Sep 2022 13:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A61FB82CBE;
        Tue, 20 Sep 2022 20:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125C3C433D6;
        Tue, 20 Sep 2022 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704780;
        bh=kxx7btcaXrcTwks5lCzuaDoGDyG0BYIdlbhdeBb8TQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWWuhlj+XKFabdRAPRQSa+LUv2rPEM7cifJxzUuRsmVb/ikfGS5feOUeNiRIFbTk1
         VweVNoiA3DXpKLK006EXn3bH1jjzd9z7CsFr7xoTzg3WzlRI1ABWw9jH6dloOp45dI
         7Yq5lNWMdt/FVj+5CmcNClnCLNPt4DmAjfrcEx60i1I+77rcXjuQekkYoTmZSqnVpJ
         yQkwjcgW23+x0wdWkOuB8JgBSZ2tq5d9qDjCxTDOVyufJ73Wj4BI4+c6xJp/BffuTB
         riWOJNgy8qa3ZcnMxDheqdC8dnSUiyLhj1uPe0JrjytYI6CKsQy9LNw/T7CK4IZtJ5
         IlF8Wom3vdUyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF00F40856; Tue, 20 Sep 2022 21:12:57 +0100 (IST)
Date:   Tue, 20 Sep 2022 21:12:57 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf test: Skip wp modify test on old kernels
Message-ID: <YyoeyZATlcrSjz0s@kernel.org>
References: <20220914183338.546357-1-namhyung@kernel.org>
 <ecb6c1b6-132e-ae75-88f3-20b6793a3d23@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb6c1b6-132e-ae75-88f3-20b6793a3d23@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 19, 2022 at 11:24:05AM +0530, Ravi Bangoria escreveu:
> On 15-Sep-22 12:03 AM, Namhyung Kim wrote:
> > It uses PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl. The kernel would return
> > ENOTTY if it's not supported.  Update the skip reason in that case.
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks, applied.

- Arnaldo

 
> > I'd like to add Fixes: 2e85d5979e8d tag here but it'd conlict with the
> > later change in e47c6ecaae1d.
> 
> Is it worth to backport?
> 
> Thanks,
> Ravi

-- 

- Arnaldo
