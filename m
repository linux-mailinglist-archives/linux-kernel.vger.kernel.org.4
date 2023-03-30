Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF36D109D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjC3VOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjC3VOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9BEB4E;
        Thu, 30 Mar 2023 14:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FDDD621B7;
        Thu, 30 Mar 2023 21:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA92C433D2;
        Thu, 30 Mar 2023 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210845;
        bh=GcxczfKCOzk1wzFLbVwJqOmXiY+ZjF6l30aoRYvQEDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DviBhQLcr/5HilNkLxJwAre3PfRXOJ46spNwWMcaD5dfEy1zqoQy7wtBp+CkaQBhS
         2fj3bE2zZc8Fee+OsYABDm8Vb2z1w6glFq4skWKoyV76SXGbATGZUp2DCnQsvd4hDa
         Wsvrd5G8Y8K6tYljXoCzeBVQFXoUpRijiSBsaLPrkU6EK8tMTzWXJgSuM+qRxMkNkd
         AwpB/6Cxm1p6earFhx85nmZQTtT7oam1sK8dfM3OsXcDpnWcI73lKgKb1Zqj3E/YF2
         fztc6PAPYVqVtiB6/HoENK+2mHQwsNCo9F9jnqM35vVL2dY0dVYnBqFJiZZGJi2z9P
         zETiFUHBznR8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 637B14052D; Thu, 30 Mar 2023 18:14:03 -0300 (-03)
Date:   Thu, 30 Mar 2023 18:14:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf top: Add --branch-history option
Message-ID: <ZCX7m2bsyk0SwAdy@kernel.org>
References: <20230330131833.12864-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330131833.12864-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 30, 2023 at 04:18:31PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are small patches related to option --branch-history.
> 
> Note, currently --branch-history is broken due to patch
> "perf report: append inlines to non-dwarf callchains" so
> that needs to be reverted / fixed beforehand.

Thanks, applied.

- Arnaldo

 
> 
> Adrian Hunter (2):
>       perf top: Add --branch-history option
>       perf symbol: Remove unused branch_callstack
> 
>  tools/perf/Documentation/perf-top.txt |  4 ++++
>  tools/perf/builtin-top.c              | 17 +++++++++++++++++
>  tools/perf/util/symbol_conf.h         |  1 -
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
