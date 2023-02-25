Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305A6A2B80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBYT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:28:00 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44593769C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f6R3HmduZHcf6R+sXIBtcJrtmGgHEVbOUtaiMM/BHsM=;
  b=VJTeoZLwU/jq1q1IuLexQNhSIjGfs5a+TNA7ObPcbwmaQYFIOfkZOybX
   8wknmymiYZOZ/ni9o8WJ/GwVjuUcROBq5MsbQ24JRx2NNRcO/mThq/s/A
   UebUvpSBsAbkw4zK/8xdEIHMRaG/ynQTg2xoXjExOzXGNkBPvcSX6F+w/
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345893"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 20:27:57 +0100
Date:   Sat, 25 Feb 2023 20:27:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Foley <pefoley2@pefoley.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: coccicheck: Avoid warning about spurious
 escape
In-Reply-To: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
Message-ID: <alpine.DEB.2.22.394.2302252027390.3036@hadrien>
References: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2023, Peter Foley wrote:

> e.g.
> grep: warning: stray \ before -
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Applied, thanks.

julia

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 2956fce8fa4f..fb492f032c5f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -18,7 +18,7 @@ fi
>  SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
>
>  USE_JOBS="no"
> -$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
> +$SPATCH --help | grep -e "--jobs" > /dev/null && USE_JOBS="yes"
>
>  # The verbosity may be set by the environmental parameter V=
>  # as for example with 'make V=1 coccicheck'
>
> ---
> base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
> change-id: 20230113-cocci-12936b2c06c3
>
> Best regards,
> --
> Peter Foley <pefoley2@pefoley.com>
>
