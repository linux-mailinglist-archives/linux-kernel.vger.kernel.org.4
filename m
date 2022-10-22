Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B7608E78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJVQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJVQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:25:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7C6AE89
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:25:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j188so6583224oih.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzLyt5KfVsh3C7/6psv5Axae2ZfgYzJFYNPQgsCwAN8=;
        b=LdemYcLSDbSaXNV/CjOK/zFEEfU+FnjOmzQvaW5igezJetDTDh1c/ltQ1d5TxPSD6Q
         KMyH94CfzBVhND9YZTyWT/2GugBos82fuLDwZCc4ObnLahqa1eA5eryaIEe7YxtDep09
         mGV2p7UIxom18re8/dFcoVaPxtCDR2TTPo4l3lHgDMDehSP8PgK0CdNaCqv4Ay1IXGqK
         0WdjZwTRu4962MkskdEgvf0YZbyGkdETnim3vh4PX5ot/bKidVVRLS8CQCQNn6f7m+um
         P/a3eBNCfGrqKwxWEHUTwF9MibTzgBSpo1b0RvrJO93Xbze56admw1ZuQl+Lg6XXLJBW
         L7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzLyt5KfVsh3C7/6psv5Axae2ZfgYzJFYNPQgsCwAN8=;
        b=bT7QjgQO/hGMZI2t2yqYNtAo7xApk/Hn5FmlJen5ZBAlQyz82q/bN36TBviixvWIsK
         ExkfTW09bXiI9U8KCm/PjOUVJ+n5AaXFXnDJ/X59lV957jGeT1lAjeENKLB9ZHlmy1TE
         VWTz4jEIZ4spo0QMR4IunCw581vzOus8vqCGzH/0rg+sshC8FZYDcSLuYdDN+mFdzzGp
         XSqyBaTZ9aNAEBkksXdlq3fTpDUA61rXlnKt03RRJdzxqX2uEWoh92sPa9JpC+Se5Bjn
         JISByWV4OaWpSYyiK5bqbK1CQuf6hslod45PtCrfn8Fw6yEq0xY6DZpyjynKcR2J9WpF
         cxfg==
X-Gm-Message-State: ACrzQf2kf0hznS7XOE6rUlAgKBNkVC8BAOLkOJzX6/PGyCp0CQjlhKDw
        2a9en9Fg+CDqPpK8ftByshLXbQ==
X-Google-Smtp-Source: AMsMyM6G/qBQ5q+e3exrCCY2O2Iwx3RvA6R1ab3lI2MiOifZwLs0NLsdCDsaszoZddt7PqF/v0GliQ==
X-Received: by 2002:a05:6808:b31:b0:354:9436:2e52 with SMTP id t17-20020a0568080b3100b0035494362e52mr26858262oij.1.1666455864517;
        Sat, 22 Oct 2022 09:24:24 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id ce5-20020a056830628500b006619dd066fbsm2421041otb.5.2022.10.22.09.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:24:23 -0700 (PDT)
Message-ID: <dfd381b7-bfb1-732e-d3ca-9ed463c55bb6@linaro.org>
Date:   Sat, 22 Oct 2022 12:24:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-thermal: Support the RK3588 SoC
 compatible
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
 <20221021174721.92468-3-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021174721.92468-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 13:47, Sebastian Reichel wrote:
> Add a new compatible for the thermal sensor device on RK3588 SoCs.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

