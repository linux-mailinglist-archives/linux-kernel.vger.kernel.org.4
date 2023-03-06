Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05E6AB8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCFI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCFI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:57:39 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551821965;
        Mon,  6 Mar 2023 00:57:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u5so9490104plq.7;
        Mon, 06 Mar 2023 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678093053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vt+MS0eYcnMeqDB+aM3O4tClbihsYFf1JjAFSjKpS1E=;
        b=Ut2pKvDf5wwayQF+UAC+FXF6xHDhXluuw7A6U2rkEwwqhkYN5kTsDWdIlcpFk0krUc
         lY8S6KlxITtUWDTDzUkrs7VSrxHu09I324zsD0cQk2qhJ6l4/sOHIWMHsGDmQ1HPXTdk
         OJcPY+GMEj99V3q+BtoXsRpgeXaGDcsNqsK+lhAFFqwgEgCj2Z7+4ag1w2DBSoSs60s8
         70iyjdwN3vTnJKC1ONpM5pMOeX3W+WXB4aVscw/4hCFnzeAS+aIz61fLh9bxrjTHmXtE
         pF78aY6e8KxYw4kXIWuF9qsUaTQ3cE8qo+HFqbMZog+hA3bXZhAW27U1EFR/81jKd3tJ
         gJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vt+MS0eYcnMeqDB+aM3O4tClbihsYFf1JjAFSjKpS1E=;
        b=bRd303f9wMGKX9S23VNDtoE+MUefeS0ECN/te5WGTZCIwDcydIcZmVEZk7i3jp7fzJ
         +Je0OPnOv/CarMF7JbmWLZP8QQYlD60PtXubrzUPHTVVdBYdJuwYkHip8iLGnSKCbFCX
         PBRDE1eZAFB/HJGy83YtgRDFSfz9akQn8OYeieBxx52fjzZdHQ4al6C2ItwTlAPoj0RP
         MieBjS52GXsmVzKU+hroewXfN7nRsKiu+V+JV84bp7huadIL2PVyov7fkLKgcrpfibuj
         dMXvKbnrFX0i68YrQjopzuA+p6+bvK1cA8701Zx7FuxBtRtcpq94nv5Tj2YXJaOa/lvc
         Gxdg==
X-Gm-Message-State: AO0yUKVaiorZ8Mpzl4DH6szbSADUrsVamImmhxIsEooPiYhcfK0Ve0eb
        3MuOoCmV47ZYsppdUl0XCA0=
X-Google-Smtp-Source: AK7set+dFQRcLEIvi0ZHJ5bHx/UaxNJvMl1pMDFFHBR/U+WXM9FUajLpcyefdLAvvbY7wiCn+BqlMg==
X-Received: by 2002:a17:902:d489:b0:19e:5cc3:828f with SMTP id c9-20020a170902d48900b0019e5cc3828fmr13019163plg.27.1678093053259;
        Mon, 06 Mar 2023 00:57:33 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id e1-20020a631e01000000b004fb681ea0e1sm5764949pge.84.2023.03.06.00.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:57:33 -0800 (PST)
Message-ID: <f53f84b5-9da7-0726-2e1f-f7e81e8ecd24@gmail.com>
Date:   Mon, 6 Mar 2023 15:57:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <ZAVp6jdeWzYcisUO@debian.me>
 <3d6a30ee-f093-f5b6-a193-cd86320f9452@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <3d6a30ee-f093-f5b6-a193-cd86320f9452@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 12:40, Thorsten Leemhuis wrote:
>> If your distro config have ``CONFIG_IKCONFIG=y``, you can copy from
>> procfs::
>>
>>     zcat /proc/config.gz > .config
> <snipped>
> 
>> If it isn't the case, you may want to enable the aforementioned config
>> option.
> 
> That or put them in /boot/config-$(uname -r). But well, that is
> something the provider of the running kernel needs to do, so it won't
> help the reader if we mention it here.
> 
> Or do you think the guide should explain this to ensure people can
> pickup their config from there again in case they deleted their build
> artifacts? Hmmm. I currently tend to think that's not worth making the
> text longer for, as at that point it might be better to restart from
> scratch with a distro config anyway.
> 

I think it depends whether someone would pick from /proc/config.gz or
/boot/config. My kernel configuration have CONFIG_IKCONFIG=y but I
often copy the config from the latter instead, since I booted with
arbitrary kernel version when compiling two or three versions, and I
want to ensure that the config used is from correct version (i.e.
I use /boot/config-5.15.x-string to build 5.15.x+1 kernel).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

