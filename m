Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44276284F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiKNQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKNQUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:20:30 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551942F6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:29 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id h132so11908865oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKqsL//0IzsgU/dgVmJ9WTA8UzafxPdX32Qc+K4q1Fo=;
        b=eVEvqN/FSoQS8pjNrBnb+Ypp4B6ei0relemgXfB8AD4lUDHiGDxuBkhmfSDzXRL6R6
         SRxjxpoRtYKWYvufwxYxoIe6SM0BCOAYG9Ti2s218ENQa5t+YIEJbtxmMtlvEc9Yhnq9
         CyExevXTyt5XVw9wSc4SArrdDNgP940qe/dNA3wS2nVP26Y64bmFsGuS3VKomK9KhBOx
         PNxgRuL/VcgyL0SGKXskmoTMyMDLpU3VmXXz8rYoxJInGkzXM5Gll0VVPL5uZuWLGsWw
         JSyA3DPLIZnZLZPd4B8DpZBWkFxi56VvPctFuoGAsj2VygStv4piVXURrI0i/MRpJArd
         ppTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKqsL//0IzsgU/dgVmJ9WTA8UzafxPdX32Qc+K4q1Fo=;
        b=OdvIiTt9HnLKDxxfSfJoJXSuV+XajnKBTN8OmE4PIDk+pG6pN52Nh/baUg865GLo2k
         pzHF62p6zPYDoTLMP4y/w38z16camtICl9wq5TlR0+8QwfZ28hs9CdgGdHbHnrjLb6vD
         g3sxf2ZuIb0pF8weqipuOhFUKVuNHd/Dh+l5rg1lcXRdRLJTUmxcJBf0x1g4+aKePxCo
         wrCOHFwypcCT0MF86qIFzIzKvk2HVFc/tGFIbtjlY8XzGetSFmdWj2ftVpEfIxyqXyBf
         ba7RyJVouNg0AtqQqc3sgkial43AK30jj3wr9FwX3fJYS5X5qFxIP8CCAxuZzOnjxLsI
         +W0w==
X-Gm-Message-State: ANoB5pm1ZZK9sqWcKoy6yJSBF4lIImAmraaW8JXKg239E8P4/VkdCvHC
        k1LpAVa5uPBcGr2UmH7MNwV8jg==
X-Google-Smtp-Source: AA0mqf7zL359S+kO5MZl3gZiv3E72ckPsucJQQvzdjG5E6rE1elbzmsFX/wBTEQrzCefnDfsWS5+zg==
X-Received: by 2002:aca:2202:0:b0:359:bf56:504f with SMTP id b2-20020aca2202000000b00359bf56504fmr6087892oic.139.1668442828628;
        Mon, 14 Nov 2022 08:20:28 -0800 (PST)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id 3-20020aca1103000000b003549dde122fsm3798040oir.5.2022.11.14.08.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:20:27 -0800 (PST)
Message-ID: <2b8c40ba-0068-99ca-6dc8-64d075e9112c@kali.org>
Date:   Mon, 14 Nov 2022 10:20:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by
 default
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221114104333.3695531-1-javierm@redhat.com>
 <Y3IeUADalX6WDnuO@kroah.com>
 <354820e8-939c-781a-0d76-c1574c43b7f3@redhat.com>
 <Y3IonmwrJ3aqDbAw@kroah.com>
 <9d53f7f9-b77b-21ff-500a-88f3a7fcee80@redhat.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <9d53f7f9-b77b-21ff-500a-88f3a7fcee80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 11/14/22 5:56 AM, Javier Martinez Canillas wrote:
> On 11/14/22 12:38, Greg Kroah-Hartman wrote:
>> On Mon, Nov 14, 2022 at 12:13:15PM +0100, Javier Martinez Canillas wrote:
>>> Hello Greg,
> [...]
>
>>> I even gave an example about general purpose distributions that build as
>>> much as possible as a module. What more info do you think that is missing?
>> Exact systems that this is failing on would be great to have.
>>
> The exact system is a Snapdragon SC7180 based HP X2 Chromebook with latest
> Fedora Rawhide image (kernel version 6.1-rc4). The reason why is timing out
> is that the arm_smmu driver is built-in (CONFIG_ARM_SMMU=y) but it depends
> on gpucc-sc7180 clk driver that's built as module (CONFIG_SC_GPUCC_7180=m).

Additionally, this fails on the Snapdragon SC8280XP based Thinkpad X13s 
with 6.1-rc4 (and rc5), however, unlike Javier's setup, I *do* have 
CONFIG_SC_GPUCC_SC8280XP=y, so it's already built in to the kernel.  
Additionally, all DRM options =y, except for CONFIG_DRM_GEM_HELP=m and 
CONFIG_DRM_DISPLAY_CONNECTOR=m.

I am hoping to find some time tonight after work to also test on my 
SDM850 based Lenovo Yoga C630, as I believe my previous testing of 6.1 
may have been hitting this but I did not have time to dig into what was 
going on there.

-- steev
