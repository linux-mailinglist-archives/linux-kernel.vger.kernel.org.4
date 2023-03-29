Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6A6CD475
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjC2IWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC2IVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:21:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC78558B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:20:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h25so19087171lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDEZImdx7nfwOHvp4OeGgm65ZkjVGi5Ql4SNtee6RD8=;
        b=sn4gtOWUAijsH+th7lILTt6mPbspY3c9QElMIqDJ8w3lVNCEs7Z8zi7FRabQEgkl0R
         xsUPvxtPaRoTdwlDw2+Wbs18WSysCU1xw2BtKpNRc8aImg6OmF9YeDVtnrTng+il4QC7
         c+W8lcBWrVnbIACihneyKtboYiiZm+giGZvSjQWjzzezAYR/XWRE+9iuvtKDE6VSrx7H
         EYQWV0Cfsp+wk/a9G0TPZC1kuuiiGYKsi7NRZvm/6BD4FMZ9DkCf1dZ1tyqzZqXD/oA+
         H6jfIWUkcJ68guazfBLNJUZheyVtLrC9gi0VF4QF5XwySB0J48ABf4zebiw4L1yRtAwk
         NVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDEZImdx7nfwOHvp4OeGgm65ZkjVGi5Ql4SNtee6RD8=;
        b=qO2ejnC6uySRk5NQatYqdOoMfvzrk8zg6dDxM3/MHU6PjS64VwNkGGIgygyHNcCz5i
         tbnoyM0RUzEFSt3L9d1gPszR5Cs8av6lTaZP5MwLwc9Tf8zwDM/+ogNAnUis4hl5zgdT
         m9uTo3Jy719CdwqcIP8qlTfb0iyv2LkqpnXd86KzFpUDf7GLgdhFux0sMHw6hZ/ckszi
         K9NroOFyS4Lp6PTqja3pXzLtXU+9fB78pmuh5zSZYsYB+l/ST6+yxp30fRBpPt7DYRXa
         dRfRpHM0WQrfBi2ZaWYJ9N5Arc4H/XnabNmJP1/2FwTJ4kIBTmcenOZ+pB6buGowssWL
         TU2g==
X-Gm-Message-State: AAQBX9dRWHnm7P6SRcE4JwdRQ1dnBjyUoZSni5gQksdY+vbkt3n6GXAL
        KfWbMKJePzJCJfLub5ETGAVeSA==
X-Google-Smtp-Source: AKy350YuQqZwb2YTBHv7l0OviW05o4Ewp7fcXR4dK/s6jfhETNu5ZQYcF4+AHDyPTfHKB74qAi3nTQ==
X-Received: by 2002:a19:c206:0:b0:4ea:f632:474f with SMTP id l6-20020a19c206000000b004eaf632474fmr4916464lfc.40.1680078035478;
        Wed, 29 Mar 2023 01:20:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a19f50c000000b004b40c1f1c70sm5391002lfb.212.2023.03.29.01.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:20:35 -0700 (PDT)
Message-ID: <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
Date:   Wed, 29 Mar 2023 10:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-8-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 uart driver bindings.
> 

This depends on clock patches, so it must be taken together.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

