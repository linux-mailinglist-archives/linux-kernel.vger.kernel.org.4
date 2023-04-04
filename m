Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213F6D5C71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjDDJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjDDJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:56:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1FE2D4C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:55:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c29so41673389lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680602152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/l2O7xGhkXg80job3CbxHwv7CQHev/2/sBjYhl7ubJ0=;
        b=juWpOLyPYEkeh2ez9VFh1DA6dxgmqiaF/d0cQ6ezmgQ6ndchZqYUXmU9CMYho18i/A
         XjAx0hGVI95SUfj1Bxa16YrF/NjM4vPTmVOA+JibxoG6AFK7n7xcOXDV/Yi5Q2LSiZli
         VsCCe6Wc0wRfGex7bCLOGsQZQTvfWhFo4ftbBuU8pOLGaU6GpGTp/ypl52IGoPguIp6f
         UwbrriaNxRA0yP838tvEmf0CmkJdOs/OCEMWPtFgSQvnjVPuLmCDRZ370oouxpCGqX9g
         yui+KQHcNysE6W9QldashBfYG2KLgPSWrEBvSPwNuEXAn+34lSphHQTHcfCYRzvzKUZW
         yETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l2O7xGhkXg80job3CbxHwv7CQHev/2/sBjYhl7ubJ0=;
        b=By2yAiO3/dC0GoEJRO6EqsnWu/u2xfsAcVyFMvYOwKDt8/hRtSlgpabsAHqBNti8PL
         7SIm98QWeHBF/Iyt5qK0hhCN+nscBbpLUnZsXJndbIPpgvbhIfhlRZxeXEtjwfu8uFnh
         g/oPKLXw7gLU5Li3NFvZmnfqkk5Vpgt47cJxWb0UZcjPXF6SLXhl43+x2bhxlNsgsUxr
         IcrgEgomqXh/rrXaKDUsNbSO7mk84uDYrEN6+4kJLcWU6i6TqPRq0XzGYRBpl1eiYDMA
         KVgjodd/oiBgRmi/tlNJhL1S8vaEqeOJimnvp+mCuQ7r/QWnJKiYzrOKrpEm/qVExbNM
         s7Pg==
X-Gm-Message-State: AAQBX9eLeD+VZ88iqYkzHqFk4sMVUJSJlcrL80pfXijTkgyHzqGUgmtS
        bYmyqVyK6iMXmEXgKzR4wXs5Bg==
X-Google-Smtp-Source: AKy350aa9aBBfffj1oFXk1jPliWoUTWPFTdHcxXTdGGgXnwyyt84D4yZLmZH5+hmTHku7u567UugvQ==
X-Received: by 2002:ac2:5613:0:b0:4e8:3dc1:70f4 with SMTP id v19-20020ac25613000000b004e83dc170f4mr518471lfd.34.1680602152594;
        Tue, 04 Apr 2023 02:55:52 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id x2-20020ac259c2000000b004eaf41933a4sm2242007lfn.59.2023.04.04.02.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:55:52 -0700 (PDT)
Message-ID: <a295af57-f8d1-35c2-77e8-7d29d043e47e@linaro.org>
Date:   Tue, 4 Apr 2023 11:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 8/9] arm64: dts: qcom: qcm2290: Add WCN3990 Wi-Fi node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-8-ca849b62ba07@linaro.org>
 <4816461e-38b7-ba79-dd64-859fa0ee808e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4816461e-38b7-ba79-dd64-859fa0ee808e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.04.2023 08:08, Krzysztof Kozlowski wrote:
> On 03/04/2023 19:36, Konrad Dybcio wrote:
>> Add a node for the ATH10K SNoC-managed WCN3990 Wi-Fi.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
> We had these talks a lot... All these 3-8 patches should be two patches:
> 1. SoC DTSI
> 2. Board DTS.
> 
> Splitting superficially patchset on initial submission does not make
> sense. If you sent it in separate patchsets during development - release
> early, release often - then of course it would be fine. But hoarding
> patches till everything is ready is not the approach we want (and we
> made it clear that SM8550 should be the last such platform)
That wasn't my intention.

This patchset is "feature-rich", as it piggybacks off of Shawn and Loic
having submitted the driver parts long long ago and SM6115 being quite
well-supported (and almost identical to the QCM). Patches 4-8 were not
"held hostage" waiting for full fat platform enablement, but were
essentially "copy-paste, adjust, verify" and that does not require a
lot of manpower or time.. I split them to ease the review (~850 LoC @
PATCH 3, ~1900 LoC @ PATCH 8).

In any case, the fact that there's so many features submitted with
the initial posting is not related to me holding onto them on
purpose, they were created together, probably within 20 minutes of
each other.. This should have been posted a long time ago with even
more things (like regulators), but there's been some communication
issues with Qualcomm..

LMK how you want me to proceed with this.

Konrad

and does not
> justify later fake-splitting.
> 
> Best regards,
> Krzysztof
> 
