Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352F6C24BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCTW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCTW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:26:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD444134;
        Mon, 20 Mar 2023 15:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08E6FB810F6;
        Mon, 20 Mar 2023 22:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D85EC433D2;
        Mon, 20 Mar 2023 22:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679351158;
        bh=M5sGTt3PrOmAbiJ7luHVkUOTCNBUX3l2wl4cmaD7JTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCnpc6nR3OTj5h7RR97+TvUfar6j0xNx6cIkhIwOb0qo+xY+MW+lgnxC76DfbOZI0
         eem7/S2QtmGimhI/qlYQtpifAJE9Ge9PQaKHpZSnOlHmFsOcGaMhy268L2urUly+f/
         VR04AeXxVeR0T1NVKdEIz1Sr+G7BnSAaz+nseV4T+BsK0T/H6HkEBYMfRm9tsrzmew
         wwsYoDiEb+QKAnP7ouzwXiSV7dOmmT1n6JB9P8TBJLN8y3TZ5kXXKK0CMy0k3WnUHx
         o8qAYPe1BUGf4X+NSZs26X/eVtc/mOsikOzo4UERMBMctEaduD/+0s+GxACDCEwFWM
         Ro003zn34e02Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FD9B4052D; Mon, 20 Mar 2023 19:25:56 -0300 (-03)
Date:   Mon, 20 Mar 2023 19:25:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Small updates
Message-ID: <ZBjddKhoS/eL0w3R@kernel.org>
References: <20230320183517.15099-1-adrian.hunter@intel.com>
 <CAP-5=fU56Kx_K1jQq9b5TpbW-AKTHRAUeQRxfrAvnX7d_zgZkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU56Kx_K1jQq9b5TpbW-AKTHRAUeQRxfrAvnX7d_zgZkg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 11:40:06AM -0700, Ian Rogers escreveu:
> On Mon, Mar 20, 2023 at 11:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > Here are 2 small updates for Intel PT.
> >
> > The first is just a couple of new event type names.
> >
> > The second is a small change to Intel PT as it relates to
> > Intel FRED.  The patch is standalone but, for anyone
> > interested, you can search LKML for FRED to find out more
> > about Intel FRED implementation.
> >
> 
> Series:
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

