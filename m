Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8425F21FE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJBIRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJBIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:17:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6B3F309
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 01:17:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q14so5946224lfo.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u5vwi2mv0cJCBaFXR16xTWh3Sv0rQv1R6ZlbVcZs2s0=;
        b=Z25NH7UkqHJjPxoqbM8K0rUlPMCJlDJ8Rbzfk70/LuafFxXPRW8pq7GC9+7+PGDNcx
         ggOMYooosvzSkdDInDFtudXttiEGnDIDBybUm7hVQp895bEvpLH98MPepdY00j3DWusE
         00wVD/fraShm7516tBo6eF37sGuQHWHX492O0GUM9nja+x0OKJACldSfziOCFZcltNLx
         +V2y+YSr4ZLzK8SGenBTAO5xvHJdTed4EEeR0M9KsotzlbgGoIqUCr5D2raU5E65pNKY
         5XcO1aksk97dgT9iwAdRdfrxI7zwfRFKhxrN9W1dfxTRX2kxr/HcAd9X2Hk4ddD+Gwr7
         eIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u5vwi2mv0cJCBaFXR16xTWh3Sv0rQv1R6ZlbVcZs2s0=;
        b=Onz2TalueqDnzVjxQb37OiFDU+A5ZkeFi6SZoT6RiN5S9oEfN/8dJ7aZqbrWSsZKi9
         3MLLzPuPxZN4uBSoRgSw+RzEqpB+Vt+0o+5cxc57VrWHxjN+v+NfkpdpIM7Ekg5raYNs
         e5Gp7El5yj95qK67xDPpfcvUYFK0uHK8cmAvqY9XSTXxRSJ57nBObmHhP0V8R8fLkzQ0
         ddxr9MkPcuVUbPeoJGzK5neVm7waNn9zn0Ma9/3Gta3HgN3v/UFEwk/Czlvb4dwJHljU
         lwffVzL0tXRt7QyakKzCNFR96voHdjAZvHrUdi12ZsgDL7qJ0mGUp2NaU2m+LU9h6A10
         IcDA==
X-Gm-Message-State: ACrzQf096ZUlIsC6w9TQvzALJmnNQ6Oo5wNNrFJUUqnV4BzB7K6DIAbP
        titCJEfMRvy8iNQW7oSrMiRncA==
X-Google-Smtp-Source: AMsMyM7MPiVwZCk7siZV+RrnjBIXnhITNfmFjP1d0jPnDwzyRQpqWoWoaW4cduej8hxjsM3h643Jxg==
X-Received: by 2002:a19:4358:0:b0:49e:e545:3cbe with SMTP id m24-20020a194358000000b0049ee5453cbemr6278473lfj.551.1664698648739;
        Sun, 02 Oct 2022 01:17:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n5-20020a0565120ac500b0048a9e899693sm1014899lfu.16.2022.10.02.01.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:17:28 -0700 (PDT)
Message-ID: <1f077808-9e04-3098-e78e-f9435bc954a9@linaro.org>
Date:   Sun, 2 Oct 2022 10:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/1] dt-bindings: iommu: arm-smmu: Add binding for sm6125
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001185715.495477-1-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001185715.495477-1-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 20:57, Martin Botka wrote:
> This patch adds binding for sm6125 SoC

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Fix it in all your patches, please. It is just "Add binding for SM6125 SoC".

In the same time, your commit subject has redundant binding - first in
prefix, second (redundant) in "Add binding for". So just:
dt-bindings: iommu: arm-smmu: Add SM6125

Please fix both in all your patches.

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

With subject and commit msg fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

