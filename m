Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242595FF3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJNSht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:37:45 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0F72940;
        Fri, 14 Oct 2022 11:37:41 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d24so5538308pls.4;
        Fri, 14 Oct 2022 11:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K03/LDbX9eB92joj+CT65ha22B4/UzgTMlmjnAboAzc=;
        b=j/tnA8idp2jE6pJ2MMtRUKqH12pF74qMJ4MdAtxbDNeqHeQ7bgoVNPPOHfC1FIHCOW
         Jf/ySqMDBOcF77lyPE5MWOAcF3YWy/ULQH9lJOzw4tQPrb4hZ6HXwAQXf57BTZkxBGns
         pCdTb8IiBZlJNyy80OGb1vQWGufx2rgtkKhDqy2m6Ef0z2nOnCTKjlPMd9VjFq81Jka1
         9RapTjKsGC5qFcWYOyZ5cTEhW1I+Sz7sUtqPNAZpEd/wexMRNo9A1qU/x3BklDJlHfea
         uEwHwHNPkk6E3D+R4PYQ3WYy0uf5ESdyWNMb8ofwpShU5OuIqf7gARVF8JJjgqyEubmH
         JVIw==
X-Gm-Message-State: ACrzQf3Whk+RWoc3DpVinBrLByJCbm7Fo6lqAscTiZK+bA8rz1Niy+ct
        QDkJpEWChIfz6R/awy+4kWY=
X-Google-Smtp-Source: AMsMyM4xIQi8dApWjum6v7as5ofEtCN2c8HFnvqgqQvGKQ7HWx2n98/GCR3r3LMT857/AAVmlYxQgA==
X-Received: by 2002:a17:90b:388e:b0:20d:4a1f:d5a2 with SMTP id mu14-20020a17090b388e00b0020d4a1fd5a2mr7053569pjb.135.1665772660154;
        Fri, 14 Oct 2022 11:37:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7bd3:5500:b9cd:d90d? ([2620:15c:211:201:7bd3:5500:b9cd:d90d])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79462000000b00540a8074c9dsm2050783pfq.166.2022.10.14.11.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:37:39 -0700 (PDT)
Message-ID: <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
Date:   Fri, 14 Oct 2022 11:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010092937.520013-1-beanhuo@iokpp.de>
 <20221010092937.520013-2-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221010092937.520013-2-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 02:29, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> LUs with WB potential support are properly checked in ufshcd_wb_probe()
> before calling ufshcd_read_unit_desc_param(), so remove this unnecessary
> if-checkup in ufs_is_valid_unit_desc_lun() to match its function definition.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>   drivers/ufs/core/ufshcd-priv.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index f68ca33f6ac7..2457b005101a 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -300,9 +300,6 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info,
>   		pr_err("Max General LU supported by UFS isn't initialized\n");
>   		return false;
>   	}
> -	/* WB is available only for the logical unit from 0 to 7 */
> -	if (param_offset == UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS)
> -		return lun < UFS_UPIU_MAX_WB_LUN_ID;
>   	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
>   }

Hi Bean,

I think the above patch reintroduces the stack overflow issue fixed by
commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to #7").

How about reverting commit a2fca52ee640 and fixing the stack overflow
issue in another way than by modifying ufs_is_valid_unit_desc_lun()?

Thanks,

Bart.


