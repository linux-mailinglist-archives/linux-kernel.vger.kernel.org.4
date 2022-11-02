Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59C616996
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiKBQqn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Nov 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiKBQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:46:26 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FB72ED48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:42:50 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 240C612048C;
        Wed,  2 Nov 2022 16:42:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 0960E1A;
        Wed,  2 Nov 2022 16:42:26 +0000 (UTC)
Message-ID: <bfc8e714fbe80a16428a447768def5764083526d.camel@perches.com>
Subject: Re: [PATCH V4 1/2] staging: vt6655: change the function name
 s_vFillRTSHead
From:   Joe Perches <joe@perches.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Date:   Wed, 02 Nov 2022 09:42:44 -0700
In-Reply-To: <5a0649c6019f1717cb2e2e8fc4e262f3747d73a5.1667397591.git.tanjubrunostar0@gmail.com>
References: <cover.1667397591.git.tanjubrunostar0@gmail.com>
         <5a0649c6019f1717cb2e2e8fc4e262f3747d73a5.1667397591.git.tanjubrunostar0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: txy8sj8bu5swc3afcnas4766rwkdzdge
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0960E1A
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/mxU+0uLylN+8cO5mkEBniTdxtqfnLOpM=
X-HE-Tag: 1667407346-556323
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-02 at 14:08 +0000, Tanjuate Brunostar wrote:
> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
[]
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
[]
> @@ -23,7 +23,7 @@
>   *      s_uGetTxRsvTime- get frame reserved time
>   *      s_vFillCTSHead- fulfill CTS ctl header
>   *      s_vFillFragParameter- Set fragment ctl parameter.
> - *      s_vFillRTSHead- fulfill RTS ctl header
> + *      fill_rts_header- fulfill RTS ctl header
>   *      s_vFillTxKey- fulfill tx encrypt key
>   *      s_vSWencryption- Software encrypt header
>   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
>  #define DATADUR_A_F1    13
>  
>  /*---------------------  Static Functions  --------------------------*/
> -static void s_vFillRTSHead(struct vnt_private *pDevice,
> -			   unsigned char byPktType,
> -			   void *pvRTS,
> -			   unsigned int	cbFrameLength,
> -			   bool bNeedAck,
> -			   bool bDisCRC,
> -			   struct ieee80211_hdr *hdr,
> -			   unsigned short wCurrentRate,
> -			   unsigned char byFBOption);
> +static void fill_rts_head(struct vnt_private *pDevice,
> +			  unsigned char byPktType,
> +			  void *pvRTS,
> +			  unsigned int	cbFrameLength,
> +			  bool bNeedAck,
> +			  bool bDisCRC,
> +			  struct ieee80211_hdr *hdr,
> +			  unsigned short wCurrentRate,
> +			  unsigned char byFBOption);

Please compile the files modified by your patches _before_ submitting them.

Note the mismatch in your naming for this function prototype and the
actual function.

fill_rts_head vs fill_rts_header.

I believe this was already pointed out to you by the kernel robot.
