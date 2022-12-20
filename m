Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4B651E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiLTJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiLTJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:57:03 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CBD81
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:55:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j4so17869517lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5F3EDqHaAaBkwK8dgS+P6ptpGavemal+xXF9dHVZ1Mo=;
        b=hZUVLL7EDHfJZhxzTxFapYTZHxS7c0VQUioNmCOCJw7i9iV1AIx2pQuTp5diNyxIY/
         cvpKNTQglgXR9AuUqg7UQC2CQB2gKZ4z/WgcdYJXs9gyljd/DdNLC5w7VJWenCgoz5sh
         J9WSzDc/0h01Tkvn4MGFBCVEACSKHlM1+WdWwSTbRWwRs70Vk1Y6kwRRgJcSOXsadTWn
         6BP0Iu36PwhvgI3v8wHi3rNPkcYNEgDw/w5IWhayxkTVL2srHBSfl7a42J1aSowqmhUh
         KOw7lIuu6bDEyK06iQHrjDwEkbBI8doceNv7c2DMEoxpPMngi5YrmqgGPwgmPOSTrSMl
         KkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F3EDqHaAaBkwK8dgS+P6ptpGavemal+xXF9dHVZ1Mo=;
        b=EBazD9oPKgTh45nwQir0ab/nYD3yI/27EOixQcRSH7nndfTL+fI7VBhcZCfbxZ1gn+
         DTVDL+3TNrWtfrX/sjLEYW9TPJrtAeq4ft4jcNCNwcfsUxiAGbD5ZqxOmUv5IejzIY/p
         pRPdVLvivxL42E8MQv0qcGWGozx2qinjgbYoa+37n01rflM0FsmWh2jA/4ks/YUFa5jd
         0U6L7qyiKjtgO9rQhoVp3DvTBavlQHtrg8Qt2laHXqw4HVZSpcojqyiP7s+7nxjAJus2
         aEVFSU1pLqyIm/F28erS/T7OuH6Y+nIzohZ9lfx+b0GoYLgtWWGYBn35o5B+J/yFHZKB
         AYsQ==
X-Gm-Message-State: AFqh2koyUD+ny9856BL8Fa6OCiAsgzL71nrneagazbmydV4fFOkSk4BJ
        FhntIgLdRP/x/OCr7IrkFOQE586aoNk3O+Vt
X-Google-Smtp-Source: AMrXdXstQOU+EuywhBXn05xJVw1VNj9pca0CefR0lvpIHyr15hfGmdJwDvONL/yTCuejQPkFV4buww==
X-Received: by 2002:a05:6512:34c2:b0:4b6:fae9:c9b7 with SMTP id w2-20020a05651234c200b004b6fae9c9b7mr477078lfr.7.1671530132182;
        Tue, 20 Dec 2022 01:55:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a056512208500b004acd6e441cesm1387856lfr.205.2022.12.20.01.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:55:31 -0800 (PST)
Message-ID: <26d4662b-1742-2963-a7d9-08a39bcfba7b@linaro.org>
Date:   Tue, 20 Dec 2022 10:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/9] dt-bindings: media: rockchip-vpu: Add rk3588 vpu
 compatible
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <20221219155616.848690-2-benjamin.gaignard@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219155616.848690-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 16:56, Benjamin Gaignard wrote:
> Add compatible for rk3588 AV1 vpu decoder.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

