Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78F06555F1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLWXQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLWXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:16:43 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC831D642
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 15:16:41 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m15so3123906ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 15:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo8+qziymdofRv3UJT9Vr9QEs/JxpV0VfpNVZ4a+DD4=;
        b=YAOggKjqGks5q6E6bbeBGXMAkHu90HOkHroiwF6ex86LsVjJ/0yQzaIbd5QI5R5jZ0
         siRkbHK2ZocCTF21MTjD5Fuf+SIgjz6+OjwtTOi0UEMuxuj9G6nfIO5fpOeY9Bi55Ewk
         aFdwufpJTV0hoxzNQ4Xos9zykeGJrsb7i4/as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo8+qziymdofRv3UJT9Vr9QEs/JxpV0VfpNVZ4a+DD4=;
        b=XMXiCt6IxtguuWyjqMIwCtxeciNJoh+I7wYrH/eZluw+exiFzNX3lc58oNR9qdaE0R
         OWK00OxdJ+RJfsAQTT3nVRzOQRKT8RgSZZ5N3q/fsVwXNYlR0AEQJTY2yPdiK+K8lGNc
         bDf8qTy5npJMXfadRD1Mn/RpoIqPpRoBBZNbpdiG0PuXJSv1P0lg5GjHwLhVB42Pi4lG
         nvEcUvzDSQ94/zFl38wrtT8u21xVdbBODeEY48GhVAdc7rsLZ7znk0ivW0GASfWJ4wPK
         2uUStgFSfw3rRR0iaxWUsuSjsc0ntCqQQXJIQT5KnYmqPRUa4SUn9UWlwOcUB8i7UkEd
         QVoQ==
X-Gm-Message-State: AFqh2kp3Y7Xh8A3WeUqoAl6/63HMPA9atVfW1S39QPca89cevzb8fUsa
        tYwf6SdYPcr9IVO49HJkauwwNQ==
X-Google-Smtp-Source: AMrXdXtBCjEBL3y0Ms4Y0lvLazdMaD09uL52cX3vuS/Jzd+aLpCpsyh+6V4TXnGydLIPvhXO6sNOUg==
X-Received: by 2002:a92:6403:0:b0:303:18a7:815 with SMTP id y3-20020a926403000000b0030318a70815mr7324272ilb.17.1671837400889;
        Fri, 23 Dec 2022 15:16:40 -0800 (PST)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id z9-20020a056638214900b0038a57c147dbsm1346255jaj.122.2022.12.23.15.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 15:16:40 -0800 (PST)
Message-ID: <207bdc58-c0f6-8a95-70bb-fee7d4749bd6@ieee.org>
Date:   Fri, 23 Dec 2022 17:16:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: enable IPA in
 sc7280-herobrine-lte-sku.dtsi
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org,
        quic_sibis@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215224552.1232449-1-elder@linaro.org>
 <Y5vDXm4oo2cn3etX@google.com>
 <CAD=FV=XsUXCzjKbLvOd7M-CPQi13pf9dvpvLwLQnsoL0m-5xCQ@mail.gmail.com>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <CAD=FV=XsUXCzjKbLvOd7M-CPQi13pf9dvpvLwLQnsoL0m-5xCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 4:39 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Dec 15, 2022 at 5:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>>
>> On Thu, Dec 15, 2022 at 04:45:52PM -0600, Alex Elder wrote:
>>
>>> Subject: arm64: dts: qcom: sc7280: enable IPA in sc7280-herobrine-lte-sku.dtsi

I'll post an update with your suggested subject line.

Thanks!

					-Alex

>>
>> nit: that sounds as if IPA wasn't enabled previously. It would be
>> clearer to say something like: "sc7280: only enable IPA for boards
>> with a modem".
>>
>>> IPA is only needed on a platform if it includes a modem, and not all
>>> SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
>>> used to encapsulate definitions related to Chrome OS SC7280 devices
>>> where a modem is present, and that's the proper place for the IPA
>>> node to be enabled.
>>>
>>> Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
>>> DTS files for Qualcomm reference platforms (all of which include the
>>> modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
>>> enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
>>> to enable it.
>>>
>>> The only other place IPA is enabled is "sc7280-qcard.dtsi".
>>> That file is included only by "sc7280-herobrine.dtsi", which
>>> is (eventually) included only by these top-level DTS files:
>>>    sc7280-herobrine-crd.dts
>>>    sc7280-herobrine-herobrine-r1.dts
>>>    sc7280-herobrine-evoker.dts
>>>    sc7280-herobrine-evoker-lte.dts
>>>    sc7280-herobrine-villager-r0.dts
>>>    sc7280-herobrine-villager-r1.dts
>>>    sc7280-herobrine-villager-r1-lte.dts
>>> All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
>>> for those cases, enabling IPA there means there is no need for it to
>>> be enabled in "sc7280-qcard.dtsi".
>>>
>>> The two remaining cases will no longer enable IPA as a result of
>>> this change:
>>>    sc7280-herobrine-evoker.dts
>>>    sc7280-herobrine-villager-r1.dts
>>> Both of these have "lte" counterparts, and are meant to represent
>>> board variants that do *not* have a modem.
>>>
>>> This is exactly the desired configuration.
>>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
>>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I'd agree that the subject like proposed by Matthias sounds better. In any case:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

