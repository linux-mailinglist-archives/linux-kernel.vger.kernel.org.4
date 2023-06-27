Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4073FD11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjF0NpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjF0NpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:45:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93A211B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:45:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991f956fb5aso161223066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687873515; x=1690465515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCgJkdEEyunIECiH+1imlT3YGzipKdsZqBxVSz2hzhE=;
        b=yEW2RYhaMp7O0Z7mBIYWx47qxCbbBC4kSyevnPwtr6Tu0coluudBLKH6m15BlQpYn+
         cJDuTKCYgLXeWHos+R8qLp9feb4/WwTv/+uof1Ou+6Iwo1T0e+MEQVOQq5RsrMazadZu
         69Az0u/b5gjl3lE0hMeLyC3uVppD7akAStRCrCYiWQEVqvuiMev5gWMXpv5hh9xkkcf1
         EAtg6C8C9WQwsQsEt1eCqXUiKA3MVwremt76YObWu8CQl+mcI4F8mVFHZGW1rNcD+w72
         i5zPK1FSGo/Xv/eOsjaaWAruPi2hhoXRVAkCpPDQF8pzP7CtVeVGIoe4YEIYw8KVSmd5
         GBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873515; x=1690465515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCgJkdEEyunIECiH+1imlT3YGzipKdsZqBxVSz2hzhE=;
        b=QIGsxnmQdrgEiA68qnNdlYDLCcUon0EHWs5i6JM6TpY8yBrgKmbJ5d2uGOlaylI2bH
         DZ2Tsxq8VZvb1l/B8qpqifuALjZ+1umt+wSfb29gbv74aPFOWQ+K6fBNbBRwB75EeorV
         ilW49yz7luv0hxA8ZssmCAr7lCnsamiA0olNwW//hie6MELOKHYhBFFTtw+JB5bbsoxr
         fVl/Ii47MSw+grdWR+iFdr8l+5H4g0ID0y9g1UpSBK0C51BHu2duhizBhYguF14EGuVK
         51U9Om4arKtR2VX1qU3x/OUuvsgnPR+QiARwNWyForJ4dmC2jmIraUpMr9TcsToAwcG7
         wwNQ==
X-Gm-Message-State: AC+VfDzLaBITHqAGvXBdwEvxsdKFuelyFgQtwsOx1s39GukyTlfLxEh+
        pQzYBZChunNyAefUoX/tTHCmsw==
X-Google-Smtp-Source: ACHHUZ7xNs87HMMWtByJqpHlJHnDFoSkmWTxbl6mYxdivUVK9EldUno8mJHdDxO9cD97xkI8YLQ5MA==
X-Received: by 2002:a17:907:74b:b0:971:484:6391 with SMTP id xc11-20020a170907074b00b0097104846391mr21886195ejb.20.1687873514820;
        Tue, 27 Jun 2023 06:45:14 -0700 (PDT)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709064d4600b00988c6ac6b86sm4537989ejv.186.2023.06.27.06.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:45:14 -0700 (PDT)
Message-ID: <3ea32af9-406e-f6fe-1df1-a5988015dbb0@linaro.org>
Date:   Tue, 27 Jun 2023 15:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
References: <20221209-dt-binding-ufs-v4-0-14ced60f3d1b@fairphone.com>
 <20221209-dt-binding-ufs-v4-3-14ced60f3d1b@fairphone.com>
 <1f94de94-c5bd-738d-5fbe-907558333cb2@linaro.org>
 <CTNAIDCV0BIO.2JMX8MXEQ197U@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CTNAIDCV0BIO.2JMX8MXEQ197U@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 10:29, Luca Weiss wrote:
> On Mon Jun 26, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
>> On 26/06/2023 10:15, Luca Weiss wrote:
>>> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
>>> bindings and the example to match.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>>> Reviewed-by: Iskren Chernev <me@iskren.info>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>
>> SM8450 should be rather converted to qcom,ice.
> 
> In v5 sm8450 is now using ICE, both in dtsi and binding example. But I
> guess you could also argue reg-names should be purged from dtsi and
> binding completely and to convert all existing dtsi to use the
> standalone ice node, right?

It would be good, but that's no exactly my goal. My goal is to have
dtbs_check without errors.

> 
> But I'd also like for this series to finally land at some point, we can
> do this later, okay?

I need to look at v5 then.


Best regards,
Krzysztof

