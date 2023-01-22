Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493F676C64
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjAVLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:40:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8B1DB99;
        Sun, 22 Jan 2023 03:40:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47E45B80A36;
        Sun, 22 Jan 2023 11:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6930AC433D2;
        Sun, 22 Jan 2023 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674387639;
        bh=mrCwh8rnHVNuJJ9uXW6L9xtLqHdoTlnPc2chjp+cULc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Gnv1AHcdyHkeRaFbaNeLHA3okSsSqgsW3yND4TATCt5+Em0NorUN+xw+4Gsf9cJyW
         Bk03flBM48vOM2FKc7YGWHjySL2DaAY5S+qHfgjpzPUnoGaRoqOrbkfNpZ1yfLoZcx
         HPXjgRxtxILmm3DnpZk6rR9JkbzTWFf5ktgyhuIyXG3WWNz7tlq6Mvy2/kjz8i8xpr
         9ZqZ2da4IIkShSvkUd4nfB7W2yjbeRWcI1gBiYf+JcKYCF1OtSdGcJ2M9VmL6Yu/bA
         s/BW4kiGeJ7tERMkeQPivrw8AmmppBjhNCSYjeSkBDcdO4syo8xt/K0J6WIXdietPI
         taJMDR9AwwuwA==
Message-ID: <e59e3933-1fa2-06c7-9038-3b58822a4a61@kernel.org>
Date:   Sun, 22 Jan 2023 12:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: google,sc7280-herobrine: Add
 platform property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org
References: <1674210685-19944-1-git-send-email-quic_srivasam@quicinc.com>
 <1674210685-19944-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674210685-19944-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 11:31, Srinivasa Rao Mandadapu wrote:
> Add platform property in sc7280 machine driver bindings for including
> platform subnode in dai-links.
> This is required for binding the frontend dai driver with codec driver
> and cpu driver and to do dynamic pcm routing in ADSP based platforms.

I have doubts that this is for binding frontend driver with codec and
CPU. The CPU and codec phandles are already there, so they are bound...

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../devicetree/bindings/sound/google,sc7280-herobrine.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> index 869b403..0b1a01a 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -75,6 +75,18 @@ patternProperties:
>  
>          additionalProperties: false
>  
> +      platform:
> +        description: Holds subnode which includes the phandle of q6apm platform device.
> +        type: object
> +        properties:
> +          sound-dai:
> +            maxItems: 1
> +
> +        required:
> +          - sound-dai
> +
> +        additionalProperties: false
> +
>      required:
>        - link-name
>        - cpu

Add it also to existing example.


Best regards,
Krzysztof

