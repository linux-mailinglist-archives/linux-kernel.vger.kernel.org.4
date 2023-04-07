Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AAA6DACD1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjDGMzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDGMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:54:52 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7675255;
        Fri,  7 Apr 2023 05:54:51 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17aceccdcf6so45513966fac.9;
        Fri, 07 Apr 2023 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680872090; x=1683464090;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0VdGwQhJdbIBIDImhMZQQz4N3I4RfbJCBc+igru00U=;
        b=CCPSUOOsF4Fa2gC+3YgCT+EPoFFb2/IEz6LeO9YglqLf7IxcsFigEq3G6xD8gQLEHZ
         7SW0IIpbUpGLsD1GsTHdODmR/cruRwKr00bED/ItFC3vagPCsx8+jSRUPb6qO82l0+47
         meDveEN1zB1qM64eJb0H/CqBr4wG5Sdhi4WpmBXcgjY+VRN6oH622LeVxLtdGXHohQL3
         HSedoBhMo/EeSk3V77tM/TMPKpbD3xXK5satWzqz/lqY0L6XJinHyKC5ya44OlKVJtZr
         qx4to0kQMPc79bp7PaVlY1qdYdE8b0Wecj38taadpzjKsiqpdbmB7Lohdn4iUrw6gUbp
         COMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872090; x=1683464090;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0VdGwQhJdbIBIDImhMZQQz4N3I4RfbJCBc+igru00U=;
        b=7MPxBL9An8vqDt/kBRiMqy58Na2EfSuAhf/9jC3m2BYxDJjyvjrWyhWdGroXIAGKm+
         gADRQu2s4ugpJhRkrjOIW8gWzHn/lmimLSbojJg6TziACrwOw6tAgCdVQ2bLZ+dP9ij0
         djn69ETBP/3AC40YLHBefwzpoAbr5EhlO+NNYTVHDVr57/jwpXrKphHlkrAOxEFxgleR
         dP5HMuVAkEYpSJBojUhjXGFeKdrRxhKy1QFWOgqLHi7TuPRdsoGeO0BIExnxYAGfysa+
         fhgGU5faWbe5pNCgp2njfKvOQXcl4j2JOZr8xrF+zntA2wuiXzJdVuOZIGZs6NpLO6X2
         ilNw==
X-Gm-Message-State: AAQBX9dDRbscONcQzuFqaLw3a3b27limT85b1YkiXwFe8dlJlptoQfC6
        Cdh5xjIHUc1MkK/Sxh3HEZqounFEYSw=
X-Google-Smtp-Source: AKy350Y4E6V2TBoEvM494LQDPU0eBT0J9y//eSR2b0TfMKMCBbtUPlCH1pn7r5jcuwiIvl7nGFhnrw==
X-Received: by 2002:a05:6870:b421:b0:184:256:bf57 with SMTP id x33-20020a056870b42100b001840256bf57mr1352638oap.9.1680872090327;
        Fri, 07 Apr 2023 05:54:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020a0568301e3500b0069f1774cde8sm1642412otr.71.2023.04.07.05.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 05:54:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e256d281-49a5-2d9a-7def-fd68e177e926@roeck-us.net>
Date:   Fri, 7 Apr 2023 05:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Armin Wolf <W_Armin@gmx.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406152321.42010-1-james@equiv.tech>
 <2257deba-187b-82d2-181c-f1fed08a2ff7@gmx.de> <ZC+sgnuy5bssD1DN@vb-22lts>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: add HP WMI Sensors driver
In-Reply-To: <ZC+sgnuy5bssD1DN@vb-22lts>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 22:39, James Seo wrote:
> Hi,
> 
>> is it guaranteed that faulty sensors wont become operational later?
>> Also filtering out such sensors would make the support for the hwmon_temp_fault and
>> hwmon_fan_fault attributes meaningless.
> 
> Good point. I can't be certain, but the MOF does seem to imply that
> sensors can indeed be faulty on just a temporary basis.
> 

Your current code would explicitly exclude faulty fans from being listed,
which does not exactly sound like a good idea.

> I'll filter out only the sensors that are "Not Connected" at probe
> time. My thinking is, even if these might turn into connected sensors
> later, that would mean the user is e.g. hot-plugging a fan (!), and
> keeping them could result in a large number (~10 on my Z420) of
> pointless extra channels. And this would also match the behavior of
> HP's official utility.
> 
Ultimately that is an implementation decision. Are the sensors hot-pluggable ?
If so, how does HP's utility handle the insertion or removal of a sensor (fan) ?

Either case, it is ok with me if disconnected sensors are not listed.
Not listing faulty sensors seems like a bad idea, though.

Guenter

> Does that seem reasonable? Or did you mean that I shouldn't filter,
> and leave disconnected sensors in like some other hwmon drivers do?
> 
>> The sanity check for HP_WMI_NUMERIC_SENSOR_GUID is unnecessary, the WMI driver core already makes sure that your driver
>> is only matched with WMI devices containing HP_WMI_NUMERIC_SENSOR_GUID.
>> As for the sanity check regarding HP_WMI_BIOS_GUID: this WMI GUID is not used inside the driver. Since WMI GUIDs are expected
>> to be unique, checking for HP_WMI_BIOS_GUID (which AFAIK is used by the HP-BIOSCFG driver) without intending to use it is
>> meaningless.
> 
> In that case, I'll gladly remove the checks. I was following the
> example of the platform/x86/hp-wmi driver, which checks for that GUID
> and another at module load.
> 
> Thanks for reviewing.
> 
> James

