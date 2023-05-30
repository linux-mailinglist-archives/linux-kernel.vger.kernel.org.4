Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE477171E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjE3XoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjE3Xn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:43:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F23C0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:43:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-773793070a4so124731339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685490235; x=1688082235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3ypystYzBp0z6BGyUyrOubrVmHDSkpBeVSSYpzrgNU=;
        b=y9u0NB4kWnHYwt549HNPXWJTG3IRqe8/i0EgPjGKGvZyD3aP2NoPLebMVxLbcZdGoI
         B+1piYrPAfQVtfFMiqq4dy3hooHR5gQ2g1kves8qith5oI92YNMOzgnj/Q9RS/f7M9YH
         typUsW4DaeYZdS011PpV+S5goYadVJHRJ4mmOdUmWKHHgxFr2ch2RTCVA5C/6OpAHbbP
         zZSV8SaEUhvODRyfGj50W5/Pbe+d81pHxDxWupxNAcEFlKHLZ4IArqaV1NhbJ8aYjuB0
         ICsS+U4VmwCuLpSyNSeNDLk4yaRC62eZ1VzHy0kFHfpSYmt2RsnWTRukVJ11lVyEKiqo
         4dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490235; x=1688082235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3ypystYzBp0z6BGyUyrOubrVmHDSkpBeVSSYpzrgNU=;
        b=SN3qCqAffmk5kiBcsQ4sG6fj3PGxk8FjUyXoz16X+lgv/ne+O5tvORyeJIOdFGGyaQ
         IX478pfyqBLqXtdnNDpHvvS6Iou8b/FBOGWYehm3l9DslF6mW8QwLGmlepnXv6Nf1FUf
         I1eM/Tbb5YfcfXr48aElqaTHqgeLs7d+pTMU76aR4iSGHtFyE1klGqtjJh4U4c4oC3jQ
         wxvC9KPE4VCGFctogJ+udoWno45P0VIFroYzphVEHsJZ4QYViGz310iTqwBOKjTrmrIb
         oKe66C1nNmTCi8m1ZE5NLw2F/IPUquS0sWbzxaa8TB81rRqSfZdomzqg/NV5LBO4miNq
         lRpA==
X-Gm-Message-State: AC+VfDyji9Wx/SYQD3B2zWSRxze21tFadcxP+/4oLtIGxOB8xEdbF/QS
        w1iVd3d0k54BsM2gaSkJEbwN/g==
X-Google-Smtp-Source: ACHHUZ5eAUPfBfmQO0GDa5baK1HyIohLoaAUddvYA3t+pGk/ntaEhQaO5j0ioafC/00n6ndwS115vA==
X-Received: by 2002:a5d:87c2:0:b0:76c:65df:a118 with SMTP id q2-20020a5d87c2000000b0076c65dfa118mr2397211ios.6.1685490235653;
        Tue, 30 May 2023 16:43:55 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id l5-20020a5e8805000000b0076c5c927acesm3522902ioj.13.2023.05.30.16.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:43:55 -0700 (PDT)
Message-ID: <694f1e23-23bb-e184-6262-bfe3641a4f43@linaro.org>
Date:   Tue, 30 May 2023 18:43:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2] net: ipa: Use the correct value for
 IPA_STATUS_SIZE
Content-Language: en-US
To:     Bert Karwatzki <spasswolf@web.de>, Alex Elder <elder@linaro.org>,
        Simon Horman <simon.horman@corigine.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7ae8af63b1254ab51d45c870e7942f0e3dc15b1e.camel@web.de>
 <ZHWhEiWtEC9VKOS1@corigine.com>
 <2b91165f667d3896a0aded39830905f62f725815.camel@web.de>
 <3c4d235d-8e49-61a2-a445-5d363962d3e7@linaro.org>
 <8d0e0272c80a594e7425ffcdd7714df7117edde5.camel@web.de>
 <f9ccdc27-7b5f-5894-46ab-84c1e1650d9f@linaro.org>
 <dcfb1ccd722af0e9c215c518ec2cd7a8602d2127.camel@web.de>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <dcfb1ccd722af0e9c215c518ec2cd7a8602d2127.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/30/23 6:25 PM, Bert Karwatzki wrote:
>  From 2e5e4c07606a100fd4af0f08e4cd158f88071a3a Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> To: davem@davemloft.net
> To: edumazet@google.com
> To: kuba@kernel.org
> To: pabeni@redhat.com
> Cc: elder@kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Date: Wed, 31 May 2023 00:16:33 +0200
> Subject: [PATCH net v2] net: ipa: Use correct value for IPA_STATUS_SIZE
> 
> IPA_STATUS_SIZE was introduced in commit b8dc7d0eea5a as a replacement
> for the size of the removed struct ipa_status which had size
> sizeof(__le32[8]). Use this value as IPA_STATUS_SIZE.

If the network maintainers can deal with your patch, I'm
OK with it.  David et al if you want something else, please
say so.

Reviewed-by: Alex Elder <elder@linaro.org>

> Fixes: b8dc7d0eea5a ("net: ipa: stop using sizeof(status)")
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>   drivers/net/ipa/ipa_endpoint.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
> index 2ee80ed140b7..afa1d56d9095 100644
> --- a/drivers/net/ipa/ipa_endpoint.c
> +++ b/drivers/net/ipa/ipa_endpoint.c
> @@ -119,7 +119,7 @@ enum ipa_status_field_id {
>   };
>   
>   /* Size in bytes of an IPA packet status structure */
> -#define IPA_STATUS_SIZE			sizeof(__le32[4])
> +#define IPA_STATUS_SIZE			sizeof(__le32[8])
>   
>   /* IPA status structure decoder; looks up field values for a structure */
>   static u32 ipa_status_extract(struct ipa *ipa, const void *data,

