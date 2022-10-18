Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2099860213C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJRCgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJRCgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:36:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038418380;
        Mon, 17 Oct 2022 19:36:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so16061856pjs.0;
        Mon, 17 Oct 2022 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQsvsKFvIgYktIg/XKnkN+HjvyN+ijqDltwi/tGC1YQ=;
        b=Olf2nqyyty+JBycOlgJblOjTCAWJTo8Yp3OrQi6+5/7+7XIdlOCSIux3/EUeUEVQXZ
         +ma530KdOkh0nrg8x32h0il2YvWYTAsr6uMnlrmRLh03difFGXQ1CHbgnFeR9UIyh3d4
         mAWfRWnwKRyaZHzu//1LIaTyybdCATDD5XcBbAF3mKB8Hp9JHLKbiT94d2Q4viX87enE
         JIjcUi+1j9k5hC+vrZmTqQSy+amn0LE2M+tWAgCxj0IhXho5Hx4hiQjflZgSRYelCK81
         fXjJ8AvfNcz81TbOJKN2Jw48ffoyitn9qNyT6Je8ALN4RJuQp6I5VuvO0dbkEumUDTuq
         GLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQsvsKFvIgYktIg/XKnkN+HjvyN+ijqDltwi/tGC1YQ=;
        b=b5UqV5HKWVQif1Cqar+0vPD0szEoTgmy6+NvU/nHVR+iX5HuOL6ArHqt5kuj0hykIs
         Wn7nfDKWcg7V1L5l2l8oHQXhUfP8rLaxYErinAzrq0HKCsaKPHldwu2e9PIU2P1CduHZ
         ACLs59pNHdl0ASvcjZRYib3aHBmSXSd5Gj61RGVg3IboLinZxkqzuYtrXSZc2iX8Xxd7
         sfJ1vkxPoHN83S9aaVynMrcFNEk3cNpAhxZzH6Kr5NRyiNxMuxvP68ZlhdmvU//PVFFw
         9BGQ3+eAQmHvnPEPUCPkGQWzy321xsvXQHDBob5N0aR+MWOOBR0KgtlI7GpvSYYOs2XK
         dCyg==
X-Gm-Message-State: ACrzQf3K2HNW7R+qkrmIheY4yEpuvIdjAPYIFv6QNCV8v6VlVf+4i7Qh
        ksa+SuzjIaQo0JRQOkvZFzM=
X-Google-Smtp-Source: AMsMyM59m/v/Nwrhs3kECx31Bo+s5XUbUhpMtDDJvD3Ta1QQ+hBCIQ9oYq1GgZI/F+S6RIoW6c6www==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr709561plh.142.1666060577437;
        Mon, 17 Oct 2022 19:36:17 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v8-20020a654608000000b0044046aec036sm6807949pgq.81.2022.10.17.19.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 19:36:16 -0700 (PDT)
Message-ID: <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
Date:   Tue, 18 Oct 2022 11:36:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, bilbao@vt.edu,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <Y01pkubcT7FOwCjL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 23:41, Matthew Wilcox wrote:
> On Sat, Oct 15, 2022 at 01:06:36PM +0900, Akira Yokosawa wrote:
>> Hi,
>> Minor nit on language code.
>>
>> On Fri, 14 Oct 2022 09:24:53 -0500, Carlos Bilbao wrote:
>>> Start the process of translating kernel documentation to Spanish. Create
>>> sp_SP/ and include an index and a disclaimer, following the approach of
>>> prior translations. Add Carlos Bilbao as MAINTAINER of this translation
>>> effort.
>> IIUC, the language code for "Spanish (Spain)" should be "es-ES", as is
>> listed at e.g., http://www.lingoes.net/en/translator/langcode.htm.
>>
>> The other translations use directory names found in the table, with
>> "-" replaced with "_".  It would be better to be consistent.
> 
> I don't know what standard we're actually following.  RFC5646 suggests
> simply using "es", with "es-419" for Latin America specialisation or
> "es-ES" for Spain.  I don't know how much variation there is between
> different Spanish dialects for technical documents; as I understand it,
> it's worth supporting two dialects of Chinese, but we merrily mix &
> match en_US and en_GB spellings.  Similarly, I wouldn't suggest that we
> have separate translations for fr_CA, fr_CH, fr_FR, just a single 'fr'
> would be fine.
> 
> We do need to be careful here; people are rightfully sensitive about
> being incorrectly grouped together.  If possible we should find a
> standard to follow that's been defined by experts in these matters.
> https://en.wikipedia.org/wiki/IETF_language_tag may be a good place to
> start looking.

I think generic "es" is OK, especially if "es_ES" can have such a
negative connotation to some. I just wanted to point out "sp_SP"
looks wrong.

Carlos, if you go the "es" way, it would be better to mention the
reason of the choice in the Changelog for future reference.

Subdirectories "ja_JP", "ko_KR", and "zh_CN" were added under
Documentation/ way back in 2007 (v2.6.23).

As you might see, two of the three language codes needed region
distinction and they were reasonable choices at the time.

        Thanks, Akira
