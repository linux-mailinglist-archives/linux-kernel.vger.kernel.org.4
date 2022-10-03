Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1E5F379A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJCVV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJCVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:19:54 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8938D57557
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:12:37 -0700 (PDT)
Received: from [IPV6:2a00:f41:18f3:7ee6:a401:45d0:c41f:c16e] (unknown [IPv6:2a00:f41:18f3:7ee6:a401:45d0:c41f:c16e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CFAC83EEAA;
        Mon,  3 Oct 2022 23:12:34 +0200 (CEST)
Message-ID: <73726dc3-f6d2-144e-680a-5ee9e2b2edc9@somainline.org>
Date:   Mon, 3 Oct 2022 23:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: add xiaomi,sagit board based on
 msm8998 chip
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221003185500.928608-1-dsankouski@gmail.com>
 <20221003185500.928608-3-dsankouski@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221003185500.928608-3-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/10/2022 20:55, Dzmitry Sankouski wrote:
> add xiaomi,sagit board (Xiaomi Mi 6) binding
>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Binding changes should generally go before the actual patch, so that

there's no commit where there's an undocumented compatible.

Konrad

> Changes for v3:
> - remove unused 'sagit' compatible line
>
>   Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index fb1d00bcc847..294075bafb97 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -239,6 +239,7 @@ properties:
>                 - sony,xperia-lilac
>                 - sony,xperia-maple
>                 - sony,xperia-poplar
> +              - xiaomi,sagit
>             - const: qcom,msm8998
>   
>         - items:
