Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DC6AB8F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCFI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCFI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:58:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B5618A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:58:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ay14so31662266edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678093091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nHk7kEbO9AokF1qaXLUoBjyo5uXMiP5Ps1ym6YA8rs=;
        b=zB6mOdjHzdFaVpKAklcFYDkXouPgFIBSYiOLORRsZ42ops4uuY3dxvBxhmjDsgYqQ0
         6lxoVhrQtDmMqWz/idzKXRe+Y1JFu2PqWn9U3xGYZq1MJV6Qmj40IZvs97ZwXmeoNyka
         6jvhhbsYJn2jWh4eDWg4exnWYZNZnoKguhIHs+bXgd6icF4nf2yH9p+wvoF/mGn0wI+3
         kgPWRdc9k/E/jYGz+B/somaKaVl53GC1QVocRhA+UE0xZmdaLRzVWPeIs5aRsojueoNv
         tJyiSXkzLx09i2jEZOQua1O7ft0UJvknF22W2mfexsTFxErhV1VN/2ykvmoERDCBehDc
         WGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nHk7kEbO9AokF1qaXLUoBjyo5uXMiP5Ps1ym6YA8rs=;
        b=2ztubNL+ZW8d8RrkREk9aax7F5pN1uteRCCogspVm1w6kac9wZFpWHeqmZWH30Ba4P
         X2lqP9REe6jdb1h8ReM4Va0qtO1CBbO26YkcyDtC3UrAlVHJX490Ltz4Erx7AvAQoBcm
         X75VN+KZkdwuTlEE7RZ5xbNoQDJMO5c7gzCjW+ive8SuYx85jINhC1Qt08HDkLgXQXg3
         Wr02Q1nq22+Kxp9tDIRuxo70+eP70y9PgaXz3VR2jKZovTdhSucJK3w2m1X8QZIax18I
         Hd0oW2M+O0xWXbuvwKcsC607euCCzetE2+lG1JBUiZQNLxoPlJJ3iKvrNDplb/00P4Eb
         PEdg==
X-Gm-Message-State: AO0yUKUP5sJqgrUcM0y8lHbvOQTPYpsLIQ9Ldcic1wIVqqsmp5VdpTFy
        9tnId7OTeGitTSBoUFteKwnzUQ==
X-Google-Smtp-Source: AK7set/eg58r3XUsG1hqUjwssW9lMLsFRDRi9HIAsxu8Mgxs5HwT0Tz6KIuJy+VklMmlRrOnSt0IVw==
X-Received: by 2002:a17:907:2075:b0:878:714b:5e16 with SMTP id qp21-20020a170907207500b00878714b5e16mr9629349ejb.28.1678093090834;
        Mon, 06 Mar 2023 00:58:10 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id b18-20020a50b412000000b004af6e957b22sm4815533edh.6.2023.03.06.00.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:58:10 -0800 (PST)
Message-ID: <cbfa5c5e-e1ab-ca56-f115-5225b6f6fbf6@linaro.org>
Date:   Mon, 6 Mar 2023 09:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/15] dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
 <20230303-topic-sm6375_features0_dts-v1-2-8c8d94fba6f0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-2-8c8d94fba6f0@linaro.org>
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

On 03/03/2023 22:58, Konrad Dybcio wrote:
> SM6375 has a CPUCP block (which for all Linux can tell is really rebadged
> EPSS) responsible for scaling L3. Add a compatible for it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

