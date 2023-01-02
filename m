Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676E565B44A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjABPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjABPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:34:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642ECEE;
        Mon,  2 Jan 2023 07:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B8B6100E;
        Mon,  2 Jan 2023 15:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14DC433EF;
        Mon,  2 Jan 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672673696;
        bh=zJNTfbfKaQsZHuoRWNrWjoFueZFaKIOgRu8XXFughmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWeExQuNd/hxzvyL3CO6P9+LFR8lQ+6neY/BYDS73yDx+G3ax1cqa1aI/tKmTg+y2
         cVcHSUzFfKW5D/u38jVNDecmfGJHlCWI17WfiCDD0z3/otl6393XLj2feKla1i6ptG
         H9dbd3lLkbcHQFF3L5RwwdApJ0sLSOrQEUMv7PQ7bgz1TOn/ywwceB2FP557pPKWmb
         EQEg28zOmJyhKRWXXl4SpHGtN0f3F9yhcJo58iFk8CQdj0Rd64k1QcySrhZJBfXIdP
         K2HfEht4cvYZhj6eSEklbPzq+DWuSMMce6OS0DsOb4wI2AF2+npG086LQ5jSrSLnYr
         Ov7bxE/LcTOgQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E10C40468; Mon,  2 Jan 2023 12:34:53 -0300 (-03)
Date:   Mon, 2 Jan 2023 12:34:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf tools: don't include signature in version
 strings
Message-ID: <Y7L5nfcAH1aTh8po@kernel.org>
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
 <7c9637711271f50ec2341fb8a7c29585335dab04.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c9637711271f50ec2341fb8a7c29585335dab04.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 27, 2022 at 09:58:00PM +0100, Ahelenia Ziemiańska escreveu:
> This explodes the build if HEAD is signed, since the generated version
> is gpg: Signature made Mon 26 Dec 2022 20:34:48 CET, then a few more
> lines, then the SHA.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo

> ---
>  tools/perf/Documentation/Makefile | 2 +-
>  tools/perf/util/PERF-VERSION-GEN  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> index 6e7b88917ca0..ba5d942e4c6a 100644
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -267,7 +267,7 @@ $(OUTPUT)%.xml : %.txt
>  	$(ASCIIDOC) -b docbook -d manpage \
>  		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
>  		-aperf_date=$(shell git log -1 --pretty="format:%cd" \
> -				--date=short $<) \
> +				--date=short --no-show-signature $<) \
>  		-o $@+ $< && \
>  	mv $@+ $@
>  
> diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> index 3cc42821d9b3..d7dc7c28508c 100755
> --- a/tools/perf/util/PERF-VERSION-GEN
> +++ b/tools/perf/util/PERF-VERSION-GEN
> @@ -19,7 +19,7 @@ TAG=
>  if test -d ../../.git -o -f ../../.git
>  then
>  	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> -	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> +	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" --no-show-signature 2>/dev/null) && CID="-g$CID"
>  elif test -f ../../PERF-VERSION-FILE
>  then
>  	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
> -- 
> 2.30.2



-- 

- Arnaldo
