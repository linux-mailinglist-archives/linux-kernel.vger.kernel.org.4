Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965E6D4040
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjDCJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjDCJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:23:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E63AF1A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:22:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so114485742edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680513763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjeXiHYDWLDYDH3tp2OHz3EiswuWFVd+Ntpw6O0fatQ=;
        b=z6Av2ppJybkbEQzB/0dLSbhCmvSMg5sYHB4466FR8KqhH52rocQ3sWeQY3mdCNFvo5
         XfaL9ToasOWr2ICYR62hiz2ND++yoH3QWb+0nPmUcBtCWGHZkhKPvOcoLoU5+lKJMUKG
         C2hTVV9C8i1v1O7A89inr67fbEcNcmo3JZn85HtACkWz6CegDyAhZ0TfZtFYEUzffekY
         vYXwosGWmAZiHATxb0yuWMxjpSbHTMmnQkZuj9oWI+2USGbWIuNCGH78B7kcQzzxCUT0
         fwZH//+Tx2IYhjk41NbaurMuAep+vwsZDHnA+zPXBfPxmyFHfq1wTjmK9c5miaSfnkMN
         A4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjeXiHYDWLDYDH3tp2OHz3EiswuWFVd+Ntpw6O0fatQ=;
        b=33PxTtIAbtSS5T6z+FQ/c+OuDu9qwBFMyFRrkbyj/pm0Or3cx74//RdLf3uI3gBE7C
         Hz0blUXgTDsi2WI9kY2jDlaxfHqiuW1dZyFiT7wAeGbvPP0fo+wPe3ltO5SdUHi+h4Uc
         m2t6cUTgwpmnM5paPMrErzIKHi3HsP+ejSLuDlryOqhdZ1aw3r8mvTetFtd5JeAQXYOT
         TC/Y3F7xhVTzf9PXGem6vJytCdT/ArdAE2rk9W9AKsZRPAE93sUdxSWuq0FJrcUI/gdA
         5aSPpPxN5q4JafItgevSKP5od5J9DkSYK5rLKfR1koKbvWPsPQYyldGjVnjjusYxweoj
         5soQ==
X-Gm-Message-State: AAQBX9eJrFhtvo5+8q9vMjQ0s6//8QURE+gV9SZl89XFCyF1c3PXP15E
        C/p/vspOwXrFxZ8oODaizSxy5A==
X-Google-Smtp-Source: AKy350Yj5ESiRy5699EV3GW6T9BfJpuMHWCkbBNGLqd26yEE0yjjj1FOYFwSJySIaibJItggeUy8Yw==
X-Received: by 2002:aa7:d5d5:0:b0:4af:63a7:7474 with SMTP id d21-20020aa7d5d5000000b004af63a77474mr30655770eds.17.1680513763451;
        Mon, 03 Apr 2023 02:22:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id b17-20020a50b411000000b004bf7905559asm4347630edh.44.2023.04.03.02.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:22:43 -0700 (PDT)
Message-ID: <5f324c32-86a3-a1af-cfe6-b41c4b3979f4@linaro.org>
Date:   Mon, 3 Apr 2023 11:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 2/4] dt-binding: clock: imx8mp: Add LDB clock entry
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
 <20230403081246.3194230-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403081246.3194230-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 10:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add LDB clock entry for i.MX8MP

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  New
Best regards,
Krzysztof

