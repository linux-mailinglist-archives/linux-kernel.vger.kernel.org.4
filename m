Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BC71736A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjEaB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEaB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:57:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065111D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:57:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77703f20aa9so121639039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685498239; x=1688090239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGBe+JwfrEM1Bt4Dz4KNFsVqieTeS2ww100iu61WbqY=;
        b=PArDOZmrvL1rwO8A1H33sgpcO8KwthjTR/baWua09z1DG30HL4+GuRXI7ynRJSgkJ0
         /tx5K5jOsu4XU3+N8YiVSh6zhFumlRGAlZoQpVDJtHta+LXAecwmchM4tio7Y69B25Gq
         P/Y/4UmtKzpJ7j7GyF/0raZPRhLDPfii5nECpV8scDHc4PRGqUBrLtgyE2ME6QF3oON9
         ond5Mpvd2khWIc2EYmB9yeXN0DV1ILrM7EULOtFC5OMzIVrWlPPuYNS9Q2yxdMDgmHdA
         yWm1upsCZl9iM9s3y/W01Zkk/hae/a9j4ZSHBIyppam/NXfw3B3R6Ce/J4pN52CmLtLa
         FyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685498239; x=1688090239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGBe+JwfrEM1Bt4Dz4KNFsVqieTeS2ww100iu61WbqY=;
        b=G9A8F/0KvwLYrBKwWelPrFKH7q2xQslT5LgK+pafXgqTWSu9gNm8n0Mlx/DLE4On7i
         fP7uilN1k9dvORyaZWJQ0ParAlLkjmFl+ylnQiOp5p4KW595M3Bov0IzssCwf5J/z2XQ
         7MrPABnmLpx1j93vyhQ6vpZ7khxvuI9FXObG9UJBMM5mwfk9HuYt6WO0dj6fqQ1HmSEf
         gsf6X8ObZp8od4FsBebumhkoYWrTGZ8zPz6KjYfVr8R/BTfT0lSPLZwUKW4N1R/W6U5Q
         oKgt3TuMxJfuETrfWz0g0H4vRbZwfaaLB8ayHdLB+EDYQ7lkLcPuZvp++lIUzE3gNJgw
         Cv0g==
X-Gm-Message-State: AC+VfDxe8havwcDArvTtp82hjFt1igI55eRIec3f2AtCL3uGL1hBgMdN
        DIJ/+mE9Q6gD0tWxQHoK4jbpXg==
X-Google-Smtp-Source: ACHHUZ56ZTu3zznsi6iJymiKNF371TpCtjQJRolcjerH79lKBzRrD2/xT87oscVG7rXXde/jssc6Gg==
X-Received: by 2002:a05:6602:19:b0:769:a626:6e13 with SMTP id b25-20020a056602001900b00769a6266e13mr2884020ioa.19.1685498239040;
        Tue, 30 May 2023 18:57:19 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id u22-20020a056638135600b0039deb26853csm1161716jad.10.2023.05.30.18.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 18:57:18 -0700 (PDT)
Message-ID: <e144386d-e62a-a470-fcf9-0dab6f7ab837@linaro.org>
Date:   Tue, 30 May 2023 20:57:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2] net: ipa: Use the correct value for
 IPA_STATUS_SIZE
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>,
        Bert Karwatzki <spasswolf@web.de>,
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
 <694f1e23-23bb-e184-6262-bfe3641a4f43@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <694f1e23-23bb-e184-6262-bfe3641a4f43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 6:43 PM, Alex Elder wrote:
> On 5/30/23 6:25 PM, Bert Karwatzki wrote:
>>  From 2e5e4c07606a100fd4af0f08e4cd158f88071a3a Mon Sep 17 00:00:00 2001
>> From: Bert Karwatzki <spasswolf@web.de>
>> To: davem@davemloft.net
>> To: edumazet@google.com
>> To: kuba@kernel.org
>> To: pabeni@redhat.com
>> Cc: elder@kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Date: Wed, 31 May 2023 00:16:33 +0200
>> Subject: [PATCH net v2] net: ipa: Use correct value for IPA_STATUS_SIZE
>>
>> IPA_STATUS_SIZE was introduced in commit b8dc7d0eea5a as a replacement
>> for the size of the removed struct ipa_status which had size
>> sizeof(__le32[8]). Use this value as IPA_STATUS_SIZE.
> 
> If the network maintainers can deal with your patch, I'm
> OK with it.  David et al if you want something else, please
> say so.

OK, Jakub has spoken...

Bert, I tried before to explain what you needed to do, but it's
still not quite right.  Please contact me privately and we'll
work out how to get this submitted in the proper format.

					-Alex


> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> Fixes: b8dc7d0eea5a ("net: ipa: stop using sizeof(status)")
>> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>> ---
>>   drivers/net/ipa/ipa_endpoint.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ipa/ipa_endpoint.c 
>> b/drivers/net/ipa/ipa_endpoint.c
>> index 2ee80ed140b7..afa1d56d9095 100644
>> --- a/drivers/net/ipa/ipa_endpoint.c
>> +++ b/drivers/net/ipa/ipa_endpoint.c
>> @@ -119,7 +119,7 @@ enum ipa_status_field_id {
>>   };
>>   /* Size in bytes of an IPA packet status structure */
>> -#define IPA_STATUS_SIZE            sizeof(__le32[4])
>> +#define IPA_STATUS_SIZE            sizeof(__le32[8])
>>   /* IPA status structure decoder; looks up field values for a 
>> structure */
>>   static u32 ipa_status_extract(struct ipa *ipa, const void *data,
> 

