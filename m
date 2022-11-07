Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CE961FD44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiKGSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiKGSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:19:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722A1117E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:18:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so17920584lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWsXLh2L851r8RYCKJq+fTeiBfSiiVKT4hw/fDZo7zY=;
        b=pnj0uLR9fJ4eXPPSx5vdtLny3B0AGgtcshzTfn3nv25iVQZT59hBKwyjlRsIC9sntp
         jEuUijaHMRcGw3yti8oH31EW5tMd1hlxPQKFTHFsypbLaGIymVzeU1nXISqhRvdNzC9L
         PSCbYJsCrzdyzrnrxrmVR6zDmuZ1nVNQaBd6UJ8jWrAsEaOZd9DBvwz+bb4pFuvF+EeR
         oh9zSgdToRaeLlZiBTwgGWGwU/fyaCoLgF91yPovyLR0G6O3/4L2Du42WrLyqmHdtOwi
         KxOHR6xJ7HV3MizjMJBJpEeFftaccz93wkl2HmazKT5fA50FNlbD4+LardUi4tu3lJ88
         5z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWsXLh2L851r8RYCKJq+fTeiBfSiiVKT4hw/fDZo7zY=;
        b=2bxtmeS3QRvEAMwb9ZTdnYpfoUQpIBbxOierWp8dO+H62Y7T8JPq9kTVUvsK/CpzaT
         Gwdufm/jr3CHwv1ZfM2N/g0gD27uZhuxpqkvE3LsfLu55bdJT1CN/HbXabfRbW79X/+L
         yrj0XomUmu305ROvShK2WLAUjEmgiaQkl1olDyjVOGNEF9MRj+0V14fqfis2riWJ/GAv
         wazSaMnKqbDbfg9TwLE53XkEFw9dEqLCa9EKPUBvQn44bsYqEiN3JvEwhZUBEsNvBydY
         CK4P3bLOPysD0nG6uH4Et3PeVr17lbUmQXtxPNMj3w7oCs/S0gjUNKvVYp/XhSF3J+yF
         378g==
X-Gm-Message-State: ANoB5pnp1S/NBgn5niqUCdCmvcpPezHU8js4ct8Qxjg6cHCYXhWEK07Y
        Q+EllG+eJKQQV5HrmUAgufBprBmf9jyJAw==
X-Google-Smtp-Source: AA0mqf6uQrloA1xdpVDP17NsvKbFFDiNw5PsPA/9ZXq1MuCsgg9JsvymfHX6GczKvE6+iQskp7J4ig==
X-Received: by 2002:a05:6512:38c9:b0:4b2:1a29:cc44 with SMTP id p9-20020a05651238c900b004b21a29cc44mr4679507lft.176.1667845125716;
        Mon, 07 Nov 2022 10:18:45 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm1350619lfc.245.2022.11.07.10.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:18:45 -0800 (PST)
Message-ID: <7b848257-e3a4-3b6b-9986-57174e40319d@linaro.org>
Date:   Mon, 7 Nov 2022 19:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to
 rpmpd binding
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-3-quic_molvera@quicinc.com>
 <23e8a609-345f-a8ce-b0cb-2926fd86a315@linaro.org>
 <20221107174848.lwq4ma62bj5b2fkt@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107174848.lwq4ma62bj5b2fkt@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 18:48, Bjorn Andersson wrote:
> On Thu, Oct 27, 2022 at 11:25:42AM -0400, Krzysztof Kozlowski wrote:
>> On 26/10/2022 15:05, Melody Olvera wrote:
>>> Add compatible and constants for the power domains exposed by the RPMH
>>> in the Qualcomm QDU1000 and QRU1000 platforms.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>
>> Looks good, but you did not Cc maintainers and  they must see this patch.
>>
> 
> $ ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/power/qcom,rpmpd.yaml include/dt-bindings/power/qcom-rpmpd.h
> Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT,in file)
> Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)
> 
> So you're right; Melody did miss Konrad in the recipients list. But he's
> typically doing a very good job of keeping an eye on the list - and both
> you and I got the patch.
> 
> 
> Why didn't you add your R-b if you think it looks good?

Because then you would pick it up and that I did not want. It shall be
resent so all maintainers get it. I did not check though how many of
people were missing.

Best regards,
Krzysztof

