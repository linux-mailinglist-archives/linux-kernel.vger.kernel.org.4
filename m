Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6A640120
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiLBHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiLBHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:39:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389CAD992
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:39:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id l127so3538534pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKdJy8iwYIrzA6eUcHS1xN++4Pj6b6rZ6Y+yBBYokW8=;
        b=Uw1oClizcn3XTQesSOqhOmB5uui3mQLM2nfnZLp7ch36IdWnVz33clXfk4pw4FoI/W
         XMkc7MJawfHhIBKsjA0b/bl1oSzxHbPhekaCKF/HdvEi+2F6lZ+R7V/YtSU/EtzoDwtv
         yFXYWYBmMWAPn/yQGpLx+AtN48qzfQA4/InfnhgC1EMYmzfSpJdu1x19LCBWOgXh2yp7
         IKui+F7vxprrEQ3XXvuyZgrTyDanXVjL0VI3Q1l+MTQLdB+UfSj7blpsnLxlK7IDS/ul
         M+dOR4h8DD9s3wn9qRi+N1ZmPnV7oKxB8TNvZkNJgVfNGNISX/ECEeyP4enPo8A5dvCJ
         HLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKdJy8iwYIrzA6eUcHS1xN++4Pj6b6rZ6Y+yBBYokW8=;
        b=RHfgyUGUjcAbkJ3s8K5XIkyYPQYbhuKVGrXFFTDyjGsGPDp0uLVUSxh/m4c/pfT3/H
         oDHc34zZDQWTMW8QTQoTxthiVdt/kozPPbTajNDVweLMRf1fMfEf64ndvJvhLWtmVGeY
         Ou1NnTpkwdB+tLOkDJj41TkQHhhUIfmcoDvcVv93mfg2moOo64b6Jd5Yv4FvCn+d+Qq/
         AuYxkUASdqzFHRgjVmw1FFxi6V7LV799sjxQDVHDCk587KpWT2NAGod8Ym5FFGDIfn9d
         wzXgc/tMgVGJ94GnFfL1c2NWqiWK6vvd/x8Sb8O/n8dI3e+g2QHZwTtfZfT/l4RcWFps
         /y6A==
X-Gm-Message-State: ANoB5pkbvyhSqOimIQGZz8SYfKu3sVHnm/ewxRM2Vgrgh0r9pOqiZ8KN
        LWsDk/C3Ks2bLLzNdidzzzNi
X-Google-Smtp-Source: AA0mqf4RHtpfIlj5JeeEw6Da3Yq5R9fgzfWHMLyg5+ZY64vcJqKkS0zVLdyfP/r8TE+O0RRrfjgcOw==
X-Received: by 2002:a62:840b:0:b0:575:2199:70e8 with SMTP id k11-20020a62840b000000b00575219970e8mr25115627pfd.14.1669966798480;
        Thu, 01 Dec 2022 23:39:58 -0800 (PST)
Received: from thinkpad ([27.111.75.154])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b001894198d0ebsm4849251plb.24.2022.12.01.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 23:39:57 -0800 (PST)
Date:   Fri, 2 Dec 2022 13:09:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] scsi: ufs: ufs-qcom: Remove usage of dbg_print_en
Message-ID: <20221202073951.GD5356@thinkpad>
References: <20221201230810.1019834-1-ahalaney@redhat.com>
 <20221201230810.1019834-4-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201230810.1019834-4-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:08:09PM -0600, Andrew Halaney wrote:
> This bitmask is unconditionally set in the current driver,
> so all conditionals using it can be considered bit rot.
> 
> Let's take the current default conditional path everywhere and remove
> dbg_print_en from the driver.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 18 +++---------------
>  drivers/ufs/host/ufs-qcom.h | 11 -----------
>  2 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 1b0dfbbdcdf3..b1fcff1fad0c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -22,9 +22,6 @@
>  #include <ufs/ufshci.h>
>  #include <ufs/ufs_quirks.h>
>  
> -#define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
> -	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
> -
>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -1040,7 +1037,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
>  		ufs_qcom_hosts[hba->dev->id] = host;
>  
> -	host->dbg_print_en |= UFS_QCOM_DEFAULT_DBG_PRINT_EN;
>  	ufs_qcom_get_default_testbus_cfg(host);
>  	err = ufs_qcom_testbus_config(host);
>  	if (err) {
> @@ -1191,14 +1187,9 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  
>  static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
>  {
> -	if (host->dbg_print_en & UFS_QCOM_DBG_PRINT_TEST_BUS_EN) {
> -		ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
> -				UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
> -		ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
> -	} else {
> -		ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN, 0, REG_UFS_CFG1);
> -		ufshcd_rmwl(host->hba, TEST_BUS_EN, 0, REG_UFS_CFG1);
> -	}
> +	ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
> +			UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
> +	ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
>  }
>  
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host)
> @@ -1315,9 +1306,6 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
>  	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
>  			 "HCI Vendor Specific Registers ");
>  
> -	if (!(host->dbg_print_en & UFS_QCOM_DBG_PRINT_REGS_EN))
> -		return;
> -
>  	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_REG_OCSC);
>  	ufshcd_dump_regs(hba, reg, 44 * 4, "UFS_UFS_DBG_RD_REG_OCSC ");
>  
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 44466a395bb5..e567e4636357 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -113,15 +113,6 @@ enum {
>  	MASK_CLK_NS_REG                     = 0xFFFC00,
>  };
>  
> -/* QCOM UFS debug print bit mask */
> -#define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
> -#define UFS_QCOM_DBG_PRINT_ICE_REGS_EN	BIT(1)
> -#define UFS_QCOM_DBG_PRINT_TEST_BUS_EN	BIT(2)
> -
> -#define UFS_QCOM_DBG_PRINT_ALL	\
> -	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_ICE_REGS_EN | \
> -	 UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
> -
>  /* QUniPro Vendor specific attributes */
>  #define PA_VS_CONFIG_REG1	0x9000
>  #define DME_VS_CORE_CLK_CTRL	0xD002
> @@ -212,8 +203,6 @@ struct ufs_qcom_host {
>  
>  	u32 dev_ref_clk_en_mask;
>  
> -	/* Bitmask for enabling debug prints */
> -	u32 dbg_print_en;
>  	struct ufs_qcom_testbus testbus;
>  
>  	/* Reset control of HCI */
> -- 
> 2.38.1
> 

-- 
மணிவண்ணன் சதாசிவம்
