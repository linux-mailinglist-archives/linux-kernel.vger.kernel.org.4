Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3656ECF68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjDXNl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjDXNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:41:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB85A25C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:41:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a39f6e8caso811451966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682343679; x=1684935679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaIQnz6MXqt2DQqm+j81XjEmEAepSn6x6b2vVwOA/r8=;
        b=Z24T99B2K6WIpfvpeOOJRygqcawNXLKO7jrdBzF5m6/dbB3G1LZ8UKuIMKaGPaldC5
         6Jc2P0l3WY7jVZ8DSYPrr/XqO9Ov06Kvp29xkObnSW0Jr66RnckZ+eO7SVnhL/+9mvSE
         5nOnvarHVVuTYKo/SXGNIlXx6oHH+alDz+6ABlJ//43An6qbMdvAskEyDCDwPqByANnf
         UJpTHPbejQk9JdzMwVSkREw+KTnYFAStaUPhWz9AgGDuIXp24SGIYG6k05gBKNCulFaK
         fyL3JB4APsm8lHDyFBsSRhMcni8uEUUNE6B3/hdSWc35K72DwfM0JfnOcAZibLPc0rVF
         hnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343679; x=1684935679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaIQnz6MXqt2DQqm+j81XjEmEAepSn6x6b2vVwOA/r8=;
        b=gSitcnACCbdMkeWpxP2yyCSVWsEx91OPNAxMeaX9hAX8fkzV5xo2Q4loL9prBF8LIg
         ljD5yw5qTNPslnASUc16vfIU3wAyoRXrukHnqBk2Ooncra/OrCDy7Lxc2oR1y9259JLb
         +jJcaXgR7nWvzeppccZidE/WifSD2g+dMGVhRDDsgCdLbNO8Av2mBUrTd/us2QMXaDO1
         8MZy8LuOrCxsdGh0Zf3t5ezgQpK9AaNnJHtMeUM1nKg1iCfMLYBv7JkVtY+7zbYR/Cys
         k8uRrNehufj0BkKFtS0rS6ZIj3Jr/krEkHCoJtqJn12X1tEmvYB8NS/ncmLFSh4PTItZ
         7uaQ==
X-Gm-Message-State: AAQBX9cjsJR9UOx/bEzae+11d/PawSHUrFkyqdoKMjwj6hNH2M9vqpHH
        Ko8anzu64946m8H2i86sqKyrTg==
X-Google-Smtp-Source: AKy350ac4lFXsh0hd0rlvk7HVYQfKXNgNYgbE+v29TI5Z1Kexk6Qatct2y5fk+TDPg4S/eLXCwM8OQ==
X-Received: by 2002:a17:907:7208:b0:930:b130:b7b with SMTP id dr8-20020a170907720800b00930b1300b7bmr10133898ejc.6.1682343679630;
        Mon, 24 Apr 2023 06:41:19 -0700 (PDT)
Received: from [10.105.146.163] ([88.128.92.195])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906105800b0094a9eb7598esm5416370ejj.120.2023.04.24.06.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:41:19 -0700 (PDT)
Message-ID: <8213dc69-5128-623a-004b-c1691a297ddb@linaro.org>
Date:   Mon, 24 Apr 2023 15:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch v7 0/8] Tegra234 Memory interconnect support
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230424131337.20151-1-sumitg@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 15:13, Sumit Gupta wrote:
> Hi All,
> 
> Thank you for the review.
> Requesting for ACK on the remaining patches and please consider
> for merging.

You know, if you haven't make it a dependencies and request to merge
everything through arm-soc, the memory controller bits would be already
in v6.3.

Best regards,
Krzysztof

