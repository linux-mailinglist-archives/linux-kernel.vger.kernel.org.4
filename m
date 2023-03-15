Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD146BB5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjCOORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjCOOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:16:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3F1BF4;
        Wed, 15 Mar 2023 07:16:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id bp11so5014203ilb.3;
        Wed, 15 Mar 2023 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678889782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9PqS0is4BFBhZIUbIafMoHIoQlBBc9tsQxTd/4r4m0Y=;
        b=bf4qG4jUwR6UAlaHoe9a6UH/FV/HHFjeNypHVurJVbp569Uurn6uKxILTeF1YbHAVi
         dhNbTl8PP2yq4hcYyhrSp71hQHQHv0++5uP2q8cVLJGiiP3w5tp8skdPDcSGHn9SO8q7
         jgg3JrLv+i4emcTEsIqDAdlZ7VZ8yXLg/9O1S73TACzgYNnm+65xARK+Dm6z/xVLLjLQ
         1u4eumikZGNOJg8AjB9db4f3RP50/uBd8PBBS/UiYqbFh2xTc/PwBrI8z3DNw1xPEXgn
         kMPmI3gk6qLA3ApW8Jddjz7NW/jB3+z7CBUJtXySVPA/4Bal793sWOIX1J2zETxz3LSP
         A5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PqS0is4BFBhZIUbIafMoHIoQlBBc9tsQxTd/4r4m0Y=;
        b=ShB8FnBFpPKoF/Aez05RckSUWxWjp2Bn0IjkSet9//GD5+i0xSYZH040ruL8YU3wNI
         3f3dsaJwey5eHf/Vvuy659570n8cVHffUWKFmdSIt0bj9Iok2lOCK48YqbPA0lrjEE6w
         fWdCJQut4eTPlG79QqyOOMOt3IxWKk9oFYjGNZAmg7BfAmrNVHHNcZEWIQmh+yiw4HlX
         hyVazIqzmfdjkfx7jQaiCq9MS+sGl1eAG6ZiafQ4WvnD4k6YDOvYXkoJUWWyd5OW2d8N
         PYUlaNqhe4EpJXg1p86yQh30LyuxbxUALk57ZfGY3LABdv2LmjZCWvs99T6ibmR2ZZRK
         d/pA==
X-Gm-Message-State: AO0yUKUO69Eb6JyTSjn5TctmW9K9FfSN+qnx2zz+SxJZvK3PPml4L3pV
        ow0OQT+tmOcTDJBhxEfwF/8U3ZmvdSs=
X-Google-Smtp-Source: AK7set+Io//LtO6XKCL4IkO6kufc4biv6gHKOY+tK5XbcN4sTqh9/Z7Z9+LbNtv9Gpv3OSG/DVlh4Q==
X-Received: by 2002:a05:6e02:1294:b0:323:140f:a72e with SMTP id y20-20020a056e02129400b00323140fa72emr4786141ilq.1.1678889782181;
        Wed, 15 Mar 2023 07:16:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a056638022400b0040535426261sm1691486jaq.37.2023.03.15.07.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 07:16:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64e3ecac-6684-1989-02c5-06fc0e755631@roeck-us.net>
Date:   Wed, 15 Mar 2023 07:16:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Content-Language: en-US
To:     phinex <phinex@realtek.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315121606.GA71707@threadripper>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230315121606.GA71707@threadripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 05:16, phinex wrote:
> Support thermal zone so that we can just rely on dts to describe a
> thermal zone and do the cooling operations.
> 
> You can define a comptible string "drivetemp,hdd-sensors" to enable
> this, such as
> 
> 	sata_port0: sata-port@0 {
> 		compatible = "drivetemp,hdd-sensors";
> 		#thermal-sensor-cells = <0>;
> 	}
> 
> Then define a thermal with this sensor to get it work.
> 
>                 hdd_thermal: hdd-thermal {
>                         thermal-sensors = <&sata_port0>;
> 		}
> 
> In most of the SoC systems, using dts to handle cooling is common.
> This can eliminate the usage of user space application to check
> the value exported in hwmon and then through sysfs to cooling.
> 
> Signed-off-by: phinex <phinex@realtek.com>
> 

The driver registers drivetemp instances with the hwmon core using
HWMON_C_REGISTER_TZ. That means there should already be a thermal zone
for each instance. If that doesn't work, please find out why and fix it
instead of replicating what the hwmon core already is supposed to be
doing.

Guenter

