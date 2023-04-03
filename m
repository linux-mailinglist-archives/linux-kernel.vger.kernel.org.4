Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADF96D5028
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjDCSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDCSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:21:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE42703
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:21:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y15so39230261lfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680546088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUo/oPqYc/Bc1B1hrXFD8BK+EMrCo5Xw8lmzoaSnqjk=;
        b=ZqcEOdKCBvN7yzIvm6oEUYBTPHyaOjWK/jtPHI+JLNYbn8y1ssRSHtCejkgqSChCVP
         yOx+ibhAripYm7IxfeRzVpkfXFDokE9KnQ+sQZhJxnnVHtMk63IGJO5i7sYyN63So+DE
         h4BP79BJO0itjdG/mrQXDxRLLjnStU210nLgSh6oEJKSIJeXbqoDsdWGqhGWqBYt4oxU
         Avmir1m0XbVZiQ/SCst9WhPWlMZgYCF1vDpPDV4CdP4cnCHw76PmfDWXqYkcrPJr4Ozn
         g+XtTYpmq+53zfW2s2l2VvaMHgLlozJ80xicZUjnZ/4Hmi2h33ML+uL4ArpoSJeNPiu9
         YpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUo/oPqYc/Bc1B1hrXFD8BK+EMrCo5Xw8lmzoaSnqjk=;
        b=nJ1nhBMa40CoJ85ohKQDrzTuKTdvR7qUIk45S37ErP1Cq20hFm6HhsbkJNVy34aHIl
         pqppUn78xKUCeQLvvXJKoL2M6/FuiHYgD1NUd5bkS/NWzynJ1LJ9sEuDZ/OSIjVWJzZ9
         QBrYGPpgzf1sFjm5hTuborgsnVIm9Evk6z4+JThNN5+MwoLOJoXJT1Z3Kb+KeZ2ColSJ
         Zc1qXvZYyA+BMH6gD0du2peuTm2mk+CthYnbErKATz91n/Sd+rutxpGxjOya/FoOJfuM
         4hcCxzih4peLNQ9RwLDQ0nLfjd4rHISXfJizx4zuoqXU0DRruiOgMVRGIO+jYWKMcFaz
         hxgw==
X-Gm-Message-State: AAQBX9dKt59TPJn/tWEY3f0bc1Wm2bXIgcSoyxD31YBqCBv2eDDbZSOs
        8ZrNJOSygJ3jEjRY3GGHA70llQ==
X-Google-Smtp-Source: AKy350asl33c6Hs41beIy8oeQZJfZs4hHMVNNOclSJ2c8B+Pas/icvJpH9/OOokIUoOFNwgnG12LWg==
X-Received: by 2002:ac2:59cf:0:b0:4eb:43f3:9610 with SMTP id x15-20020ac259cf000000b004eb43f39610mr653183lfn.20.1680546087764;
        Mon, 03 Apr 2023 11:21:27 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b0049ad2619becsm1868902lff.131.2023.04.03.11.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:21:27 -0700 (PDT)
Message-ID: <fe4dd395-cd1d-55e8-1be9-f588f69a8b13@linaro.org>
Date:   Mon, 3 Apr 2023 20:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
 <3f434777-c4b6-272f-1971-f9adf3faefe4@linaro.org>
 <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
 <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
 <e19393e3-5898-bff2-cc00-d88c9194c7c2@quicinc.com>
 <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
 <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
 <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
 <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
 <3c5a9608-ecd2-a3c0-e866-7d0070e49b89@linaro.org>
 <8c513ddc-435e-40ce-b1f8-84eaf8241ed4@sirena.org.uk>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8c513ddc-435e-40ce-b1f8-84eaf8241ed4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 20:14, Mark Brown wrote:
> On Mon, Apr 03, 2023 at 07:53:48PM +0200, Konrad Dybcio wrote:
>> On 3.04.2023 16:07, Devi Priya wrote:
> 
>>> But, when the regulator driver comes up, it tries to bring up the
>>> regulators to the minimum supported voltage provided with the
>>> regulator-min-microvolt property in the DT.
> 
>> Right, that exists.. 
> 
>> Mark, do you think it should be updated such that the requests are
>> aggregated before assuming min_uV is "just fine"?
> 
> We can't tell if any consumers are ever going to appear, and the
> regulator having a voltage outside of the constraints is an urgent
> problem we need to fix quickly.  Since we try to bring the voltage to
> the nearest end of the constraint the driver could always change the
> bogus voltage it reports to one that is excessively high, this would
> mean the core will try to bring the voltage down to the maximum rather
> than up to the minimum.  The driver could also look at the constraints
> when guessing at the hardware configuration rather than claiming an out
> of spec voltage, this would mean we wouldn't need to correct anything.
Hm, all of what you said sounds like a valid concern.. And then we
probably shouldn't shoot up to max by default, as going too low is
not going to cause as much potential irreversible damage as going
too high.. Especially with programmer error..

Too bad Qualcomm's firmware architecture doesn't allow for reading
back the voltage..

Konrad
