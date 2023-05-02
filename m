Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648E6F4B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjEBU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEBU2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:28:50 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057521996;
        Tue,  2 May 2023 13:28:49 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-63b51fd2972so3084754b3a.3;
        Tue, 02 May 2023 13:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059328; x=1685651328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbDeJmwqlhx/Uc/BoBY+MH9m48arvcLqRsgyaqRFpYo=;
        b=BENuPsWF9gUgg/2bCvwBIXdNUzVy07DMsDRxpWNu2mbLuZssbY3lB2QtUDhgNqoynN
         f+oQwRCeWJoKGrwqaa7IFjakJvl9Bb4iSCnrtynGy/77guJ46aTnNsX2IJct+Tv+Kw2t
         rU8+Djnpzj2w3BXH40XMZvj4wQc+rvjEbT46NMWvfRs7tx2KUpDJ3lzUY6KL+1r0ZtPp
         Gz3tWpNW0+PTQBEOWrvrbSdx7mNcSS+J0QQfAPL1MHiFFiSWBQdlSg1QeFokgL+Gmq7R
         g3QVVSU/pSgPSnbPYxtych4Mb3q/8IlyXaSdOs1VkUPcJ1vwMvzc6iJ8RAoZ9z+WxjxV
         Q4bQ==
X-Gm-Message-State: AC+VfDzWfAEHnQNMgebyY06Wvw2TTQj6FLZxx3OZhe11HlzApBQbY7nI
        aEdm7ACsxibFujNim7JT+V4=
X-Google-Smtp-Source: ACHHUZ7ju2RgE6ExuoCnUXJCR3+ngQ3XGa0VOc0I0/8HlKzKRgZ7xBJbT/Odu3V55q3Z3hcDcc7bhg==
X-Received: by 2002:a05:6a20:958d:b0:ef:e240:b559 with SMTP id iu13-20020a056a20958d00b000efe240b559mr20943594pzb.46.1683059328249;
        Tue, 02 May 2023 13:28:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a0c8d00b00246b1b4a3ffsm8200159pja.0.2023.05.02.13.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:28:47 -0700 (PDT)
Message-ID: <28ea2183-d1ce-f42d-1765-9d07d7481eda@acm.org>
Date:   Tue, 2 May 2023 13:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] scsi: ufs: core: Use readable 'return 0' in
 ufshcd_hba_capabilities()
Content-Language: en-US
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
 <20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 04:31, Keoseong Park wrote:
> The 'err' variable is the result of ufshcd_hba_init_crypto_capabilities()
> regardless of MCQ capabilities. Return 'err' immediately when the function
> error occurs. And if it is not an error, explicitly return 0.
> 
> Anyway, if ufshcd_hba_init_crypto_capabilities() returns error, MCQ
> capabilities is not used because it fails to initialize UFS driver.
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 9434328ba323..44328eb4158d 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2343,18 +2343,20 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>   
>   	/* Read crypto capabilities */
>   	err = ufshcd_hba_init_crypto_capabilities(hba);
> -	if (err)
> +	if (err) {
>   		dev_err(hba->dev, "crypto setup failed\n");
> +		return err;
> +	}
>   
>   	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
>   	if (!hba->mcq_sup)
> -		return err;
> +		return 0;
>   
>   	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
>   	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
>   				     hba->mcq_capabilities);
>   
> -	return err;
> +	return 0;
>   }

The most important change in this patch is that ufshcd_hba_capabilities()
returns earlier if ufshcd_hba_init_crypto_capabilities() fails. Please
change the patch title such that it reflects this change instead of the
other less important change.

Thanks,

Bart.

