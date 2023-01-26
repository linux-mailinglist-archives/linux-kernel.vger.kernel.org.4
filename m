Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB467C7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjAZKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbjAZKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:00:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5DE402C3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:00:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2897551wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRgVXPw5t6QVo2geW3WNhb1rgDC2iA39PRv/GAVQDio=;
        b=vTcMGyXsf39j1Pv1ktHj9xKL5iJq2HfVCB7ZDr/oA7PxzZWC46OtUb07mNAD5yZMBO
         p9nPr3PZWB5lLNVS8lpvd2ZQVWNh+1zlHNlyByHZmrUIawF9kgeiP+xG7IzbRNDfUT/U
         U5Amgws9CsWnwBI7AoThUbiVUETnMsJ8ohSjOHmT0yqvv06GEYytAk00/wIMElspB0UT
         t0MzSBWCHGNE9Hpgx1H6tJyNRGPTNOSHHf1ObB2SZUx9QcQYbFbVoK0LfbSJHwpzviUf
         d0SjDF8XGuaKcgz66eQrykR9AALBDeCquTKiYuvUoDMKJeGJliInGycAIpQzTMVaLt9R
         s/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRgVXPw5t6QVo2geW3WNhb1rgDC2iA39PRv/GAVQDio=;
        b=puDCrP3m1VWEtMMiX2uhjDOXhP4Xjx4821QcO6XC2XbzVSxqZFp+L/IC+WrNWll3l5
         OwO3XgLO4IJKxvBobRQszqjXMt2RJfJQ4T3OoSqVDiP+WioQbIgX+v2dgpwz2X8hU9jW
         82m4mJ1HnIrj42GRcukbZO3qLeHITnRAoU9u0IpU80tUIACfO0XYf8klmrqyNC4E7YPQ
         +DaDUgAbHqHqOuurBS7XVotvY2J8naglkcK8LdExg3SsTYtZTimkDQHSQKKcy7lYxpT1
         FF9rQB5viQ/31usTDFCQYIhOtN533/qQwAVM2rV54Xa1OvWjgmunFebgfrIa+wfXMEmQ
         hECQ==
X-Gm-Message-State: AO0yUKUtekZmXhSCfQeo/eM33Cy/2X2HealkIQ/S5zg2gU/MN6+8c4kc
        zPhcyaUspxK50JYt7mnC4yLdzA==
X-Google-Smtp-Source: AK7set/aZLK6a4J5BP5py17o2vPlMYEYYqGkUd/mG6BXhAEOu/N3E4T9mGZDkPE1RSRpaEXhZnwoVQ==
X-Received: by 2002:a05:600c:3512:b0:3dc:2c7c:6616 with SMTP id h18-20020a05600c351200b003dc2c7c6616mr210993wmq.21.1674727211804;
        Thu, 26 Jan 2023 02:00:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aa89:e801:e296:9b7c? ([2a01:e0a:982:cbb0:aa89:e801:e296:9b7c])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c479400b003da119d7251sm985242wmo.21.2023.01.26.02.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:00:09 -0800 (PST)
Message-ID: <6d304884-9e54-6eba-1e2e-882fa6c5b983@linaro.org>
Date:   Thu, 26 Jan 2023 11:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] arm64: dts: make dts use gpio-fan matrix instead
 of array
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20211029114948.41841-1-david@ixit.cz>
 <20211029114948.41841-2-david@ixit.cz>
 <CAFBinCBVXNYG62jKABhJJt0m61+vQKqEyC4Mk5Ljg7htN-brTA@mail.gmail.com>
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCBVXNYG62jKABhJJt0m61+vQKqEyC4Mk5Ljg7htN-brTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 31/10/2021 20:39, Martin Blumenstingl wrote:
> On Sun, Oct 31, 2021 at 5:51 PM David Heidelberg <david@ixit.cz> wrote:
>>
>> No functional changes.
>>
>> Adjust to comply with dt-schema requirements
>> and make possible to validate values.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
> for meson-gxm-khadas-vim2.dts:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Would be great if you could re-spin this change but only for the meson-gxm-khadas-vim2.dts file.

Thanks
Neil
