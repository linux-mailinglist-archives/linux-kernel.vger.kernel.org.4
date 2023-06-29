Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41F742B51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjF2Rd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjF2RdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:33:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C13AA1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:33:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso1045965f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688059991; x=1690651991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZxvYIZuxAB+lwUWpz3iVved5/FIuiHwGeX7NNNfKPs=;
        b=oXBlUOCsey6+rQUYnSJFVtS5AWj+TbJrKzuUNlXTOUDDPjK+vhhuNDtuh7MyHlBUsP
         Ukjnxt4TxiOim3clDHs754DtEm602HxHBTOIFJ0b+NopLsIPE7rA6+oD7LY51iHYJR+m
         20c1zNfsyGl1cEqDtSLlm2/WFFdvFlgAXUdIIuHRpGLhBRs7n6Vo6gIFhGFosIPlOi4S
         yXGkdGT17L0B9ls3SA7mR8Ki+y/tYlW9/UAiFJkGqX9DfynoLqqQm+0tLR8EkHpzejP+
         ACbLaqzMjnVZAM3SRHoK93fl0XcLt5aKHocBM8O01XqnbrNSQzYssz1m6CnwHxWqyscx
         rFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688059991; x=1690651991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZxvYIZuxAB+lwUWpz3iVved5/FIuiHwGeX7NNNfKPs=;
        b=Nvd6OgH5TrQwA4H69TX3YH8ynbonLkwHXwoB9DTh/5kG2sOlj0rvlDpU/tkEGoAOfe
         B8muJwRYgLWEWHpi2y8CDof6TFpo1GmuGYTwMLRWptcPg920ywNCzvl1GuLn1kyHVQ6M
         sM4eUugTfLfPRmklFDox2+BDhsWAO+XVnRVJINRw/T4A2EipjekIKs4Nv7rjkohuW2Z/
         LaXNFnc6ha4cZ87BI0/mEZp0cmDUJqJqIZsOl7r2gdnM8SD288OKZhixZNWcF5S5Xxh2
         tfcdaiEh4nNj2LI7GrEikSc1YpwFKYatuQ74kuKLeDG2z3sk+e82VUAxwh0XinRVKAsK
         GxyQ==
X-Gm-Message-State: ABy/qLYhGmvkx0doNSkbNR1ingh8w75TXitT5BunYousHw8M2c/qP/lr
        HFRCvEuIujEoRZUlVacHOaqCZw==
X-Google-Smtp-Source: APBJJlE8XZRIPMaI6hNQHvv0XXg37ddZC1ZtloaleapPkcO90Mg1HZkMU3CBxM8wYYCsAhqtCIVBew==
X-Received: by 2002:adf:fd43:0:b0:314:77a:c2b2 with SMTP id h3-20020adffd43000000b00314077ac2b2mr223834wrs.32.1688059991220;
        Thu, 29 Jun 2023 10:33:11 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c1-20020a05600c0ac100b003fba6a0c881sm7762482wmr.43.2023.06.29.10.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:33:10 -0700 (PDT)
Message-ID: <77b348f7-0475-5e16-95e1-0e5831408d2b@linaro.org>
Date:   Thu, 29 Jun 2023 18:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
To:     Mark Brown <broonie@kernel.org>
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
Content-Language: en-US
In-Reply-To: <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/2023 16:43, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 10:24:04AM +0100, Srinivas Kandagatla wrote:
>> For some reason we ended up with a setup without this flag.
>> This resulted in inconsistent sound card devices numbers which
>>   are also not starting as expected at dai_link->id.
>>   (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)
> 
> Why is this a problem?

In existing Qualcomm setup the backend pcm are added first, which 
results in frontend pcms getting pcm numbers after this.

For example: with 3 backend dailinks in DT we have frontend pcm start at 
3. Now if we add new backend dai-link in DT we now have frontend pcm 
start at 4.

This is a bug in qualcomm driver.

> 
>> With this patch patch now the MultiMedia1 PCM ends up with device number 0
>> as expected.
>>
>> Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
>> Cc: <Stable@vger.kernel.org>
> 
> Won't this be an ABI change?  That seems like it'd disrupt things in
> stable.
Yes, but this is a real bug. without fixing this also results in abi(pcm 
number) change when we add new backend dai-link. I have also sent fix 
for UCM to handle this.


--srini
