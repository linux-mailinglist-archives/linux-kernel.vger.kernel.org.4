Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370AC638977
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKYMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKYMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:12:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9C4509D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:12:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j16so6568196lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIDCe1F2pbbd2Mgy1MXrte4UDEybWJsDPNOb5ZCnmZQ=;
        b=UoBk6bEFZdln6Gqli1w+RnWCFscF0VbAqS8Ag3LpE2o4H48mryNm6HdqsmHags6EXS
         xWOJNeT6QcZWbiloClD2sl8WKeKQxA/oVklAnjTYhvwL0MBIZZbi0m/y1XM39p/LtRe6
         XpN1GYXTREaIVvk1MIvWnXe6oVJVfxwCY60WiH5GTVCDt+JtTHdJqv9kjD34DsxOgiC1
         Ri5SWYvCQFnsJDigQUQa3BP50L8u1oWeVq90QxGOBOZSPsFaFjX7LT0bkVQILYZGu9Bo
         HB0m3lHG9D9VJ2rtsyhYlFf8TOnWdfoUOZnhPu5vISCEQa0tbrgHTG6kp+nI0tM8MpRc
         P/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIDCe1F2pbbd2Mgy1MXrte4UDEybWJsDPNOb5ZCnmZQ=;
        b=VPjfJjBCXoqb2Ip4UX7l+Nr8W63Y0ZuwPWZdfJxoDP5UIKMnM7qK8fFvh7MlyQMkrV
         4g72BMj030wOhDTc0FdkRIPTTV7ml88VB8KNgyBLyUlvd4waaMIuHv+3rMkrCXpoWN0p
         3zTPN/1X2mfEDdES6ZNYw0DtlyOSv/f9Pv28LiFQ9PYZ6R9k1rnGP+jYcG0mDQRpiHRu
         1ig4mFGaind0A1T1jTAuPPNgrJEcGSX868ss9lo+7rK7cq6sNmgw1BXDhR3v35i2iM7S
         NLFru+3RNHHJtaw+PGc4m1S4NS/m2U1VuFq/fXv2Mw0QGN6v73ghLPfiRMZfWAcCS3mA
         SfYg==
X-Gm-Message-State: ANoB5pkEKfbiidd8sEKHbZKhmwjCRmks6G34BAM4UC1tMpqCM1uHmQ/w
        L0NI1PFAuKSJO4c60OWb/fZePA==
X-Google-Smtp-Source: AA0mqf7AYDN1omQtlSSqKyibMA+E7LIJY49giATJQ8eBdw3MdfOTWsmmF57QotBfyUz6z3524orkhg==
X-Received: by 2002:ac2:4f0c:0:b0:4ac:2f5f:5c9b with SMTP id k12-20020ac24f0c000000b004ac2f5f5c9bmr6226180lfr.206.1669378340651;
        Fri, 25 Nov 2022 04:12:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j17-20020a056512399100b004b257fef958sm508060lfu.94.2022.11.25.04.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:12:20 -0800 (PST)
Message-ID: <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org>
Date:   Fri, 25 Nov 2022 13:12:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
 <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 11:34, Lad, Prabhakar wrote:
>>> +/* Device, Non-bufferable */
>>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
>>> +/* Device, bufferable */
>>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
>>> +/* Memory, Non-cacheable, Non-bufferable */
>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
>>> +/* Memory, Non-cacheable, Bufferable */
>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
>>
>> What are all these? They don't look like flags, because 3 = 1 | 2...
>> they don't look like constants, because we do not use shifts in
>> constants. Are these some register values? I also do not see the header
>> being used in the code, so why having a bindings header if it is not
>> used (DTS is not usage...)?
>>
> These are register bit values for the MTYP[5:2] field. The DTS example
> in the binding doc (above) uses these macros. I haven't included the
> DTS/I patches with this patchset yet do think I should?

Then why storing it as bindings? Bindings headers describe the interface
implemented by drivers and used by DTS, but this is not implemented by
drivers.

Best regards,
Krzysztof

