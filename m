Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E914360E257
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiJZNlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiJZNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CB5F10A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F6261EE9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A62C433C1;
        Wed, 26 Oct 2022 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666791660;
        bh=vKOEPWMp7cRIQ+4dX2vcpxzdSfjM1T8pKfGE6OpkAuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLnuZLPESK4DQDXXkRw4+ixpGlzUaMGsH6525y/LDctBWe+K13qDby8ZjOJl+TM5G
         gPyfZFGBCDDB0Ah1xu14GLOQlmcP/2PlWbZ+RgbtaljLRy7z6sj51J588XDDVMkGOK
         H1d7OPX61e5QGq7ANNLWXXnfFirwYhH+sCldnqYlP0o7WDvI6GMx7ecWsqcNowSmQQ
         +EToeW/lwMbk1jx/TH6RUl6Q9ZuB9+43vZgGQX5f8d85B3VdX22zdvCOGL5ut8zGzM
         IWjdHB64raPnh5hJ+YHDNLbLkWzvcMYwaFo5eRyEruQFqGy2ur7VnAprLzJyaKXFDZ
         Q8IfZ3Lu057YA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87950404BE; Wed, 26 Oct 2022 10:40:51 -0300 (-03)
Date:   Wed, 26 Oct 2022 10:40:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf amd: PERF_MEM_LVLNUM_CXL -> PERF_MEM_LVLNUM_EXTN_MEM
Message-ID: <Y1k44x5PkAFNRnWo@kernel.org>
References: <Y1g/H2/ljZ1rGmM9@kernel.org>
 <678160a9-49e4-76ec-f002-8c19521a4ef5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678160a9-49e4-76ec-f002-8c19521a4ef5@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 26, 2022 at 11:16:24AM +0530, Ravi Bangoria escreveu:
> Arnaldo,
> 
> On 26-Oct-22 1:25 AM, Arnaldo Carvalho de Melo wrote:
> > Ravi,
> > 
> > 	I'm updating the tools header copies and noticed that a previous
> > sync brought PERF_MEM_LVLNUM_CXL but now this got renamed to
> > PERF_MEM_LVLNUM_EXTN_MEM, so I had to add this change to the sync of
> > tools/uapi/linux/perf_event.h, please ack.
> 
> Kernel header needs to be fixed as discussed here:
> https://lore.kernel.org/lkml/f6268268-b4e9-9ed6-0453-65792644d953@amd.com

Gotcha, will leave the tools/ copy with CXL then.

- Arnaldo
