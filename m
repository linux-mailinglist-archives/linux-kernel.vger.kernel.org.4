Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8D6D527D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCUcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjDCUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE14109;
        Mon,  3 Apr 2023 13:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F396762A84;
        Mon,  3 Apr 2023 20:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2A9C433D2;
        Mon,  3 Apr 2023 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680553943;
        bh=8EeIXGTBPv7sYSrRcZhwHFfUMyZbNPxNijX3qQ8Njtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7ngi9C89HtYNA6O32lHdyR+O4BLsB7GlP09vuIKlCcfwCjtV1H2PSfsbOlsfaW4a
         Y894+8AOV6qJyKoETl1qXVOiGads+yln4sPV1qZ6FAaNFv0IXhKnRv2jxDP4MPzs/9
         lxIK1mEVPKBGsXpNgJjXTuk6NpH9BMfy5IebzvNtgzyGimAgtjDvh0mmIJnsA5aUlM
         qiejOo4CWGVxxbacRBHtCM3FxkD5ICE0I/sw5vnou2my/0GOeTPZoj3Zj2PcF2jBvK
         6YeKhXFGqeTn7o1JFaUyGYuz0Y2IXT+RyjOPJygXM9iAeNIqIgQR+ByGJ/0y/6yclz
         wFTJtxuHZXhBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7FDA4052D; Mon,  3 Apr 2023 17:32:20 -0300 (-03)
Date:   Mon, 3 Apr 2023 17:32:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>, Artem Savkov <asavkov@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf top: Add --branch-history option
Message-ID: <ZCs31HwnoTyCWpFs@kernel.org>
References: <20230330131833.12864-1-adrian.hunter@intel.com>
 <ZCX7m2bsyk0SwAdy@kernel.org>
 <369307a5-e6ca-5e5c-f024-49fd174e4f2e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369307a5-e6ca-5e5c-f024-49fd174e4f2e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 31, 2023 at 07:17:08AM -0700, Andi Kleen escreveu:
> 
> On 3/30/2023 2:14 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 30, 2023 at 04:18:31PM +0300, Adrian Hunter escreveu:
> > > Hi
> > > 
> > > Here are small patches related to option --branch-history.
> > > 
> > > Note, currently --branch-history is broken due to patch
> > > "perf report: append inlines to non-dwarf callchains" so
> > > that needs to be reverted / fixed beforehand.
> > Thanks, applied.
> 
> 
> How about the revert to fix it too?

Since there was no discussion on this or a proposal to a fix, I'm
reverting it now.

- Arnaldo
