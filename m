Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616F66CC2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjC1Osn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjC1OsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:48:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2312D327
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:48:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er13so9786882edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680014885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMuegniqFjuWU/AoMlUG2hK0eMl2E6VjLUE5zlLE9e8=;
        b=ZWL5QiItDi2M5Jnu/IDKggD5lypPhInUpNqPoRKOX6AUYd/MlPgq+fMGTW/lHcAfL+
         iGACfEQ50cL8VephyPKTmoPYNrY20L5/9jM2tHVcyEqIJZP4q2qx2pv+G5nn3zJV6Gfp
         pufhnLVAGIeUDOYSzbPC3SDTs6EvtG/nDOkTrJxVBc+hkeIYvLZszrZ3oCJTGBhjylV7
         hHao/MRzFAtSvfDCcAX+qctJSbqhRxCnaLetsFSzq4r+eALUVlCzy+2DNPLnz2PhK9z6
         xvM4IrTQoi6soDoMl8AKuxcY2SprCoXBfiCymhZ/DhrhmaNOolZ9OnOQQyeeXjx4INb1
         354Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMuegniqFjuWU/AoMlUG2hK0eMl2E6VjLUE5zlLE9e8=;
        b=nMOULCXeXwxxuTltLqhn04hCO34eSrRqwVtT0cYxxVQEqF4YzcyeWfXKkN+OFtxqpn
         ju6eKm9VpVFN07ouyD2MRPpzOlulNrI6dcAwX/RyyJUqMNOIgWLr+3ieM/nE9PYi2Zuf
         W4rB2kDykMlkl6b/v0WfDgQUAK/mEfnvKNne6Q9XXU6bUMd6U5sHiLeaDgFEofDZWmVO
         TicJEjxuSlh+j7M3TbtU11WNR3NodiAhI58rXqbBGa4wyRs7nPZoMmEQbTxczvrx/rN8
         7RoUVXl5AC/zT0lzrInMAJIq82ybOAvSPNo6vWcW2jXKTAw3wZvNd5/c1xi5wTHH/eaI
         EZSQ==
X-Gm-Message-State: AAQBX9e+hZFQzLSZ5Yvkyn+nm18PVpSmaMrfWPC387n51qm2NAYnr2fY
        BBzEQSVjVO4OOJ0NKvvup5DS2g==
X-Google-Smtp-Source: AKy350Y2xnQW9raqN0NUOlAtswBML0x4+QcffeGsP0VHcvAkCPvGxPKONFOTBXjvmT1OeAWXMIU+kg==
X-Received: by 2002:a17:906:4796:b0:93f:3084:d6f with SMTP id cw22-20020a170906479600b0093f30840d6fmr15159453ejc.18.1680014885530;
        Tue, 28 Mar 2023 07:48:05 -0700 (PDT)
Received: from [10.105.135.205] ([88.128.92.162])
        by smtp.gmail.com with ESMTPSA id lj24-20020a170906f9d800b00932ba722482sm14580086ejb.149.2023.03.28.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:48:05 -0700 (PDT)
Message-ID: <256e7c1e-c741-99f0-59e7-726c53d85c2f@linaro.org>
Date:   Tue, 28 Mar 2023 16:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
 <CAL_JsqJvOZvw7BKYZRTf3gQwyVOmhva8BFHYF8-rf5uyo_HMUA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqJvOZvw7BKYZRTf3gQwyVOmhva8BFHYF8-rf5uyo_HMUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 15:57, Rob Herring wrote:
> On Tue, Mar 28, 2023 at 12:24 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> one is not enough for i.MX8, so enlarge it.
> 
> But it wasn't 1, it was unbounded. As dtbs_check shows, the new bounds
> aren't right either.

Uh, so 16 is also not enough...

Best regards,
Krzysztof

