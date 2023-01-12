Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E7666D45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjALJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbjALI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:59:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9325C6;
        Thu, 12 Jan 2023 00:56:06 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 976C33F9FE;
        Thu, 12 Jan 2023 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673513515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahx2/VRGZnRz/4L6FrPmyuE3/nmwxEy6nYPQo/mPJNE=;
        b=oK7Tz2uYjRwQ83wcKYQamzMeNyIc8/SDohbbqSiv4HgOuaVNSx4b+j0+65H9+p9pdpScc4
        7V8xMtMvkBfux8RjtW6Ufmk0RX3MR60IHiQuguBKnzSfPd4J+Se9OgEHe3vA0L5jR0svFE
        mjaJpX5Rw+zwoffx0r8g55e14psHjks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673513515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahx2/VRGZnRz/4L6FrPmyuE3/nmwxEy6nYPQo/mPJNE=;
        b=KA2r/M8XpeEgweIrd5uCJN5jiGqMzA04IXSpvd8ox/fqwdXkwzbO2ZY+q06WyI4kzYE8Ur
        WrMeeQq3KERwJhBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6737E13958;
        Thu, 12 Jan 2023 08:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Go3zFyvKv2PkDgAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Jan 2023 08:51:55 +0000
Message-ID: <04b46a66-4c96-a2ee-bae3-a449b7a2df56@suse.de>
Date:   Thu, 12 Jan 2023 09:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 17/23] arm64: dts: Update cache properties for realtek
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-18-pierre.gondois@arm.com>
 <35413b5c-0d83-0f37-9ea7-1217305c138b@arm.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <35413b5c-0d83-0f37-9ea7-1217305c138b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12.01.23 09:33, Pierre Gondois wrote:
> Just a reminder in case the patch was forgotten,
[...]
> On 11/7/22 16:57, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>> The 'cache-unified' property should be present if one of the
>> properties for unified cache is present ('cache-size', ...).
>>
>> Update the Device Trees accordingly.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   arch/arm64/boot/dts/realtek/rtd1293.dtsi | 1 +
>>   arch/arm64/boot/dts/realtek/rtd1295.dtsi | 1 +
>>   arch/arm64/boot/dts/realtek/rtd1296.dtsi | 1 +
>>   arch/arm64/boot/dts/realtek/rtd1395.dtsi | 1 +
>>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 2 ++
>>   5 files changed, 6 insertions(+)

Short-term I can offer an

Acked-by: Andreas Färber <afaerber@suse.de>

Regards,
Andreas

>>
>> diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi 
>> b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
>> index 2d92b56ac94d..0696b99fc40d 100644
>> --- a/arch/arm64/boot/dts/realtek/rtd1293.dtsi
>> +++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
>> @@ -30,6 +30,7 @@ cpu1: cpu@1 {
>>           l2: l2-cache {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi 
>> b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
>> index 1402abe80ea1..4ca322e420e6 100644
>> --- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
>> +++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
>> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>>           l2: l2-cache {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi 
>> b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
>> index fb864a139c97..03fccd48f0c0 100644
>> --- a/arch/arm64/boot/dts/realtek/rtd1296.dtsi
>> +++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
>> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>>           l2: l2-cache {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/realtek/rtd1395.dtsi 
>> b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
>> index 05c9216a87ee..94c0a8cf4953 100644
>> --- a/arch/arm64/boot/dts/realtek/rtd1395.dtsi
>> +++ b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
>> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>>           l2: l2-cache {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi 
>> b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
>> index afba5f04c8ec..2ee9ba1ecdc1 100644
>> --- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
>> +++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
>> @@ -87,12 +87,14 @@ cpu5: cpu@500 {
>>           l2: l2-cache {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>               next-level-cache = <&l3>;
>>           };
>>           l3: l3-cache {
>>               compatible = "cache";
>> +            cache-level = <3>;
>>           };
>>       };

-- 
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nürnberg)

