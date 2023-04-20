Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF576E89BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjDTFu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDTFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:50:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF53AAC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:50:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33K5o4Rr064066;
        Thu, 20 Apr 2023 00:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681969804;
        bh=/RtS1OSSqfE7MKMq9mwU/Yg+d2QJHbYSzq86zRaow9I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eUzGQt5pSZTCP4bDTlA1julcLc0mofA0tPf3psfVja05Q1cve7GIuHqPY/GVkWg9v
         QBHMqQ/neJ1MvgoLgA8SEJOYfepPEFjC+np+i7LVBQZO9BOmSBMsn0PAdxCS3huYsm
         G2rbXmb3CzxGLslxlMAq7z/dBcgn8WnIwx2kMd4Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33K5o4Z8130720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Apr 2023 00:50:04 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 20
 Apr 2023 00:50:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 20 Apr 2023 00:50:03 -0500
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33K5o0q6019850;
        Thu, 20 Apr 2023 00:50:00 -0500
Message-ID: <f6c92e55-93f5-e5c6-e5ca-4c24fd59f245@ti.com>
Date:   Thu, 20 Apr 2023 11:19:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] soc: ti: pruss: Avoid cast to incompatible function type
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <llvm@lists.linux.dev>
References: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 17:11, Simon Horman wrote:
> Rather than casting clk_unregister_mux to an incompatible function
> type provide a trivial wrapper with the correct signature for the
> use-case.
> 
> Reported by clang-16 with W=1:
> 
>  drivers/soc/ti/pruss.c:158:38: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>          ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/soc/ti/pruss.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 6882c86b3ce5..e68441bd7b30 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -38,6 +38,11 @@ static void pruss_of_free_clk_provider(void *data)
>  	of_node_put(clk_mux_np);
>  }
>  
> +static void pruss_clk_unregister_mux(void *data)
> +{
> +	clk_unregister_mux(data);
> +}
> +
>  static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  			       char *mux_name, struct device_node *clks_np)
>  {
> @@ -93,8 +98,7 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  		goto put_clk_mux_np;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
> -				       clk_mux);
> +	ret = devm_add_action_or_reset(dev, pruss_clk_unregister_mux, clk_mux);
>  	if (ret) {
>  		dev_err(dev, "failed to add clkmux unregister action %d", ret);
>  		goto put_clk_mux_np;
> 
> 
> From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91400C77B78
> 	for <linux-arm-kernel@archiver.kernel.org>; Tue, 18 Apr 2023 11:42:44 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> 	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
> 	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
> 	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
> 	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
> 	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
> 	List-Owner; bh=+CAO6uf34Wr1geK3ZRBtb0JAI43xTLZvVoAx3bYFR8o=; b=cuIUNZeFjlNWar
> 	n1qXrpSC2BWjTp1I6lb3nOHEvktz/aw4F5DEvvoNHxGvFGjKOkNVCOZ8kbNaPmbgN+kTATZka4FkF
> 	qQ/sW/CVCX/kWrwG1Wp/Q0rQfY1gO9+SaQEKNFvIM/RKK/G/9IP0kk2vQDjozKlCG52ka8uzTU5/Y
> 	mv5rKIYXf6KAsCH8KNxykQvIo5vCnaRzOIh/DGnFsuCdD0ShIuf1ymQBmFmg6rpXtTNBaiEU9asnR
> 	JbTngu0Ike23z2CkRSjpjDU7yULHoaUcp0FELF8NnkX5bbbKsPpjww949637SS7v9pEs11L7pNeDi
> 	lW4G7+LEEpL2z2yRkAPQ==;
> Received: from localhost ([::1] helo=bombadil.infradead.org)
> 	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
> 	id 1pojif-001zZA-2v;
> 	Tue, 18 Apr 2023 11:41:57 +0000
> Received: from dfw.source.kernel.org ([139.178.84.217])
> 	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
> 	id 1pojid-001zYi-0s
> 	for linux-arm-kernel@lists.infradead.org;
> 	Tue, 18 Apr 2023 11:41:56 +0000
> Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by dfw.source.kernel.org (Postfix) with ESMTPS id B371562AB8;
> 	Tue, 18 Apr 2023 11:41:54 +0000 (UTC)
> Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D70C433EF;
> 	Tue, 18 Apr 2023 11:41:52 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
> 	s=k20201202; t=1681818114;
> 	bh=HDO76kSQTCd/EdXhW03QxEZMNUJlfvxdzP1GEo8IYVg=;
> 	h=From:Date:Subject:To:Cc:From;
> 	b=JZMzw7vBy3kF7tUHrf3heWahdw/+GlTfSbSfX4l8BXBY+xlpkYbzXBZF6yUtnZ6ei
> 	 X9heGXlXJ7Qjq+ln6+s1947UlK8OkkZ8GO5SvG5L6ek9ceYzedjuzvPZfxymikoQY+
> 	 e3xN7D2jgVVu7zVcX2rgraJ86iVq7G62fX9TnTnZ3cy6CQpj1mkPaQSTd0FJ09djlq
> 	 Ott8fvgXVB18h1Z2jWGiQOs3a4y7x0d+smz5RcKCOs2Qm6EWCicR19vJHHrpjqh3Yd
> 	 Wycn9PVVKILWspPmYdQLWAj2UTH539mJEdC3MrBHQG5XKAoYZ45uelHZwLuE+fL9gI
> 	 hj7mkdKhM7mmg==
> From: Simon Horman <horms@kernel.org>
> Date: Tue, 18 Apr 2023 13:41:48 +0200
> Subject: [PATCH] soc: ti: pruss: Avoid cast to incompatible function type
> MIME-Version: 1.0
> Message-Id: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
> X-B4-Tracking: v=1; b=H4sIAPuBPmQC/x2N0QqDMAwAf0XyvICtE8d+ZeyhjekMlk4SHAPx3
>  xf2eAfHHWCswgb37gDlj5i8m0O4dEBLai9GmZ0h9nHor+GGm+5mSHVFyljGkOfINA1jAU9yMsa
>  sqdHiUdtrdbkpF/n+H4/nef4A+lxSD3MAAAA=
> To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>, 
>  Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
>  linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
>  llvm@lists.linux.dev, Simon Horman <horms@kernel.org>
> X-Mailer: b4 0.12.2
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
> X-CRM114-CacheID: sfid-20230418_044155_365668_53307A20 
> X-CRM114-Status: GOOD (  11.38  )
> X-BeenThere: linux-arm-kernel@lists.infradead.org
> X-Mailman-Version: 2.1.34
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org
> 
> Rather than casting clk_unregister_mux to an incompatible function
> type provide a trivial wrapper with the correct signature for the
> use-case.
> 
> Reported by clang-16 with W=1:
> 
>  drivers/soc/ti/pruss.c:158:38: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>          ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

> ---
>  drivers/soc/ti/pruss.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 6882c86b3ce5..e68441bd7b30 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -38,6 +38,11 @@ static void pruss_of_free_clk_provider(void *data)
>  	of_node_put(clk_mux_np);
>  }
>  
> +static void pruss_clk_unregister_mux(void *data)
> +{
> +	clk_unregister_mux(data);
> +}
> +
>  static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  			       char *mux_name, struct device_node *clks_np)
>  {
> @@ -93,8 +98,7 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  		goto put_clk_mux_np;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
> -				       clk_mux);
> +	ret = devm_add_action_or_reset(dev, pruss_clk_unregister_mux, clk_mux);
>  	if (ret) {
>  		dev_err(dev, "failed to add clkmux unregister action %d", ret);
>  		goto put_clk_mux_np;
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Thanks and Regards,
Danish.
