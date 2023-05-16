Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5FC704A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjEPK0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjEPKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:25:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3146A79
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:25:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96aadfb19d7so881333666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684232709; x=1686824709;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2Oe3JB1551Ifyx7cKfdHGYFp9RdJC1mFhFOMst3c+Y=;
        b=TcQSMAYetCU7XethsGdoMi1IU7K2tphdW8gTMBtGnakEEiqSkZvj0sh92MSZalIf8I
         WHX42fNRPM7m9mWlEVcoIkD7bdwKDXmegGgn+pmy158YQIMffbgY0LKTQPE6M/GOsY1/
         ypewFN7+0iu86uXNl/TnXPMNK/xaw9BEEkkg1IHXP7ilDQGOZ0fqeEcy/XfwoF57ICEM
         2bQikMf5OIpgW21dmtQZJppts77OaB8WuzN5bgGuH2Bf9VWH4MxG8amhznE4Kxc5Sdq+
         6iubQGN65P4Qbvok8XYB9Lcm9n13k/hPb4DYCMANglYaydXYfgJNB7ePj3C0pLRE1Ldd
         KLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232709; x=1686824709;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2Oe3JB1551Ifyx7cKfdHGYFp9RdJC1mFhFOMst3c+Y=;
        b=KqoUtgKFNlyGQEV76DvvqutCfGpWvCTSVQbxAHDbr32GYenF81xnI2etl5ICKzF9k7
         DYA1fAncIIG8xnM/FmABZU63BH+gUDvcDehq+Z8TcKoIJOj461ZTRe7vrnZVSzbWsQep
         RrNQqH7jipkicZYWohHRZOGD2UmLfXwycvqGRkTrBy7x4LUUiX3ifJz2hy8Aj/YpbuCU
         nmhYwzG1MeBDZWLuDnN4NFjFcltK3dZjOcX5knagWie5YD3DSWAVikTAvrGU+cxxgn0R
         5okCEFGxHsVrWAJsr+MKuC/2i8LyUK4Dlv9/h0DurrCWEIH+TVIis4C4puwx0VFrxd2P
         uzUg==
X-Gm-Message-State: AC+VfDwGmc3L6n0WrVak3GLy8TvvqNCW9Igf38M37kRDBKJ6me6kmMan
        rE3h2SygdBjlsfwMXxrwPoZhIg==
X-Google-Smtp-Source: ACHHUZ4B7fCNUMfYrGV8dXmk26j3EQ8WI2HtGXoKigndG71Seq21Cc00mF4ru+7HVvb/XJvJY20DrA==
X-Received: by 2002:a17:907:9281:b0:960:ddba:e5c5 with SMTP id bw1-20020a170907928100b00960ddbae5c5mr39077044ejc.11.1684232708841;
        Tue, 16 May 2023 03:25:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709061f5300b009596e7e0dbasm10695764ejk.162.2023.05.16.03.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:25:08 -0700 (PDT)
Message-ID: <578a743e-dee4-59b7-2f4e-290b551211e0@linaro.org>
Date:   Tue, 16 May 2023 12:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Content-Language: en-US
To:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230508131515.19403-1-bbhushan2@marvell.com>
 <ea9ae4c9-2808-bf22-70a3-bb7e7b1168d0@linaro.org>
 <DM5PR1801MB1883175A2538B85FEF571B7AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <8119eec8-0190-b6a5-85a7-301bcb81b0c9@linaro.org>
 <DM5PR1801MB1883A414F47BB56E9537673AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <8b540cc2-bc0d-9d8b-45e6-98410322b3f6@linaro.org>
 <BY3PR18MB4737947E20CB44CE6DAB940DC6799@BY3PR18MB4737.namprd18.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY3PR18MB4737947E20CB44CE6DAB940DC6799@BY3PR18MB4737.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 12:06, Sunil Kovvuri Goutham wrote:


>>>>> Marvell have octeontx2 series of processor which have watchdog timer.
>>>>> In 95xx,98xx,96xx are the processors in octeontx2 series of
>>>>> processor. So
>>>> octeontx2-95xx is on soc, octeontx2-96xx is another and so on.
>>>>
>>>> No, 95xx is not a processor. Otherwise please point me to exact
>>>> product datasheet. Hint: I checked it.
>>>
>>> Looks like 95xx data sheet is not public, will remove in that case.
>>
>> We can talk about 96xx. Can you point me to the SoC named exactly like this?
>> Hint: I checked it.
> 
> To recap what Bharat mentioned before along with references to individual processors.
> OcteonTx2 is a family of processors
> https://www.marvell.com/products/data-processing-units.html
> Please check for "OCTEON TX2 DPUs"
> CN96xx and CN98xx are two silicon variants in this family.
> https://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-infrastructure-processors-octeon-tx2-cn92xx-cn96xx-cn98xx-product-brief-2020-02.pdf

This is a product brief which further suggests CN96xx is a family (or
sub-family).

"xx" is pretty often used as family, not as product. Otherwise how one
product CN92XX can come with 12-18 cores *in the same time*?

https://www.marvell.com/company/newsroom/marvell-announces-octeon-tx2-family-of-multi-core-infrastructure-processors.html
"Marvell’s CN91xx, CN92xx, CN96xx, and CN98xx processor families include:"

https://www.marvell.com/products/data-processing-units.html


> And CNF95xx is another silicon variant in the same family.
> https://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-infrastructure-processors-octeon-fusion-cnf95xx-product-brief.pdf

Again, unspecific product brief. Your other briefs specify them clearer,
e.g. CN9130, CN9131

> 
> Since the HW block is same in all the variants of silicons in this family, we would like to use a
> generic string instead of different compatible string for each one. ie
> - const: marvell,octeontx2-wdt
> Hope this is okay.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

> 
> Same with CN10K or Octeon10 family of silicons.
> https://www.marvell.com/products/data-processing-units.html
> Please check for "OCTEON 10"
> 
> CN103xx and CN106xx are two silicons in this family.

Are they? "Up to 8" cores, so how this can be one specific silicon? One
customer buys CN10300 with 8 cores, second buys exactly the same CN10300
and has 4 cores?

You are mixing families and specific devices.

Best regards,
Krzysztof

