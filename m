Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D760C3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJYGec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJYGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:34:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E1BC9D;
        Mon, 24 Oct 2022 23:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F91B81710;
        Tue, 25 Oct 2022 06:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F135EC433D6;
        Tue, 25 Oct 2022 06:34:22 +0000 (UTC)
Message-ID: <c756d7f0-5c2a-a4dc-4ace-6824ef06d0b4@xs4all.nl>
Date:   Tue, 25 Oct 2022 08:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] MAINTAINERS: Add Vikash as VENUS video driver
 co-maintainer
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1663070940-8165-1-git-send-email-quic_vgarodia@quicinc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1663070940-8165-1-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/22 14:09, Vikash Garodia wrote:
> For the past several amendments in video driver, I have been working
> with Stanimir in multiple design discussions or handling a given
> issue. With this, adding myself as a co-maintainer.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 936490d..d3ef64f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16969,6 +16969,7 @@ F:	drivers/thermal/qcom/
>  
>  QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>  M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
> +M:	Vikash Garodia <quic_vgarodia@quicinc.com>
>  L:	linux-media@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
