Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B306DD65B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDKJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:12:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA26A9;
        Tue, 11 Apr 2023 02:12:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t20so9474310lfd.5;
        Tue, 11 Apr 2023 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681204352;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtfQiofTa512tuCMPWCEjaBEGijC53jXghVYHeriOMs=;
        b=C7Paf3ccTcR5wiekvM7kwf1t5P/j47OKMmIIwjrgnDglYVrGyCcTebk85bE4dSZoU9
         FlO+k2zlX3gPnBZlgw9SXWRIYqFbkthwQ0+hPBFkMm5fanT+I1QaozJDbRdrr6MwqTBo
         w3j18UQkkUyXhN/8aEg99rSlo3SWo7CKpXMXUX7C10snBSG9mJS5Xz2tsGd+1u8hXjC0
         SdsnxfOF/LpxCkZECPGliV+MQhE1fGRvKv3JG5FOliIK11traUhp9z+9lJ+EL3zi5r/p
         yLACuCWUVsZq/BxknvPDH0/2Cs1+fzymCuNs+JimrtkvuYHpYCk16tPymO5ewSVxSK7L
         3MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681204352;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtfQiofTa512tuCMPWCEjaBEGijC53jXghVYHeriOMs=;
        b=GgvhaQumFYfmbpBDHYGGdgYFU7ThvjqnTffTEVoYPI33epJrmCO8FTRIsEXpCgEIjo
         7T7zACNpyA5BjnlKruFEVPkkRGqDgHaybF+gqVUe4A1Xo/ha7Y+h+P0fZUNAkKBpHnyJ
         azKV245PVKhW3+/srhIxDw7K/77EEOXT1FpSHjKweBSmuU0GyB6xAmc6ZJUWp5V7WgXL
         8PZWsEaGumqLGbq+lFRUV/iM252Ad+L3xyrEThyDdOnBU3UgBtqZUISLmcaeoht4ti3E
         LQe8l84sJIL0KmxWugw4PjxiDnl9a8HViWekLWIetEy11lHujj3f1PeSuTBqCTpHFqSA
         vNjg==
X-Gm-Message-State: AAQBX9dcYRKsugYN4B821gMD8pquOOIogzVYHcvL4qBY+Pf+KZhbIOgj
        ajB2WSDB6J5FXn1usrP9gtU=
X-Google-Smtp-Source: AKy350Y2v2swTzHbkzcGh5onxpOf6MXoUWfmNQCnIQAOOkLae40oXau2rRexCymAJxSEzLMW8GdwEA==
X-Received: by 2002:a05:6512:517:b0:4eb:18d:91de with SMTP id o23-20020a056512051700b004eb018d91demr3979091lfb.43.1681204351698;
        Tue, 11 Apr 2023 02:12:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004dc4c5149dasm2477601lfe.301.2023.04.11.02.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 02:12:31 -0700 (PDT)
Message-ID: <80b09e1b-f00e-4c78-6627-111959779376@gmail.com>
Date:   Tue, 11 Apr 2023 12:12:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Mark Brown <broonie@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 16:43, Mark Brown wrote:
> On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
>> ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
>>> On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:

>> Or, is it so that no "generic handling" of these errors is to be
>> expected? Eg, consumers who implement any handling must always be
>> targeted to a very specific system? My thinking has been that the
>> device sending the notification knows the severity of the problem and
>> - for example the REGULATOR_EVENT_REGULATION_OUT is only sent with
>> such severe problems that consumers can try disabling the regulator,
>> whereas the _WARN level notifications may not warrant such action. But
>> again, I don't think we have a specification for this - so this is
>> just my thinking - which may be off.
> 
> Do we actually have practical examples of systems sending warnings that
> aren't followed in very short order by more severe errors, notified or
> otherwise?

I asked about this from the hardware colleague(s) in Japan. This far 
they were not able to provide me a concrete information.

One potential example use-case they mentioned was "rejecting and 
re-doing a measurement if regulator warnings are flagged". This sounds 
(to me) like using a voltage from a regulator as some measurement 
reference or supply, with very strict warning limits. Still, as said, I 
did not have a concrete example if/where this is actually implemented - 
which means the answer to your question remains still "no".

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

