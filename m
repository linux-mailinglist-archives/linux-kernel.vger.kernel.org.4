Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24096963CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjBNMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjBNMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:46:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07B22A12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:46:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o15so12196436wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxmK5g1abaNwwSCB60QD2b4u2X8cfC3SrJxt6nIz5VM=;
        b=fyX7C6luQjo3Uvrx/Hg6E2vN53n7Qd3dRNOi67CoqqpE3BkCwMDs04ZHs3zvutJ7Ww
         hnbAY7GDIzg+2bYuGlXPBPP2C8jF30pSbdhwr+JR1/Lmqka3s2TmSg59WgDScG8sXAgR
         WHBGa3g0iiswVQ/n8eQnJcDEnQ3H3Cw6afjGN6ACVHuUo5rqWUNSipK7OPo3IfRRhhs4
         7qxaFZo/oRvfq0Epg7ZzXRNOfH1oob+cwURWBFElv4Sslb18q+MMEeB5qn2ArTKzkW19
         lSKFAIYm9IVyJWb5qpLfQmZ7Tgs26iMR0cNqIFrd26h7gbLV5ucsHC1g0MLhnA92PjR2
         0Tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxmK5g1abaNwwSCB60QD2b4u2X8cfC3SrJxt6nIz5VM=;
        b=oYmwSb/cp2ZDKwEtSOQvVP+8lXdnWU5eqGBifgijB6trA7bPk+rdKzzSgWXnnscZjZ
         /V/nQSW8mqL96t5Biq6lTf+xO0ypez63wRZnLSElIY2rm3HFGCdzPYT0ptvGJ5H3BQFA
         J9p+gaxcZo/VzhTKs+Qof3CRB5IzNAMGFpBy0Zm79wrGcL1G1UqfoQSz4NhaqfjTWV37
         JRcuejXfOi6J9skx0z+iFyOIl38POWBMD7ttuU4gt6qZ/wuF7H6RdJIXExQ9lqruLiXe
         txTLd3sowxm+RSJ/i0gxyoXXICqPGQdhD6wxFBdjd2Dk5etPFjaZ6a30L+b4Pzw/r1rd
         n89g==
X-Gm-Message-State: AO0yUKWNj/nrHrerLTPXHt80UjsnU9dp8wcpciCFvNvX6A+xnwe29up6
        u8dRywt1tYKnS/ZGj9Y4DWaljw==
X-Google-Smtp-Source: AK7set8uGuMmyPwBMv604nXIvOjsb38cjXsq1318Ci8WaLUfENk4gIVSrHsTU7/f/fFYoYKYyjRzzg==
X-Received: by 2002:a5d:6949:0:b0:2c5:5fe2:bcf3 with SMTP id r9-20020a5d6949000000b002c55fe2bcf3mr2140103wrw.28.1676378780835;
        Tue, 14 Feb 2023 04:46:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002c55efa9cbesm3488528wrr.39.2023.02.14.04.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:46:20 -0800 (PST)
Message-ID: <0df35d66-d5c8-aa71-af14-d9550aa4f1e8@linaro.org>
Date:   Tue, 14 Feb 2023 13:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214120253.1098426-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 13:02, Abel Vesa wrote:
> This takes the already existing duplicated support in both ufs-qcom
> and sdhci-msm drivers and makes it a dedicated driver that can be used
> by both mentioned drivers. The reason for this is because, staring with
> SM8550, the ICE IP block is shared between UFS and SDCC, which means we
> need to probe a dedicated device and share it between those two
> consumers. So let's add the ICE dedicated driver as a soc driver.

To clarify - missing binding, thus NAK for the patch going with out it.
It's not a NAK of course for the code itself.

Best regards,
Krzysztof

