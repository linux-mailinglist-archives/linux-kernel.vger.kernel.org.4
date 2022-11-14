Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DA6276B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiKNHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiKNHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:51:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915E18B37
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so17886424lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiMkPfL4TaX43cTSqxFmRtCWQDwDmotoTRN5srgH8bg=;
        b=l4qNAJrpTvrOTNZI0W0UQxGZ+OcxdevBwxodFb4Aotb9i5Zbx5IGfdtwFU7lRqf6HE
         7mcOTtX1LkYwrvuapwgat9OBPdzx8u3ZAE/EddITssfUWlBTV39s7mCb10OZ3CctsNYV
         9A5tD39cbn2YNNtDPGO/dzJNrBLiewfsLYYaD85+GUouJ+fxIPuiQnS/fT2vgYPj++Ox
         AyRE5Z17yeAdMIrki0X6r+HBCjwXR5FicdyC1jxtMjLnboTB8HFxsAg/M4rz+fOEM7cD
         WwyfrOP48Wd0Sr2mHiUNcu+vvD5BfM78XBakKSBgSm3RuowUMJhSCEuM4tF0V1zkbpC0
         R/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiMkPfL4TaX43cTSqxFmRtCWQDwDmotoTRN5srgH8bg=;
        b=fukFxmn3S+/aOLX5h5noj3vGg4I4ilhHFhmioFkEUM6vS5s0BlaqijA2EmnAVktpBS
         /oGogvxQyECVT6Fytp8ea5qkkUnYuyBMI2o7yULpSnH7WzaucA/qXTQ+4utyW03L0iCF
         v3TPLu6EwsmY8S6eAiieOFvZ6eHjqeUtFLY50LpKPjQilBRRkb9Y+0aosMiOa2MXpozh
         0hyYop2UnfdO0cv4G8D63XgI9TurwlWx/J6dNo1X4ApfabGTAe0v6O+5H+WL6/thWQ3X
         4KcD2coQoa3jv7GWVAtmnZV3PvqFMv441DARcCUVzgwAaXagDFFkrxzWs0iHbtJNki7n
         dAVA==
X-Gm-Message-State: ANoB5plpd3a4gcpxJfbNfFGlKOA4moj5PpkEFOS8rjpd5urkaFTT3CN1
        I1kCfB4oVGioaxeSJp9AG5DvqA==
X-Google-Smtp-Source: AA0mqf507uN1OcY2HiTma/elM/Nrb9rt1qRtQluQ77d0nJ4OxYmxTrhg+GexdGOyXPA+HaVeLudQqQ==
X-Received: by 2002:a05:6512:3f9:b0:4af:baf9:7d4 with SMTP id n25-20020a05651203f900b004afbaf907d4mr3542499lfq.460.1668412293537;
        Sun, 13 Nov 2022 23:51:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020ac24148000000b00492c663bba2sm1716829lfi.124.2022.11.13.23.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:51:33 -0800 (PST)
Message-ID: <ec5beb10-25b8-8c14-f5d4-4a8f5241edb7@linaro.org>
Date:   Mon, 14 Nov 2022 08:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v4 2/3] media: s5p-mfc: Add variant data for MFC v7
 hardware for Exynos 3250 SoC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
 <CGME20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b@epcas5p3.samsung.com>
 <20221114054655.68090-3-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114054655.68090-3-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 06:46, Aakarsh Jain wrote:
> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for

Please run scripts/checkpatch.pl and fix reported warnings.

> Exynos3250 and use the same compatible string as used by
> Exynos5240 but both the IPs are a bit different in terms of
> IP clock.
> Lets add variant driver data based on the new compatible string

Just "Add variant"

Best regards,
Krzysztof

