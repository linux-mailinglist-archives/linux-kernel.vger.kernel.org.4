Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4673B1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFWHlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFWHli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A81BF7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:41:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-988b75d8b28so31906366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687506096; x=1690098096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t85IrXe5Gy1UtuYRgufXU6wb2wKm+nFKsdS4DPhPVgQ=;
        b=RrNp3eAmEYHDnaS+qaGXeUSRDgZ6ochaH6qth2Ja2jmqqB3zX08crrrvAswX44Qkgf
         3SUR+1Pc1obhjfbWjsEeUcjLcxUEvUZ9aibS0721fa/mNadEYSE/cwpERvUSv1jtOLyf
         FuCWUG8wek1fLfS0umoBT60W7cU4PYCqRQ0B2Wh83AgUK2HiZ+1QHv0bHkCzOk1EfMDV
         i+/S4dSLP5vp9O3HgxLNogBbvEeh8M+ibtIjCkVU5Qy8blujmDCOOucCdnxgvJcbCPuf
         qorE3GWuIChtjboDAGcwbWA5FvpbE5MIDgLTVLRpnc7e/WF2Xu7mdUiTFGFIiDlzpI5X
         kGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506096; x=1690098096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t85IrXe5Gy1UtuYRgufXU6wb2wKm+nFKsdS4DPhPVgQ=;
        b=K5TzzWubY84mSUYTIfgvOOMSkdnJ5jKO61MVqp8g287FnqZ50bpgt7srf31ywHJutu
         +h1xg3Li5OC47cEOCQL5Y0KzxLafULXBsicFjetM6WLy+sXSmhpv9XvphPhv6MlB+Bbl
         ukmEnXE9pLg/NhWsz8tfTjdy1dIlwvEoakzaRPp3NM3++AYuqDm8PDNugWGK0vAYO9z3
         XuiR+yOIvmNf1w+1ybYIwfx0Cgj9J3Oxdxrp8WPhVFb8culU0k4suLl11aWFq3IKUSAM
         8QN7CL1BdskfgqGp9VHDeKhYDSU/fGOLFtaLvOyudWbWqjgOVWgBd7ZUxf+TsxAgCDlJ
         pSFA==
X-Gm-Message-State: AC+VfDzWd5q59GI7AVWLCJ1PhkOIVHwFAQCxXX6FQEnMAkcBTi5mOAL1
        rS5G0zDuoyL9PUVxNVTspMD3nw==
X-Google-Smtp-Source: ACHHUZ7qmEzE5D18lr5WtPTSeFpa7/HaK75FX9sQiuH3eg93b2tgRs9jBlqBpuHolbtweB+TLOmIVg==
X-Received: by 2002:a17:907:7ea6:b0:988:dfdc:5a29 with SMTP id qb38-20020a1709077ea600b00988dfdc5a29mr10368758ejc.5.1687506095911;
        Fri, 23 Jun 2023 00:41:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709063a5a00b00988c93c85a5sm5620290ejf.183.2023.06.23.00.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 00:41:34 -0700 (PDT)
Message-ID: <cdc19e56-54eb-5476-4e79-28b9dd7372a1@linaro.org>
Date:   Fri, 23 Jun 2023 09:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 0/3] usb: misc: onboard_usb_hub: add support for
 Cypress HX3 USB 3.0 family
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 09:28, Benjamin Bara wrote:
> Hi!
> 
> This series adds support for the Cypress HX3 USB 3.0 family (2/3). For
> now, it just contains the USB-related aspects and ignores the option to
> connect it via i2c (3/3).
> 
> As the HX3 family operates with two power supplies, multiple power
> supply support is implemented (1/3).
> 
> Thanks & best regards,
> Benjamin
> 
> ---
> Changes in v7:
> - 1/3: %ld -> %zu (thanks to lkp)
> - Link to v6: https://lore.kernel.org/r/20230620-hx3-v6-0-6a1d6f8ce689@skidata.com

Please give some time before resending bigger (non-trivial) patches. One
per day is usually enough. I still see some kbuild robot reports - from
this or previous patchset, so are you sure you compile tested it on few
different platforms?

Best regards,
Krzysztof

