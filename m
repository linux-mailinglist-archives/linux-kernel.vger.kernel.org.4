Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A4727D08
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjFHKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:39:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594AE4D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:39:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so652178a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220769; x=1688812769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wgec4tfIWdnEhpMr6ykg9xNvcCtcxWUQ6Om3tn4cEU=;
        b=Jzu6MtqgjH4ZproiCgJgfX3WoIOd9YRTOe+yXyjdFcEaO+nd7lkAaB8Yjqrko+keSC
         /yacB0AffOxXZuZIVJe3FLLrZS/P9rVZoFIh8usEjaPdcNVjIf1rAMNTJGXkrf+sl5Nd
         GLRuFtKIt5GHSnGdU6jpB+DqUmjw5r4IdUqCTSJC2dF787mZ/u4vZVNgJzurEvPDkoXG
         RKdeiRVKyvg73DiVVZpbD5ZR2Z77Wd39/d9u0XIltYqA5GN0XoBznZ7a03LkIFu8pbse
         l2Dn3oAY5hueFhsldblYXjKgJhkaPvmV6cd9PyYS5ZIJ4Z2mAWAve6fqSkJ0Yxerrnk5
         juMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220769; x=1688812769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wgec4tfIWdnEhpMr6ykg9xNvcCtcxWUQ6Om3tn4cEU=;
        b=HL7jQiSo3jDgSTIHJPteFpgJc8l/aMCyrQ9wWijH0rhLYGx3mnwc/2y2bWqgn7oLt9
         dIivzOJMNXWsXcXtLr2ct9paa5i6O/uchkHZWo5yhn/VTroEZlCsnMCNzNrAGNPW0L3E
         uh16YfqwEGpmgU4VhoB41JM8tvk9vZug2aC1r418W0NK9aZjhFuEqkib7L8k4etefiN+
         T2JoLH04Xn8HIhzodGrktxzVCJ/zMXytmTNcVH2Mi0lH9KCUQZ8Qgta/IB7rhNfYIQ5J
         xa3GETbyiT81ZYBItktnGPCxcwcGgBlb3blhMnJRpUAXRQJGYU+ajgXWZG7cBxOF7tQ5
         ZpWQ==
X-Gm-Message-State: AC+VfDwCJ2XrN2bOXypZJGM+z1kyrf7zAA0UKcXaAqff34iRhKJaZ0l6
        gsF2gZhac2HbABBQw67Rc9c=
X-Google-Smtp-Source: ACHHUZ4ytm/M/a+Iwv6nZciUDlVTlAht7v/lQ5uBsyjdfFH4TWUuLUvl3T6ueNXwjFKIgWOf3yY0ng==
X-Received: by 2002:a05:6402:31ef:b0:514:8e14:7f1b with SMTP id dy15-20020a05640231ef00b005148e147f1bmr6910012edb.12.1686220768883;
        Thu, 08 Jun 2023 03:39:28 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c50b000000b00516a1fa0e60sm384205edq.89.2023.06.08.03.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:39:28 -0700 (PDT)
Message-ID: <f7a1a20c-bee8-c7a4-4c49-b66415f556f9@gmail.com>
Date:   Thu, 8 Jun 2023 12:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Ondrej Kozina <okozina@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
 <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
 <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
 <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:39, Coiby Xu wrote:
...
>> I do not think you need any cryptsetup patches, all you need is to write
>> decrypted volume key from LUKS metadata with
>>   cryptsetup luksDump ---dump-volume-key -volume-key-file <out> <device>
>> (or any code equivalent with libcryptsetup), am I correct?
> 
> Correct me if I'm wrong, but I don't think there will be a safer way to
> preserve key without patching cryptsetup. Actually the --dump-volume-key
> approach has been proposed before and I agree with your conclusion [1]
> on that approach i.e. "passing volume key this way is quite insecure".
> Without patching cryptsetup, even if I save the volume key in the memory
> reserved for the kdump kernel, I need to retrieve this key in the
> userspace to unlock the LUKS device which may lead to quite a security
> vulnerability.

Hm, where are the patches for cryptsetup, then? I am afraid we do not want
to add such specific things there.

But we are just going to merge a patchset that changes how we use keyring
where you can tell cryptsetup to store/link key under some specific name
and to specific keyring
(see https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/492)
(Please talk to Red Hat cryptsetup maintainers for more info,
I just mentioned this mail to them today.)

> I respect the efforts from you and the cryptsetup community to make LUKS
> as secure as possible. And kdump is used in product environment. Kdump
> is to a server as a black box is to an aircraft. So by no means I want
> to reverse the used security measures and patching cryptsetup can allow
> to keep the security measures. One concern raised by you against "FRC
> v1" was a copy of the LUKS volume key for the kdump kernel creates an
> attack vector. I took this feedback seriously and have sought advice
> from my colleagues to implement the countermeasures ([PATCH 1/5] and
> [Patch 4/5]).
> 
> [1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/

Yes, I appreciate that. And it is perfectly ok if your customers accept
the trade-off and security risk of handling the key this way.

Anyway, I feel we are going in circles here, and as it seems to be my fault,
I do not want to sound grumpy as I am perhaps missing some context.

Could you please talk to internal RH cryptsetup maintainers first and discuss
your solution? They know what we can do here can help to find an acceptable
solution. (I added cc to Ondra.)

Thanks,
Milan
