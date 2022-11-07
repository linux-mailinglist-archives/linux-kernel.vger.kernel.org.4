Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280661F1AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKGLSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:18:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41712AF1;
        Mon,  7 Nov 2022 03:18:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o30so6656107wms.2;
        Mon, 07 Nov 2022 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bE/B1hEKlsShE0rJtK/wqGe/9FUjw3TNSnOuMMxxx5c=;
        b=kqG8f+Y6oT2x2fUWNz8vbbbNk4CncuhqoXWlJRRYGp7vCOyhe6FHCC+PhQ2spwH8kD
         o7ke5mugzwO5NHVfQnSdBhb1xupi+/WPzyUtOCFrTFOJrwh7QHhFxqIck1o3/e8d6sEN
         a+mXXGKpZV5oUQJntT+wxrjIt1jlD6VN01WMw2g1QXhdXMlzXoexB5vjwOSgwNOjtcTo
         poo7Kia1UZQHQnurHlLyQfPS6qa1dwa/tyVBm3jrWx2ue1VtYuOlvcKuQhV3sExaMKGB
         bisoLww9V2O0SuFlZjclSJ76xsL16/rA/g3DJWY7Z454d9Bpl2FQIgJPK+sqbNvHUvya
         Jn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bE/B1hEKlsShE0rJtK/wqGe/9FUjw3TNSnOuMMxxx5c=;
        b=JBsd5WVrDzMSEZXIPG7qQuq8FtkBAgxujukVQWbOoEKpwA7sfis+FXDtbBkW1U/TwQ
         cpJ2DYyztwJIvJCm46yJrRszkqFUqoHJBsOGBQ58vW8/TuU2ODEPQZF+tkdbTO1RgGmo
         mg2FweGb0HLnffQHvdEou0V3SnaEGoWJR8boaXe5TbwieYVITplJUJRr6Lw60RdrDjc7
         p3jTIJt77RCGV6+TtuxvBYYl2rIVxT/LVTJuWVhZXR1JCLfFK2eFO4rjZFj9fdMvk4dF
         FpXcm2CEbc474z9Mf3jCJshULyG/SK3dPNUHiJ+aMAAcFkl7pL8G0rJAvP2cjFWn2+Jy
         +QmQ==
X-Gm-Message-State: ACrzQf02jrCnY7HWdWqZyrpMBH5RcGthh1JV4a8Cog7tPhWPwL1X9fZb
        GO8It7oOykkxE5xY9ssOoLo=
X-Google-Smtp-Source: AMsMyM602bjMyEAIMHb7PPY/WchKiT9g7wWxWDeiZVVF/3WBk72v331wPVEgqU98Sqgeey5mI0NOTA==
X-Received: by 2002:a05:600c:5109:b0:3cf:5fd2:877f with SMTP id o9-20020a05600c510900b003cf5fd2877fmr32712091wms.156.1667819909730;
        Mon, 07 Nov 2022 03:18:29 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003b4a68645e9sm12514451wmq.34.2022.11.07.03.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 03:18:28 -0800 (PST)
Message-ID: <fcec5536-6ba8-9cac-2001-710a7170df70@gmail.com>
Date:   Mon, 7 Nov 2022 12:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/2] dt-bindings: gce: add gce header file for mt8188
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Elvis.Wang" <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221104074443.26172-1-Elvis.Wang@mediatek.com>
 <20221104074443.26172-2-Elvis.Wang@mediatek.com>
 <bdb46b7c-6e08-26cf-491d-ca68d36f29af@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <bdb46b7c-6e08-26cf-491d-ca68d36f29af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2022 11:27, Krzysztof Kozlowski wrote:
> On 04/11/2022 08:44, Elvis.Wang wrote:
>> From: Elvis Wang <Elvis.Wang@mediatek.com>
>>
>> add gce header file to define the gce thread priority, gce subsys id,
>> event and constant for mt8188.
>>
>> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
>> ---
>> Thanks for the reviews, I have removed the incorrect reviewed message.
>> ---
>>   include/dt-bindings/gce/mediatek,mt8188-gce.h | 966 ++++++++++++++++++
>>   1 file changed, 966 insertions(+)
>>   create mode 100644 include/dt-bindings/gce/mediatek,mt8188-gce.h
>>
>> diff --git a/include/dt-bindings/gce/mediatek,mt8188-gce.h b/include/dt-bindings/gce/mediatek,mt8188-gce.h
>> new file mode 100644
>> index 000000000000..e2e2c56016a1
>> --- /dev/null
>> +++ b/include/dt-bindings/gce/mediatek,mt8188-gce.h
> 
> 
> What is a "gce" subsystem or type of hardware? Why do you put headers in
> "gce"?
> 

Yes, I think we should move all header files from the gce folder into the 
mailbox folder.

Regards,
Matthias

> Don't continue this pattern. Mediatek devices do not get specific folders...
> 
> Best regards,
> Krzysztof
> 
