Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC17613A13
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiJaPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJaPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:32:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B11180D;
        Mon, 31 Oct 2022 08:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F724B8121B;
        Mon, 31 Oct 2022 15:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9496CC433D6;
        Mon, 31 Oct 2022 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230371;
        bh=W/KTX9O3WMqSWJzjJX7qBnBQU2fLvAJeSeblbFBof2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPDo0iSxflvw4UeTJUYWrggOhCr0UUI0hWCpExqIWn4TKHgAl8MWAH1NZPGIAc9mB
         xOukhyMqlT/JEcF6ShJB6Txt4cqw2QaiJvn77bjwfSdCPCPmWQSCssM8zMTTiCKZzb
         7oBnrGssrOIbcuNho++w3VS6j7j06nnS65PGClKvoocQFqc8L6h9iFr093xw/stki1
         WmELTn9xHGuh+n44w8vhJa+QvqBVHOaNGUYLZmSZbS3DTBETdqLMY8DIOctlUsBsGT
         uhvgfdqkpU1irUxu5a68fC3VKFXGsOSi+h2WGXoxZmKjPJ0UIVzaPXz0uOh3E1P4kP
         ipGJPJX8hJw4w==
Date:   Mon, 31 Oct 2022 15:32:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] mfd: qcom-pm8xxx: drop unused PM8018 compatible
Message-ID: <Y1/qnCyav/S35mRo@google.com>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-8-dac2dfaac703@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v4-8-dac2dfaac703@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Neil Armstrong wrote:

> The PM8018 compatible is always used with PM8921 fallback, so PM8018
> compatible can be safely removed from device ID table
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Tags should appear chronologically.

I've fixed this up and applied the patch, thanks.

> ---
>  drivers/mfd/qcom-pm8xxx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 2f2734ba5273..601106580e2e 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -497,7 +497,6 @@ static const struct pm_irq_data pm8821_data = {
>  };
>  
>  static const struct of_device_id pm8xxx_id_table[] = {
> -	{ .compatible = "qcom,pm8018", .data = &pm8xxx_data},
>  	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
>  	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
>  	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
> 

-- 
Lee Jones [李琼斯]
