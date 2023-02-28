Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD816A544A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjB1ITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjB1ITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:19:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CAFEC46;
        Tue, 28 Feb 2023 00:19:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52A386602E18;
        Tue, 28 Feb 2023 08:19:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677572368;
        bh=fVVg1Oe8kqqB/BkhS1jgx+11KmQgwD13uKhiAsbngls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nO1R7DBBcZRJXbkS/4Q9JMHKaByMPOYF6twaPuQC0x0mlQ64uYAZ6L5fpJ8UP/Ldp
         cRz6cmWxej3svM0Bw0sdUu0MdPwO3S3pq9zrkeOht9dph+Et3I5r/XlDW8/Hzp9JMP
         c9Mgw6YCNXsgLxDyxaSqhl5bZPcnYJu7DJmo88ETktaPsbH72qGxZUpsfOGBsTfCvz
         H4RcBAHmYEQTqFnQWKjDAm1ttYy9WyCbOb9aFJB4JRc7ArUk/GpBmVSOgATTdEPPb+
         pMx3jb2lrUQp4geUGEiUIgly2Zvhc0HPVH3E4zzr9mJrlHVYdqc5agCbVPqO1L1dW3
         DLpp8QuoYqPig==
Message-ID: <5e7f9d22-b918-bdfc-931c-0e679c1e946d@collabora.com>
Date:   Tue, 28 Feb 2023 09:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-5-67aed8fdfa61@linaro.org>
 <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
 <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
 <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
 <8a813713-c60d-4726-0c62-de032db99ede@collabora.com>
 <CAA8EJpprXe3k6Kecg6v-QHT-qP=QjimFZFpLWjPqky3M=J+x+A@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAA8EJpprXe3k6Kecg6v-QHT-qP=QjimFZFpLWjPqky3M=J+x+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/02/23 14:20, Dmitry Baryshkov ha scritto:
> On Mon, 27 Feb 2023 at 15:06, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 27/02/23 13:01, Dmitry Baryshkov ha scritto:
>>>
>>> I took a glance at the 'cpufreq: qcom-hw: Implement CPRh aware OSM programming'
>>> patch, it doesn't seem to use the header (maybe I checked the older version of the
>>> patch). As for me, this is another signal that cpr_ext_data should come together
>>> with the LUT programming rather than with the CPRh itself.
>>>
>>>> Konrad, perhaps you can send the cpufreq-hw commits in a separate series, in
>>>> which cover letter you mention a dependency on this one?
>>>> That would *clearly* show the full picture to reviewers.
>>>
>>> Yes, that would be great. A small note regarding those patches. I see that you
>>> patched the qcom-cpufreq-hw.c. This way first the driver programs the LUT, then it
>>> reads it back to setup the OPPs. Would it be easier to split OSM-not-programmed
>>> driver?
>>>
>>
>> When I engineered that solution, I kept the cpufreq-hw reading *again* the values
>> from OSM to keep the driver *fully* compatible with the bootloader-programmed OSM
>> flow, which makes one thing (in my opinion) perfectly clear: that programming
>> sequence is exactly the same as what happens "under the hood" on SDM845 (and later)
>> but performed here-instead-of-there (linux instead of bootloader), with the actual
>> scaling driver being 100% the same between the two flows in the end.
>>
>> Having two drivers as you suggested would indeed achieve the same, but wouldn't be
>> any easier... if you do that, you'd have to *somehow* make sure that the
>> programming driver does its job before the cpufreq driver tries to read the OSM
>> status, adding one more link to an already long chain.
>>
>> Besides, I remember that this question got asked a while ago on the mailing lists
>> and there was a short discussion about it:
>>
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2555580.html
> 
> Ack, I see. Maybe splitting LUT programming to a separate source file
> would emphasise the fact that it is only required for some (older)

Maybe. I'm not sure it's worth adding a new helper file, but I don't really have
any strong arguments against...

Konrad, your call.

Cheers!
Angelo

> SoCs. Other than that, I have no additional comments for that series.
> 
