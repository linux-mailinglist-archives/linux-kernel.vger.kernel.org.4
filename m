Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482D703EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbjEOUxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbjEOUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:53:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFAD9EED;
        Mon, 15 May 2023 13:53:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaebed5bd6so94266635ad.1;
        Mon, 15 May 2023 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684183981; x=1686775981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u63krdDNVLfrPpdPZ+6BGPurtOU3qe+NV5dmHvImCAg=;
        b=W1qyfspbckSC/az3IhluIlC3RAFMg0x+d5BDA5Oer3oOR04IlM1DmY9uQsu0t7y55/
         2YsWEOpwl/hcPtFzKi/+A9b+JJIMplOxyloFCBKmrPeBqGpfqWmjCH9S02c0VSr+7GxB
         b6rCARWbBZCXd8DPgkmp95695PLW0vCAPGhQT0F2LryTTsoO0J6KMYC65NDNBiwMz2e2
         ObkL5ntrDDl08C73k2EqBDZes/IroG6YQNrJnp41ryLxpMzmRx9iHE8USYkZtHOyvW2q
         0BeoxzUU/vJ8WPIBvXO3m1imy7Z/p1AJOHEUK60Xa6G9FsCZFtERhu54biXI10KW3Zkg
         F/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684183981; x=1686775981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u63krdDNVLfrPpdPZ+6BGPurtOU3qe+NV5dmHvImCAg=;
        b=LKZ/q54aiPCcR97LGBwUgad8a7h8BlhHhkofJHtv+UKOVwauSrHGL0BLfVLqp+ttxV
         AYkXaXm693zNNZapfzJ7rP12BOs9eWABk7AyFzS3x6cMjpdsmC3FyVTMRA3jv3tKNw7d
         R2AEhVMVccVAcd5Ks3Cuyevth8D07uqzD4dYyCdKBLukI5IsnDcVlJxtAFdNSAO7HFM5
         uUVcqm9RgV0Gy+1JHD/bHndZrYMD9tZ6krsAp1zZPTX23z/FGUikA2HxpZime2n7AQZC
         dnQOoggnG4ZnoKFAOW8pEhQjs74VzmA0h8mBCZdQiME7zKBRNdgyYQOxHr3BG+26KZAe
         ziNw==
X-Gm-Message-State: AC+VfDznlW820Qv8cOM/ykAJQqB2/E5JbWdHz00GxcCeSTSQkpockRVL
        N9MYJ0p6PsY9+l12OfQvoT2jDsdW9ok=
X-Google-Smtp-Source: ACHHUZ7YpluVHjMWKFwQVvEZwF56Mg9loXHBtMgyNO6I3/3cRxlu3zez5U9amXZU9oJrv9DmQybTrA==
X-Received: by 2002:a17:902:654c:b0:1ae:175a:44f2 with SMTP id d12-20020a170902654c00b001ae175a44f2mr5476497pln.25.1684183980886;
        Mon, 15 May 2023 13:53:00 -0700 (PDT)
Received: from [192.168.1.107] ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001a9666376a9sm13947855plb.226.2023.05.15.13.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 13:53:00 -0700 (PDT)
Message-ID: <b9999e76-357f-44c3-23a0-f1554ceb11af@gmail.com>
Date:   Tue, 16 May 2023 02:22:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515144910.13514-1-llyyr.public@gmail.com>
 <54471eb9-3cd0-429d-b652-07fd380f359d@roeck-us.net>
From:   llyyr <llyyr.public@gmail.com>
In-Reply-To: <54471eb9-3cd0-429d-b652-07fd380f359d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 00:29, Guenter Roeck wrote:
> On Mon, May 15, 2023 at 08:19:10PM +0530, llyyr wrote:
>> This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.
>>
>> Signed-off-by: llyyr <llyyr.public@gmail.com>
> 
> This needs to be a real name.
> 
> Guenter
> 

Do I need to resubmit the patch, or can you change it to Gopal Prasad then?

