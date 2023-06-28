Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5035C74167E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjF1QbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjF1QaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:30:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B72690
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:30:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313f61890fbso3139225f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687969817; x=1690561817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMrDQpzoZwdfVDUBjNtjm8VWm39L3gvHFkqK/8Oz7Fg=;
        b=Ba0XBSFDaUbS4aKjdlM+C4FCmPkBthmSTdfBs6mHnlYMS0NobRCZScMWgsulr6FThL
         pnVyYRHvQCjtkncraECzLAvQ+7UaaOUOeoLC/FrbqnFzQeidWUji5UyY2HQhg/pYcVVH
         ZDpPPOqOCvqYv2GZ5sfeTCDWOIDqe8SLoK35Yxpc300QsmkzeAxQVkFdOfKS944KxFT8
         SRO7PcD+XNpalbwTg9/mxwiBqFQfoph45g5itQdglK1IfaxhxXXwZznxJF/Ocww5oFpO
         9/ExtBr7Oq+j0Ob4taYU+NANwdLBzhD+eJcM7mxFBFjNHNmbpZL6QPC5Q5HQsxo87IWt
         jI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969817; x=1690561817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMrDQpzoZwdfVDUBjNtjm8VWm39L3gvHFkqK/8Oz7Fg=;
        b=JMOwSSF8BHw8W8kioPZjbV24ZSR8GZTib3yQv11qZPpA6Goi7KPShr4cnsN/g9RDd6
         c6F+0MNFH/N+g9+qbev3qFiztVc0jXD9W8b9xtlhz62F1NHLts7PTfivnba4fJXcqGp1
         KVlj78vEgH9mhyyp9qugBML+XA38R8VnOXJJF5qz5HSLcHMWU5TaScV5+iEAn8sut45v
         sddbzS5i9ngorREOp6IrevH79YqT+UuHJ2hQRrQqmUcApCcE4oydmPo7RhbLCP5MYQQC
         dVQIqnXgqXbet5PEhhhyyhRuWM0IX1hTMpFL0IoTnxwVUm0DOFf/3qMVXe5XHr0H/+19
         zQDA==
X-Gm-Message-State: AC+VfDz72L9eZ2E0SlYH6UpGIzy1BXlAaStrA7FAXA+bN32NyE0EgqK9
        hncXomdN7KBKhK8s70KIKVXTdg==
X-Google-Smtp-Source: ACHHUZ5ixMGvBpAM+0EN2kJ24buliqjZdgG6MhG+EaLDx0AocAWUzViTOhuZS9BEglKFygOinlA7EA==
X-Received: by 2002:a05:6000:1a4f:b0:314:415:cbf5 with SMTP id t15-20020a0560001a4f00b003140415cbf5mr3635839wry.51.1687969816968;
        Wed, 28 Jun 2023 09:30:16 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q14-20020adfdfce000000b003113ccbf388sm3953201wrn.13.2023.06.28.09.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:30:16 -0700 (PDT)
Message-ID: <b2aef484-71c9-5655-c1f8-ddde57687491@linaro.org>
Date:   Wed, 28 Jun 2023 17:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/2023 12:53, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 11:26:20AM +0100, Srinivas Kandagatla wrote:
>> Currently firmware file name is autogenerated based on card name and model number,
>> however this imposed a restriction of finding firmware in a single firmware path.
>> Platform specific firmwares are normally located in sub folders of the SoC.
>>
>> Provide more flexibity by reading firmware-name from DT.
> 
> Why not try a series of firmware names/locations generated using the
> identifying information for the card/system?  That way we don't have to
There is no consistent way with the current state of what is available 
in linux-firmware and what drivers can generate from DMI, atleast with 
Qualcomm SoCs.

Example for x13s has all the firmwares are under 
qcom/sc8280xp/LENOVO/21BX for two models 21BX, 21BY.

However none of the DMI properties match exactly to 21BX or 21BY.

These have to be either derived from product name 21BYZ9SNUS or some 
other dmi properties.

This logic is not going to be very reliable, can differ across platforms.

All of the qcom platforms use firmware-name from DT to get the full 
firmware path with name.

I know this has scaling issues, but with the current state of things, 
its the only option I see.

> put a filename in the ABI which has fun scaling issues.


thanks,
srini
