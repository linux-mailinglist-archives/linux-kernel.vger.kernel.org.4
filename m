Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92267382D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjASMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjASMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC5075A1A;
        Thu, 19 Jan 2023 04:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9A060A5B;
        Thu, 19 Jan 2023 12:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BF2C433EF;
        Thu, 19 Jan 2023 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674130639;
        bh=OQ7G27C7bJn8FV47yuIHXL1oUJJyi39FrG+lKjbaQn0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ztb/W1xJp8LiuoztVHp4ezbV944o7p8Kx6NHA0Kp5zNsvO7lalCoR0omE+0YAfEl1
         kwgZwiuJLVgt/y3dyU12V3CHn/T0+CyCgXslOeHeWjcpHQWijkH3xdBmvl4KYpjW3E
         da6cuvA+0pfry1RY3oVWaz3oGVqDgrTBdrL93kx5tgCvYgiNBZVZ3DKt3UCH7bNzqg
         Sgnj8HuJATSbQdzWwuGcuhDgHttJcdUotXPsjL6YugrRiDfQ3VjDu5tOE3erNObXYj
         IN4LjMwtlTzhn6G4iyZkq6qmOl3nDOsr2ROKDNZpRrwgZ+EauVn6IgRqrQ1+OBUmKj
         x+5anT071WAcw==
Message-ID: <452b332a-d796-119c-e80a-e68914f46702@kernel.org>
Date:   Thu, 19 Jan 2023 13:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] ASoC: google: dt-bindings: sc7280: Add
 #sound-dai-cells property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674108674-8392-4-git-send-email-quic_srivasam@quicinc.com>
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
> Update sc7280 machine driver bindings with #sound-dai-cells property.
> This is to fix dtbs_check errors.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> index ccf1b1d..be5c60a 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -35,6 +35,9 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  "#sound-dai-cells":
> +    const: 0

That's not correct property for the sound card. Does the sound card
exposes DAIs? Who uses these?

> +
>  patternProperties:
>    "^dai-link@[0-9a-f]$":
>      description:

Best regards,
Krzysztof

