Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9764740E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLHQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:19:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B898975;
        Thu,  8 Dec 2022 08:19:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx10so2234917wrb.0;
        Thu, 08 Dec 2022 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0OrMwQbxg/ktbV9bRCyNGFbRXJuKGNW0efSxcFv22A=;
        b=OLsKoG4u286EkOefIm4EvdcJEv8FLTeEDkKA/FB1IYSlhtpkYagrWs0+cswv6/eoXJ
         Hs77c1hNbDdpMuUpOYRnVHYaQgR7gt+FLmWATca/cTuT26jODS7Uzqv3OdYsp92g9iSy
         2zwyvqeQslhIm0gOXaIjaypUI0Crie3dPgn7v4h0nnJFSsattdvc15bCr9Dz1AJLon+j
         VQT4cFNhiTypo6H+bLMLoPky/YjdVMd7b0OczxJdHljev7UhmZUI0KE6k/veatlBGSM1
         RINNQzcs6+sB7SYBoTuhQNvpoMXGfS8jCRKjqDGBMSGooeueHpFCZhsovskXgaEYMgKI
         8TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0OrMwQbxg/ktbV9bRCyNGFbRXJuKGNW0efSxcFv22A=;
        b=0KfNGp2AeKpXHY00YuUdjfCabzPIOe3pexhTQ2se1AcHIxYP2TI8rhTEdrn4xgb0A2
         6mpE2OgjBYqxrNtn6IgEacvOItjFXpI9jfEA0tIz6JeS/6lWKHepNMTIZ3CKmXtmGEzZ
         8OpTtwS2ve5yPPXmTvnANekmVc3jFZLkQNf0GFFVxaEhMt1BpZVpv+pkh6/8otEAHZgB
         F2aCQ+ZdHwa1rEX6MsCsm3i5/agc0zEHi85MTb8dccLuDYAcGRHr4ZekHMPfHhxHOhN9
         dP1KGgude0U/f+Fbjds4Z8jc2fULUkR5iytNA0uT0qYeGHq96aFqEEe8y2xIpyxEtjSI
         DRyw==
X-Gm-Message-State: ANoB5pl79SVSJvDqRw61et5/x5XR93o4QM3FyaYrgrcN6QO7Lgj+tpsv
        8Dmt6Li4LEN+Yg2xNoJUuUuHiBKCRmo=
X-Google-Smtp-Source: AA0mqf7pacWOyqD/40HZ1D1u3a9YtU5BeJPHSRzRZLsQdT+j+f+/Y5H47ZMELy58NBnGlBVG6FZ/Zw==
X-Received: by 2002:a5d:5951:0:b0:242:7fb1:194f with SMTP id e17-20020a5d5951000000b002427fb1194fmr1756938wri.49.1670516339174;
        Thu, 08 Dec 2022 08:18:59 -0800 (PST)
Received: from [10.20.0.4] ([89.36.76.136])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d4e92000000b0024206ed539fsm22342021wru.66.2022.12.08.08.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:18:58 -0800 (PST)
Message-ID: <7054973b-f659-ee02-e379-df47255e10e0@gmail.com>
Date:   Thu, 8 Dec 2022 17:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/9] platform/surface: aggregator: Improve target/source
 handling in SSH messages
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
 <c09c9cef-14ac-2ab3-5e01-13189823a053@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <c09c9cef-14ac-2ab3-5e01-13189823a053@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 17:03, Hans de Goede wrote:
> Hi Maximilian,
> 
> On 12/2/22 23:33, Maximilian Luz wrote:
>> We have some new insights into the Serial Hub protocol, obtained through
>> reverse engineering. In particular, regarding the command structure. The
>> input/output target IDs actually represent source and target IDs of
>> (what looks like) physical entities (specifically: host, SAM EC, KIP EC,
>> debug connector, and SurfLink connector).
>>
>> This series aims to improve handling of messages with regards to those
>> new findings and, mainly, improve clarity of the documentation and usage
>> around those fields.
>>
>> See the discussion in
>>
>>      https://github.com/linux-surface/surface-aggregator-module/issues/64
>>
>> for more details.
>>
>> There are a couple of standouts:
>>
>> - Patch 1 ensures that we only handle commands actually intended for us.
>>    It's possible that we receive messages not intended for us when we
>>    enable debugging. I've kept it intentionally minimal to simplify
>>    backporting. The rest of the series patch 9 focuses more on clarity
>>    and documentation, which is probably too much to backport.
>>
>> - Patch 8 touches on multiple subsystems. The intention is to enforce
>>    proper usage and documentation of target IDs in the SSAM_SDEV() /
>>    SSAM_VDEV() macros. As it directly touches those macros I
>>    unfortunately can't split it up by subsystem.
>>
>> - Patch 9 is a loosely connected cleanup for consistency.
> 
> Thank you for the patches. Unfortunately I don't have time atm to
> review this.
> 
> And the next 2 weeks are the merge window, followed by 2 weeks
> of christmas vacation.
> 
> So I'm afraid that I likely won't get around to reviewing
> this until the week of January 9th.

Sure, no worries and no rush. Thanks for the heads-up.

Just as a note: While patch 1 is a "fix", I don't consider it
time-critical in any way. The underlying issue only appears if you
explicitly enable debug mode on the SAM EC. So no need to hurry.

Happy holidays.

Regards,
Max
