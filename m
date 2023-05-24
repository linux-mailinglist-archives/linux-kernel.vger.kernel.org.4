Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC570F793
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjEXN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEXN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:28:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA089B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:28:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3078d1c8828so794959f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684934921; x=1687526921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpaEDaEMiz0twNyfrOrBugRFe4goGloP1Qpqk47QwlA=;
        b=RRpnCjpjHBTwE/i8foXECp1howHpUJB08S3RDHVRKvOK+eeAwsKC3x39tLqwNhysca
         cI/sZp9eC0H8WA5MnMR3Wck3kwLEVf86vv/q5HMBHGSWy4KCGj8fcAyYih8bFlYz+sdD
         pxEo14qjxYnXZIROoJUVb/epU2pySWQZPM/UhVVhdK+inP5pxhiZDg0rcJ8490MDOf2D
         lFZHi9cri7PBUqx0937e80otPcYbB6cxD6Aov9gHkFGDb0QFamRLyqrj2Ycmk3UH1NrR
         hoc4lFkin632699KFRBucYZo/CD34eAaRYyFXiPx/o7vUmZC9N/i30ORAGH8AuOAj9jx
         oGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934921; x=1687526921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpaEDaEMiz0twNyfrOrBugRFe4goGloP1Qpqk47QwlA=;
        b=KWajg+cRoKhn7JjlbXT4p7aChvO2QbbNenJAjCTPTARsr48yDZ5qE7PpXuihJVjWyc
         uTqoxX4bOfDna5p/MHVDA3UF95uCyPp+d0ccsU9urm3owhKuHe/CEMRaRAnGKz9uN2GK
         wwTsmsz92FeLWePCYfjnSZdtB0U2X1Cl/r+3XtroU4JCpule53biTH1R0q6MFt3Xuy9a
         JeVUpcqqkNI0VDOZ0yYsVuJVeDWr4yeMWzLg/RmzijtSvv/7J6/lVz/m/Oe7TkapUUZK
         1KRFgcndEE98s+4oVptlWZTION71fXA4/jO9zumTWv/bvnEpNoCR8Bb5wtPubvkFGTqm
         q6Gw==
X-Gm-Message-State: AC+VfDwp8aOlhAj3Xtz+foK3eTXE061L+nhRlt39+cM7ZsUSGHnEe9ST
        heE13WMajIkAN2LEEdDdonXQpA==
X-Google-Smtp-Source: ACHHUZ5UxTF7Ty4Ha1qHIPwkF1euAKvGxSLopaZQrr7mrvaQchq5F7/btnqI5+pGB6je42At5/7vFA==
X-Received: by 2002:adf:ff90:0:b0:309:ccad:b2fb with SMTP id j16-20020adfff90000000b00309ccadb2fbmr10813993wrr.5.1684934920688;
        Wed, 24 May 2023 06:28:40 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4483000000b003062b57ffd1sm14483595wrq.50.2023.05.24.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:28:39 -0700 (PDT)
Message-ID: <56b892cd-977e-5b24-55f0-df25e187308b@baylibre.com>
Date:   Wed, 24 May 2023 15:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
 <20230523021933.3422-3-trevor.wu@mediatek.com>
 <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
 <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 04:25, Trevor Wu (吳文良) wrote:
> On Tue, 2023-05-23 at 18:26 +0200, Alexandre Mergnat wrote:
>> On 23/05/2023 04:19, Trevor Wu wrote:
>>> ADDA_BE is used to connect to mt6359. For machine mt8188-mt6359,
>>> codec
>>> for ADDA_BE must be mt6359 which are configured on the machine
>>> driver.
>>> Besides, ADDA_BE is divided into two dais, UL_SRC_BE and DL_SRC_BE.
>>> As a result, remove ADDA_BE from items of link-name.
>>>
>>> Signed-off-by: Trevor Wu<trevor.wu@mediatek.com>
>>
>> I don't understand how "DL_SRC_BE" and "UL_SRC_BE" links are done.
>> Why these dais don't replace "ADDA_BE" in this binding ?
>>
>> Regards,
>> Alexandre
>>
> 
> Hi Alexandre,
> 
> Because the sound card is mt8188-mt6359, the codec for these two links
> must be mt6359. Thus, I specifiy the codec in machine driver directly.
> If the codec is changed, there will be a new sound card and binding
> file. In conclusion, the codec won't be updated via dts, and that's why
> I don't just replace ADDA_BE in this binding.
> 
> Do you suggest me add some information in the commit message?

No it's fine, I'm just trying to understand.

When you say "I specifiy the codec in machine driver directly", you
are talking about this change ?

+		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC_BE") == 0) {
+			if (!init_mt6359) {
+				dai_link->init = mt8188_mt6359_init;

I'm asking because the equivalent was done here:

-	[DAI_LINK_ADDA_BE] = {
-		.name = "ADDA_BE",
+	[DAI_LINK_DL_SRC_BE] = {
+		.name = "DL_SRC_BE",
  		.no_pcm = 1,
  		.dpcm_playback = 1,
-		.dpcm_capture = 1,
-		.init = mt8188_mt6359_init,
-		SND_SOC_DAILINK_REG(adda),
+		SND_SOC_DAILINK_REG(dl_src),

So I'm wondering why "ADDA_BE" & "DPTX_BE" & "ETDM3_OUT_BE" are in the 
enum list of the binding since the codec is already specified in
machine driver too. I probably miss something but I don't know what.

-- 
Regards,
Alexandre

