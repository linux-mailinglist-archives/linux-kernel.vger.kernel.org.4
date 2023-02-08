Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678168F9EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjBHVxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBHVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:53:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09A7ED6;
        Wed,  8 Feb 2023 13:53:31 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m2so929771ejb.8;
        Wed, 08 Feb 2023 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcGGbFgEzftpyF+VOMqjhkA2DYYoI9t16vH0JUIgyuc=;
        b=cg9oxHSR98/LkffcvDkkGQCCtLefB0sqA93hXHygHElmL1cUKTMRrXhq97NJRUJY/A
         1HV74cpAJFBoEnIYcCflww+F/afJi1mkl8wBTT+ZgBiCk5rBKgXeAo/ipFiy9NaacDNU
         MFATqc/YfrzWwyJ8uceojDzj0QWAkyajXt3HsGXhOJC5wJoJavIRywW/MKNV01BO5lxJ
         Pwbq8xYy8HjQ+g69eWQ0TDFC88OLWRH7zFcLkXbWq7HeF11YzgWF8bXtLIewP3G3A/mc
         UU4DFiH5o/VHc3DO0t0yW8/dUDBk0+n+S+dF2Nkh97tH13BU7YFCLpqzbpVrTOhO6iW/
         SXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGGbFgEzftpyF+VOMqjhkA2DYYoI9t16vH0JUIgyuc=;
        b=3tO/NjkbSBn7SmshySmPXDSUSClnhtupA9mOWHUpkMXR2bmcWM1XhOiIADQijZND4D
         fB4JRgg8ZlJHVW1lJ3m13aPnabObn8/F1GBbqh2jBUbC5c3KSB6AVeMh5Lw3U1YsdRPY
         m3mL6+KyIAu7zfI7VtDu7X+y4y/r2sDN3fAyJk8v2uNskMCI7g0LU4rboPncL845ZfLI
         AO+K0fY4WZXVCFSLG/2zS9Bwk71aLIRWrV2tUMe9RpYBJV3G/u/ijkhdldeJEGc1oOm0
         guHmtZNsUBTfxBB+LZM+WT6t6KZ9zKO7hYaGfVQMEOJ4a+KHnaOxY9xFMTa51GuV2SgL
         ENgA==
X-Gm-Message-State: AO0yUKXc5t8DnowdMFaDzN36f+IgMOyLymDMPD5lfPZX/zeJooaqo9Hq
        Snv0Q+T1w/ANQHmnt/p2yLI=
X-Google-Smtp-Source: AK7set8pkmkQWkfL4XRfxKlhYKYQs7fnwnkKSLN8IQialzdrFeRgKSVaL/BXycnher0m459swtSKDQ==
X-Received: by 2002:a17:906:db0b:b0:87b:dc07:380f with SMTP id xj11-20020a170906db0b00b0087bdc07380fmr13510054ejb.0.1675893210275;
        Wed, 08 Feb 2023 13:53:30 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:156e:48d2:7a4d:16b3? (2a02-a466-68ed-1-156e-48d2-7a4d-16b3.fixed6.kpn.net. [2a02:a466:68ed:1:156e:48d2:7a4d:16b3])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b008adc971f5acsm1191431eje.178.2023.02.08.13.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 13:53:29 -0800 (PST)
Message-ID: <37bdad51-36bf-c69a-7cb6-3138cacf9474@gmail.com>
Date:   Wed, 8 Feb 2023 22:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-6.1-rt ?
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Everitt <gentoo@veremit.xyz>
Cc:     Christian Eggers <ceggers@arri.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <12136223.O9o76ZdvQC@n95hx1g2>
 <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
 <Y7/cYsEXHpCEGwwa@linutronix.de>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <Y7/cYsEXHpCEGwwa@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 12-01-2023 om 11:09 schreef Sebastian Andrzej Siewior:
> On 2023-01-11 09:44:45 [+0000], Michael Everitt wrote:
>> On 11/01/2023 08:36, Christian Eggers wrote:
>>> linux-6.1 seems to be the next LTS kernel [1]
>>>
>>> Are there any plans to release a -rt version of linux-6.1?
>>>
>>> regards
>>> Christian
>>>
>>> [1] https://lore.kernel.org/lkml/Yz%2FZWBeNZvKenEVM@kroah.com/
>>>
>>>
>>
>> You probably want this: https://www.spinics.net/lists/linux-rt-users/msg26345.html
>>
>> You may wish to wait for the maintainer to complete their processes!
> 
> There is a 6.1-RT but it hasn't been updated for a while. There should
> be a 6.2-RT later today.
> As for the link [1] it has not been confirmed nor denied that v6.1 will
> be a LTS kernel. Once the version 6.1 left its Schrödinger state then
> there will be an update (or not).
The cat is alive: https://kernel.org/category/releases.html
>> Regards,
>> veremitz/Michael.
> 
> Sebastian

