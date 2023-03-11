Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5E6B5BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCKMwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCKMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:52:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677E113F55
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:52:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so5080262wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678539126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5dJFQGb7q/CQhFpeP+fZ30ySwTofV5mRJn/cglIAuM=;
        b=HYsNsC95zQ0w9aI6CjXKC6E08IttMYmktVY19cymIjlJ2/wcvv3XCpYYP3rMEnastN
         5AcmPz9MER9oUuNPnYpbrWn/iEVLvGXf9jdpAua6TAKZFj3gz6+pFlRnWHo85uCRuMIB
         fO8/7lUf5a8SEHdZGPMw0uOW9rNU6LMGFR1oXacki457xMg+AS/9reiDvFpZmpL77jDV
         vF4G6MLsye+0Jw6bXpeAjEVBZQ2EGERO6BDL/AD+bWD9lstKj96DQ4ieUVXTEtguYxjt
         TQCD6hHQnmNrIr95xabGGgumdV6iCETB25JUD05f+VMr+clBcs6vrMOnWKCTeOE1tMuv
         pRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678539126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5dJFQGb7q/CQhFpeP+fZ30ySwTofV5mRJn/cglIAuM=;
        b=1BwEtBVbg1L+h7KGfgc1AiHVfpDKhmy+g6G+042nLGjQMOmzqvp9Wb4rrvOHqw10uf
         KXasdYA7afUYNjIGIw5mFKOILdqW7Efn1irKoVn/cpc4V2+bchDwjgQDKWDTYWylVUx4
         /mpuPPAa8CaoW7R6soOHRCqEVygml/bBuLdDcJN09ncLV1scP7tok38G/x1hHapqdx87
         RfMPMr/r+j9qS/2pqz55XZVBRFs+18sn3MUQwvcQIvIRLu/4SNaOCHaWhtziKfR19plh
         p/aO6CSkv9glYcVxoeSY4FeJDTPLyxY4Ut7NpSwKEHhZI39H2n2UignWqz+Hp+Pqmr8+
         7gGg==
X-Gm-Message-State: AO0yUKUPMeQjRUwHpscdFNFAjza/JFVnOxaJ9NypIm23RGZ1i+GDx2zw
        ZnutMelhNKDQDlGMyI4/x5M=
X-Google-Smtp-Source: AK7set96yv7zjK/Ne6Q5hGpcIeejX36q2ZDtHXek+eUZeqWFWrHVldlha2HYJoGT2BiH3QSli+HXmw==
X-Received: by 2002:a05:600c:c09:b0:3eb:253c:faae with SMTP id fm9-20020a05600c0c0900b003eb253cfaaemr5418220wmb.36.1678539126555;
        Sat, 11 Mar 2023 04:52:06 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b003e2052bad94sm2721984wms.33.2023.03.11.04.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:52:06 -0800 (PST)
Message-ID: <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
Date:   Sat, 11 Mar 2023 14:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١١‏/٣‏/٢٠٢٣ ١٠:٥٩, Julia Lawall wrote:
>
> On Fri, 10 Mar 2023, Menna Mahmoud wrote:
>
>> Fix " CHECK: Alignment should match open parenthesis "
>> Reported by checkpath
> See the message in the other mail about the log message.
>
> Also, you should not have two patches with the same subject.  Here, the
> changes are on the same file and are essentially the same, even involving
> the same function call.  So they can be together in one patch.
>
> julia
okay, I will. appreciate your feedback. thanks.
>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/fw-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
>> index 57bebf24636b..f562cb12d5ad 100644
>> --- a/drivers/staging/greybus/fw-core.c
>> +++ b/drivers/staging/greybus/fw-core.c
>> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
>>   			}
>>
>>   			connection = gb_connection_create(bundle, cport_id,
>> -						gb_fw_mgmt_request_handler);
>> +							  gb_fw_mgmt_request_handler);
>>   			if (IS_ERR(connection)) {
>>   				ret = PTR_ERR(connection);
>>   				dev_err(&bundle->dev,
>> --
>> 2.34.1
>>
>>
>>
