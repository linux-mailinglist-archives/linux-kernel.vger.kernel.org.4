Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BE6C3829
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCUR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCUR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:26:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA3199E1;
        Tue, 21 Mar 2023 10:26:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so62565391edb.13;
        Tue, 21 Mar 2023 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679419563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SnwtyCeqfxN+W4U7ez13LVb+d2R2LMwy11y/Jz9LSw=;
        b=litogbTU0fH+k6JlYoZGvbaT5Hq90vpRJXH6co7YHtPjy6GL7l1hcYkbR9W6LJTley
         /QC3Cm+TaFE531qQTrcwnikTApOJrtVklzYCfYrs6NvTwNKLZqHqKQ8MXRuUbwEL8oM+
         8fLVJduQ+OTnwBuxEpJ60Vn1XPeV7d5dmW4gWh0YHE5/3VW1ZXHIFh0UniHcoPHGaxHy
         MR0Nh66FbEL9n1SdmB5B5O1Eka3N858+qEGBwzRV2HWXYAfTTt6uWGtXjJnHwiZsMeBq
         VCZLadbrdEJyvuiqTQYKOsHIox9IOjOlMK5BOp1cZPxO40YRAa4JKUZOpJTbau7FKB3z
         tGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SnwtyCeqfxN+W4U7ez13LVb+d2R2LMwy11y/Jz9LSw=;
        b=hncPpfcdRq3FcsemahwYt8pRTkv1Ok8r/TT7xE0bUUwsGdrNPEndFRL/3Ud3uRUOW9
         5kDGB6THa3y/7PT5/qvEtvJedr31s84CVueCfC1OvTTwrRdycvDeEtwGofg6JHk1U9gP
         G7jAPPD4XLYxzflcQ135uwXbSJP05WdjfnSL+xzqnzKGcQHuMlxCRL/jnvygN976ktvv
         w4r13GoQnYcjSgZhAGjt4zPTOajgG7OoGGtx6/l3MFFgyWvqtQH5ccSpSaMQOOSzL2zg
         S7RFDIqqdIbMFQY0Zr0sW+a8E2N6dgP7ANJKhs8rrht6S6KYGswQHuo/nj8TZy0FjV7w
         u3yw==
X-Gm-Message-State: AO0yUKXg9GATv8cBVwnPF1pQGo0g9C451Db5kB7CgZwUkBA9n4FuI+3j
        i4MOGatSgBSIlhP4EP2tOmk=
X-Google-Smtp-Source: AK7set+CABg3f1+mYA3u1QDkoUb8lm/4Sppl7dLBmBjX4+Czz1G/Js2gGQwEPDHRJLet/KbaByWEBQ==
X-Received: by 2002:a17:906:646:b0:8a5:8620:575 with SMTP id t6-20020a170906064600b008a586200575mr3677381ejb.3.1679419563139;
        Tue, 21 Mar 2023 10:26:03 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm6043318ejy.209.2023.03.21.10.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:26:02 -0700 (PDT)
Message-ID: <d98bd7af-d9f9-bb78-9aad-80c06a7a12a7@gmail.com>
Date:   Tue, 21 Mar 2023 19:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] edits in greybus driver
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <ee77a227-13bd-70ad-1d8e-f9719970e0f8@inria.fr>
 <196b5d53-701f-e2dd-596c-9fdb6a59f5cd@gmail.com>
 <8020f263-158d-db6e-f34-425b72983bb@inria.fr>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <8020f263-158d-db6e-f34-425b72983bb@inria.fr>
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


On ٢١‏/٣‏/٢٠٢٣ ١٨:٣٩, Julia Lawall wrote:
>
> On Tue, 21 Mar 2023, Menna Mahmoud wrote:
>
>> On ٢١/٣/٢٠٢٣ ١٣:٤٦, Julia Lawall wrote:
>>> On Tue, 21 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> This patchset includes change happened in greybus driver in three
>>>> different files two of them patch one and three related to
>>>> checkpatch issue and in second patch convert two
>>>> `container_of` macros into inline functions.
>>>>
>>>> Menna Mahmoud (3):
>>>>     staging: greybus: remove unnecessary blank line
>>>>     staging: greybus: use inline function for macros
>>>>     staging: greybus: remove unnecessary blank line
>>> Different patches should have different subject lines.
>> But I have already the same edit in both file, so should I re-write the
>> subject for one of them?
>>>     You need to either
>>> be more specific about the file affected or merge the two patches with the
>>> same subject into one.
>> each patch related to different file. So, Can I to merge two commits for
>> different files but have the same edit in one patch?
> They are both for greybus, which is what you advertise in the subject
> line.  And the sense of the changes is the same, and the changes are quite
> simple.  So I think you could just put them in one patch.  If you find
> other occurrences of the problem in greybus you could make one patch that
> fixes all of them.
>
>> but in this case no need to create patchset for all changes in `greybus`
>> driver, right?
> A patchset is needed if the changes affect the same file, because there
> might be complications if the patches are applied in the wrong order.
>
>> If okay with that, should I versioning the patches to resend them again, or
>> should add "RESEND" subject prefix?
> RESEND would be if you send exactly the same thing, because some time has
> passed and you are worried that the patch has been lost.  Now that you
> have put these in a series, it is perhaps best to leave them in a series
> and increase the version number, to avoid confusion on the part of people
> reading the patches.
>
> julia


understood, thanks Julia.


Menna

>
>> please tell me the best way to resend these patches, appreciate your help.
>>
>>
>> Menna
>>
>>
>>> julia
>>>
>>>>    drivers/staging/greybus/gbphy.h                  | 10 ++++++++--
>>>>    drivers/staging/greybus/greybus_authentication.h |  1 -
>>>>    drivers/staging/greybus/pwm.c                    |  1 -
>>>>    3 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>>
> >
