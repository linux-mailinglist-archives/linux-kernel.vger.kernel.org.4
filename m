Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8060C503
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiJYHZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiJYHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:25:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2333107CE6;
        Tue, 25 Oct 2022 00:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 154B8B81BAC;
        Tue, 25 Oct 2022 07:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CEFC433D6;
        Tue, 25 Oct 2022 07:25:40 +0000 (UTC)
Message-ID: <74c5d15e-b03c-9073-7a82-787c5eb20a6e@xs4all.nl>
Date:   Tue, 25 Oct 2022 09:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] MAINTAINERS: Change email for Venus driver
Content-Language: en-US
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221025072155.2823985-1-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221025072155.2823985-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/22 09:21, Stanimir Varbanov wrote:
> My email at linaro.org will be deactivated, change it with
> my private email.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df5969d88707..516b2dc69db1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17153,7 +17153,7 @@ F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>  F:	drivers/thermal/qcom/
>  
>  QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
> -M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
> +M:	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
>  M:	Vikash Garodia <quic_vgarodia@quicinc.com>
>  L:	linux-media@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
