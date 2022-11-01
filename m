Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC44D6149A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKALlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKALlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:41:23 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683991FFA7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GG6G19Dw61h46cRqgKoqpHdx8HuhrH5txfbi2tDzYa0=;
  b=o50ZRsW5a6aRqDm2z0d+OD1yrE5QszV6+XSLcDHVWyDU3J4A9E2t3yK7
   RqT8PNLupgvRAySYQACD155IrfZT29vcZGouRsAJJR9huwFyriFMoa/IJ
   Q4IfZr0vLt3+vUvdShbec7eVXjMnwWABPr2mUmETbGpAg28zkWS8+LE3/
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="36170369"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:33:40 +0100
Date:   Tue, 1 Nov 2022 12:33:38 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 2/2] Join some lines of code to avoid a line ending in
 a (
In-Reply-To: <1da74119d5a50ef97e68f26c82c9c9e429f8d0ec.1667300134.git.tanjubrunostar0@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2211011232540.2834@hadrien>
References: <cover.1667300134.git.tanjubrunostar0@gmail.com> <1da74119d5a50ef97e68f26c82c9c9e429f8d0ec.1667300134.git.tanjubrunostar0@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2022, Tanjuate Brunostar wrote:

> The code line ends with a '(' which is not allowed in
> Linux kernel coding. Joining the lines and indenting
> correctly improves visibility

I think Greg discouraged saying "not allowed by the coding style" and
instead encouraged thinking about the reason why the thing is not a good
idea and the change is helpful.

julia

>
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index d7e439cd8675..df7473155704 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -555,19 +555,15 @@ s_uFillDataHead(
>  	return buf->duration;
>  }
>
> -static
> -void
> -s_vFillRTSHead(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	void *pvRTS,
> -	unsigned int cbFrameLength,
> -	bool bNeedAck,
> -	bool bDisCRC,
> -	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -)
> +static void fill_rts_head(struct vnt_private *pDevice,
> +			  unsigned char byPktType,
> +			  void *pvRTS,
> +			  unsigned int cbFrameLength,
> +			  bool bNeedAck,
> +			  bool bDisCRC,
> +			  struct ieee80211_hdr *hdr,
> +			  unsigned short wCurrentRate,
> +			  unsigned char byFBOption)
>  {
>  	unsigned int uRTSFrameLen = 20;
>
> --
> 2.34.1
>
>
>
