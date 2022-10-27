Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838896102D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiJ0UkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiJ0UkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:40:01 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39C1D308;
        Thu, 27 Oct 2022 13:39:59 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id y4so2846248plb.2;
        Thu, 27 Oct 2022 13:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igCEirZkjGnysMNxaCnAGHz7NSNpQIufS9WcgJf9YiA=;
        b=bw2UCSPC8UKTlpQLCd+9HyUV7USGA/U53ZNnz9Lhoga22BYvTxk5UBrt4IMET/ejhT
         Rx/GAimz44wNhNGRe+0fiRhDUJrhczlaGTd0DPc6o9jGIrNSvpG1xws7FAWYEwIPZxNL
         tpC52B3nHRm7OmzU4W6unBuCuW5n8ky5KUbJiedWyxrBDbjZhB4v7zv2x49Szta2FW/k
         jh06jRQaw8v8RMkno0U/IKOHWo3YinJCJp3P+lAj2/uAa8ll9IIp4zOe/mWk3o6uwP6V
         b0SJVhsiydcFcJzW3ZHSjXlyPTPyRhIfJfdwT35GjvJ9qizPH78bkUjwSKE30yfSzenw
         9Bsw==
X-Gm-Message-State: ACrzQf1KTByNM6kCeRJSGkwcW8ImzUqXE7+R/S+9OQRLf/VRMicfUutp
        mKVSgWR4FY3Cnk4JaINAT10=
X-Google-Smtp-Source: AMsMyM7KyIH3GWx1kAkRRS59NExx5TXr1fJhAIPyqImG3pT/K78xrFSz8VUlh7/2jFEOo4CitslglA==
X-Received: by 2002:a17:90a:ba85:b0:212:d644:fc28 with SMTP id t5-20020a17090aba8500b00212d644fc28mr12394844pjr.72.1666903199087;
        Thu, 27 Oct 2022 13:39:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902780900b0018544ad1e8esm1560072pll.238.2022.10.27.13.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:39:58 -0700 (PDT)
Message-ID: <87a0d265-f9b3-dbc6-edff-396c5a354f92@acm.org>
Date:   Thu, 27 Oct 2022 13:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: ufs: core: Use 'else' in ufshcd_hba_enable()
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
 <20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
Content-Language: en-US
In-Reply-To: <20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 23:20, Keoseong Park wrote:
> Convert if (!ret) { ... } if (ret) { ... } into
> if (!ret) { ... } else { ... }.
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7256e6c43ca6..3b794be53287 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4670,7 +4670,7 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
>   			ret = ufshcd_dme_enable(hba);
>   			if (!ret)
>   				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
> -			if (ret)
> +			else
>   				dev_err(hba->dev,
>   					"Host controller enable failed with non-hce\n");
>   		}

If ufshcd_hba_enable() is modified it should be converted into the widely
used "if error return" style. How about the untested patch below?

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 05feec10fad3..89f8b86c3f85 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4668,14 +4668,16 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
  		/* enable UIC related interrupts */
  		ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
  		ret = ufshcd_dme_reset(hba);
-		if (!ret) {
-			ret = ufshcd_dme_enable(hba);
-			if (!ret)
-				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
-			if (ret)
-				dev_err(hba->dev,
-					"Host controller enable failed with non-hce\n");
+		if (ret) {
+			dev_err(hba->dev, "DME_RESET failed\n");
+			return ret;
+		}
+		ret = ufshcd_dme_enable(hba);
+		if (ret) {
+			dev_err(hba->dev, "Enabling DME failed\n");
+			return ret;
  		}
+		ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
  	} else {
  		ret = ufshcd_hba_execute_hce(hba);
  	}
