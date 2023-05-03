Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA56F4F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjECEem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:34:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDF1FF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:34:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaf21bb427so23750875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683088479; x=1685680479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFkkmeZb1BUEWip3pN5lLS6kQAyzsQL5TmllTZk+EdM=;
        b=lBMuB1Y21BO7u6xE9O8+kPB2s1BZE1kPbs5aRzergSqlsW327uABXVlSov0EscFjvG
         c/FxeZGGMJW6Ws0AFEPhjnmmZ50DBLCJAMlxZtSkp+i2li1nKy9yl+n7ktI7TEb2Uve6
         Bw0/0cryIOkZO7kMuQj8JYlFRa/Ek6kmUeCiUMX5HKghREFXy/0qVgcaZFnlwDdZuETD
         CLl/542xrb1M/05Mpj59zpOvMsx+nzqd63WknlZ0lHw2gn4t2aAyICzp//UvIX0IDtMx
         hnt9fQ/PGCTip66yIZghXI5vdbSJ6sDOXIQBBqwyqXKTX/ZPb9a9r1iWFhABaDnt1ueX
         /S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683088479; x=1685680479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFkkmeZb1BUEWip3pN5lLS6kQAyzsQL5TmllTZk+EdM=;
        b=DDb6eMYHsSnVbZtNE6GM912d0bI0ru6h6i5VZdrRDQt5JPylbOu4CIiIg94otwKVjs
         ckNE8NjPo1KqsdYQ43wvoD/pnoGOyzxt/WbqGtcF4Sopu1ZkTwDurRXPu2BvLtfHZcIt
         HYMtIy2/XT5s/60/fQNRn3cJIbP914N4DRxZCxKHKqZl+FQytw1DEqVj78ZAzQwQLYAf
         4A/OybpKqrr8jzygC+/OyE6d1Tc4hN4EftDXnXnJH4Oj8Xo0Iu/YCWgxekhRY6n9UoF7
         V4yh5ulr/AwWg3TAcJ4RQHKoqD4/sJOZD1XqlYGZau+QQAk6Xp9nWxVeXnCkdKwZofr8
         AQ1Q==
X-Gm-Message-State: AC+VfDyoruOMiMeusG56i9ABkQlcZihE/SCDjLYI7uk/mqQEs/JNxdCn
        n0fe0epXAZPwzUCMUDyeY4vpDpXsWU4=
X-Google-Smtp-Source: ACHHUZ6eXXjIekHvZwuZ5yVFtBrX23B01X3vFVAOn7r47M4e+Wf2tRCk4hWgx/cEE5DHBGEmjlIz1w==
X-Received: by 2002:a17:903:245:b0:1ab:16cd:51a3 with SMTP id j5-20020a170903024500b001ab16cd51a3mr990221plh.10.1683088479462;
        Tue, 02 May 2023 21:34:39 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b001994fc55998sm20374850plp.217.2023.05.02.21.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 21:34:38 -0700 (PDT)
Message-ID: <63bcc1eb-b0f5-4da1-0a22-31e0c86c0851@gmail.com>
Date:   Wed, 3 May 2023 11:34:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-6.4 alsa sound broken
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly>
 <CAAJw_ZtKnZ3QruicqFRG_TLV0Ltbc8LSvdJSCEQRkr5GMSWvCw@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAAJw_ZtKnZ3QruicqFRG_TLV0Ltbc8LSvdJSCEQRkr5GMSWvCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/23 22:05, Jeff Chua wrote:
> On Mon, May 1, 2023 at 3:17 PM Oswald Buddenhagen
> <oswald.buddenhagen@gmx.de> wrote:
>>
>> On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
>>> Latest git pull from Linus's tree ... playing a simple sound file will
>>> resulted in a lot of echo.
>>>
>> how _exactly_ does it sound?
>> have you recorded a file through loopback for us to investigate? best
>> would be a short sample of a clean wave (sine or sawtooth) with some
>> leading and trailing silence.
> 
> Just send .. in another email. If the atttachment got stripped off,
> please let me know.
> 
> 

I don't see your attachment. Can you please post the link
to your test file on file storage hosting instead?

-- 
An old man doll... just what I always wanted! - Clara

