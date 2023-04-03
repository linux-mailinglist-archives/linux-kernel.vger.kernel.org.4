Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A376D5043
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjDCS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjDCS0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DDE170A;
        Mon,  3 Apr 2023 11:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52AAD625BD;
        Mon,  3 Apr 2023 18:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E35DC433D2;
        Mon,  3 Apr 2023 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546397;
        bh=9cTbP+OwoBmN9lO7JnS56Gimu901xUlOBcJBWXc836g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5r4/M7Vm7P7FUqKuVcFelGPTC8sFySfyH5iBCpaUzJ2L4I+y6RbVwW+++vwx7l7r
         A/DimKxXuLS8iBKzRW7vBMh0tViOSXMfSz1i1qbq9kldUMOsE8Pqi4nEo+rq6YpkaR
         dglxEiC90tvw1WZDm3DYpWNdU85NT1q1XI+PW6OUIUH4+9GABf06kkCHICtBcGh6/3
         sfEvu9t3B2HsM/+LAFEdRgKMwrulib1fP2ImcW3nkeABf9e4O6UvYtma4T7qH2fwhb
         LSjovmMIIw9SO+2vHWfzKlTwynDwx88d0B81fCQXLDW9xSAOuBsbcMbbKp2/uRPrhG
         xPTNcl5LD18SQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C8004052D; Mon,  3 Apr 2023 15:26:35 -0300 (-03)
Date:   Mon, 3 Apr 2023 15:26:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Two small fixes for stable
Message-ID: <ZCsaW/uqxR2cN6b3@kernel.org>
References: <20230403154831.8651-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403154831.8651-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 06:48:29PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are 2 small fixes for stable.
> 
> 
> Adrian Hunter (2):
>       perf auxtrace: Fix address filter entire kernel size
>       perf intel-pt: Fix CYC timestamps after standalone CBR

Thanks, applied.

- Arnaldo

 
>  tools/perf/util/auxtrace.c                          | 5 ++++-
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
