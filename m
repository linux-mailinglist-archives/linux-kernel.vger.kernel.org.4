Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88646F0635
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbjD0Mwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbjD0Mwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:52:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0F1FEF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:52:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-95316faa3a8so1611695266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682599962; x=1685191962;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S7zteozI39e1f65YN+KzAHLQjEDIyO2L33ga1+sRYY4=;
        b=mCesDhSP3FewVqDSHL8uW6t62XOJs7Mm2UPiEwaNG1BQ3A+BJTogaTNooGq+Zqq8yx
         hgg738DXifPkOF9OvN2YxMQVdewpRO40p3/GCuBuzjYtQ+T0WSPShrTgw9CUs4vtqsMU
         /HANP9ecdASW/o9MRN1AfTEOJnMDLgdqwW08273ZPjgN6/xnaWxSFu03QIjBhubQlcmJ
         F5+pOy5eKt/0ZFAHMIut0AB4i8l7FPJSw7dW/HuS/TKVWM9b2DAhTMGVlhP7pmK76SC5
         wg3rJWOnWaLxuQKaYgB+MUW3cd6DWvR8/TDII532wGIJERpWPA0SPX9eGDgkLslHvLCZ
         F7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599962; x=1685191962;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7zteozI39e1f65YN+KzAHLQjEDIyO2L33ga1+sRYY4=;
        b=FRg6G8ffL5QgC4uUu4eNF8RAu2Bm11U2sNEO3eDQbSEyuq1rv8ISP+5t5mIOwA0n+z
         l4DiZ8mmbVgzwAflBEYLxY9f4F2Y74aYCc/rmsQ9cn/4ngMGQDQ+Ya7IltOfdynMa1Tr
         rMr1x+Kua5fdj87IKkrhcyjsfyOlQSbSRJKmN3asu4fD9P1Eew+Wj9KEFWkyI2b7tt/l
         IoEIaC13GHGFhri2THehOmbhYSWL2N94W6J+tPPbBbk8AIqtkCtecUqzgwl6ErP4nJbh
         gVaGJBz2X7kfwzCyUwjyzYbdUJ7wnzwxy2wQGobJTEVe6p5PQPugR0X9Pe0ijM4kEDOM
         hZZg==
X-Gm-Message-State: AC+VfDzpkyPesnLhJfZF0Tx69tU9ImPbcJWfZ1aLyOdBwgbpcZxrmjR0
        VN51YMt3LGmyKlLBx/hjrnC9A27bSfd1ZfCQlm4zHw==
X-Google-Smtp-Source: ACHHUZ7C2fjLjPXdjFbhPrME9i5Fnu4UpIc98ohf679GmbE5etDN0uDNhkWQgrKRKJuMzV1PFyNPAA==
X-Received: by 2002:a17:906:5d0b:b0:95e:d468:c35f with SMTP id g11-20020a1709065d0b00b0095ed468c35fmr1494912ejt.57.1682599961882;
        Thu, 27 Apr 2023 05:52:41 -0700 (PDT)
Received: from [172.23.2.82] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id q26-20020a170906941a00b0094f01aa9567sm9525405ejx.20.2023.04.27.05.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:52:41 -0700 (PDT)
Message-ID: <3d76d332-f1a4-d363-fcdd-b7f08afdd55b@linaro.org>
Date:   Thu, 27 Apr 2023 14:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: set variables meson_hdmi_*
 storage-class-specifier to static
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tom Rix <trix@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, khilman@baylibre.com,
        jbrunet@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230423145300.3937831-1-trix@redhat.com>
 <CAFBinCDQRwaTNLeHD973gD-g9aHOwnu+G+U2di7Tz17LPT2DXg@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCDQRwaTNLeHD973gD-g9aHOwnu+G+U2di7Tz17LPT2DXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2023 23:36, Martin Blumenstingl wrote:
> On Sun, Apr 23, 2023 at 4:53 PM Tom Rix <trix@redhat.com> wrote:
>>
>> smatch has several simailar warnings to
> s/simailar/similar/
> 
>> drivers/gpu/drm/meson/meson_venc.c:189:28: warning: symbol
>>    'meson_hdmi_enci_mode_480i' was not declared. Should it be static?
>>
>> These variables are only used in their defining file so should be static
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> With above typo fixed (or with a comment from the maintainers that
> they can fix it while applying):
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks, fixed while applying.

Neil
