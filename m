Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A1605367
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJSWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJSWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:50:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7052E4E;
        Wed, 19 Oct 2022 15:50:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y72so20966869oia.3;
        Wed, 19 Oct 2022 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TyeRkVEOZiqX6Ou3Xrr7rGnkYAAlYAOk++yC+obN0Y=;
        b=NdEkwFcPeD4sVQMT3vnv0jC7pvtQaITJt4tY6qTknnB/v/qcHVDpP5/bcRlymawh3Y
         91PMY51EYzqjs/PYdO82V+TmNrFJq/A/daXty0m2Hp9/eBryfO4AWDV7x8E3PVCiwomJ
         eSgdGQL8uphtQ84cRrC3dL2/Hmx8/4yvIVQRbgDl5Gb8Gj1pi3os1agaBgG74g9eA4hR
         kMRi3wZdfbHG5NSoy3VHXO1qfN00STdOEmgWsUvBytaXkHy4JiOjXwJIpty6gJ2RGRci
         uRclFHeB7sBdiQHgqlQSXZx/jTdF/+revM3f1cq7S8S9TQ7PkPkIBnPmD4jsr3MvE0y7
         HWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TyeRkVEOZiqX6Ou3Xrr7rGnkYAAlYAOk++yC+obN0Y=;
        b=zptEXLAJZ+DJbdNfNTKdGzV/uwF9qsfMVfLWT3mK8oV6r926lSX2ePPyfRMeh16ZBc
         z9wj32J5S2ee8d/2VQQyUpg8oSoji82mv+DWaQNFws+Yo0cUAuHgwh/tPU/Zr+Xn8AVm
         FC99jV+Qvcyv4+43toqG2wooUFWjrvcsEJqEWnm8eAxeRlwtrJz8KcWT5UDltN3140DD
         K2mzyczylu5YOF+DEyTwuqdmHijuy0+DpzCQqXcARgImyVC5ACW2v/+TptkLvGb471Lb
         OYsUBgos6JvrcXmFvHJcz3KE4i+7ti3zAQg5TGSCdEYK/9jKWkbOckxkIyRrIaS6w22+
         UQUg==
X-Gm-Message-State: ACrzQf2AbtABUPyzuLtYjlo1ARdM/iytt/KDT2V2Lx1Lf+nNbHq1wOQN
        co8PK3T3HI62CKTAOSxLC1S6xZtMYkA=
X-Google-Smtp-Source: AMsMyM5Sql3FFYtgoddgiBJxw+/ww/1PObWMV2upp5iokOpUA2ejbQje4p1hcjt93ns0xcAq13vZdA==
X-Received: by 2002:a05:6808:1b25:b0:354:c1dd:9d47 with SMTP id bx37-20020a0568081b2500b00354c1dd9d47mr5701640oib.46.1666219826106;
        Wed, 19 Oct 2022 15:50:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y26-20020a4acb9a000000b0047537233dfasm6975742ooq.21.2022.10.19.15.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 15:50:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2d22d0ac-ecc8-1c05-fb63-b0bd0569036c@roeck-us.net>
Date:   Wed, 19 Oct 2022 15:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
References: <20221019214108.220319-1-martin.blumenstingl@googlemail.com>
 <0d1b4fed-7ded-88fc-3c37-4f859fc505c1@roeck-us.net>
 <CAFBinCAutvvNzSD7HXfMzLOg-NZ3ubifjtHzC9yURe=BZJQEiA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (jc42) Restore the min/max/critical temperatures
 on resume
In-Reply-To: <CAFBinCAutvvNzSD7HXfMzLOg-NZ3ubifjtHzC9yURe=BZJQEiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/19/22 15:03, Martin Blumenstingl wrote:
> Hi Guenter,
> 
> Thank you for the quick feedback!
> 
> On Wed, Oct 19, 2022 at 11:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> [...]
>>> +     if (data->valid || data->temp[t_min])
>>
>> This contradicts "with applying the previous values by only configuring
>> them if they are known valid". It explicitly applies the values if they
>> are marked as not valid, and it also applies the values if they are 0
>> (I don't really see the value of doing that).
>>
>> Sorry, I don't understand the logic. Did you mean to use "&&" instead
>> of "||" ?
> My understanding is that that:
> 1) data->valid = true is only set in jc42_update_device() (which is
> only called when reading back the values from the registers)
> 2) jc42_write() can write values without setting data->value = true
> In other words: if jc42_read() is never called but jc42_write() is
> then we still have some setting to apply while data->valid is false.
> Whether that's possible in reality is something that I'm not sure
> about.
> 

The above only means that the code is not optimized for the problem
you are trying to solve.

- Calling jc42_update_device() would solve the valid problem.
- Calling jc42_update_device() from the write function would
   solve it as well.

Relying on a previous call to the write function is most definitely
wrong.

Also, for optimization, jc42_update_device() should really read the limit
registers only once. The best solution would probably be to convert the
driver to use regmap and let regmap handle the caching.

Guenter

> If your suggestion is to simplify this to use data->valid only then I
> can do that.
> It would be great if you could also comment on whether
> jc42_update_device() should be called from jc42_suspend() to give the
> driver the chance to at least read the data once (and set data->valid)
> if this has not happened before.
> 
> 
> Best regards,
> Martin

