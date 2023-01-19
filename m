Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD86737F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjASMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjASMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:09:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DD66FB4;
        Thu, 19 Jan 2023 04:09:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B838360AD8;
        Thu, 19 Jan 2023 12:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0A9C433D2;
        Thu, 19 Jan 2023 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674130140;
        bh=t/s2UfVNfXZ74ABSKzm9V2zdch9aLkeCT9UMo9bCRqY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TpofgGV9X8knhWWj2CfyNxxyWXGp397tyvqL3rWIPUVFS5n6XKGLzCyW6nKbppVVq
         hXaYyIGC06uHdgcqv+7QsosRsNjnVilgcrKKtol3tEqG8lR5sXt0ssxkuvs2ACZ/Bz
         ZB+Q9E/6MK7kR9YUZ83NfJTLEm0x2oc8lVR7FOfJhkSDUawUoyVe58Q1pWlRZ5AKUl
         JHe7Bkxw5YI/6KNFhUmu14kUtpVnGy9OpofGYODLGRJFIZUJJKF4s+u+W0KUfnsCak
         +WFNUaW4bvwBfbPKqpFX82QAHyrYGRiT+BwMtBEr4mOlc6eIcXa9zEmLPkh6GEnioD
         Sya1f6xTo7Hiw==
Message-ID: <a67ae6ac-10ff-a7ab-7c75-05218dd0c05f@kernel.org>
Date:   Thu, 19 Jan 2023 13:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] ASoC: qcom: dt-bindings: lpass-va-macro: Update clock
 name
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-2-git-send-email-quic_srivasam@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674108674-8392-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:11, Srinivasa Rao Mandadapu wrote:
> Upadte clock name from core to macro in lpass-va-macro node

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> to make it compatible with existing driver and device tree node.
> 
> Fixes: 67d99b23c881 ("ASoC: qcom: dt-bindings: add bindings for lpass va macro codec")
> 

Drop blank line,

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

https://lore.kernel.org/all/838e7657-817c-e5bd-5a45-d852560c7fe1@linaro.org/

> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index 26f0343..e468adb 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -36,7 +36,7 @@ properties:
>      oneOf:
>        - items:   #for ADSP based platforms
>            - const: mclk
> -          - const: core
> +          - const: macro
>            - const: dcodec
>        - items:   #for ADSP bypass based platforms
>            - const: mclk

Best regards,
Krzysztof

