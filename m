Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A1627977
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiKNJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiKNJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:49:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B957DEF3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:49:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so18319660lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJjyfBDsX+JRhsPEen5MxPycUVlZ3Pj+Kpu2ZuqdZ1A=;
        b=dzSiwp9ZB2kRHdTTKSTGc6XUetNf7VZKxzJNTLuEIzfQWkS6RsmdFP+LfZ2oCgbFWf
         1bmjDOe/QIX9twgxoMtuEnEv3kDcYKEjuXClp6OllOpVIADnmIYoxuA4q5fMbyqlTFM2
         uBpWiop5maEP30N6G5BcDGKwfRagKTEmaYaXQ8bM0Fv4zT5NjmXu+s0zYb0EQouGjkEB
         BlEF4LkaxcIXh1ZCivPaO5DQfudAOniqswvehdofaaYmobbMZwHdvY6/y6lB1kEsSR9F
         IUXQFQz31xdDF25PS39zMW6bzdZwCoHDNUamDKt8M5wOJzkj8ItCEtov2hAtTgm02wSV
         P+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJjyfBDsX+JRhsPEen5MxPycUVlZ3Pj+Kpu2ZuqdZ1A=;
        b=bhc69ZoAZZDGb4G5qqEYLV83ddlLfwpTEWTGSpfBB/As0ZWvgDBDjNocmtLTOi/M/d
         MBKa0uSzV0J+go6wH96SIpYzkkNW28q6jy/dOsjhT3/wafW6uMIt1J3ikor7AWsPckSt
         nDnY7O6M6b4KUHlhRCrMOHL1pG41zUBYjvbYpWiywE+dV2bPptJZHlJ2hwWWKSCUbn0+
         zV3iZXfkeejmJKFHhwHrkhp3CLSJ5vg3/16j3eDwfDzUfw6DMFcuOk9F/ZVxBwFd5Rot
         N3MoBz7T9c0PXWZsZa3hPU/akMJ0qYOc7DUwPZ8x497EOT5sfw6Fybeuq7F74ENZ+00I
         exgw==
X-Gm-Message-State: ANoB5pmeu7QTBFI7uI/QVEsIu0cHi6kLWVmbv98v8pcWbBMN+CarQgZq
        f9AnkcoBWEOE9L/Li36SqlAAgg==
X-Google-Smtp-Source: AA0mqf6ejVdnbLOljN6vUt8XoVjEdS6I9gXRZKGNs8IUB8bBi9iDeTHLclSEgVl5teuYUARYNLwZ5Q==
X-Received: by 2002:a05:6512:6c5:b0:4a2:2223:a6e0 with SMTP id u5-20020a05651206c500b004a22223a6e0mr3810313lff.42.1668419373652;
        Mon, 14 Nov 2022 01:49:33 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b00498f32ae907sm1769448lfs.95.2022.11.14.01.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:49:33 -0800 (PST)
Message-ID: <cba6d4c7-c3ca-1f2d-f6fa-86678e64f81c@linaro.org>
Date:   Mon, 14 Nov 2022 12:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 16/22] phy: qcom-qmp-combo: add DP configuration tables
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-17-johan+linaro@kernel.org>
 <56752623-d865-2848-3132-4df769a31d39@linaro.org>
 <Y3H+gpKZsOH05RET@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3H+gpKZsOH05RET@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 11:38, Johan Hovold wrote:
> On Sat, Nov 12, 2022 at 10:39:12AM +0300, Dmitry Baryshkov wrote:
>> On 11/11/2022 11:56, Johan Hovold wrote:
>>> In preparation for merging the USB and DP configurations, add dedicated
>>> pointers for the DP serdes and tx tables to the configurations.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
>>>    1 file changed, 24 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> index 499368e19e00..b27d1821116c 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> @@ -816,6 +816,11 @@ struct qmp_phy_cfg {
>>>    	const struct qmp_phy_init_tbl *pcs_usb_tbl;
>>>    	int pcs_usb_tbl_num;
>>>    
>>> +	const struct qmp_phy_init_tbl *dp_serdes_tbl;
>>> +	int dp_serdes_tbl_num;
>>> +	const struct qmp_phy_init_tbl *dp_tx_tbl;
>>> +	int dp_tx_tbl_num;
>>> +
>>
>> I'd prefer to have DP-specific instance of struct qmp_phy_cfg_tbls here
>> instead of having separate dp-specific fields. WDYT?
> 
> No, I don't see any good reason for doing so currently.
> 
> You may be able to share a few pointers between some of the SoCs but
> only until it turns out they need to override certain sequences anyway
> (e.g. sc8280xp which mixes v4 and v5 tables currently).
> 
> You'd also need dedicated aggregate table structs for USB and DP and it
> seems all of this would just make things more opaque for little gain.

I was thinking about moving the qmp.*init_registers into the common 
library. However let's probably finish the cleanup before working on 
code consolidation.


-- 
With best wishes
Dmitry

