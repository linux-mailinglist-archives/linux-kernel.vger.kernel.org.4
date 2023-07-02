Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1D744D3F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGBKaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:30:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C9E54
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 03:30:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311367a3e12so4592179f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688293811; x=1690885811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/AKobFXk2c7axAYUWlFRY5XKu7EkRHpm3DTOLsRDMw=;
        b=qYeuy69OwZ+bkpFiGmLnLvQV+HdgH8p5lPD1W6N+UirHmEQp/EQYsPcT5BdhVSXLC9
         AxItyQc+1FnHfifuChU4xhxfm/rXJSzZNe1KRhFTmyfN4i5VqMqZo7m82Zvib45z34Bu
         HJoNGec4gqBa5X3uvSyRZSyjR5GdzBYRmC4HJl27XkNvl9JATaW5R8srXSWZKJzBCnq1
         nBNkY0RsiWdUEgXR4T7JlB1riEbuVeeqWAcrn4JMABRXjWUHVz/TYNfaaHf7LUKHD5Vk
         DoQbA4SLBYpR04RSQxq9buZbfgKmRVdTaF2rkV4xq1XR3Ei78FSMxscPGsnWGayjAQHP
         +Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688293811; x=1690885811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/AKobFXk2c7axAYUWlFRY5XKu7EkRHpm3DTOLsRDMw=;
        b=fl+NfPRVaIodBhCEV4aivNEkV2lvVANTMR8ELgvF+kyESCznDynw7IMcJpR1xO9VjQ
         5q/CQ6ShKvWfsbsh5PXQDRVaqXVX1PNgG4OpK+MteUMHguG2seFkvg4XtwrApxkjN3Mc
         RqIdeSuMxIa+M/fp/mxzE7CwyGnncvd+e619+wgdL5DH6nRZqDEer6C0sEN51Bmg0kUu
         jCXEm6TPxyYy+8rCvcb3sCtKdDqKwxeDvzlA2dYeyRBExEf9smWF5M38S2k/yDdQ+S4F
         FCG4iRrUcJJCmWZOPz0GlEPZVjx97fqnt7ReEOsUOP2KtsZtY7dEs45X7n2xmr+2HN+P
         qn4A==
X-Gm-Message-State: ABy/qLa2kmHtnhytB7ds6BEBNlYHBmVf+AllRzM2bEQurFhokF2gToH8
        mCAmMFCOf2dEdyaSkhsRTE7fZA==
X-Google-Smtp-Source: APBJJlGd1Q363NUQ95fT39f6EGsQ1a//7/2PXR2vnTVuYr5WHw1UQOY0P0dU26vA//L8rrC45Cvh2A==
X-Received: by 2002:a5d:4ac2:0:b0:313:e161:d013 with SMTP id y2-20020a5d4ac2000000b00313e161d013mr6654510wrs.15.1688293810652;
        Sun, 02 Jul 2023 03:30:10 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm8969693edw.87.2023.07.02.03.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 03:30:10 -0700 (PDT)
Message-ID: <3348348a-ee62-c9c4-d9b4-0df6745ff6a0@linaro.org>
Date:   Sun, 2 Jul 2023 12:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/7] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS register space
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230630151436.155586-1-nfraprado@collabora.com>
 <20230630151436.155586-4-nfraprado@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230630151436.155586-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 17:14, Nícolas F. R. A. Prado wrote:
> The binding expects the first register space to be VDEC_SYS. However
> this register space is already assigned to a different node on both
> MT8173 and MT8183: a clock-controller node called 'vdecsys' which is
> also a syscon.
> 
> In order to resolve the overlapping address ranges, remove the VDEC_SYS
> register space from the video decoder, and add a new property to hold
> the phandle to the syscon, so that iospace can still be handled.
> 
> Also add reg-names to be able to tell that this new register schema is
> used, so the driver can keep backward compatibility.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

