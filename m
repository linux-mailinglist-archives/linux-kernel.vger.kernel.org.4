Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A80601017
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJQNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJQNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:18:57 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9B61D9B;
        Mon, 17 Oct 2022 06:18:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 584C51C0018;
        Mon, 17 Oct 2022 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666012732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AR6gsO3KItGs+h4qoIrNM9fVvOyOHbuFkGe+loBQDqo=;
        b=HIIwvvT6IvL65SaDL4XZUfSSG0BhY5o4T9I33GNOgwRebSOvDwbgUfICTQLT4iSNd4X1NJ
        a4u6ypmSh4TRYTykVfoJJ7x9qKK9y3mrM4Zt+uLofma3isuticm0CXdpkPlfVDGNRf9N/1
        GrvTfpWkQoiAuSjxOFFDUrWaYWV26rkqb+ObpvGeuRIaUrMkw+iXmu/4xFBXefQmhQ1ksa
        4cmHCKPWdUmQ25nrOwNBRY2GhBIrYP8dcfw79kRfFrCn2N4gFNFf/H1uAGWZRU6crlTwWp
        EcFcjOvLoYr/LseCzCHL8pVxmdWAgh7Xat0mmgdjYOBpQDbY4mCqDJ84gMI0eQ==
Date:   Mon, 17 Oct 2022 15:18:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 09/11] rtc: pm8xxx: drop unused pm8018 compatible
Message-ID: <Y01WO7IoSmPLgcfe@mail.local>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v3-9-531da552c354@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-9-531da552c354@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 11:45:34+0200, Neil Armstrong wrote:
> The PM8018 compatible is always used with PM8921 fallback, so PM8018
> compatible can be safely removed from device ID table
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-pm8xxx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index dc6d1476baa5..716e5d9ad74d 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -461,7 +461,6 @@ static const struct pm8xxx_rtc_regs pmk8350_regs = {
>   */
>  static const struct of_device_id pm8xxx_id_table[] = {
>  	{ .compatible = "qcom,pm8921-rtc", .data = &pm8921_regs },
> -	{ .compatible = "qcom,pm8018-rtc", .data = &pm8921_regs },
>  	{ .compatible = "qcom,pm8058-rtc", .data = &pm8058_regs },
>  	{ .compatible = "qcom,pm8941-rtc", .data = &pm8941_regs },
>  	{ .compatible = "qcom,pmk8350-rtc", .data = &pmk8350_regs },
> 
> -- 
> b4 0.10.1

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
