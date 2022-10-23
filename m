Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B42609381
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJWNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJWNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:16:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0A27FFC;
        Sun, 23 Oct 2022 06:15:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m15so22134345edb.13;
        Sun, 23 Oct 2022 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHgwQM7J9w2p/Yomya8nmFZftLJ0S3USYJ+LjewRLkQ=;
        b=AxsDpkehrbvam7YPhUxQrFsGZZd/02lptE1TxGzjninV+9EGxCM7acploa4jtgja/V
         3VO/vZ8wz2mQrLHakDEzIf40L8RC/3lr1PG2htWaJjgqp5C5Nyl8912OYmFDFGHmQ4og
         6+marLRjPenETnHJ1kTBhuAVP1ZKyK9ypzv+Pgj7wPIUz6/TMPCClIwIgJDTyYLqfmFp
         W4wJR3QY4ZATt0vx5yYZmxM2iWCc/dfrNEnq4xgOo6Fdxc3KzX0wPReHOn0Z2et2GQSL
         warnCHWHWLFjhjWyrdkI/B7fJjbnuamFljDz3uPZwPO+azIU8bHokdAoLGQ1xjSqW8Jj
         FKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHgwQM7J9w2p/Yomya8nmFZftLJ0S3USYJ+LjewRLkQ=;
        b=wy3DiC5Qk/hDjFaKviSBD8UWaRfmZhNUZDrrx8kYK/LNFMda0Y+zjrRgPBLJhMK8G9
         Ah5J/do/f3XMPQreyASLiQ0hnPC/upzx+abWbPWw2g2CRYV0SGBEdy+WoGsqZElf71Ev
         R5lSwdywhOevl3F3U5Q0HjlzmwZjrp0dVI6/ckkMAe/GKTpkiJY4S+rik918RTYLPteh
         pc9LNKwGRWjGJ3LmT/P7MDXWVA3OQ+Se09z4IUz6qOt4trI83HlKNXpQedfNnro5wjkG
         5Wszc+XCtU7aI2nMfquE3IoEDJA2Hy+yxKbVHrayO8JkZCYuhdPklvE7W1twoROO1K91
         mp+w==
X-Gm-Message-State: ACrzQf2dFPYMxt/cnGVqCLWMsBKg955HhYBK1xduoPjSa/BbUQUS67AL
        /zPm51nsWGIEd/tmAUGahwv/Koy44OyznKe1
X-Google-Smtp-Source: AMsMyM7H9g5HPTmoMnueWo24D9wlG3WYElx2Sc8Yqei5jSbbvktacAVALtu9/bsxindbGqghkrPWlQ==
X-Received: by 2002:a17:906:d555:b0:78d:ce55:23af with SMTP id cr21-20020a170906d55500b0078dce5523afmr23051719ejc.524.1666530938667;
        Sun, 23 Oct 2022 06:15:38 -0700 (PDT)
Received: from [192.168.0.22] ([87.116.164.153])
        by smtp.gmail.com with ESMTPSA id eg49-20020a05640228b100b0045fd8e22d9dsm5873430edb.40.2022.10.23.06.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:15:38 -0700 (PDT)
Message-ID: <6ef88c2c-3435-8847-0f4f-53e81cd3af5d@gmail.com>
Date:   Sun, 23 Oct 2022 15:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for temperature
 sensor offsets
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221021174834.736930-1-savicaleksa83@gmail.com>
 <20221022135720.GA739650@roeck-us.net>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <20221022135720.GA739650@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-22 15:57:20 GMT+02:00, Guenter Roeck wrote:
> Please go up to 100 columns to avoid excessive line splits.

Will fix this and other comments in v2.

> Is it really necessary to re-read the control buffer repeatedly
> to report this value ? I don't know how costly that is, but unlike
> the pwm value I would not expect the number to change.

Yes, aside from the driver userspace can also change settings on the
device using hidraw and we'd end up with stale data. Reading it is
very fast, it takes about 4ms in my testing.

> Also, is this number indeed not included in the regular reports
> sent from the controller ?

Unfortunately, it's not. The sensor report only includes final (calculated)
sensor readings.

> The driver doesn't distinguish between offsets in the control buffer
> (pwm, and now temperature sensor offset) and offsets in the report buffer,
> making it a bit difficult to determine if those are the same or not.
> Some explanation in the driver would be nice if someone finds the time
> to provide one. If the control buffer offsets are in a different number
> space, they should really be marked accordingly (for example with a
> _CTRL in the define).

I can see how it can be confusing. After this, I can send a patch to
reorder the macros & initializations and add more comments regarding
what is what.

Thanks,
Aleksa
