Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB4675EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjATU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:28:41 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5071379;
        Fri, 20 Jan 2023 12:28:40 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-15f83e0fc63so7496628fac.11;
        Fri, 20 Jan 2023 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZlMeRVUsWNss7A9ALjJ6icC270gH0NiCS0tX3tXuWE=;
        b=akc+wlZX34+ao85SDAufJ30abCRRK3sm1U2iDQaUHx1GCtwx84Og/TB9QW168Z1Cda
         oSaf8gJc3ouDbziEm7DldHcToQXYtcJtbg7X4eGmcNgtsnJpBDC0LVPYadvD1iKCcVBm
         P2bIezOIuOpfiXayBktmu9r62frbYORYPAHp816ZsqL//h4vTAgmkAj04vICkMLjRwBH
         iqdfD0zoo6QvFttPlzmU2tbiOmatojUoYWY1icXa1Jcu3vLK1X/+mufhaY3tZOyN+v1n
         jeo9+ZjAlruY7NkSCbXl9wm0txIVnyyHfKFcpwV2NarM6QoznS8B9j/HOtjM+kwzXxGz
         hYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZlMeRVUsWNss7A9ALjJ6icC270gH0NiCS0tX3tXuWE=;
        b=Crd4Jj+d4I0df7ohPfHtWeU360M3tVVM08IoJjrT3ikF+GvaQumtT6oRNV4vCNIoFW
         z7STmQwj2wW5MlmYRzM4qJHT3IwEEpAbghhD//b7VilnuXp+iYBAHuqYIwtuZJXKAm5y
         cwAB+O4TH1Lb11AdFyj12BQX26b6O3rCQVqYbf0tYhA9UAn8EHMiWyvkxPeWH3CC/xEO
         sYougllSiJzuGyKFpHtdVZHXC8Ow10JREk3H+QqEmoMsCAGB2U2ExNmJP+q5/jCujdW2
         WIzWUMPXjYzmQc0yAoQ5kEJ4oh6Km/1wCzIg9rIEETfjK0QAJmw/BX5+JaXOHZ/jsdEt
         k2Zw==
X-Gm-Message-State: AFqh2koBC7FUuTCRj5kazMI5ABsSevuQ0hCY5MsO9Gv5pT/my7DaBYDT
        lpQNEil61/jv2tPrECe28Zc=
X-Google-Smtp-Source: AMrXdXu5e99uZ0fGT+4DzsURCF2xQaGQvr7i5kqFGTV2UZKeiZXjjlM4M7aFiUKNcgWjYi7ENkaQ6g==
X-Received: by 2002:a05:6870:d628:b0:15f:da23:18a9 with SMTP id a40-20020a056870d62800b0015fda2318a9mr1417459oaq.26.1674246519198;
        Fri, 20 Jan 2023 12:28:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k19-20020a056870571300b00150aca072e8sm22177791oap.38.2023.01.20.12.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 12:28:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a6906293-634f-a7b0-8fde-92816192130f@roeck-us.net>
Date:   Fri, 20 Jan 2023 12:28:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards
 support
Content-Language: en-US
To:     Sebastian Arnhold <sebastian.arnhold@posteo.de>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
References: <20230111212241.7456-1-pauk.denis@gmail.com>
 <20230111212241.7456-2-pauk.denis@gmail.com>
 <20230115161224.GA1246527@roeck-us.net>
 <6fd769f9-da0e-c4a8-dc0e-a1e464c2d9fc@posteo.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <6fd769f9-da0e-c4a8-dc0e-a1e464c2d9fc@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:50, Sebastian Arnhold wrote:
> Is it just me, or is the support for my mainboard "TUF GAMING X670E-PLUS WIFI" now implemented into the latest "linux-next" kernel (I verified this by looking at the source code at /drivers/hwmon/nct6775-core.c), but the actual patch that contains the NCT6799D driver is still missing?
> 
> I had to patch my linux-next kernel with the patch from https://patchwork.kernel.org/project/linux-hwmon/patch/20221228135744.281752-1-linux@roeck-us.net/ to get it working.
> 

Well, yes, I do have day-to-day work that I am getting paid for,
and I did not have time to resubmit the patch adding support for
NCT6799.

Guenter

