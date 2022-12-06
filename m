Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD3644A91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiLFRpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLFRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:45:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165237208
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:45:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so18698439pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnXuCMBJLGvaQ8GD/oAIn2hbJLbNYlY5oG7JUQ6WrZs=;
        b=Car3FCxir2IE4cCpDcdBvjDJODCtqU/FMnhPBQ2ZChw6LybsvXbSbeYIgCEpqS8zBk
         O/bxcfu3V4iJBezsRvo6tIt26lzNsUEkzolUMvX8tnvcPUJZpNENQ3KuIYGEltvAbESe
         kGByCtOcbf6ztbG7j7qI6gqmxiGXN2o8iBeVpgxkU/yXsZgsWcESWVqEhLhg0gCMgVFo
         GpMQ9XoKlYkEhnvfY6KNa+LUfgqA1AyKMhMA7rnAObIHx2v/TzBYVoj3TobWg81LDXTs
         epubBmQA9sYHkjid0ofIfDBnrGw4+sDXl/t30F4bxM97+yppivRJV0AgegKWVHoEKA1X
         X+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnXuCMBJLGvaQ8GD/oAIn2hbJLbNYlY5oG7JUQ6WrZs=;
        b=Ytz8LS98QnPSzaSh28unUf5YgzNSzaduAk3Ei/WxsX4gENNJbVhmqLvgqF3M/vuhCI
         EsSl48g4kyBFfSHRSbug7/MZsiUwtFoog1TAcJNH2BwErhy6bGq73MZX9nloaQP6Vmks
         7do6/cSPdwFCraVzzUKzN09ta8ph52ASqgCFAT1oeuGnaNUkqSTIIjoVQIr37msnFnOv
         8i/KOngOUC6D1oygdKIaCaLwOw4sQXEm4mcsQ26+PDZFGoYKCusleYH4SW7jcCIHMwms
         acHrR1PZpbxmv9mftGE1Qk8yJauWLntKRwTfxPCNgC+hjK3QLNZRabwCeLZQ5kjvY0ON
         hjhA==
X-Gm-Message-State: ANoB5pn+c2vvi5zj6qWhEMEFLH5F3jklyHryOBkAZyprMXsL2+WmLMd8
        vZyc8JA/Gpr7KDqlv+3UKZoRsA==
X-Google-Smtp-Source: AA0mqf63M5QudRaFUyWkka3wLk0yj7w6tH3rMCRjclZAEfsaj6iitdAM4YgOb8a9ZCk928yrZDL1Ig==
X-Received: by 2002:a05:6a20:441e:b0:ac:16ae:1082 with SMTP id ce30-20020a056a20441e00b000ac16ae1082mr795935pzb.32.1670348736388;
        Tue, 06 Dec 2022 09:45:36 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id s1-20020a635241000000b0046ff3634a78sm10143474pgl.71.2022.12.06.09.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:45:35 -0800 (PST)
Message-ID: <77c5a9e2-ce25-df19-1eba-ba4808bbeb9d@9elements.com>
Date:   Tue, 6 Dec 2022 23:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 4/4] hwmon: (max6639) Add pwm support
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
 <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
 <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Rob

On 29-11-2022 10:11 pm, Guenter Roeck wrote:
> On 11/29/22 08:34, Uwe Kleine-König wrote:
>> On Tue, Nov 29, 2022 at 05:11:34PM +0100, Naresh Solanki wrote:
>>> Add pwm support for max6639. Also configure pwm fan speed based on pwm
>>> provided in DT.
>>
>> Did you do anything to resolve the questions I had in reply to v5? If
>> yes, I must have missed it.
>>
> 
> I don't see a response to my concerns either, especially regarding fan mode
> (dc vs. pwm) in the bindings. For that reason, I won't even look at the 
> series.
Best I can think of regulator with voltage control. Because as per my 
understanding, DC control fan essentially control DC voltage on negative 
pin of fan.


Regards,
Naresh
> 
> Guenter
> 
>> Note that maintainer time is scarce and with sending new versions of a
>> patch with no sign that you improved in the aspects that were critized
>> before, you're burning that scarce time and loosing the good will of the
>> responsible maintainers.
>>
>> Best regards
>> Uwe
>>
> 
