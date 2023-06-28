Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70A7416DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjF1Q5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF1Q5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:57:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913C10CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:57:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so707641fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687971459; x=1690563459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/zCltrriS9+FwfYPkaoLx57nyP2zICnwZ3L4CTqa1o=;
        b=syyZXBBk17JauNows5A2urMe/pcWTLphLlt4SnwA2w1ABVK5XugBET02VZTNZuT4nG
         BDOc/kJ6ib1UvpjR32PSCHkft8ibj9934gCK2qvehWRrfkXF7XIf4m9a2w5Ob9dQ4t6m
         YZ5YM2SzILcwULe1BPJAKAJIk+Pp/GFko0WMt29LldbbJK8E+rLLMRBjb2C03Ue8b75A
         u7mMPttbXk1mjEURIFqk7RS7UbQLQ7z7WoDPAsVE6Q2SzvNwTuRfQw3Ojl1xWI2r0ocl
         c+kPoqasBRouUlgkGGyrbERJppvjbFjiNYmcTRbdgXFDfJYEir3S3Im2G2WUV2XiPykH
         lDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971459; x=1690563459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/zCltrriS9+FwfYPkaoLx57nyP2zICnwZ3L4CTqa1o=;
        b=V6fzo8wBUw7rTkEfacLyWK33dQdGRRiUV46bMjdkCvrCtGAAiDTxwIM2ta7zttjP16
         Ngi9BT3/2cNyLH/ia+F44WUrlTD+ISmCvOED74oCpKuNKMec4hsLLpKV07ZsTR8vvCN9
         sPbn4oNLG2oMf4wnjR7JwUJC/BmNwzmEhEdqz1m47z0TDWHyYShGSc6H04rHA2to5oic
         QJaUGPP8egc1Uwls0nsW/hl6+e6uUqvASy10RxK5dpJJEhpU6s6+SOI8c+BNMqQ+Skvk
         73kjKw8cM7PB2RfEKyoZYMZ7gSSRj3FNyKNenezm1snmrF6tDRRYOWr31TDgNkx159xV
         otzQ==
X-Gm-Message-State: AC+VfDzXfyY/KLEfucESYIKi4xG9L6X+yMvW/KevsGQXA8yCo9pYZU+K
        HxLcmAJUkFMuvN9MS9PDk2ogpA==
X-Google-Smtp-Source: ACHHUZ5O1WkcZQ+NAg+pK0OUsPsx/35pHTmfE+O/DSkG1d2UB7WiB+g4BQBT7/MHrfwy18PtV+CYew==
X-Received: by 2002:a2e:7c09:0:b0:2b5:80c9:1266 with SMTP id x9-20020a2e7c09000000b002b580c91266mr17376124ljc.43.1687971459498;
        Wed, 28 Jun 2023 09:57:39 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a2e9c48000000b002b6a824d65fsm1076904ljj.0.2023.06.28.09.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:57:39 -0700 (PDT)
Message-ID: <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org>
Date:   Wed, 28 Jun 2023 19:57:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
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

On 28/06/2023 14:53, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 11:26:20AM +0100, Srinivas Kandagatla wrote:
>> Currently firmware file name is autogenerated based on card name and model number,
>> however this imposed a restriction of finding firmware in a single firmware path.
>> Platform specific firmwares are normally located in sub folders of the SoC.
>>
>> Provide more flexibity by reading firmware-name from DT.
> 
> Why not try a series of firmware names/locations generated using the
> identifying information for the card/system?  That way we don't have to
> put a filename in the ABI which has fun scaling issues.

This is what was done by Srini in the initial (currently committed) 
version. Unfortunately this easily results in the audio topology being 
separated from the rest of the platform-specific firmware. For example, 
for the mentioned X13s we already have a subdir under /lib/firmware/qcom 
and several firmware-name DT properties pointing to the files in that 
subdir:

$ grep firmware-name 
arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn";

This is not unique to the X13s, other Qualcomm boards also use full paths.

-- 
With best wishes
Dmitry

