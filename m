Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135E605B11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJTJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJTJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:24:58 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A373732BA1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AygbfjnKnB+/RDS1GNl/7N5AgIDAmqmAzOgJPCJ0Cqw=;
  b=uDVC7WsR4KlqUZexSOGg9BjKogYc6Mn3lWRYiiJc5mg1ACGnSBcosMxP
   FetlqLPEAr1lXpeFxYKMobVhgEpeJ8srZ1n95nLzCBUJQQxe8OEPcQllr
   rtoM1yCLzbHJOWFbwiBEM/8B5SEAZdtTvdlPxRzsEEZBKTahEc6OAesk+
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66133235"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:24:52 +0200
Date:   Thu, 20 Oct 2022 11:24:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v3 05/10] staging: r8188eu: correct misspelled words in
 comments
In-Reply-To: <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com>
Message-ID: <d89421f-7546-f33-e621-815b428b71d8@inria.fr>
References: <cover.1666249715.git.drv@mailo.com> <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com>
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



On Thu, 20 Oct 2022, Deepak R Varma wrote:

> Incorrectly spelled words should be corrected as per the Linux
> coding-style guidelines.

This seems a bit verbose.  I think that spelling mistakes should just be
fixed, and the need for fixes shouldn't have to rely on style guidelines.

Fix spelling mistakes in code comments across the driver.

> @@ -4615,7 +4615,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
>  	return ret;
>  }
>
> -/*  if psta == NULL, indiate we are station(client) now... */
> +/*  if psta == NULL, indicate we are station(client) now... */

Does station plat the role of a function call?  If (client) is just giving
some extra information there should eb a space before the (.

>  void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short status)
>  {
>  	struct xmit_frame *pmgntframe;
> @@ -5014,7 +5014,7 @@ void issue_assocreq(struct adapter *padapter)
>  				if (!padapter->registrypriv.wifi_spec) {
>  					/* Commented by Kurt 20110629 */
>  					/* In some older APs, WPS handshake */
> -					/* would be fail if we append vender extensions informations to AP */
> +					/* would be fail if we append vender extensions information to AP */

envder -> vendor
extensions -> extension

> @@ -5344,7 +5344,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
>  	return ret;
>  }
>
> -/* when wait_ms > 0 , this function shoule be called at process context */
> +/* when wait_ms > 0 , this function should be called at process context */

Unnecessary space before the comma.

> @@ -6058,7 +6058,7 @@ void site_survey(struct adapter *padapter)
>  		} else {
>  			/*  20100721:Interrupt scan operation here. */
>  			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
> -			/*  It compares the scan result and select beter one to do connection. */
> +			/*  It compares the scan result and select better one to do connection. */

select -> selects a

> +++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> @@ -94,7 +94,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
>  /**
>  * Function:	phy_RFSerialRead
>  *
> -* OverView:	Read regster from RF chips
> +* OverView:	Read register from RF chips

Not sure why View is capitalized.

julia
