Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A86D074D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjC3NvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjC3NvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:51:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B05FEC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:51:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q16so24588247lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680184260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFioh8KEjXK9vkYc+hdZvmSiagi9AnGPNz7oxJLFgPg=;
        b=aqaLZ2C0OW74EnyCVtd7s2XzYVvuqTZHzdqXHT5I26oPOfFJFY0ab9JYTGzVprk2iZ
         QQkjWXN4Z8NrQc2WI73+dWNCXlMnVw7NawqEy64kYsYWS55rvtQq1ZvQ2Tqr7mpHmKTN
         qMs4Ca2DqTPUe1rGJgL1TdGfKNj6qb3Hw2Df6Hgnrnl5TwquFwZleL2k1ETqJvs7b4uC
         Kz9h1KGGy6TQNNT09bSN9YieX113fGt1Zlpe4O5a8fc+cDFHU8sV8cuKsXKhcAYJPJxs
         Pq2b8Pl6XqjPJTypif6/QvAv6SURe0Kn5l91UtaQ78tbJp5cXZrf5655PlewX4pAlY0k
         9/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFioh8KEjXK9vkYc+hdZvmSiagi9AnGPNz7oxJLFgPg=;
        b=v+KBGzqaUeL6dOO3enXSNx61kNCaMQBVf7tQsLf0pylhuoIdAbn9ZvmnwZAX15wKE4
         ImEtzoQ086ohWisrF3nFueOB3uQzc0IUdqjcUi0k59DefK8OPOgm/SYYuvauG2RCupbm
         j7w6m8rIOiwk4nzEuON4Oba5+xvkJa6X1HEf75o9wdXveYrkJcF8wbIFNMyTytv0W55Z
         Ga6RGuNxuFsfJm0EKIU0Tir9aAYJyXcQpY0gprBjqPZQKvPBLpPqggzPA+OjoZlb1WYS
         PqXovuN3+PvQNzAp2Ihj01SRh/FAEiiLd5+wJasmq7SQDGcJGppc4FzBRpY1ZhGKFRLj
         bq+w==
X-Gm-Message-State: AAQBX9eNkk5rMejp8H4V5Uk30FbK3p93Pw2l4srkUYvoKdDmlGxSPqqL
        QYFIN/4AKTdB9k5o156Uq7Jf+w==
X-Google-Smtp-Source: AKy350YBGOQY3S+mf01A6pGyFA/FOJmRXnmaoj9y0eOpGoWFYDZR5RoMaGKb6fDvtOfrGDbYZg+z6w==
X-Received: by 2002:a05:6512:3881:b0:4de:d6a1:fd71 with SMTP id n1-20020a056512388100b004ded6a1fd71mr6284092lft.50.1680184260036;
        Thu, 30 Mar 2023 06:51:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y28-20020ac2447c000000b004eafa141a12sm3343289lfl.9.2023.03.30.06.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:50:59 -0700 (PDT)
Message-ID: <500872d5-78e9-0928-17db-81bf20f6306b@linaro.org>
Date:   Thu, 30 Mar 2023 15:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20230330091736.1873121-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330091736.1873121-1-peng.fan@oss.nxp.com>
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

On 30/03/2023 11:17, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format, and rename it to
> nxp,ptn5110.yaml
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Rename to nxp,ptn5110.yaml
>  Drop port property


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

