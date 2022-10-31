Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98B612FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJaFhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaFhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:37:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B67673
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=T0w8ULuDyhUzxWFGtdLWGl/ewEQE0OtdcowCqfo6WeA=; b=T/0p12qG95i6nUZEza6hIJNdwg
        0oomTKzWnqoox+ypNCTjuNN1oj/VGrHPrwrX0ooLYG0nq2DT94hhR5IE3rsIQ/tV5PdmvSzLWW4ln
        7vOGwGCC0Qa9gzt8AhpySjagNIYIiiiqVo0cUP2OLRXAwncKzHCb/scKqW39FusN2IgPWFAzbjbO/
        4NMzMvTke9/NPUvWdt3WIbH97+Cc1r7/GXiJnZQhrdSrzkpExsrgaY66XUHdENx0WFD+s3M+eI4Um
        q95mpsjTvJLchYvnJYnGs1Xj1la9eE5/eVGKVub4IXT4cpHLYZqwlJNePrNbdq0AjMRLYfcabW/cy
        nb97Q1Qg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opNTs-008MYF-OV; Mon, 31 Oct 2022 05:37:04 +0000
Message-ID: <93ffb3eb-8e79-2c71-cba6-db8109956e49@infradead.org>
Date:   Sun, 30 Oct 2022 22:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        hyun.kwon@xilinx.com
Cc:     laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        daniel@ffwll.ch, michal.simek@xilinx.com, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221031052621.121867-1-jiapeng.chong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221031052621.121867-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/22 22:26, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/gpu/drm/xlnx/zynqmp_dp.c:793: warning: expecting prototype for zynqmp_dp_link_train(). Prototype was for zynqmp_dp_train() instead.
> 

Note that this warning is from scripts/kernel-doc.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2666
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 7c9ae167eac7..176d752782df 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -784,7 +784,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
>  }
>  
>  /**
> - * zynqmp_dp_link_train - Train the link
> + * zynqmp_dp_train - Train the link
>   * @dp: DisplayPort IP core structure
>   *
>   * Return: 0 if all trains are done successfully, or corresponding error code.

-- 
~Randy
