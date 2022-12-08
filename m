Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A055A646CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLHKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLHKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:23:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841066C86
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:23:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so1066405ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+B5X/siBQMDNHW++d/NVJYttMcaz1xev1asS50hTk8=;
        b=EQQ3NvJkl389D4dVGmRkI7rzjjmUgb9H1rWNL3+YePkOU2G367ojIHLfsHdsAo1Bpt
         G8l05jUG/3HYadgZuEumI+wyElNcaHx0FTeW3EXRgyLJB3MsJDUrSpy1Qu7UVEHod6uE
         0plq1iyITpsNdTa28xmpRQrpVUrPbz7zsFSDPDGzH3HVK8HZo4KJ71Cm5bN+BJQvTyYG
         p5ncQxRrourn1artoxlR0ljkaBPNd+H5KlODWDHbtTqsrUb53GZKzamVFz5/ZLYx9qzj
         TIXikXWtokZESio2ssV8bENWplx9E5VuQRJAiHFfGOgCcASMVlryfcxnCDLoL9WSR/cD
         WZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+B5X/siBQMDNHW++d/NVJYttMcaz1xev1asS50hTk8=;
        b=e4PvCqbJGZpSXmZ+iMiswmSiuvwyrNAjK0s68qlL+TIrgtwdpMlULqi9UjOmnOpm+U
         OFhRCmXY4ZNHuu8FeGuJ2mTDb65ahmyw5RJ4KYhL1KJzgLdVMAV4/7caJnfSf4h+q+A6
         tiO07bhAEgzzUX2InM0ZuzfsTbn8DZF4vb8OFJyzVjHb2V5+AOaq1rDykkajPZMMuy7w
         Kancb0njxTrOcH/TkZJ3XtVku0pJra8I0UzJ4lvHc0Lvv4zM45CdrdzAVRgM1vHy5mCc
         l6rX+2dfIDqOCspNEg1gvR8wOhuG7GpvmQB/8E+MLdHRKwUGeZ+n3gLegDzJzTWQshvG
         zzzg==
X-Gm-Message-State: ANoB5plfUOYqO9tqOFurgt9oEdhhY2Cx1Tfv4shh9QpASwQNlnabFnM/
        +dBDHI1CSECXPz2oURMHC03qmg==
X-Google-Smtp-Source: AA0mqf4yZqf8tgWsUV7vtH0t1c6GV/jQbn+tgZj2f773cilX6ivTWQ5qvmx4rfBe7VjJ9RNWCqRjkQ==
X-Received: by 2002:a05:651c:1c7:b0:27a:267b:f33f with SMTP id d7-20020a05651c01c700b0027a267bf33fmr339228ljn.260.1670494999039;
        Thu, 08 Dec 2022 02:23:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a195001000000b0048aee825e2esm3276489lfb.282.2022.12.08.02.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:23:18 -0800 (PST)
Message-ID: <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org>
Date:   Thu, 8 Dec 2022 11:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <20221106193722.j64xrhitdencrjxy@SoMainline.org>
 <20221202093658.vg6t2ptar2arh7hn@SoMainline.org> <2656622.mvXUDI8C0e@g550jk>
 <20221208101232.536i3cmjf4uk2z52@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208101232.536i3cmjf4uk2z52@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 11:12, Marijn Suijten wrote:
> On 2022-12-04 17:19:05, Luca Weiss wrote:
>> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
>> [..]
>>
>> So the way this patch does it is good or does it need changes?
> 
> Except the typo(s?) pointed out in my first reply, this is good to go.
> 
> If we stick with generic adc-chan node names that should be documented
> in the bindings IMO, as it is currently only captured implicitly in the
> examples.  Krzysztof, what is your thought on this?

If I understand correctly, the outcome of other discussion [1] was to
use labels and generic node names. In such case the patch was correct
(except other comments).

[1]
https://lore.kernel.org/linux-arm-msm/20221112162719.0ac87998@jic23-huawei/

Best regards,
Krzysztof

