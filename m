Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA955BE79F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiITNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiITNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413F445984
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e16so4400506wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=gmezfN1Xisi/Y28D8CBgw2JKxBcXRNXAGwUqlEq0780=;
        b=TticrSrHXNVtW1E2+32pVgMqJhmUwukqjyuyFRmS50udd03bwD90/L6anJgm2u++79
         lKURGQXHweyVFQsGGzU6B0LzmVDd0I9uLbWN9wWBfsZCvBoji1uYeVF8tzo09gbYQTZk
         OmwEPEcDxZe8a61dP/aAA8kZT6zR+JsNyhTqSDMjMkwwI7oe9b9DAZDlMm3qrTI02BOm
         Y2LvyAdbezNSFoiS/7JhPzUJ5e4zs+C2by9qmLM1TIU95y9GmyhSPrYGidvY5sRl+rNV
         pNqSEIs0i0qdAHkcacQT691Pe9JHhIb0/Q8kku9FWWURm+QWb56RNhPQ/XS2ymnPhwjG
         XPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gmezfN1Xisi/Y28D8CBgw2JKxBcXRNXAGwUqlEq0780=;
        b=lJX9ytkBEkvZluXBFn0Y1cxJVlwa8e7U9j9p2PIFMIiMAz3wcMBR9KlO+cyAt0MLKn
         WpJGB8IZq2afBSBIBsuAODjyOmDxgiEJ0QLrfTe+hwkSgjCQpJmYYHIDmZFgSjpBtNh1
         M6gRTeX/9jjJstTqVpL+pOVQ5wLipngNWku5T6a+A8KlUwVDScqz8eLJyXKv/4CYTpRV
         eJL1JObmoAYDJC/2mGKdkRlBnXa7YL5xtCgCz97ENoh6JQg9fb+8CfGR1Vkdccm6IjSX
         mceJUcQhsYbl0N5drvfHn+iVgnhN8mkWi4viPv76kZTfj/LbKgnXX/372jXQtCqnA9Zb
         oTkA==
X-Gm-Message-State: ACrzQf1lQh4mOxQhSbZvr8wNHR6GH/iZuhP6p4c6ws1zu11wbe5zFTRC
        RuijGpx11OxVdqwDDqfjioW94w==
X-Google-Smtp-Source: AMsMyM7ECIzt/fSl1/bV4qil5N/5McfHi6HQSeLKJF4mNeGACnu2MAgU8b7V99M7CFP7GIU5bvHzjw==
X-Received: by 2002:a5d:59a6:0:b0:22a:e22f:79c7 with SMTP id p6-20020a5d59a6000000b0022ae22f79c7mr12748671wrr.511.1663681899630;
        Tue, 20 Sep 2022 06:51:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id m1-20020adffe41000000b0021f131de6aesm77101wrs.34.2022.09.20.06.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:39 -0700 (PDT)
Message-ID: <5f8d5e01-6fa7-b0af-bf46-ebfb60dce47a@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/17] phy: qcom-qmp-pcie: drop unused mode field
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-10-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> Drop the unused mode field from struct qmp_phy.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 666109a11329..65825ca41e96 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1374,7 +1374,6 @@ struct qmp_phy_cfg {
>    * @pipe_clk: pipe clock
>    * @index: lane index
>    * @qmp: QMP phy to which this lane belongs
> - * @mode: current PHY mode
>    */
>   struct qmp_phy {
>   	struct phy *phy;
> @@ -1389,7 +1388,6 @@ struct qmp_phy {
>   	struct clk *pipe_clk;
>   	unsigned int index;
>   	struct qcom_qmp *qmp;
> -	enum phy_mode mode;
>   };
>   
>   /**

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
