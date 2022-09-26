Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF65EAF56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiIZSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIZSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:12:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582576458;
        Mon, 26 Sep 2022 11:00:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so12145936lfr.2;
        Mon, 26 Sep 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OxspaBouJm9lWuF7hJ+GRzyfh+IHOjJvQkXxQ3ccAI8=;
        b=nl+E+dsYQCKZ/fldDpa0rqxqYrMjd36KRo6CrkvwQYXc3xR+vmUxVKLhKPRFhcQv1g
         JIk9dCGYEyCYEenipGYOTJScU+jcCHNcv68mRp384Jvsr49uhag/Aucke3/7+ZN3GJwd
         d0w709Q1GIkHEsjYOwH7pEqSMdab/79wUYWypJEloEyvMqo8d43sDcGnC9xGxO/EXEY6
         m+r3GkRbP35hq7LeUdui65leHe7RxweKlndMB6I6szcAm50cRsPMqy3aPAlBc5bdlbTa
         wZTZ69M4Q8MGDKPVB4F9DMksTRT2DsVhpysK+IV/v81GblV7KSUYbEaHBoEucU5rAVfr
         6LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OxspaBouJm9lWuF7hJ+GRzyfh+IHOjJvQkXxQ3ccAI8=;
        b=C0fujbHEeKumfJrILiO5rBW6iuaR6gntzN7KT5KfiYm3To3TUFtbNY2YCrLgmG/bxh
         /Vg+v7YN6I3RLejHNxKFzytQXxe4LnUOmoSfsSIyX+SPzZrBEIEJc/Bgp3X8groZno59
         aGzeTOPbLuQVefVd28u+4KU2tOBmtKbtBVUkLT0ZFXz7xKieSIlZF62xsNYDHW9oSWqf
         nH0AqPGGDmDTpdfqFFJowKXpvQD/p7auWg+ybDys60XqWZXCCi/Gu6n+yp/7S0m3GecV
         rrof/FlFFmPO1LvsXeYbj4+Ua7qNZOTSGIbeIvEruuLEfIXVa4P3x4XjFxVbPHIKwq9r
         gFvQ==
X-Gm-Message-State: ACrzQf3FF52eImszKhLq8wvIWxFw49x/CM5ZpPeG0VrcJ1mXYYtMDmgt
        O7XKcM7iVcLYRe2mr2USk0xIgKiXPUki/g==
X-Google-Smtp-Source: AMsMyM727+f++4Qi7Ejq3M9ahR8yxFYVlCUBVsFcO1zcq0Mbin5Ek/ur5pME6AY1J98Fsh2cfZlJ8g==
X-Received: by 2002:a05:6512:10d3:b0:499:cce2:37a8 with SMTP id k19-20020a05651210d300b00499cce237a8mr9150687lfg.169.1664215210174;
        Mon, 26 Sep 2022 11:00:10 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b00497a8f04905sm2597239lfg.251.2022.09.26.11.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 11:00:09 -0700 (PDT)
Message-ID: <5a608241-520c-596a-92f0-69ef6589713e@gmail.com>
Date:   Mon, 26 Sep 2022 21:09:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] Input: twl4030-vibra - Drop legacy, non DT boot support
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20220616153323.29464-1-peter.ujfalusi@gmail.com>
 <Yy/pFF+Y6Fvq3bmd@google.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <Yy/pFF+Y6Fvq3bmd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/22 08:37, Dmitry Torokhov wrote:
> On Thu, Jun 16, 2022 at 06:33:23PM +0300, Peter Ujfalusi wrote:
>> Legacy or non DT boot is no longer possible on systems where the
>> tw4030/5030 is used.
>>
>> Drop the support for handling legacy pdata.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 
> Applied, thank you.
> 
> I suppose you will be dropping definition of struct twl4030_vibra_data
> from include/linux/mfd/twl.h as well?

Yes, that is the plan after all drivers have been cleaned up.

-- 
Péter
