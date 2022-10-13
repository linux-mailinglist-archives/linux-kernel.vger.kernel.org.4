Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529265FE41F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJMVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:18:47 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60208900EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:18:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mx8so2103222qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kapsffevo7CiEyz0RzVrGEoVlV5mkWbfwdc9eC+twpE=;
        b=e9jgQtk6B0QyKrNah7ZqUZxxivK03N2oEntaWnQfofK65ngKboOvppvw2o/ZjZGDQo
         aHjmjaaIFuMBZtc485FtqbjAKhKlcuiUewyy/RM2AjU+z1nrFjuLGVpBsITP9sK9y9ml
         WklnVabFvSNTtywMAiCGn3E/ZcFESB8ImMJySwfufwjfPL/NRoK9pYx/YFgKqzEeEQuq
         ZXFZLu7BzLeXf916YvIfaay8L6sC59nX1bQ4ippQv1J5oyrwlgGIiyhD5XG+BggNX7o8
         YKuddxyDTcA/JhkUn5Q+tCsoUcL6oAGYBrhoQs+44Lg12hlsI5EMLTkaY29481IXCSsr
         3T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kapsffevo7CiEyz0RzVrGEoVlV5mkWbfwdc9eC+twpE=;
        b=HwYp4WTr9aj1SofsNLXEuwgbhPj6m61slDMPuAc+lDOoI3iUT1nBFC132AGQDYsWs7
         HFXDABbUqFBzB3KN/7XOwBu0APaPA8xZPzIPBO0WzMsfonW0GY3E5/zsAsbI6vYkAscl
         hU6DBBPwjtcZKDqMefg7fYTt7BcFGkaoVSEBAhg0hZ+R1lyCOEsR33ZKXx559az7l0os
         bGnZJG7KCU+lqP+iNSHRU7ZssCQ9ikP8AhO8qpvUqYz/kw/0aGh8RFZ/aHacH3o3CN09
         7Shntaflisx7hW2oNRMm3txfT0Q/5lPCYbYrRlBlRHdjezQbERTCPDHmsd//6T8rjes9
         sQxA==
X-Gm-Message-State: ACrzQf0lTvU6J2CMFV3g0htHgIiiUh+5iXb3ssYRFP8YLzH7edxk9PND
        SEiCo9Hg4HoNC86vBYAFd+766Q==
X-Google-Smtp-Source: AMsMyM4ZIBu4HZXfpI+8e0m7scRAcHECSqvEtArxQcX5dfEfLzXy+g3tz2P5MPZeekNo0dqRVe6Qaw==
X-Received: by 2002:a0c:a953:0:b0:4af:a643:dfc with SMTP id z19-20020a0ca953000000b004afa6430dfcmr1823330qva.10.1665695871793;
        Thu, 13 Oct 2022 14:17:51 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a148600b006bb0f9b89cfsm613550qkj.87.2022.10.13.14.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 14:17:51 -0700 (PDT)
Message-ID: <163116cc-a5b1-aa98-01de-c24702a7aed7@linaro.org>
Date:   Thu, 13 Oct 2022 17:17:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 3/3] ARM: dts: qcom: apq8064: fix coresight compatible
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013190657.48499-1-luca@z3ntu.xyz>
 <20221013190657.48499-3-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013190657.48499-3-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 15:06, Luca Weiss wrote:
> There's a typo missing the arm, prefix of arm,coresight-etb10. Fix it to
> make devicetree validation happier.
> 

Fixes: 7a5c275fd821 ("ARM: dts: qcom: Add apq8064 CoreSight components")

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

With fixes tag:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

