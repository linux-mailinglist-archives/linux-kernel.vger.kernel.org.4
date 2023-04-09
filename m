Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B86DC081
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDIPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 11:12:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BC3A8B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 08:12:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34c299d8so15677966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681053168; x=1683645168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+F3m/Z1uNGrSrVyh1TkFgL4DP+S57DCP37l7qhIJQgc=;
        b=M1RAi9Y3eZ4oDqaOiEgfRPTe/gFBcbz7h93AcksETsvCtZ04/kx4YmzrlzVm/ifNwu
         MCw6qFNZE7iA5jmtIVXIcNLwlYMfAi+E63iZ93a7Ytms3b22G4ePknBKZDCe+Q3pVkql
         VM66Rosv6gKKASVmYOozZKyL7ALolz7ckIviCyEpfJJcHpmBjXQlOJhnvWxONOHzuNq7
         scmSYOLPLqzOiUxkLdmhX3OVRXmtY4LC3F4GQqyt245bn44/7xEuG+Q40g6EMBzvI5ZE
         b10UhGc13YUmGnL/gaddvWvVTW/vT9WxZWfMni2/nzZA6tFS+e030DPw0NAtdCbY0GTD
         iE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681053168; x=1683645168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F3m/Z1uNGrSrVyh1TkFgL4DP+S57DCP37l7qhIJQgc=;
        b=Ehg7/N2DAJdxJrTr+3TAnCfKokgblf7eHzbDRHbk1mmgi9uyb67s2NiEG+ewrAjqic
         B368T92tHPxBw3BgSmhlTOEqhrwbTYHACtjHCzpXOifK2v0ZAKTure325mFW80+dLPJe
         EECvFWg9HWTMIz5TNXJBC5AQRSa+Tr753qrBFupJ2dsQsT2+c93A4NwWQAHYrDVcZ/qw
         F2Z+glZyQ/FT+VCSvwGlWc4mU95lMlF+Y199oN1G2eup621JH26rMhATunLHuGhcOniO
         3IyWV06WUTDMMkd1hcnerxOYfqt4yHTYdY5P7bMzERuXhr8YzDN5kAteqYWZdsrSJK20
         9HAg==
X-Gm-Message-State: AAQBX9cjLQ4Q/GuFKROeLBwT80z5q0s79Ssq56Ybim1XbCQE5ijPuIId
        16NB9+NzHpBZ6wAKNHovltI=
X-Google-Smtp-Source: AKy350aXdP/4zcTH5rfZ8DrW36jFFGlRTxXaKkWpBLRu6s7JDmhShcva6dhqne+aieO/JmSVru2nIQ==
X-Received: by 2002:a17:906:10c7:b0:947:f415:db23 with SMTP id v7-20020a17090610c700b00947f415db23mr4727852ejv.1.1681053167642;
        Sun, 09 Apr 2023 08:12:47 -0700 (PDT)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id dd20-20020a1709069b9400b009475bf82935sm4177550ejc.31.2023.04.09.08.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 08:12:47 -0700 (PDT)
Message-ID: <004210bd-0ed1-58d5-0315-47499c850444@gmail.com>
Date:   Sun, 9 Apr 2023 17:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] staging: rtl8192e: Fix comparison to NULL of variable
 rf_set_sens
To:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZDK5UvVHa96ejEfU@Zephyrus-G14>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZDK5UvVHa96ejEfU@Zephyrus-G14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/23 15:10, Yogesh Hegde wrote:
> Fix comparision to NULL of variable rf_set_sens as per Linux kernel
> coding-style. These issues were reported by checkpatch.pl.
> 
> CHECK: Comparison to NULL could be written "priv->rf_set_sens"
> CHECK: Comparison to NULL could be written "!priv->rf_set_sens"
> 
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index cb28288a618b..a67edb81a820 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -311,7 +311,7 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
>   	/* ~130 Mb/s real (802.11n) */
>   	range->throughput = 130 * 1000 * 1000;
>   
> -	if (priv->rf_set_sens != NULL)
> +	if (priv->rf_set_sens)
>   		/* signal level threshold range */
>   		range->sensitivity = priv->max_sens;
>   
> @@ -813,7 +813,7 @@ static int _rtl92e_wx_get_sens(struct net_device *dev,
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   
> -	if (priv->rf_set_sens == NULL)
> +	if (!priv->rf_set_sens)
>   		return -1; /* we have not this support for this radio */
>   	wrqu->sens.value = priv->sens;
>   	return 0;
> @@ -831,7 +831,7 @@ static int _rtl92e_wx_set_sens(struct net_device *dev,
>   		return 0;
>   
>   	mutex_lock(&priv->wx_mutex);
> -	if (priv->rf_set_sens == NULL) {
> +	if (!priv->rf_set_sens) {
>   		err = -1; /* we have not this support for this radio */
>   		goto exit;
>   	}


I would like you to do more.
I you search for rf_set_sens you will see that it is declared as a function.
But there is no definition of the function which will cause an oops when 
this function is called.

Because there is no definition of the function the priv->rf_set_sens 
will result always NULL

Bye Philipp
