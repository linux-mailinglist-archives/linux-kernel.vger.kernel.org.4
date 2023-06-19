Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DF735154
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjFSKA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjFSKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:00:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7517E74
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:00:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b4826ba943so4294431fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168810; x=1689760810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgtgZC+NWCmbR6AgbaQUNv+TVCdcpACa8YYNOaYVq6s=;
        b=u4QFBKx7tQmyQGEIg9zHlgovL7arAs7XdU4ib6zvOnsvUrXGsD3tkIQQhbGdxr5/mz
         SGeVJsqoSPwfd+YdhGDv8H55ln9D7JZQC4rrpJcnmdssdbPxug7q3sZiB9Hbvo7dRAsT
         +6M2OyG9ccnhfDDuoucW+MONXvSkX9x6epU148mqVCCrm1PTKCfZwANNNDs8vFID9cc0
         EszcW1dZy+rkx8lL9GxLAMqzWyDFQVOB2qs4FWI9QuGMCt4s6B/AyJkoSXuamlWNHHgV
         CQh/WKGLUNUobusSDg3gNLA/4qfST4z1p4pxcHmfw4O7MUBRXF71ctElv0ijsVVtrRgP
         DbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168810; x=1689760810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgtgZC+NWCmbR6AgbaQUNv+TVCdcpACa8YYNOaYVq6s=;
        b=SikUkINGthjfByI3k9YwCMgZyPsCQlWvngplqsFBKLidK1+8gS50Nh5+SVPWU3BAPU
         6snsIaXvExG72JNcQi1MuzAYATf2dAV2/ppW8yPfoEFavZWZ8/0oA3LvRQfPkdYNWQu4
         nOX9HaIV6GUKRhuIxbWbOCuKM7PxZ4n17bxEsq0UDnIevEEfmDLFEkDhAdQ3+qmMTjp3
         bqr3A5l9B+4Rn8R8ssEpR+aUFIxN9udM5RA1gtWmmdFm54fv5nHscw/K7AV6ftYZI4dB
         ZZsvppeNeB46/y2EHEFtx/BFuePC3THRQuLoUOahhVMkza9j2mDKLeyWIcvyM3YEbBlQ
         Kw0A==
X-Gm-Message-State: AC+VfDyWOcLdONFsmhi/hJnOqHUe9vYUq21aQzjsGNLODTnyOudi6Tnc
        eKHgZjTSeMYVhQyDUmRDhk07hg==
X-Google-Smtp-Source: ACHHUZ5Kw0cGvG0SbexzELcxNJo/BkSOmCE9JHC/OFXkpSOmiVIDXuyi6fVNnbuArOZ7110bPSCNjA==
X-Received: by 2002:a2e:98d6:0:b0:2af:3141:a52b with SMTP id s22-20020a2e98d6000000b002af3141a52bmr5791422ljj.22.1687168809898;
        Mon, 19 Jun 2023 03:00:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a2e860f000000b002b44bcdf809sm2039965lji.87.2023.06.19.03.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:00:09 -0700 (PDT)
Message-ID: <23cecdde-2b24-a472-1497-5da9f1158c00@linaro.org>
Date:   Mon, 19 Jun 2023 12:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] dt-bindings: firmware: qcom,scm: Document that SCM
 can be dma-coherent
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>, andersson@kernel.org
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
 <e89e574c-db6d-877b-462c-bb91cc9d9ff1@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e89e574c-db6d-877b-462c-bb91cc9d9ff1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.2023 10:07, Krzysztof Kozlowski wrote:
> On 16/06/2023 17:14, Douglas Anderson wrote:
>> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
>> normal TZ. On TF-A we end up mapping memory as cacheable. Specifically,
>> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
>> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
>> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
>>
>> Let's allow devices like trogdor to be described properly by allowing
>> "dma-coherent" in the SCM node.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org
> 
> 2
Forgot to press alt or something

Konrad
> 
> Best regards,
> Krzysztof
> 
