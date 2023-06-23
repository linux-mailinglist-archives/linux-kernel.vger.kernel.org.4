Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97A73BAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFWPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjFWPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:00:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902AE7E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:00:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-54f75f85a17so526632a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532426; x=1690124426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y64wZbLvDhAp64CszEHArvKP3yZ1dAb276xqL28d98I=;
        b=awJ8vtW7gAuMZ+JHHmJw1Z7ykj2a9sgB2IcwFcSpvWUEj8hPnBhYipV7QVFBdshc/h
         k37D4/YQL7kGsacUu7pImW3qBq9mc7GYhn99VgCgGdWXwdUQ3s1gNcNjSs7OJFKNlSpB
         HvJPJe3Ow1blXg04w61hxIg+5Kb6qEXnbm21Ky0hIwJlVwBjVNfCH2jLYSQz3md5QmXV
         xhTiJ7BSJaK7krJyYJdcTWRL3ClG7K822etBrXA2ofmm/eiAxjM8XT9k/4rfaBbBmdt/
         AuzBkk129NxmI9vbdTET9O8hOD1ETcV4LqRfyT6OSenQ8sHsROl4Cj8Vz21Ve5d3UAFV
         ohiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532426; x=1690124426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y64wZbLvDhAp64CszEHArvKP3yZ1dAb276xqL28d98I=;
        b=g/Q4SqYz7uyPXH2ajvJ7Rs+l0lEVrATxRYWxtwkDGFLydE5s1jKSjbB/Xvcg2D6/bl
         ghBpDbf0fAl+rSRPvcjDfXL7nD06UokFRzwMbnf8AJclVpA5XIL4PPDXSmYL1xXBtxIZ
         IqAa3DE/b5/Z9sefGp8e2kI63J3oVw6opEe9i1Rmw9V90kBhR519E+t1q2PyJz8ioNvf
         x/oiDR7YkWGeHoFgJThearjZpsNjRvyuRQuMit4BjH04GQPehrLbRElH5/vLmUp+GeQ4
         Nt7CKDDwvZ162acV8if+uffj05ACG5pzKwZXXwCjQQ4mjZ1s5yXAngvaZ8JfoLXJr/1j
         MDYQ==
X-Gm-Message-State: AC+VfDwtp6HyX5+oFEKMq7AQaO3y1AZRcnSdLKXajJN+Htf7iOVb0uRN
        KwNBc8UuYSkLj4pn0UU3Kndz0jZbnryrRA==
X-Google-Smtp-Source: ACHHUZ5erdI2uvkRppWMMyXC7RXSQoS4p2VBxCetx9I5xOAz2tgiP6733+TXK0I2ZEFHZyoG1ca1bw==
X-Received: by 2002:a17:90b:a4f:b0:25e:112c:c5e9 with SMTP id gw15-20020a17090b0a4f00b0025e112cc5e9mr14097588pjb.12.1687532426063;
        Fri, 23 Jun 2023 08:00:26 -0700 (PDT)
Received: from [192.168.0.103] ([49.207.243.158])
        by smtp.gmail.com with ESMTPSA id s22-20020a656916000000b00548d361c137sm5889529pgq.61.2023.06.23.08.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:00:25 -0700 (PDT)
Message-ID: <985bd8ea-fbe3-a95e-28f8-e51b8a03825a@gmail.com>
Date:   Fri, 23 Jun 2023 20:30:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
 <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh>
 <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
 <2023060155-mustard-mating-32b7@gregkh>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2023060155-mustard-mating-32b7@gregkh>
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

On Thu, 1-Jun-2023 14:38, Greg KH wrote:
> On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
>> On Wed, 31-May-2023 22:20, Greg KH wrote:
>>> On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
>>>> On Wed, 31-May-2023 20:08, Greg KH wrote:
>>>>> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
>>>>>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
>>>>>> Can you please review the latest patch series? I think I have addressed your
>>>>>> concerns. Thanks.
>>>>>
>>>>> The big question is, "who is going to use these new features"?  This
>>>>> tool is only used by the in-kernel build scripts, and if they do not
>>>>> take advantage of these new options you have added, why are they needed?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> Hi Greg,
>>>>
>>>> Thanks for the response.
>>>>
>>>> We use it in VMware Photon OS. Following is the link for the same.
>>>> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
>>>>
>>>> If this change goes in, it will give a slight push to our build performance.
>>>
>>> What exactly do you mean by "slight push"?
>>
>> Instead of invoking the signing tool binary for each module, we can pass
>> modules in bulk and it will reduce the build time by couple of seconds.
> 
> Then why not modify the in-kernel build system to also do this, allowing
> everyone to save time and money (i.e. energy)?
> 
> Why keep the build savings to yourself?
> 
> thanks,
> 
> greg k-h

You are correct. Sorry, I got busy with some other work.
Thanks for the inputs Greg. I sent a patch for the same, please take a look.

-- 
Shedi

