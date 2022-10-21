Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115A6070C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJUHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJUHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:16:31 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1611F9A12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cimr5WtQ9tNPFTNONr5qhR4LP3AfQdH7f2eD8pZdOCY=;
  b=Bez2ESF1q6bC6/NX60zHC7wp8DYR9fo+UEwxSf9BNpYgT4/td++rMlDd
   9DSTPnBX8FGrLskzxVR/1z8CpPH3KbDA3raVPtEiG3Y72KgEGZjip1Omv
   /HvU8SHxR6DU0nJBzXS0Xpc4Y5KwOoJVOlHdXCxEkdm/O1N+9ixcd1fkU
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,200,1661810400"; 
   d="scan'208";a="66310781"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 09:16:11 +0200
Date:   Fri, 21 Oct 2022 09:16:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
cc:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        forest@alittletooquiet.net, greg@kroah.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH 4/6] staging: vt6655: refactor long lines of code in
 s_vGenerateTxParameter
In-Reply-To: <605ec34c-202f-dcba-20f8-a0f2653b59dc@linux.microsoft.com>
Message-ID: <15b531fb-7e8b-3cf2-3e79-e266292922e@inria.fr>
References: <cover.1666288416.git.tanjubrunostar0@gmail.com> <03dd39114b1e5c029cd8022245403a079ff03ae7.1666288416.git.tanjubrunostar0@gmail.com> <605ec34c-202f-dcba-20f8-a0f2653b59dc@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Oct 2022, Praveen Kumar wrote:

> On 20-10-2022 23:57, Tanjuate Brunostar wrote:
> > fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++-----------
> >  1 file changed, 48 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index dc853b83459b..42f4261293ba 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> >  	}
> >
> >  	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
> > -		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
> > +		if (byFBOption != AUTO_FB_NONE && uDMAIdx !=
> > +		    TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
> >  			/* Auto Fall back */
> >  			struct vnt_cts_fb *buf = pvCTS;
> >  			/* Get SignalField, ServiceField & Length */
> > @@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> >
> >  			ether_addr_copy(buf->data.ra,
> >  					pDevice->abyCurrentNetAddr);
> > -		} else { /* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) */
> > +		} else {
> > +			/* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA &&
> > +			 * uDMAIdx != TYPE_BEACONDMA)
> > +			 */
> >  			struct vnt_cts *buf = pvCTS;
> >  			/* Get SignalField, ServiceField & Length */
> >  			vnt_get_phy_field(pDevice, uCTSFrameLen,
> > @@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> >  			/* Fill RsvTime */
> >  			struct vnt_rrv_time_rts *buf = pvRrvTime;
> >
> > -			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> > -			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
> > -			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> > -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > -			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > -
> > -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
> > +							       wCurrentRate);
> > +			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize,
> > +							       wCurrentRate);
> > +			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
> > +							       wCurrentRate);
> > +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> > +								wCurrentRate, bNeedACK);
> > +			buf->rrv_time_b =
> > +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> > +						      pDevice->byTopCCKBasicRate, bNeedACK);
> > +
> > +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> > +				       psEthHeader, wCurrentRate, byFBOption);
> >  		} else {/* RTS_needless, PCF mode */
> >  			struct vnt_rrv_time_cts *buf = pvRrvTime;
> >
> > -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > -			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > -			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
> > +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> > +								wCurrentRate, bNeedACK);
> > +			buf->rrv_time_b =
> > +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> > +						      pDevice->byTopCCKBasicRate, bNeedACK);
> > +			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize,
> > +							       wCurrentRate);
> >
> >  			/* Fill CTS */
> > -			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> > +			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
> > +				       bDisCRC, wCurrentRate, byFBOption);
> >  		}
> >  	} else if (byPktType == PK_TYPE_11A) {
> >  		if (pvRTS) {/* RTS_need, non PCF mode */
> > -			struct vnt_rrv_time_ab *buf = pvRrvTime;
> > +			struct vnt_rrv_time_ab *buf = pvRrvT
> > +				ime;
>
> I'm not sure if this patch is compiled ? In my understanding the recommendation is have the patch compiled and if possible basic sanity done (can discuss with respective maintainers if they can help / guide) before sending here. Please do the needful. Thanks.

In particular, always be sure that you have a .o file for the .c file that
you changed.  The safest is to first try just compiling the file:

make path/to/my/file.o

Some files can't be compiled in that way.  You may need to do, eg

make path/to/my/

instead, but then there is a risk that even if you have compiled the
directory, you have not actually compled the file that you changed.  So
always check for the .o file.

julia


>
> >
> > -			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> > -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > +			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
> > +							    wCurrentRate);
> > +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> > +							      wCurrentRate, bNeedACK);
> >
> >  			/* Fill RTS */
> > -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> > +				       psEthHeader, wCurrentRate, byFBOption);
> >  		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
> >  			struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> > +			buf->rrv_time =
> > +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
> > +						      wCurrentRate, bNeedACK);
> >  		}
> >  	} else if (byPktType == PK_TYPE_11B) {
> >  		if (pvRTS) {/* RTS_need, non PCF mode */
> >  			struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > -			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> > -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > +			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
> > +							    wCurrentRate);
> > +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> > +							      wCurrentRate, bNeedACK);
> >
> >  			/* Fill RTS */
> > -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> > +				       psEthHeader, wCurrentRate, byFBOption);
> >  		} else { /* RTS_needless, non PCF mode */
> >  			struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> > +							      wCurrentRate, bNeedACK);
> >  		}
> >  	}
> >  }
>
> Regards,
>
> ~Praveen.
>
>
