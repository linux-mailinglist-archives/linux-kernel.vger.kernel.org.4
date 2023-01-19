Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD4674BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjATFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjATFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:07:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D285367;
        Thu, 19 Jan 2023 20:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1646B82291;
        Thu, 19 Jan 2023 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C418C433D2;
        Thu, 19 Jan 2023 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674131189;
        bh=v9L6O/kpVavTAGVUX5tNF84tMHDgWEumEJW0la5jK9k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G3oKUnQAfK+bLJ/exC6I7cCOyATgyL3RGezNeN1Q8JOv8zqwSakrpFNQCQY4xLomW
         PEiAmfGN5SUAKQtNMx69KdJb4B+j6o0dpKQxuA/9SGy1LhSJ/uTfi2syyKHjSoqM01
         CrYw6OVqkRFsKDBddVBM3h/vMWqhDxRFatC6OvamfDDmyOP0T0lzjwhjeJ7Hnh/hKP
         bqmUWl0N0iCpW+MqLhSId4W/1ZXjBfSVn+9jLZP8RTzBOHnFyUz447AQMjclKFnAPy
         gDR4ly4EZZRieH0oZvVlLWQu16zQAb/wC+kXIWZjpUu+628AsIPwIuzeLFfuAmyvo2
         wnsY5pt9/l/3Q==
Message-ID: <dd96a81a-84c1-fa82-627b-894cae5f7bdd@kernel.org>
Date:   Thu, 19 Jan 2023 13:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v10 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Content-Language: en-US
To:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20230119112848.3523273-1-shravan.chippa@microchip.com>
 <20230119112848.3523273-5-shravan.chippa@microchip.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230119112848.3523273-5-shravan.chippa@microchip.com>
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

On 19/01/2023 12:28, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You skipped several of people/lists, so please resend.

> 
> add new supported link frequency in dt example

Start with capital letter. Finish with full stop.

> 
> Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> index f5055b9db693..09533496b20c 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> @@ -82,7 +82,7 @@ examples:
>                  imx334: endpoint {
>                      remote-endpoint = <&cam>;
>                      data-lanes = <1 2 3 4>;
> -                    link-frequencies = /bits/ 64 <891000000>;
> +                    link-frequencies = /bits/ 64 <891000000 445500000>;
>                  };
>              };
>          };

Best regards,
Krzysztof

