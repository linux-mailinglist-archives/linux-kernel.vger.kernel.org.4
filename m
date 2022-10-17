Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32114601C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJQWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJQWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:19:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E69232
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:19:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HMJAlQ029343;
        Mon, 17 Oct 2022 17:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666045150;
        bh=e4dV8Xf9V3JOhebWVJUneiAZ21IQIOxq5WLonuNcyBI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DPbuAQ7dty+Oj5AlLPWqYxw+5ffO74+Jj8/l+/lPZS34QIWjf/GUlAI8uUiQnieuT
         C5wYApPlhZZSvcKdYFHuFgcbMwsWT+KQXjKzD2SdLPpdvtlHXWXiSQvoxUVbfgH9xU
         tDIB9K03nfFD79Kueab/jvQytz/jmZlg9O8ysgsY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HMJAJH047531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 17:19:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 17:19:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 17:19:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HMJAR2099232;
        Mon, 17 Oct 2022 17:19:10 -0500
Date:   Mon, 17 Oct 2022 17:19:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
CC:     <ssantosh@kernel.org>, <m-karicheri2@ti.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] drivers: soc: ti: mark knav_acc_firmwares as static
Message-ID: <20221017221909.ds24hrbivwap5cek@countable>
References: <20220927061951.103450-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927061951.103450-1-chenjiahao16@huawei.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:19-20220927, Chen Jiahao wrote:
> There is a sparse warning shown below:
> 
> drivers/soc/ti/knav_qmss_queue.c:70:12: warning: symbol
> 'knav_acc_firmwares' was not declared. Should it be static?
> 
> Since 'knav_acc_firmwares' is only called within knav_qmss_queue.c,
> mark it as static to fix the warning.
> 
> Fixes: 96ee19becc3b ("soc: ti: add firmware file name as part of the driver")
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  drivers/soc/ti/knav_qmss_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 92af7d1b6f5b..c466b98a0293 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -67,7 +67,7 @@ static DEFINE_MUTEX(knav_dev_lock);
>   * Newest followed by older ones. Search is done from start of the array
>   * until a firmware file is found.
>   */
> -const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};
> +static const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};

next-20221017 checkpatch suggests:

static const char * array should probably be static const char * const

Could you check to ensure we are clear here?
>  
>  static bool device_ready;
>  bool knav_qmss_device_ready(void)
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
