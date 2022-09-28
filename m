Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63B5EE12C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiI1QDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI1QDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:03:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A7DF3AD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:03:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so8521475wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references
         :reply-to:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date;
        bh=XU11ixlhb+u4soUFNHZJtpgKK6IKQcVXkoMJ24YW0R8=;
        b=HdUdZxbMHUXgaQOTBzdH16VdppkchgZA4IYvg2KHdhPrLFYcXa5Ef2a3F6MCF5Toz+
         KaAsDopel63Ydmq4ZsCxrgU1zQuI65McK0UmEnF3wC3HIyQqdsjEXsWc47mzXB+SLE8p
         X+tlr6MU6ffypQEx7izOF063ZqKmI4gD1dddj92RgjKmk807kZN3OuaFvK+D3q29ewGP
         8Yz19k351RcbhxTky6WVmBrsGanuBGJ8sfx1HvEiFeOJDXHkIHHwcgVC2uyMFDRjAC8s
         MwFysKVqAulmK7ginwRaKGZIymOVR9lUlO8VoO267eTvYD8oFZCXyHxsU3WH134gkKwY
         FF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references
         :reply-to:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date;
        bh=XU11ixlhb+u4soUFNHZJtpgKK6IKQcVXkoMJ24YW0R8=;
        b=grZ6k+kskBBTxEI/LEF0xwU5IfeSZ+aZfCG+ekpPIhGzy5PqZ97RV+gTynI6Y76L34
         6MnXlmwpKsoVU3CaRtrD4xNlhkq89W2Ju9OPt8IvZLCqzbOxloyL4dATC40d5AN3tf44
         bhxoZOH2q1m/gZUlzPvSGzetPddd0tRdwJwtCHPrlxeMgjmlIN/XRvG8Bwo6S7MFNhLD
         meCHemx10vISXSqNiu9gs8h2JQJH62gbLDAsj2Iv2Ntp0CCMI1CSTHcSRKO+dfUifPYi
         lE0nxtz5cGnT7TU88hPddZC0eLcM2Ilkq6xIsrIwASJWF2+6k5JI36vVAPTQUWZ+S3ac
         q8lA==
X-Gm-Message-State: ACrzQf28diMCwEIDryNahCVqHWSUHRSGMoCCdTKhRHmzq3/aDs+Zu+kc
        HP/AG3aJ0smCiYufZple+iZ6Aw==
X-Google-Smtp-Source: AMsMyM7dS8fbbuHO5T9iAq/a/FI0ieRM/47RAYkKsTccUoIvj6bL++V23jPnMw1p3Lh6GQCrbD/jKQ==
X-Received: by 2002:adf:d08d:0:b0:22a:4560:9c29 with SMTP id y13-20020adfd08d000000b0022a45609c29mr21200486wrh.579.1664380988935;
        Wed, 28 Sep 2022 09:03:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id q4-20020adf9dc4000000b0022cce7689d3sm104241wre.36.2022.09.28.09.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:03:08 -0700 (PDT)
Message-ID: <ecebc912-de59-b607-5a60-2d174e7c5d58@linaro.org>
Date:   Wed, 28 Sep 2022 18:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] phy: qcom-qmp-pcie: unify sdm845 registers
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: neil.armstrong@linaro.org, neil.armstrong@linaro.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-6-johan+linaro@kernel.org>
 <f4148c7f-3f75-bedd-3e3e-a50113cf41b8@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <f4148c7f-3f75-bedd-3e3e-a50113cf41b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:01, Neil Armstrong wrote:
> On 28/09/2022 17:28, Johan Hovold wrote:
>> The SDM845 register array is identical to pciephy_regs_layout so drop
>> the former.
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 7b3f7e42edd5..4146545fdf5f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -92,12 +92,6 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>       [QPHY_PCS_STATUS]        = 0x174,
>>   };
>> -static const unsigned int sdm845_qmp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>> -    [QPHY_SW_RESET]            = 0x00,
>> -    [QPHY_START_CTRL]        = 0x08,
>> -    [QPHY_PCS_STATUS]        = 0x174,
>> -};
>> -
>>   static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>       [QPHY_SW_RESET]            = 0x00,
>>       [QPHY_START_CTRL]        = 0x08,
>> @@ -1545,7 +1539,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>>       .num_resets        = ARRAY_SIZE(sdm845_pciephy_reset_l),
>>       .vreg_list        = qmp_phy_vreg_l,
>>       .num_vregs        = ARRAY_SIZE(qmp_phy_vreg_l),
>> -    .regs            = sdm845_qmp_pciephy_regs_layout,
>> +    .regs            = pciephy_regs_layout,
>>       .start_ctrl        = PCS_START | SERDES_START,
>>       .pwrdn_ctrl        = SW_PWRDN | REFCLK_DRV_DSBL,
> 
> Isn't is an issue if QPHY_COM_* entries are in pciephy_regs_layout and not in sdm845_qmp_pciephy_regs_layout ?
> 
> BTW it seems those QPHY_COM_* are never used..

Forget this comment, I missed patch 3 removing them...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


> 
> Neil

