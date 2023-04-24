Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2676ED066
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjDXOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDXOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:37:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1059F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:37:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f7a7a3351so825905066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682347054; x=1684939054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKF0Q2cCHsYATyTnjEGCFebP5yuIhL32CPd8lwpuJSs=;
        b=vhi4CLtiTD+Xbkr2y/t/18rdTuCOkl/jSE+P9W7hMLsnmWULhH3CFBmxskufvA1qPN
         9uI80bLXCszZ3i7j6f8v8knHXwvSI+EOQx5t9Kqiz5bXQCELgt/kT7qXalwJNTki0SMy
         n8pbiXoATiPSXNpYt/0J58tjJBEGF09o2m84Ga0+mqdtbo8a++zMQZCphUE/+uL3gv/Q
         UoyYki5+pqsrLmd2ZPBpyt+TCQOBt8cMZCxrSuLaLkK+jhCnd4luS6MDZE1QqH7a/6Wn
         ZLvaz0DmgwcvABYm0iMgYLr93ZDEafKT3ugWap2QfPU8C+BRKjXljihPGpDAsCELUYgh
         CKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347054; x=1684939054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKF0Q2cCHsYATyTnjEGCFebP5yuIhL32CPd8lwpuJSs=;
        b=jGvLdTqYREFJbdffpqysdtWvxw8z2vfp91hutldOyXIp1rTs+9Ug0V+XUPd/S5dQts
         cvxxwQXVXakP5QexSpEDcN1WVHU4PjXyLM9YVi9nzr63NIiD4zGPHMjKTsIblU51935d
         cg6FxuYEwlNMSZ/R8egDHaXM77VW2x4QEBgr+1ct6Du960JYsHYJUGMdJ7qOLE/GUbMb
         3YHSrjSCTBMH3K1Rb0WNSHZLBG5CWu3zPLya8LLTM1q2ApXwsyJphu381fwbX8LWz7gM
         PdafVOFcQ/cMZ5wH6EWfG6cHs/DVq70qcpPMoBZquRcaBeCsZVitsl/lZ8yxQE26OPe6
         gjyA==
X-Gm-Message-State: AAQBX9eBdF2otBBDo7HAqxYdwPLk6scONmIzAZr+zZM04vliLlGORf/h
        yXnc89oqjrA5+s/Xie81LLDsTg==
X-Google-Smtp-Source: AKy350b5Vvu3r4BolsJSQlKVvbia6hcsiR/aOZX/ur298uTB2CJnH168NiqJrn9YFBzu5hZCe1RViA==
X-Received: by 2002:a17:906:1345:b0:94e:61d3:d13b with SMTP id x5-20020a170906134500b0094e61d3d13bmr10027267ejb.75.1682347054153;
        Mon, 24 Apr 2023 07:37:34 -0700 (PDT)
Received: from [10.105.146.163] ([88.128.92.195])
        by smtp.gmail.com with ESMTPSA id bh20-20020a170906a0d400b0094fbb76f49esm5685415ejb.17.2023.04.24.07.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:37:33 -0700 (PDT)
Message-ID: <bc6c0012-d7f0-c8f5-bafb-71b05db7a501@linaro.org>
Date:   Mon, 24 Apr 2023 16:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 0/3] Add support for ESM
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, kristo@kernel.org
References: <20230424105011.70674-1-n-francis@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424105011.70674-1-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 12:50, Neha Malcom Francis wrote:
> Resending as no major changes, commit subject change only.

That's a new version. Keep changelog - for some reason it disappeared.
> 

Best regards,
Krzysztof

