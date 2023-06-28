Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31F87418EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjF1Td0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjF1TdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:33:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A6130
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:33:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso3137331fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687980797; x=1690572797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8luJOwdXXfNeGMdyQDRfNqFP6j7QRvwX8K5JggFfHh4=;
        b=OFojlgb6qOIm4BRwHjuEJRu21xeqeV1LKW39dulUm0vJglosAJKjZTlgW3/cLlgfU8
         sPI1lmD/lzuYgpDV9HQafdKnia9WgUg3ps4kGh906wC3CQM3CUftthUwZpdg7TBFzX3b
         9IKQRCdmv2yazcc8DILLCL5930i2OlChyeDr4t8roHHZ/8D5Pg3L6dzeUbrwd+FnfPJP
         DP6qRBRkRtoeC5tx0hOHsHdiNUcEQtnRemfIlpTpqqZ9vtZXAlhmrS8UpwMjvoRSIX/i
         jxGG/T63PLW80jwq8IRznHCsNQ9kM6G9jYkhNVr3xenUyn7YyYoQknQ5JwtTAu3ecF4b
         Yjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980797; x=1690572797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8luJOwdXXfNeGMdyQDRfNqFP6j7QRvwX8K5JggFfHh4=;
        b=WqEtLy3I1PhVw7ZLowfR7MwrjBO+lnXLBvr50Qae33LOxpiT/Vl0yeqNHKsYiiGJB8
         /OMD6cR5690yAwwT9EaEbDWVrtfD4mwmaUjP5GDfcqdWUq8W/vnkGnM6DoZP2H/nzSea
         VDQdnO3YVDGnDz3odbOpMirMPcX/n8xRAOfrocciemhES20AjLjzx3lbn5L+/45W9I8c
         khnJ2TViWAKClA5MPpQDryKr5reHim51UPKXoZ5sJkC5gTTKRiA7E57bH0AjwHfhvveN
         sRiA8Esse27v5iSruukbl3DTi/vkaxYbZD6TbsAb/MAzK1VE9bkB6Nrb6y45xC7E5F3i
         6AFQ==
X-Gm-Message-State: AC+VfDx0fL0EgRBA7xzGNUgXsNDwDJPc7XwZZrZfvtarhHxOjIzQkquA
        F3khfwkMuPyViL6iKNrByK2cMg==
X-Google-Smtp-Source: ACHHUZ4tzZacjhlbNXcdymGFQQEzjZFRE+pRBdGohWQU6TmdwqnDkuI66k6/rbtFjpxqb2SbajrvVQ==
X-Received: by 2002:a19:674d:0:b0:4f8:6ea5:104b with SMTP id e13-20020a19674d000000b004f86ea5104bmr16247327lfj.30.1687980797180;
        Wed, 28 Jun 2023 12:33:17 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r22-20020ac24d16000000b004fb757bd429sm1385852lfi.96.2023.06.28.12.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 12:33:16 -0700 (PDT)
Message-ID: <fabef33c-a8c7-af61-80b4-91e55081c977@linaro.org>
Date:   Wed, 28 Jun 2023 22:33:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
 <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org>
 <c377aefe-2678-4ba7-96b3-2186e8f3f1b4@sirena.org.uk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c377aefe-2678-4ba7-96b3-2186e8f3f1b4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 21:10, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 07:57:38PM +0300, Dmitry Baryshkov wrote:
>> On 28/06/2023 14:53, Mark Brown wrote:
> 
>>> Why not try a series of firmware names/locations generated using the
>>> identifying information for the card/system?  That way we don't have to
>>> put a filename in the ABI which has fun scaling issues.
> 
>> This is what was done by Srini in the initial (currently committed) version.
>> Unfortunately this easily results in the audio topology being separated from
>> the rest of the platform-specific firmware. For example, for the mentioned
>> X13s we already have a subdir under /lib/firmware/qcom and several
>> firmware-name DT properties pointing to the files in that subdir:
> 
>> $ grep firmware-name
>> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> 		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
>> 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
>> 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn";
> 
>> This is not unique to the X13s, other Qualcomm boards also use full paths.
> 
> If the goal here is to put all the firmwares for a given board in a
> single place surely it would be better to factor this all out of the
> individual drivers so that they ask some helper for a directory to use
> for firmware?  Adding these device specific firmware node properties
> doesn't seem to follow.

This quickly becomes overcomplicated. Some platforms use different 
firmware naming structure. Some firmware goes into a generic location 
and other files go into device-specific location. So having a generic 
helper doesn't really help.

-- 
With best wishes
Dmitry

