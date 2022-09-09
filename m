Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66765B31B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiIII2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiIII2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:28:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CE129C45
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:27:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so1496848lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aaJgQP6mmOZSBtHCI9caEKhaJVZ90AwBEM8xc756oKU=;
        b=PkfSceaEsCN3DpwzT8WAOBHdhnr+T+3XRaGeaR7p49jx4tBR9Qj413xsXGQanqhfoU
         uue3QFM5syxSdoOsUTd+FPVTJejwBpH6Xy4kpd6YjS7OIjzBn1gW91Iu4lgohO+zUpes
         NVjdNvCCKSZKyCmQcZnvVzlqFNuZgZZgU++IpRQNCp22jAqHqRacoEip4/LRefcJkcfP
         1wdzAxA2JOc/DW5m9xTso4VANt357kwefrfBgAG8RvRoPoLd27pvP3A7qVhYEEevdzLG
         I43EfJlJeuTCZewT8kop0fv+dBAta9ME61DIoPj6MZTtfNdEF1ZnNfMYXbZlGXO+PiIR
         k/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aaJgQP6mmOZSBtHCI9caEKhaJVZ90AwBEM8xc756oKU=;
        b=Zs45NW7BekzT/d0DaZyQO480Zab7HfP7GPnvhT1v6w0UoMBN6Ts46iUiZw/3628sid
         CLivY5/KPL9gvXx9BuAj9qSpsG3v/krb4jmbP4n8XC+55dHi0TbMQOlpGwTi/EsldXNX
         h6kAvOd234LgLVkg3aPnslAD9rCFBzK6kREBb06y5wez9MC2VUC7kXnWNom0XJfbfZMt
         wAFzSnYOy0fRLVgWUTrg0HbkztdkjARFkJliVJ6X2kgjoewLAkKt0eWGBPLTiWKGwJOR
         Ie/uZhBP+sh/tx9QG5VtF3wKZwdpRhuA52GI3LC9JHGzAg1MWiY+n2AXyxRFjq7qMW/8
         71wQ==
X-Gm-Message-State: ACgBeo059n3d1xge5UhlkeHhfcQMsnqJhoz//tqsWz0Lo9pBI7YW2+1Y
        VAJn1leOy1gr06ofwN+0IbuR+Qwu8eBSIA==
X-Google-Smtp-Source: AA6agR6q6dm061SxXLm4iCirWAM8P1i+n441YDphCVJBfNX6AwWGizOpXP2cFam8rCAb/gLNemJBIw==
X-Received: by 2002:a19:9157:0:b0:496:8bd6:a594 with SMTP id y23-20020a199157000000b004968bd6a594mr4174662lfj.314.1662712076092;
        Fri, 09 Sep 2022 01:27:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l6-20020ac24a86000000b00497fed6cbb1sm188710lfp.71.2022.09.09.01.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:27:55 -0700 (PDT)
Message-ID: <36f9ed08-169b-dc92-2df0-842de4116d49@linaro.org>
Date:   Fri, 9 Sep 2022 10:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
 <20220829080830.5378-2-chunfeng.yun@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829080830.5378-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 10:08, Chunfeng Yun wrote:
> Add a property to set usb2 phy's pre-emphasis, which used to widen eye
> opening and boost eye swing.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: Add more description suggested by Krzysztof
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
