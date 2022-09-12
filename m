Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA515B534D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 06:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiILEd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 00:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 00:33:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9DC2494F;
        Sun, 11 Sep 2022 21:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17FE8B80BA8;
        Mon, 12 Sep 2022 04:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F5BC4314D;
        Mon, 12 Sep 2022 04:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662957200;
        bh=S2TI/EtxQqFBH8LeQLbIhmIX+coZeNUose9GD+Vdcws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNabnSf0wY45ysxAws+9viKiB8NcNk1I5kWO7s8IBHVhBV/EQ9gK+SSUmq6f7ZU6s
         Eu7ybRYWZRfOcN0HOGF3DjjrImQ7yY0k5Rpj1SJ0GBOmAsyyaJ9nLe11e5bf8xaGaB
         jKHeI7YRQFNXSg1skZ25be5NRP07lCxag2CtWoi1aGGIsn/TcafxKMxGGCUr7H7/p5
         ETwGCRo2yHuq0H6MGq8ZXZhkEfHEE7kd9PME6wbBjMdNKEYHVbKhKSZlr085xZjGIZ
         diMRnu+pS63W1fmmaKSOs/6LclggaV5KoFQOig7dCDAJjJ8i+M8zxxrqN0huD3jd5S
         +u5FIZaDwXUfw==
Date:   Mon, 12 Sep 2022 10:03:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com
Subject: Re: [RESEND PATCH v5 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Message-ID: <Yx62jJX++/8xweb5@matsya>
References: <20220909204207.15820-1-quic_amelende@quicinc.com>
 <20220909204207.15820-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909204207.15820-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-22, 13:42, Anjelique Melendez wrote:
> Add support for the new "qcom,pmk8350-pon" comptaible string.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/power/reset/qcom-pon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 4a688741a88a..16bc01738be9 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
> -- 
> 2.35.1

-- 
~Vinod
