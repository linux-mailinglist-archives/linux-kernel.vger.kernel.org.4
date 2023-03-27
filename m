Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826416C9CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjC0Hr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjC0HrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:47:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898F1981
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:46:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b20so32102270edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679903193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb4tmemzNzPfIOjPtgMNPF0CGomNiXxN8XvI9oRSmNI=;
        b=VOfYyK9i6gZs8IWKGfI37YsIXxvoNnvPus05sLgBEuQYEVjULkcjsjyFNivEOsYqvf
         FDYabVFqnS1vndkA7pAb61k2xYxFdDu2+xLecPJuE2FIXTU4bndsTakmFPrJAkt0E44c
         NTJldoufbchjv82hpKqsFaXg5TmLrDoPsY/STlri88zmsTVABenlQmfHInDPDblJE1Ks
         xgB/szC11Y2g8HBr0Fn1Q9A1/UHPMZI1v78/6S02XjYf9kgLd/WKyJFWmZ0XIbBI9FgR
         bOsJzirVpDJMdkimwZM8u7Q7Bs4mmxcerQ3hC0PcKvea6cICA28v4JaWajIg7BsoYqNm
         brMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb4tmemzNzPfIOjPtgMNPF0CGomNiXxN8XvI9oRSmNI=;
        b=dviuzAmfm5FeiAX3JaF8QWKBLNWoz0Wurut1PZzu02w36nL5GwKZz+u8nrioW7B//1
         vGSKLwlOFe8/1p3HHvM5bRizId6WAFQerTxgmK2tAqMk8oLCOc/bKxtPf8WS1XpAvV8j
         Vug8/Gkyvv2grM4TRpK0XWWelTRtEp0DNVOsXjCnq/5W1t4q6aUJstOCbHOn0ujVRDnb
         H1JsZw5Ba6Y7Lj+ft+UtMLpB2R6HSWBf52wZuJHF9uuaG8B66Tc8LXe3i+wh4DLNjD9z
         5onHxOiNGsq2fW7YStGZoJa2TDyte7oBeCvhfnKcTeoNdK32IXo7IU4AO2VqDrclSpVf
         i5pg==
X-Gm-Message-State: AAQBX9dY6rn+9r8svmvmkNVfkNOjmyVJekddUTuG4KbNaFlh1gkbqxCN
        PMm0w9NiXVTULIFCHVNSxWYOlw==
X-Google-Smtp-Source: AKy350ZNWA0feM++fE9Wdn2rh/TytZ36eDYbHVPI+fh8qG3pqwsASZFFXhljXwAi23S7uHcsc2ijNA==
X-Received: by 2002:aa7:c646:0:b0:4a0:e305:a0de with SMTP id z6-20020aa7c646000000b004a0e305a0demr11834978edr.19.1679903193519;
        Mon, 27 Mar 2023 00:46:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm14246435edd.66.2023.03.27.00.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:46:33 -0700 (PDT)
Message-ID: <6f6be544-48da-0c22-ea54-e07e35131ec9@linaro.org>
Date:   Mon, 27 Mar 2023 09:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/12] Introduce the SC8180x devices
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
References: <20230325122444.249507-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
> laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
> laptop.
> 
> I would be great if submaintainers can ack the binding patch so that
> everything can go thru qcom tree

I think Bjorn recently was rejecting taking bindings patches, so what
changed?

Best regards,
Krzysztof

