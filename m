Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022873FD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjF0NrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjF0NrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:47:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC730D1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:46:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so5066117a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687873613; x=1690465613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovdi3NoFM51haUam0p0BHU27Xr8YaY7wpx+YxNLA8fA=;
        b=vHuAAeiPDae36BOR/3xcpceQeXwHjd1clPQd7HXDxjfwz16HpoOFB3sJmx9M4iqeM0
         45GcuRtECK9sRSJMzdfz5jiMjD3+icLeG0xuXttoOjRieKAzOtW6XPyZaOuFPhqIZi83
         gpMxrFJOOFf56FVs4KwaB1v8O0BEYVNGLxodYqzMZnYbvt6Bden7br0zHQrKp1fALApC
         1WzLbD33ic0OhlWfH6n8t1aFMGGOKZp4U5lwlKaPQXIYqjjk7/uiObyVxksf3tF0k24K
         WHcDg1VkJcY++zt3KfTcoFlCqGoNf/S126nCf8r4+VpAXfmqrK2BFfdk6pfCDQLlRQSo
         Kc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873613; x=1690465613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovdi3NoFM51haUam0p0BHU27Xr8YaY7wpx+YxNLA8fA=;
        b=M7RCzmFbiw3gIo0u35F3M33smAfLTr4OGuxTXA+PR1O1ISnXV8KTXK32qqk6s5PWxz
         EaeCxY/qpkdIgBI6tki0SgwaimO4vl1rbfX1LK3kDXbuExri+y8sCfJj9kshrQg/qJNa
         iNStAN7cGfDLQKuydcO2F/GtbK/UGoOkgh85PR8ZBF1A5h89HrDeudQ4U4Jui8JDSzwB
         9R/xqryLaqnAN15BRkYqeQ53cqvBA8afOabN2EvpS0kk/LsWcvkL+2jilTZzqi1xT/O+
         mFxbAzHG2eCagXYlPOQY72s/iVQ3WxGPWJCdrqM3Wz+aROdfdANnSqEt8cXVedGXNZmU
         rwLA==
X-Gm-Message-State: AC+VfDxFgAh6hK5VM7Xp7q3CoLZKgAZOfSFqt6DDwh8WraleotD/2paW
        0RXrb/QO+178XI88M00vm2WGIg==
X-Google-Smtp-Source: ACHHUZ7Pgq4TaD98zOdQJZwiNqdo6lU1g3UzFJniq6T+CNL/Dtshy/7q83LPm0cpURchTf+OcpaFeg==
X-Received: by 2002:aa7:cf1a:0:b0:51d:91d2:335b with SMTP id a26-20020aa7cf1a000000b0051d91d2335bmr5492032edy.1.1687873612834;
        Tue, 27 Jun 2023 06:46:52 -0700 (PDT)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7d90f000000b0051bc5adc942sm3858850edr.47.2023.06.27.06.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:46:52 -0700 (PDT)
Message-ID: <25ca1872-3ea2-aa44-37f0-13510b81dd50@linaro.org>
Date:   Tue, 27 Jun 2023 15:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/5] dt-bindings: crypto: ice: Document sm8450 inline
 crypto engine
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
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
 <20221209-dt-binding-ufs-v5-4-c9a58c0a53f5@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209-dt-binding-ufs-v5-4-c9a58c0a53f5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 10:28, Luca Weiss wrote:
> Document the compatible used for the inline crypto engine found on
> SM8450.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

