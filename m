Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31146B0544
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCHLCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCHLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:02:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4CC149A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:02:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw28so64093689edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0ZB63Z0EuHBGN7h3pjkBD+vV3b+1Ob9vWpelsqrwK8=;
        b=K8r0k70dpa/9ezVzeJMQzrnE66QawLgu6Pn1RdHD9q1MyH/kwBz0JI5QSXKvaJyy4d
         Eibj/Q6uX5XO9aXEFxFbm7j6KaZKKhVRr4DbV7VDZ/EEcnYxS3SswweOLheJmTqN7Dat
         4p8yOkTAWfUklkTEnmN0F4RIdaoHXaP9PbQHi+GEi1Y1I3QoZSI8qbgB+A7Qt4dE9niL
         qTnALIqWDjTGUuaL9muEaFy+CGLo31VJqrEnJqh+C8iK448eG+TG38/GcdAbyg5PEILb
         NReLa4jcDH5yEfetU7gcuflHRLT2F50lZPGE/6Gy1oyemCD0AwP/afVNBx4xg6n9nzGY
         vw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0ZB63Z0EuHBGN7h3pjkBD+vV3b+1Ob9vWpelsqrwK8=;
        b=ISfK/O9xOZiwzUIK4dVBz2HPZxDxPkKy6li+0Z8JyjpQ2JHQTkHiNS7BjbmXFdwg7K
         fowIivzfiR2qWV3FDAI4zX6zGWmErOmLhMj4FLuJCYAn3BwKxI0XJBnQyi4BVnEPnJBr
         Mf0hl9DNBIqN95yUZVaJLnglwIEItrN13UDpU96IJ4YRygdRtDtRDYqrU/nMndqnIAgn
         dYuIXlmMp5SLtHzuOVGM7V5WNEGIWaLhnrAesRxbZ29ufamWwGcJyr6kW7U10UYc5Pu2
         i8uHazayuCpIvnSDoMVbqpUwgaiscCfeHWu6dHcEjEmo4pxs+ap720F/q/AgCQYqFrds
         w/AQ==
X-Gm-Message-State: AO0yUKWYpVDyZRlJbE7Tl+2tLE2KrtkFJh5PsEXqfDqy7QRkFvSqWxH5
        gWhgrctJjdHrPH5j4d+3d6BHdQ==
X-Google-Smtp-Source: AK7set+yQObMeUURTtJuMCj/guA7XpAEF7aR9VxBzmGvqwCoEJDhQcT7JOmpVfvcLrnK3Avbf6fLFA==
X-Received: by 2002:a17:906:d51:b0:886:50d:be8d with SMTP id r17-20020a1709060d5100b00886050dbe8dmr19716178ejh.13.1678273325755;
        Wed, 08 Mar 2023 03:02:05 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id le16-20020a170907171000b008da6a37de1bsm7474357ejc.10.2023.03.08.03.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:02:05 -0800 (PST)
Message-ID: <1a915c33-ef32-852c-a856-10c8d35be151@linaro.org>
Date:   Wed, 8 Mar 2023 12:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: correct name of
 remoteproc_nsp0 firmware
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org
Cc:     quic_shazhuss@quicinc.com, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307232340.2370476-1-bmasney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307232340.2370476-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 00:23, Brian Masney wrote:
> The cdsp.mbn firmware that's referenced in sa8540p-ride.dts is actually
> named cdsp0.mbn in the deliverables from Qualcomm. Let's go ahead and
> correct the name to match what's in Qualcomm's deliverable.

I don't think vendor deliverables matter. linux-firmware is here more
important. The file will be cdsp.mbn in the firmware, won't it?

Best regards,
Krzysztof

