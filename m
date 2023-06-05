Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6004722F17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjFETB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFETBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:01:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B994
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:01:54 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33db1ad228aso681005ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685991713; x=1688583713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FCMgag38vfbtUpIaPdfRT+VvGu4ZzQNO5yK+UmTnRY=;
        b=EwQuPD2pQ2kaXVIUWni8Pav1vNCkU6Kd0pZvWLacIFOdCBQAZCKGuyeVhIh2UvWECm
         qT6YOau45zjb5CwFEdRx5bvq7WLVXCYuqKV537SctYI9PahwnffAu9Oz/wv4ctrE38Q5
         kQp585RfDsSBIbkvNWYLAbwQjI1E+6lJ8S4rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685991713; x=1688583713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FCMgag38vfbtUpIaPdfRT+VvGu4ZzQNO5yK+UmTnRY=;
        b=Z2g9d4V7YAfu6w97X92Ok4SLpV0pUW94mE1+xQUOr0v1JO1F+gEGediG4vkM1zCVwi
         MdQin/6C1o3e0btutQ/YtjXW+92v6DmDo1lafchwErAhg7jr8u365gvq2XqYTqo5vE7I
         pLvtgNlcfBNr6MjKbq6kylummVklP0DkEQ1/imP9evVAx8UDLuKHtr2sPjhrt9u9+iys
         33m7q1LaR8TLKVjUEW9tnJ0DQmnKB+5+9vbiSeEeBtZBovsknPEZ0VkCJs+p6MvHNMni
         TikuO0+Hwf1M2Bvkp2V8KVSsIubh1Mhi8nepqufg9uY0Fl3xBALcJxFBnMHZmUduzCI1
         3bpA==
X-Gm-Message-State: AC+VfDxO9KgufgD9fPzVN74IlzO8mwssRhY7SlHbhZ0unjHNGF/9UFN3
        eZfxlxN2Hz+p4pxLkJnXrrqyfg==
X-Google-Smtp-Source: ACHHUZ5wxkLAMBl91PlInY7+Du/uZRMCFqCXM1lLMBVvr1Z9AIqxW8ON+rDoVw4WlYRWLJe7u8CfWg==
X-Received: by 2002:a6b:3f06:0:b0:774:9337:2d4c with SMTP id m6-20020a6b3f06000000b0077493372d4cmr91711ioa.1.1685991713603;
        Mon, 05 Jun 2023 12:01:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c9-20020a02a409000000b0041d73d0a412sm2355812jal.19.2023.06.05.12.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:01:53 -0700 (PDT)
Message-ID: <3a9c8407-7ffd-e6c0-74d2-574c99fd739a@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 13:01:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests: allow runners to override the timeout
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        tiwai@suse.de, tianfei.zhang@intel.com, russell.h.weight@intel.com,
        keescook@chromium.org, tweek@google.com, a.manzanares@samsung.com,
        dave@stgolabs.net, vincenzopalazzodev@gmail.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230414193845.2494120-1-mcgrof@kernel.org>
 <3f5c5c28-3814-3fea-dfbb-a3c7604e0edc@collabora.com>
 <CAB=NE6Wx=PQ6n__hdseLzahNdkGoyUXDW4w9B5bBLvg-kVxbXA@mail.gmail.com>
 <ZG6WlUZZN4etzM2k@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZG6WlUZZN4etzM2k@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 16:58, Luis Chamberlain wrote:
> On Thu, May 11, 2023 at 08:26:42AM -0700, Luis Chamberlain wrote:
>> On Fri, Apr 28, 2023 at 1:34 AM Muhammad Usama Anjum
>> <usama.anjum@collabora.com> wrote:
>>>
>>> On 4/15/23 12:38 AM, Luis Chamberlain wrote:
>>>> The default timeout for selftests tests is 45 seconds. Although
>>>> we already have 13 settings for tests of about 96 sefltests which
>>>> use a timeout greater than this, we want to try to avoid encouraging
>>>> more tests to forcing a higher test timeout as selftests strives to
>>>> run all tests quickly. Selftests also uses the timeout as a non-fatal
>>>> error. Only tests runners which have control over a system would know
>>>> if to treat a timeout as fatal or not.
>>>>
>>>> To help with all this:
>>>>
>>>>    o Enhance documentation to avoid future increases of insane timeouts
>>>>    o Add the option to allow overriding the default timeout with test
>>>>      runners with a command line option
>>>>
>>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> Tested-by:Muhammad Usama Anjum <usama.anjum@collabora.com>
>>
>> Shuah, just a friendly poke! This is needed to allow me to enable full
>> automation for kdevops for selftests.
> 
> Shuah, friendly re-poke.
> 
>    Luis

Thanks. I will apply this for next.

thanks,
-- Shuah
