Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A0695C44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjBNIIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjBNIIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:08:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581713D4F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:08:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j23so14762226wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iN3ZMqjZosbU/hI1NsSGntsECLWbts5tczKkDQ3dHxE=;
        b=Z5R8LJFZQF+sFxGg3eeP3py7bOQD5ul95g9EmK+/vvVJ342mee6DCybq4m7ubfLwtT
         wdKlLvtOJav9X6u780Ls+57PZnVx/x+OxhH5rSljW5e+ZJb8LFoagn/z3/CwfxUX5y8b
         gPJhqEj1TnWiZ1sw/RyIJk/DD7EWQ2CddJlgI6ei7HCY//k/try65ujUVTaiaofSpVSF
         z81oxGFfPTW6hXaxPSqzBCEMlhY9VAl+efSkBrUckRR59OOlId5oFmhLWwqk+SA9GVPx
         vSAYqq7a31bsWawmwrOxIU2dUU2b/VtfSnz3M9F2slRESU/jmExBKRbCOj+2MvQoFaNs
         9XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN3ZMqjZosbU/hI1NsSGntsECLWbts5tczKkDQ3dHxE=;
        b=QwGHF9VYjcTTSgE1SjU9EkucgYCE90FJs3GSvoPxDHQCFYbj2+GgZKXWD4iEWv8eHY
         lvZoIcVl1QY3olkNLZinLsDvxg/w1+/P3bSIy1W5xk2FcoO0NjNbBPVnp8MhrVeGZOMp
         LBHoAcooLqMHtCHXSssY/vC7MlCpkeudQAwUhnDHVOvtnR4GKu3f+D4z4qRM+vzVqplf
         tKvES5QVBqVDFdliqNuL1n1w7fMthk4l5lJKD1DGYVRJwahhqcfmGoQtDJdDnuRT8Up8
         VnmlJDdVSr0VZS7KIEDKCzfOWn5JF/Wcqxw0fEgctRO94sS5BelT1hky6zKNEgbklrY1
         FE6Q==
X-Gm-Message-State: AO0yUKV87my8UMtDlhl5yPb6SGXknxl/2QRj3oDxcjS4xYyLaKuwLVS5
        qxLuq/i/IFWaYJ9HqUXtwfcWMg==
X-Google-Smtp-Source: AK7set9Dc7KyT3AZCMzvREvN2+SdsG4snoQezyTd1qBf6XE5CvzudSSJGXe1PQVMBgtccGlStZ+bPQ==
X-Received: by 2002:a5d:654e:0:b0:2c5:56ff:4321 with SMTP id z14-20020a5d654e000000b002c556ff4321mr1197406wrv.4.1676362119008;
        Tue, 14 Feb 2023 00:08:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm7344051wrp.61.2023.02.14.00.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:08:38 -0800 (PST)
Message-ID: <64b88191-c419-e009-418b-174f66a5f26e@linaro.org>
Date:   Tue, 14 Feb 2023 09:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: hwlock: sun6i: Add missing #hwlock-cells
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230213231931.6546-1-bage@debian.org>
 <20230213231931.6546-2-bage@debian.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213231931.6546-2-bage@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 00:19, Bastian Germann wrote:
> The allwinner,sun6i-a31-hwspinlock.yaml binding needs #hwlock-cells
> which is required by the hwlock type.
> 
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

