Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993CD610B32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ1HVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1HVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:21:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC9392CC3;
        Fri, 28 Oct 2022 00:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82630B81FC3;
        Fri, 28 Oct 2022 07:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E13DC433B5;
        Fri, 28 Oct 2022 07:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666941694;
        bh=ldtxaAYay6wYygiBjwGGXItQZodlkvcE8cVHtMo9FS8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JFMMmB+l7nc9LCK5MzHep3/DeBTWgUirBgn5kitkgrP6nc/tXBTcJNysSkF0fh+ko
         xI73+Z/PtIUb1BSPZ8W27IQtW0aiaLkcfP6BKsuzd9IXvEN+3g+WMgZV6dP30ceibK
         ReJ++1gySB6OOz8mzMV4H7GvsSF7PNsFY7cn8BIG6ubNP6XyPqKmeZaKeD9Q+ovFfa
         nocyZY/dapsuw5zHHVYbudYsyes723I2dLqZ6zKBYLoXIlejthXjFcFsBsEeW668GP
         MYGmLVnUu28QC1Y3UbOETpoRTn+7Ax6qSC21WNPNObQ0nD93zmrRvCQx5D0tX47yCA
         ynYLIzDvMwAoQ==
Message-ID: <ba254421-c721-87a8-11f8-e27b04782189@kernel.org>
Date:   Fri, 28 Oct 2022 10:21:30 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] interconnect: qcom: sc7180: fix dropped const of
 qcom_icc_bcm
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.22 18:48, Krzysztof Kozlowski wrote:
> Pointers to struct qcom_icc_bcm are const, but the change was dropped
> during merge.

Oops, thanks for the fix!

BR,
Georgi

> Fixes: 016fca59f95f ("Merge branch 'icc-const' into icc-next")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/interconnect/qcom/sc7180.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> index 35cd448efdfb..82d5e8a8c19e 100644
> --- a/drivers/interconnect/qcom/sc7180.c
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -369,7 +369,7 @@ static const struct qcom_icc_desc sc7180_gem_noc = {
>   	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
>   };
>   
> -static struct qcom_icc_bcm *mc_virt_bcms[] = {
> +static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>   	&bcm_acv,
>   	&bcm_mc0,
>   };

