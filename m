Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC272A9F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjFJHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFJHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:39:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BF35B0;
        Sat, 10 Jun 2023 00:39:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b24cd75989so11994345ad.1;
        Sat, 10 Jun 2023 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686382744; x=1688974744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsNUoF97Ojf8i4nmjXrcSgoP9RKyKJanJ2CtBfvra6I=;
        b=E2++uQgpt6i01Zb9xtZ4zaxEauzl8V0qDODOXlnopq6D1JRcm1A9wuLwcsyZMq3zOz
         1Gv4Cke8VXo7AJ5cRFDZullSPyECiJikHr7WxxM96sPAE6T3fnX+Jb2QOSYmo5cy4haU
         xGipf5UnUbHEqZe9iafH94Omh6tF3w6URoih/mEhg2vbmNuSmh/208BxgZD6lXkdCRaB
         vMnAjkra5Vuf74YefM1DCi938GH/fMQLbizHfv6gAtOIkPGwKbl5mOZUvTX5oPxboRxs
         rZe7EBonyN7rdgarx+R2VuY65t00pb8nVvoo9FjWW7a246Q7L/t1ytWJdWLLO475Z09D
         fMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686382744; x=1688974744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsNUoF97Ojf8i4nmjXrcSgoP9RKyKJanJ2CtBfvra6I=;
        b=dt3F9nIBMV+vJD74zRukzv95N6Fm4X5FPRRm07k/w5KaoiRVtDbW7NAkz27fx3NqYz
         dbHjOIyu9dewagm4kBAZeu72fq77Ji1TurlyECCBb5Cu5Ll/SNLicQhBhruzxMppH9eo
         c9cMi/7Lq9smV7Y01GVa5VbONMXOU8g0MPxyTeJ8dsrRDofpSHmxvW5yfczFY6aCc9yW
         ogcThkCHQj4yz5hJT9wAHn8QIcK9zJYTjUaUp5Sw3ZTvNHHi1s/iQ/tEoBQPU+8sGo6H
         k3d8M6bbvYnhMVHNs8+Z9pzNgj9GeTZ+QRy+/Nkd76bM62uOs1tICcPa5qh0KcR+ngTu
         N+/Q==
X-Gm-Message-State: AC+VfDxmyia5G7pVb7chbAo+hMFNoH9bKErqFtIYCakaLzLsd4W0vePS
        rhuH9WA+c1U3WJ/NodvWjws=
X-Google-Smtp-Source: ACHHUZ5MRqYSis2oCTgqmli//xNpQt7In/tGIP5SV0p3yGoBfy+MsOY+Iwvwe28NlmEhGBVsIVtH3g==
X-Received: by 2002:a17:902:c111:b0:1b3:95a9:3fb3 with SMTP id 17-20020a170902c11100b001b395a93fb3mr1064209pli.3.1686382743838;
        Sat, 10 Jun 2023 00:39:03 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090a1b8a00b00247164c1947sm7587181pjc.0.2023.06.10.00.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 00:39:03 -0700 (PDT)
Message-ID: <08dd7a08-62d2-8efe-91ea-fb4ffd4548f2@gmail.com>
Date:   Sat, 10 Jun 2023 14:38:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Fwd: rtl8xxxu kernel module deauthenticate session from public
 open Wifi AP
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        dbnusr495 <dbnusr4950@proton.me>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <31ab2156-e93e-4e0d-73a7-313d9d24ee6b@gmail.com>
 <f969c91f-f7a1-bea8-ae72-67543bb3df83@gmail.com> <877csbhj38.fsf@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <877csbhj38.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 14:28, Kalle Valo wrote:
>> FYI, from Bugzilla [1], the reporter posted (untested) fix. Would you
>> like to review it?
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217531#c8
> 
> I'm not seeing any fix from the reporter, where is it?
> 

Oops, the Bugzilla diff link above just adds pr_warn() debugging info.
No fixes yet.

Sorry for inconvenience...

> Also more information would be good to have to pinpoint where the actual
> problem is. For example, it would be good to test different APs with
> different encryption methods and make a list what works and what doesn't
> on his device. There can be numerous reasons for the problem.
> 

In the starting BZ thread, the reporter had issue with WPA enterprise
(as he can't reach login and usage disclaimer page).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

