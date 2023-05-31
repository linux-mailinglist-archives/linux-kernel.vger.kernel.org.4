Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077787187BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEaQqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEaQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:46:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1E12C;
        Wed, 31 May 2023 09:46:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso6859408b3a.0;
        Wed, 31 May 2023 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685551583; x=1688143583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HbUqG/hAuM91PW1jIKAuU+eixIUM09PYOEoZK6mKciw=;
        b=H+D32DJRUiZ7Sb5AkTUh9TrKubt70HFOawetLYKmmlLZNH460IApt8YuEiuEw3IOX9
         aLioO/Wtm0LTwuFDs21jH/9nnR70v8T5jKsb2hToEYRimo4QMJtjCm03FIdtBl0BG5lO
         DAiiYRMowlQsPeFlW4QNWTZTfDtXqANZSYYJHvls6PLELjvP2cBdvSumPMTU1XbuyZxG
         SfriWjMlHS3U6lAizWZAK71Dbp1nRuxht4pDpLVeFTpZ9rj38eSTLiHrXjrFuCthyuvD
         6bTZV+Uf1nFAUhvGIZ4IbfqxApSavb+sjxs1cNiCmNFOUlPIxkJWAOSu1k8+6hO8X47x
         oyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685551583; x=1688143583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbUqG/hAuM91PW1jIKAuU+eixIUM09PYOEoZK6mKciw=;
        b=TKKQguhV+bxoxNMG12S8QGGhlprgGGBKHbeo8wUGz5HS8cb/b5sdYvTEwK5YofvcZc
         WEwTfPGPTuDKp6MPIh827JxBsnt+lqfprTWW1kXSmdsbivPEiIFdjahJodOS/pD2kodI
         qkxCaPFlV+TIoaa8YIJJZEDsrBAiwSc1IMFM+rcMNTl1sjg7U3knSIgdUo4SHlOftNlY
         /vmK7x2wIrgHmXhc4mDQynDErbaTQX+W8REY2pAcMxtUmJvSfT8lcEY8YKLPRpUgomJP
         LPajMUfdUePXJBo1NW+VOLNRBqTdkpb0HDl+liDF5obApUZggpC3DcmbmFEznSNy2xGW
         F1jQ==
X-Gm-Message-State: AC+VfDzy5XqRHcexN1eO4Xm5z3iR6NHlo8c8z8kpo7FYv9TXcQJld8bV
        XxF3zT9CUpNCuVfthjPFS3PJXg5e58o=
X-Google-Smtp-Source: ACHHUZ5E5pm711g/A+8KlZGn695wN2U80NTYglvDnjCk0VAFCEqP/hrGOh7PGiWKI5v/JYU4qcuTng==
X-Received: by 2002:a05:6a00:2e1a:b0:64a:9090:5147 with SMTP id fc26-20020a056a002e1a00b0064a90905147mr7685538pfb.10.1685551582947;
        Wed, 31 May 2023 09:46:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78d03000000b0063b7af71b61sm3503311pfe.212.2023.05.31.09.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 09:46:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net>
Date:   Wed, 31 May 2023 09:46:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported
 boards
Content-Language: en-US
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230527012206.133464-1-samsagax@gmail.com>
 <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
 <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 05:04, Joaquin Aramendia wrote:
>> This attribute is a no-go. It is not even remotely related to hardware
>> monitoring, and thus must not be attached to the hwmon device.
>>
>> I don't know exactly where it belongs, but it appears to be related
>> to the keyboard. Its natural place therefore seems to be a keyboard driver.
>> We could possibly also attach it to the platform device, but there would
>> have to be some precedence of other drivers doing the same. Question
>> in that case though would be if this is just the first of many attributes
>> to come. If so, we would need to find a different solution.
>>
>> Guenter
> 
> Sure! Should this driver with those changes go into a platform driver?

You are attaching the attribute to the hwmon device. Moving the driver
to another directory would just be an attempt to avoid review by a
hwmon maintainer. Just for that reason I would NACK such an attempt.

Guenter

> Seems a better fit to me. The case against keyboard driver is the
> switch changes behaviour of the key but both the behaviour with the
> switch on and off is device defined. Some use the key as part of an AT
> Translated Keyboard and others just operate on the EC itself to grab
> the fan and set a special TDP for "Silent mode".
> For now this is the first such attribute found by the community and
> some talks with the manufacturer but it doesn't mean there wouldn't be
> others. Specially with such new form factors adding some "control
> panels" on Windows to set some hardware behaviour via EC writes. My
> goal is to allow those same functions to be available to linux users
> in a way some other userspace tools can serve as front ends.
> 
> Would taking this same driver to the platform side be a solution to
> that going forward? It would be a combination of hwmon monitoring
> attributes and some other special functions with custom attributes.
> Seems a better fit to me.

