Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240A7734383
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjFQUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjFQUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:34:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D7172C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:34:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e0fbd742so283686166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687034060; x=1689626060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDT98+tq9yphi2ITN6OKufow+YGDt55MTQWdD14+NmM=;
        b=au+AT2YEcGZIpWxwoWts5CEwJ7E0F7Y+y+gCnwMEvgDHf+eUb7q6IfM/BWOySeK4FK
         0ZgmgnRt5BjmiACb9TK9bGErdx8l47NSUJpv8LKgcFCfflhOg7LPwunzKlCPAdXjj9fI
         oU6Zn4LZhtR6zHRX/iuv8PBrGvJV/c+qHNfcLWVbx5t8yh1sWDk1/NavmZlxUSFUFg01
         dDAoL/6ds3SJWxbnEp5BZo0MumrMAogJDDdk1E6nV2hJRXmjqWbr4+Oq67EVak9pL4jH
         pmln4OpPFk2xE+y96KxLt8nX35AXVMzDvtpUK+WNmnv+l4tAOofzd5br1V5lHfODP9U7
         lJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687034060; x=1689626060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDT98+tq9yphi2ITN6OKufow+YGDt55MTQWdD14+NmM=;
        b=U+sj/j+BYp5+1aROiNsFW6WZ6rqHmmRdzw11ZNAFszHaWoiLklX+qva3sV88QGpwKr
         8tbLqjkhNEMywPcDWE8MqGbdj/+H4HsyXHziodk1dsM59svBc7WFZ01XMMXO0rnN4bsH
         7ByqDcMwy6efzRi26ZlRzeE1U2cNY59cenHch/603D/nwKoN2HrGdJa/b6D3edHElHGn
         y+glu/Or7Q5JpRQdtJJsi0bBwEywOOMNl59BuS4WEvdTf/9IeQmfnRScn7loTqSZdQ3q
         wV4sstmMVGtLLZCBkML6w0UKZSkcEMyPMQlc8KVDG7vaSiuwTlF77+3ZfT2EpaCWtu+W
         p7tQ==
X-Gm-Message-State: AC+VfDwSyIP5S1BQipNV9DkOuHZIpf36ZS+KjATJg5jRxoAqXXSEqKZ5
        aUI4XoZWtcT3Q5T6Rn8d5RjfNQ==
X-Google-Smtp-Source: ACHHUZ5ARZwxtt3P0MlCdDeWpXMZMHNeiJP/9Y3veHLePivd6vRYzfO31quVGPyf2/33w+Hqr4TKfg==
X-Received: by 2002:a17:907:5c8:b0:974:6de:8a5e with SMTP id wg8-20020a17090705c800b0097406de8a5emr5119000ejb.40.1687034059963;
        Sat, 17 Jun 2023 13:34:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906471400b009663115c8f8sm12436310ejq.152.2023.06.17.13.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 13:34:19 -0700 (PDT)
Message-ID: <68aeb55a-dd0e-e517-4e66-3bf7fd32bba1@linaro.org>
Date:   Sat, 17 Jun 2023 22:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] dt-bindings: net: dpaa2 mac: add phys property
Content-Language: en-US
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20230617134009.23042-1-josua@solid-run.com>
 <20230617134009.23042-3-josua@solid-run.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617134009.23042-3-josua@solid-run.com>
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

On 17/06/2023 15:40, Josua Mayer wrote:
> dpaa2 mac supports runtime configuration of network protocols on a
> generic phy object specified via the "phys" property.
> It is currently used with the SerDes28G driver to switch SerDes
> protocol between SGMII and USXGMII at runtime.
> 
> Support was introduced with:
> f978fe8 "dpaa2-mac: configure the SerDes phy on a protocol change"
> 
> Add bindings description for the missing "phys" property, to fix dtc_chk
> errors present in various layerscape based dts:
> 
> 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

This was sent:

https://lore.kernel.org/all/20220801181347.3873041-1-sean.anderson@seco.com/

And obviously will get lost because Sean for some reason decided to not
Cc maintainers and lists... so sure, we can go with this one:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

