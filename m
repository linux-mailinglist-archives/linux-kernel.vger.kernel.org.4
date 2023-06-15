Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E917319D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjFONXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjFONXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7387172A;
        Thu, 15 Jun 2023 06:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692E06317F;
        Thu, 15 Jun 2023 13:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D7C433C8;
        Thu, 15 Jun 2023 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686835390;
        bh=t6/5UDP4RwExGVEdFU2AtHIctJ/fcDBjkxLPyQsjmHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D+/SQTuckZEp+iItMgxmneOtJMZLnJ2Wb+uQxOyWhiLuoLTg/yUA6otdRKgciz9e6
         +5X5s/A5KhGJl11WV8R3j+6E5VOJnWoPcG21gtqTXUzT0FW+dGPhqbBASLlLgHomga
         N6F//30/wmTtY7tuI9poQ/m0B+DMIlvPA/5KcigY/MXk3B/r9o4LyZIO9AdS+opp8+
         +ZOFECPf3PQjrWCVuovLm8sAxii0CXNzt236i35s0EpqHPgSo7LtCLK31q7XeeGlp6
         yNGLv3JT+LQE2zca5jDsRy9icDhbH0KBfR6QWb0HgaJaEs2BU5uH0rHMNaqKf90qYX
         r63yamcFJF0/w==
Message-ID: <e9634d2a-f8f9-666b-abf6-65e676205203@kernel.org>
Date:   Thu, 15 Jun 2023 15:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI
 SLAVE mode support for GENI based QuPv3
To:     Praveen Talari <quic_ptalari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
References: <20230615070706.18322-1-quic_ptalari@quicinc.com>
 <20230615070706.18322-3-quic_ptalari@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230615070706.18322-3-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 09:07, Praveen Talari wrote:
> Set this property to configure QUPV3 as SPI slave controller.

1. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.

2. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC.  It might happen, that command when run on an
older kernel, gives you outdated entries.  Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

3. Commit msg: Don't explain what you are doing, but explain why you are
doing and why this is needed.

> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> index 2e20ca313ec1..cdd6d19876d3 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -66,6 +66,8 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  qcom,slv-ctrl:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Awesome, so you send untested, broken code skipping necessary mailing
lists so even automation won't test it. :(

Best regards,
Krzysztof

