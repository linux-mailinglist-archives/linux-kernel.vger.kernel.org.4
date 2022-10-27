Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E46101F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiJ0TpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiJ0To7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:44:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE342315F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:44:58 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i7so3601385oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bkWNJkhoPjdxy3msNlSE5uhqnXnU/IZYE+785Ej5bZA=;
        b=k2Rc21j4zG+ZEqmj+OPwYesCt4FEkjUGkSV6C94zNFUtSg3qEc6MJeOQDgc4s4mMnH
         8pfPePeiNZHSxEjt2vw4V0vpbFux1UU2rlhhzI0GiP5xO2Acch/0z1EfaV92ioZdG7b9
         l6PL/cHJ88PlyJZRKnM4yDA+yj565svy0wtVx9dhLuFrY73M7EScgQdLnUbov+vmBpm9
         KA/1BOegbypqs69E8NA1KanVI+xzdYorwTgKsZjxxpbxAyRNiafVACdR7dTI/0k/Sil6
         ZcHakMVpPBGl6KkNgU1KV6DOvZhrjor3p/YlIgIkeSNUa8U6hh1FBYJvwTAdtVUcdsRc
         P8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkWNJkhoPjdxy3msNlSE5uhqnXnU/IZYE+785Ej5bZA=;
        b=HvQdhDRbGju3tXyimyqvLQcUKWtrnukbxfO3HyHt/FDZC92+r9SDsGLdm/CYLm2vGF
         YrLTl7+eUS/8iInWaxhcHCq1lfnYVANL2Kz3KFMDWmwmGSDr32K30QtPS33pIEWJpfjF
         +fE9wWNLAv74W7nMQNdf3wlyM2A81lL+gRDyEUAWJxXEBRcd8GuyV9uLXrQu2BfeLiHW
         Z0gKWtR3xp5DHhqF/Iq+PZKgPFr4hqEulhsttmj9W7yHrPsWkf41vn5YKWR5TO+RBIR/
         wvznaBPocDESxr8ewhei2BGO+mD0UzFMs45IE5w6ru8nhDZkDxvYAcaUZDU+s7FEL8ig
         Cwog==
X-Gm-Message-State: ACrzQf3EHNux6vHTDNr47ra+R4DsHmhjEsASxqOjKzLyTX6ijgdeLUSh
        llZtuHSIwlrj5NEiw/2q0Pw=
X-Google-Smtp-Source: AMsMyM5riIors1bPC2D1LEmR5lK8J3h4c6Lbl9fAM80jm+IBUKIrkyxlXkkqGDS9j7iFyrVwiHsajw==
X-Received: by 2002:a05:6808:199d:b0:355:1b7d:3fef with SMTP id bj29-20020a056808199d00b003551b7d3fefmr5676656oib.288.1666899897907;
        Thu, 27 Oct 2022 12:44:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a05680809b200b00359a9663053sm765441oig.4.2022.10.27.12.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:44:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c994811-e481-d0e3-3e0b-c2a8ac456464@roeck-us.net>
Date:   Thu, 27 Oct 2022 12:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
 <20221027150237.4e69ba27@gandalf.local.home>
 <CAHk-=wiXk3jrhzjkYgC=a7F1+oFY2wNmxeMDTza10maGU2-i4Q@mail.gmail.com>
 <20221027151650.77d7e4de@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027151650.77d7e4de@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 12:16, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 12:11:43 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Thu, Oct 27, 2022 at 12:02 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> So it works on current stable and current mainline? Does that mean we need
>>> to worry about this?
>>
>> No, I think Guenter is saying that current mainline *without* the
>> patches works fine.
>>
>> But v6.1-rc2 (which is quite close to that current mainline) *with*
>> the patches blows up.
>>
>> So it's almost certainly the patches that break. There are no
>> appreciable timer changes in those 105 commits (there's some added
>> irq_work_sync but that looks very unlikely to be related.
>>
> 
> Got it. I'll need to setup an arm64 VM to see if I can reproduce it.
> 

Try http://server.roeck-us.net/qemu/aarch64/

Guenter

