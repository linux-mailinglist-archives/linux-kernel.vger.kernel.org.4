Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBE6D9EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjDFRjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjDFRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:39:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63770977F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:38:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so3236689ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802736;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jm6/z3zOtbY9jNueTA1ERmfBJwq9/SWUgmv3+goc94=;
        b=KQSXqvzJuUrpkMII+mSFk3JtEuL9g/2z/I3ay1hyHJ50iCkeDXhBJu9MweUB+QlZ1I
         fWfCCO7swoD308CffMNyWm6CeZCL43P6CpUJVWZaulSgITdz5k1KC/COASsdgHv9hyFe
         XcSfqRzhbhBGp3xEUSykiaphLqAgzuFu/7QmEBc0fgJzXs+f4wfN/h0WIatJFUmJVYmv
         udqjSkuLh/kU4co+Kx4RfsTLliTxnpOsvZhvKPb74YgOMbXS7iVprfd6Sa/smr/4Wy3O
         DJY1vhyGgRN+m1F3o581Q7u2XT3QPti/MeJaACtnYaHRJiXcxT727ymWXGyiBfufmJtE
         K2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802736;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jm6/z3zOtbY9jNueTA1ERmfBJwq9/SWUgmv3+goc94=;
        b=4OMJzPVFEg/qKrSrIOjSJ0F4fnLan9Nfw2uitKwJoLV1GuChMi2H9UE6jhfuBSF91f
         33Z6o5kKzcbmfYYpAjpeWH8QRWD74fikRsUYws7MZaxWnXARWuLDyDiJeaPH8U7esUsN
         3cJ14Y8WJWNefHR3N4SruzPI1GrnqKIxH3tdyABGSBQ13hzPU/c50H35cV014GZ4RTw0
         2cxbCpoduMhzPguDMvkT1FAL+BGaN6sMYsm3yu77EzieRWyo3rdLaRj7ltrDY1a5QPhf
         +u/napXLmAvP40i7JtyQEAJHgd1I4nqPjm4zulO7AC6P0l6eebcSBxBrr0hSGTtAC6eb
         i9bQ==
X-Gm-Message-State: AAQBX9frNC+uKN/nYZU2X81VrZ4C0LreQkuMpZFosVwNEUDinOqALp/6
        XJmKE8vmXZ/uSTzhgKxoS5L0SA==
X-Google-Smtp-Source: AKy350YVZrEszAeDepT1f3g3EF3G04yZ8f9eLpPBlIRH16dvMRX7+OLjWRipQpDZ9KlxMILetNOn6A==
X-Received: by 2002:a17:907:7854:b0:931:99b5:6791 with SMTP id lb20-20020a170907785400b0093199b56791mr6446720ejc.72.1680802735836;
        Thu, 06 Apr 2023 10:38:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id gn20-20020a1709070d1400b00946e6dd887csm1051754ejc.126.2023.04.06.10.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:38:55 -0700 (PDT)
Message-ID: <45ac9ff4-ff42-afac-9c96-a460c64436a3@linaro.org>
Date:   Thu, 6 Apr 2023 19:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8580: Convert to dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405205025.6448-1-danascape@gmail.com>
 <7c1d4762-469f-0bf9-3482-ff99bc5840b0@linaro.org>
In-Reply-To: <7c1d4762-469f-0bf9-3482-ff99bc5840b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 19:35, Krzysztof Kozlowski wrote:
> On 05/04/2023 22:50, Saalim Quadri wrote:
>> Convert the WM8580 and WM8581 audio CODEC bindings to DT schema
>>
>> Signed-off-by: Saalim Quadri <danascape@gmail.com>
>> ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

And a bit change of mind - please make it one binding (as my comment for
wm8523).

Best regards,
Krzysztof

