Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD00605B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJTJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJTJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:28:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE191C19FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:28:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g7so27422883lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ewn4HhGslcazbRmLvsGRl3y97RhVhfkn6hwU61L66A=;
        b=TecGvojYZ9NKrDOGAKWWzGAaSNS6hxRavZ9+eDJH2Y8N0S6fQfbROXCAnrmUGULfQG
         i93HBAWQ68Tyh3pqiyE+vl3Y5kNqcRL62NsHcKhFQREF1WvcI6kX7aMefICtDvFTgflR
         CO19cxjQ/G8PNbzIPgtI92d4YxKtCN3iNfMk64RvROr7k2lkLJxCZP+SidyfM2Km2zyg
         MuGEnZgVkbBNxit7Tuk4I8tKP9uhf5C8SPmzyKEQcb7TT4WJmR3WzAIr3u4VFZUDcQC7
         fSGSGUcn4FUKA9Xqv84s6OXL8bpvA3jyF95Nq30Egt3xkP7g9oi9EoOw+wXHAj2GdgvQ
         7s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ewn4HhGslcazbRmLvsGRl3y97RhVhfkn6hwU61L66A=;
        b=PI8rHlB2e/VvgnA+jJHb805+rYFEvVU6XqQOAeHoB1g66bcjMyU8TBd3+JLOVJsijA
         AoxLB4fVigecRvtRMt0rOxb6jOM8xzVqOwiHKsabau3BraD/G37QCIoUJF4aCZCNLTHD
         NBCvY/ok5EDWbXD6YVGWeKfEwnGpITODFIFRWQXmev1xA9xDegnG3wMCtGfozHKIPU6D
         +HWTPN2Hsnd2oJu/rmGN/U3MuDoJ15EdjshvDCAOVUGSscLxkuz9wPGw98kQI2b+0Y/a
         fKAKyuDtnxpgnziUmvU7b/rqg4C3sXi59VY1dzCb+4gCzbA7+uHa3Zfh18YLxTxNCl76
         8QQg==
X-Gm-Message-State: ACrzQf1KqUbL+Da4fwf4v2RBt0bD4HDUL3k1gwY2+KoyZpOb9f7Wiyh2
        dRUssgfivxnaEzIvcoz1LWc62tbfwOPSvA==
X-Google-Smtp-Source: AMsMyM7bv9bGxciIiXjNDJB5vQAP1sSIqPeH3B8ClBGO1n1JwLDwakmvPLlFQ1Qb2gOXyRzYa1nIyg==
X-Received: by 2002:a05:6512:31cd:b0:4a2:69d3:d009 with SMTP id j13-20020a05651231cd00b004a269d3d009mr4132905lfe.68.1666258095352;
        Thu, 20 Oct 2022 02:28:15 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s15-20020a19770f000000b0048b365176d9sm2644658lfc.286.2022.10.20.02.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:28:14 -0700 (PDT)
Message-ID: <7eb3fb9a-ce4a-eee0-b6bc-cee6aa6bf37b@linaro.org>
Date:   Thu, 20 Oct 2022 12:28:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 13/15] phy: qcom-qmp-pcie: add support for pipediv2
 clock
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-14-johan+linaro@kernel.org>
 <325d6c7b-ca96-df73-a792-4d156a710267@linaro.org>
 <Y1EPZBinv0tyZVqW@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y1EPZBinv0tyZVqW@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 12:05, Johan Hovold wrote:
> On Thu, Oct 20, 2022 at 11:31:35AM +0300, Dmitry Baryshkov wrote:
>> On 19/10/2022 14:35, Johan Hovold wrote:
>>> Some QMP PHYs have a second fixed-divider pipe clock that needs to be
>>> enabled along with the pipe clock.
>>>
>>> Add support for an optional "pipediv2" clock.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
>>>    1 file changed, 36 insertions(+), 6 deletions(-)
> 
>> I still think that the attached patch is somewhat simpler. Diffstat
>> supports that idea:
>>
>> $ diffstat /tmp/pipe.diff
>>    phy-qcom-qmp-pcie.c |   26 ++++++++++++++++----------
>>    1 file changed, 16 insertions(+), 10 deletions(-)
> 
> It's not just about LoC.
>   
>> Yes, I'm speaking this after having cleaned up several open-coded
>> versions of clk_bulk_foo from the drm/msm code. It typically starts with
>> the 'just another clock' story, and then suddenly they are all over the
>> code.
> 
> But you don't start using the bulk API when you have one clock. Two,
> maybe. Three, sure. It's a decision that needs to be done on a case-by
> case basis, and pipe clocks for the QMP block is different from general
> interface clocks (which are more likely to be extended). (And of course
> the clocks would need to be independent in the first place.)
> 
> Here's your example diff inline:
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 9c8e009033f1..a148b143dd90 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1378,8 +1378,10 @@ struct qmp_pcie {
>   	void __iomem *tx2;
>   	void __iomem *rx2;
>   
> -	struct clk *pipe_clk;
> +	struct clk_bulk_data *pipe_clks;
> +	int num_pipe_clks;
>   	struct clk_bulk_data *clks;
> +
>   	struct reset_control_bulk_data *resets;
>   	struct regulator_bulk_data *vregs;
>   
> @@ -1923,11 +1925,9 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_init_registers(qmp, &cfg->tables);
>   	qmp_pcie_init_registers(qmp, mode_tables);
>   
> -	ret = clk_prepare_enable(qmp->pipe_clk);
> -	if (ret) {
> -		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +	ret = clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> @@ -1950,7 +1950,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	return 0;
>   
>   err_disable_pipe_clk:
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
>   
>   	return ret;
>   }
> @@ -1960,7 +1960,7 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
>   
>   	/* PHY reset */
>   	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> 
> The above is pretty much identical, expect for using the bulk API
> instead of the very straight-forward pipe-clock helpers.
> 
> @@ -2154,6 +2154,7 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
>   	struct platform_device *pdev = to_platform_device(qmp->dev);
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   	struct device *dev = qmp->dev;
> +	struct clk *clk;
>   
>   	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(qmp->serdes))
> @@ -2206,12 +2207,17 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
>   		}
>   	}
>   
> -	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
> -	if (IS_ERR(qmp->pipe_clk)) {
> -		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
> +	clk = devm_get_clk_from_child(dev, np, NULL);
> +	if (IS_ERR(clk)) {
> +		return dev_err_probe(dev, PTR_ERR(clk),
>   				     "failed to get pipe clock\n");
>   	}
>   
> +	qmp->num_pipe_clks = 1;
> +	qmp->pipe_clks = devm_kcalloc(dev, qmp->num_pipe_clks,
> +				      sizeof(*qmp->pipe_clks), GFP_KERNEL);
> +	qmp->pipe_clks[0].clk = clk;
> 
> So here you're poking at bulk API internals and forgot to set the id
> string, which the implementation uses.

I didn't forget, I just skipped setting it. Hmm. I thought that it is 
used only for clk_bulk_get. But after checking, it seems it's also used 
for error messages. Mea culpa.

But it's not that I was poking into the internals. These items are in 
the public header.

> 
> For reasons like this, and the fact that will likely never have a third
> pipe clock, I'm reluctant to using the bulk API.

Let's resort to the maintainer opinion then.

> 
> +
>   	return 0;
>   }
>   
> Johan

-- 
With best wishes
Dmitry

