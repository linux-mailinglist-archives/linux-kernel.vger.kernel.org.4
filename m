Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3F6C5940
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCVWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCVWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:04:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A6F945
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:04:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so33247454edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679522662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrRk+gaJjYLT5/E0PnsUAhp4KDn0wBS9o7C6buEtHBc=;
        b=yvTFowc16cu1PU/l7kVOfvBxkEFcpqrpWd+oVqsU6zzN3acJq+3HrI4Aufymz5620e
         SrWDJHzWPth67Ae8o4r4so7Xs65xetVeeWFN8DPafaaFWzcoB7PvkJN+9g8uDmyg6JcB
         /88lg18inP6h8lYc3aGFbBkTxYaGms403ZWz5T0W4a/BdWS0fiQk5dHW5o4GJ7oT//uZ
         oOmRNLX2e3fDdG5cnWAcmA/VkoGln4I8gwgAQAFQjih5mwjpLTtKSXeke1/kexURJEak
         st5m00Yz2ZmADh+4Gb/WOhDHwfpMc7zwB86lG96vccQj27+svMS2+87Q+9YYSvAodCFB
         OrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrRk+gaJjYLT5/E0PnsUAhp4KDn0wBS9o7C6buEtHBc=;
        b=REvnqW6qAjN0zrP+Z1ISwyk/QXIOTEftsDPy13vYSc2L88M/UmazjNb32FpnkszTrF
         pOdHamb1Daqwe2NgOuQG69dx9W8RmbZM/gan0TiFQTkrIEL6fxVXk4rQNI9tfxySJWit
         X4CW3lg0lnF4QnAwXPy//KAMllsRb988xGqYQfEhGVl3njVmPt+L5OKmAV4Zn2iVkoh4
         uYTDcOcLP2pj+2BQejbmYIbBuBPwhOL/pL74Nx8GVoxLzk7bcfqw5VutGqyNCUPrGdUL
         QfbRRm6ULwEW2OoIFK63YUEnDrQRDhV6vzbVMTDXTgFMLt/4hpgRdV5lBkQt7ABd+Rw6
         OC/g==
X-Gm-Message-State: AO0yUKUYIjPLKGdl4a6VNt8OdSUQJ8OhzZ8lG3Djb/g1YFfxE8Mk30MR
        dySnXvpnyqACOJsKMvNSsFMS9hXmrp2rzVso2xg=
X-Google-Smtp-Source: AK7set9DmUAygXVMqWsEQS/8hyYS5W4WJtg8t7pcvflJhNmmgfo0zg1SyiSdx3q14rcGziO/AWr3wQ==
X-Received: by 2002:a17:907:33c5:b0:878:66bc:2280 with SMTP id zk5-20020a17090733c500b0087866bc2280mr8959235ejb.12.1679522661994;
        Wed, 22 Mar 2023 15:04:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00921c608b737sm7721409ejz.126.2023.03.22.15.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 15:04:21 -0700 (PDT)
Message-ID: <12e898d4-e83a-3f08-53bd-f4990af97104@linaro.org>
Date:   Wed, 22 Mar 2023 23:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH linux-next V2] dt-bindings: usb: snps,dwc3: correct
 i.MX8MQ support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20230322125618.3402577-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322125618.3402577-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 13:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The previous i.MX8MQ support breaks rockchip,dwc3 support,
> so use select to restrict i.MX8MQ support and avoid break others.
> 
> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add a new yaml file for i.MX8MQ DWC3. I am not sure whether this is right,
>  still meet dtbs error:
>  arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb: usb@38100000:
>  Unevaluated properties are not allowed ('phys', 'phy-names', 'maximum-speed'
>  were unexpected)
>  But there is already ref to snps,dwc3.yaml and dwc3 yaml ref to usb-x.yaml

Because your DTS has invalid properties, like usb3-resume-missing-cas
and others. Drop all properties which are not allowed by snps,dwc3.yaml.

Best regards,
Krzysztof

