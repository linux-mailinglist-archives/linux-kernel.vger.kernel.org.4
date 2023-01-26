Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27167C9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjAZLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbjAZLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:18:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622142DFB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3043317wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3zgwj/N2m78fr4mQomhV+/0L8iV0s8h+XqoJd6wA6U=;
        b=LXLuoY62A52JG2d1O1qQQxvByARad/iGJzYq2HxpgW8+sUarqND5Kz5zV4gyPoNL1i
         yq9Mr6mWWPDplbks3qmsHiQPllaKr+R+859bmxlHrnqwGHCvYKV61T8L6KD2TIDB9qkO
         b4H8Q+jVKPt6Sl9NySyFGKGgb5eAyLUztAkIVNkWxBmVq+Ri6qHYIJ73RMW1tenreXwA
         Kdp365+K6AFazBHK8Igp2A6JTTEzf9jFdzEZayIwn+ZrZqiCG9SZRbu+wexvfOZcV0aN
         qpARl0E3/2XT1NKblMYE3xkN8O4r3xMJ8rVtguA2OUUd1SNFcVeObKX34hUczu1mBkzh
         5zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3zgwj/N2m78fr4mQomhV+/0L8iV0s8h+XqoJd6wA6U=;
        b=O4RhL/t2Z2QqTpNfJ2m86AUb+Ha2UPtctxmFzW0aq1Jx2akjiOWA4y/2eFvSQ/ASV8
         Id3ziDoYqyfyFexuAbysJT80Nq+4IEg2G7+bvtEMLmhGWzUP9/m6lYOESH5e2GGUqGko
         oC3KlRzyoEDOY4VTo8zyrxe3eQZMzR9KolQNJ10rjvtqtBDzoRWFUJRNuvaspkdZjcJ4
         0oj4QBdThbcOG3mwbCWO+sO4B00+VsUXui7MwL2bHzcXnslG41+J7ZtJTrZ6g6VOs7H+
         1XC/LEFqsKZcbBy07Q75xTbofCHdD69CuXVbUPgtfT2PTzLnhHW+Pn+cXBWQaaGrljCG
         tr8g==
X-Gm-Message-State: AO0yUKXPEXg7LXSOasuyQsdQH6+eVCfnHbmX3ZsyJmcFXlrw2FgkRvfF
        cv1tK5HxQCkCCp1GahKn4o/PGQ==
X-Google-Smtp-Source: AK7set9lB/2kTVzhBnU62TmJMHNYHvsyX3yIGi3D04EymHpXcSdwKyllD5e8qRMiDwpXFiut+Ar65A==
X-Received: by 2002:a05:600c:310c:b0:3dc:18de:b20d with SMTP id g12-20020a05600c310c00b003dc18deb20dmr7272177wmo.33.1674731929685;
        Thu, 26 Jan 2023 03:18:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c071500b003db1ca20170sm1136755wmn.37.2023.01.26.03.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:18:49 -0800 (PST)
Message-ID: <407f1860-faaf-be6e-cde2-17272e65ee87@linaro.org>
Date:   Thu, 26 Jan 2023 12:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123193422.15972-1-ansuelsmth@gmail.com>
 <20230123193422.15972-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123193422.15972-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 23/01/2023 20:34, Christian Marangi wrote:
> Enlarge opp-supported-hw maximum value. In recent SoC we started
> matching more bit and we currently match mask of 112. The old maximum of
> 7 was good for old SoC that didn't had complex id, but now this is
> limiting and we need to enlarge it to support more variants.
> 
> Document all the various mask that can be used and limit them to only
> reasonable values instead of using a generic maximum limit.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

