Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421B61F3C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiKGMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKGMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:54:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4041ADBB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:54:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2075560wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/gjDZ1YQuAcmh+CpxdZMBXAa/U5srszeLdkjriKYp8=;
        b=NTivC4ETZtU1/X5wyJLZC4F00LZcyxyp6iUGzeEP7hmotz6pr+yEv0LFjjLw9XXq0e
         X9m5nLTr38Nhsensx1D1EvPBAtc2jqbfE57V13cgCuWiPxiWhAh5ytiCiHgiARar0t7F
         /EBYDNtpe+d8F509xzyJDp3RfBQjiiWkwCOJE1AHQBTAKoGcf8VJ/CnTInXFNZuPzfEM
         BLcpRfypWkjm2V++ZnXNO4yUK6R/ETXupadcgdui5e5f05tlJHSdm6ywR28CHImkVnyM
         vbGUSP4Rth750H7l8Qb3JtoKS2qf1UaDkHQmOGFsnTXE0701fZeFTDr+Jo4Gjl9OTsmp
         qG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/gjDZ1YQuAcmh+CpxdZMBXAa/U5srszeLdkjriKYp8=;
        b=I9J7rlGkZ6jGx9bjpT/fes9pRY08aphiJaD1B6VI0a5rToEtFsFoIBd/OJRqNJFgAJ
         jX5YMWDb30AN3wDvCcWgfICsL5k7DEgaT8nnbftMc/sCHVXIiz64oceOPyoESPbFzsz5
         FGlt63G+yjQ8pLF7QfktHnT9AjC46lIO2HAsy6hsx0ieH5hIs+IvgHfy+KlcLFvbI3jy
         5S2wYPzhCr21njhZmmb+6Uzae+FEdhiILNRvaXupbgcx3aXQ2qhDO5Utk+LLwehL9CPx
         yBs+ZabgurExNSo0U2vH0VjrF+WFQlctqw1C15N5eu+9Fhjnm9CdYePLwABmncK4ngWc
         kxIA==
X-Gm-Message-State: ACrzQf2TJSkI/XaVaQ6H/QMxMMvoScCVp9WTWyO3/5WbR8TYGQJh1vcA
        fAjPvnjPmDPplNPbar4qJ/8=
X-Google-Smtp-Source: AMsMyM7v49Nb+m2ayKO03i9bfCDc5uGPlIaBmmQYN5ErSV36EtHAfWw6o0TPzeRNwHLxP78KaHbpLw==
X-Received: by 2002:a05:600c:4b27:b0:3cf:67ab:3ac6 with SMTP id i39-20020a05600c4b2700b003cf67ab3ac6mr31931942wmp.35.1667825665526;
        Mon, 07 Nov 2022 04:54:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b0023662d97130sm7218408wrx.20.2022.11.07.04.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:54:25 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:54:21 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: use a qos_hdr in
 validate_recv_data_frame
Message-ID: <Y2j//dFRONly9kU8@kadam>
References: <20221106170455.743058-1-martin@kaiser.cx>
 <20221106170455.743058-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106170455.743058-2-martin@kaiser.cx>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 06:04:53PM +0100, Martin Kaiser wrote:
> Define a struct ieee80211_qos_hdr in the validate_recv_data_frame
> function. Use this struct to replace some numeric offsets and make the
> code easier to understand.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index cb0f35d7ab98..245b931c483d 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1032,7 +1032,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
>  				    struct recv_frame *precv_frame)
>  {
>  	struct sta_info *psta = NULL;
> -	u8 *ptr = precv_frame->rx_data;
>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
>  	struct rx_pkt_attrib	*pattrib = &precv_frame->attrib;
>  	struct security_priv	*psecuritypriv = &adapter->securitypriv;
> @@ -1071,10 +1070,12 @@ static int validate_recv_data_frame(struct adapter *adapter,
>  	pattrib->ack_policy = 0;
>  	/* parsing QC field */
>  	if (pattrib->qos) {
> +		struct ieee80211_qos_hdr *qos_hdr = (struct ieee80211_qos_hdr *)hdr;
> +
>  		pattrib->priority = ieee80211_get_tid(hdr);
> -		pattrib->ack_policy = GetAckpolicy((ptr + 24));
> -		pattrib->amsdu = GetAMsdu((ptr + 24));
> -		pattrib->hdrlen = 26;
                               ^^^

> +		pattrib->ack_policy = GetAckpolicy(&qos_hdr->qos_ctrl);
> +		pattrib->amsdu = GetAMsdu(&qos_hdr->qos_ctrl);
> +		pattrib->hdrlen += sizeof(*qos_hdr);
                               ^^^^
Why did this change from "=" to "+="?

regards,
dan carpenter

