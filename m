Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941C6876B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjBBHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:47:18 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42584B64;
        Wed,  1 Feb 2023 23:46:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z14so691869pgs.10;
        Wed, 01 Feb 2023 23:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGSOYxv/j/MNJQzPd2QdkN2kozRqA+JtR82Gzkjbx/4=;
        b=nxTnHQkQPeB5wDvkC6I2tEqM1JicchQbGn7nXhk5Ewo/2PjyrAhpHOXkyE4PoLWuZG
         PS/5Pz6lI6gdh1nybrUQUo/kscIDpth6EjQokxYoK2dCe/DV+BV8hV6Jr4ZZPQKjSYcA
         6poExH2b8YRM+2tLAhykRrFo+LBgh/0uYKkmKliUlXXvF31woRaycJMxEFx/E7RzV4nt
         dpobntcxRpZToU2GdM3LGnT+kH8DTs3oq4rrSGgtPb9WL75715b6hGM24UQbSRXE9J0v
         /ipt46EVAFJtbQMw4brq6FNGuceARsqMOTxyyfn+5ryfUKR0RnsdGLiUkYejjkv16j1s
         mw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGSOYxv/j/MNJQzPd2QdkN2kozRqA+JtR82Gzkjbx/4=;
        b=l/TOrSMOcNNVMeE077x4JGKBKeM/FAfe8M08O1Yj8ii7N5CTePaaXUUVo0DFuiItV7
         PKVxwSVQ92cSc0O1JaA/7Ziu1+swbzMZJQ4kbHcLuTXq+nSKqOJ5pWbwE9WKYrKrEc2V
         chZRfr3qIuNMUD7naQvUaji/Vhemzd/GNGsvHSiMwCxY3OU2WSdEY2KUe7v/MAog44tO
         etxAQNg+7o71lB0kMci3RybtiiDwddhIUKiAVZwGU6qKcAXpp6JE72zl2GRAT42wZTs/
         wRuF25yjPdyXk7Fr4DIba3yiL8yjnv3N03CeJ2MTlVMRVy6fA2A+jkzfyGL24WifMSRn
         mo4w==
X-Gm-Message-State: AO0yUKX9LLoJCr5NIAa0vs7aDz9UwNvLXJDOo837O1kevngLx1/nrXqw
        sEAmOc6MTD53PtUklQIkKMDXkpMFFzKx2w==
X-Google-Smtp-Source: AK7set90d+GUZzx4Pc5ATKw/9I6NQuiioo26ysN+zhEnOBJIrfHMc5MfSjPdmPmmWgM/wFj4e21Hgg==
X-Received: by 2002:a62:1e81:0:b0:593:d1ff:b8d4 with SMTP id e123-20020a621e81000000b00593d1ffb8d4mr1029258pfe.26.1675323956676;
        Wed, 01 Feb 2023 23:45:56 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id x30-20020aa79a5e000000b00589d8cbd882sm12730606pfj.150.2023.02.01.23.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 23:45:56 -0800 (PST)
Message-ID: <9740934c-1bf6-87b0-408f-75089585e6ec@gmail.com>
Date:   Thu, 2 Feb 2023 14:45:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131221105.39216-1-skhan@linuxfoundation.org>
 <Y9nkqhAS6EW2Lu8Z@debian.me> <875yclx8ay.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <875yclx8ay.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 06:41, Jonathan Corbet wrote:
>> I think you haven't addressed my comments there [1], so I have to
>> write the improv:
> 
> Bagas, could you *please* stop this?
> 

OK, withdrawn, thanks!

Thus, without the improv,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

