Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76567DE50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjA0HMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjA0HMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:12:50 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED01027B;
        Thu, 26 Jan 2023 23:12:49 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id v6so11227267ejg.6;
        Thu, 26 Jan 2023 23:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVj6tESp4nEWyweFFwTiuF+hajljU5N9ZtVJsgI50Ms=;
        b=spwoF+puhEjVBhNP5gOoMlFKbk/MH1yknmcI4QedkyCZoDTamlQtoVzSTfCRgRPdEy
         4WBB9GDugTjm7Qd1e5n8kArL6pRXRHhaY3gm/oJVSzK2o4fH32BTjIzhwFtmk90w33Ky
         5JQ9gpsam3uX7S/366uvjpyGKVWBpaeOo6UfI7hc6LkD4gNrZTNu68OHVENb840ZsBfD
         TAxL5JbSihHEDRUUUd//UFsz0Vny3lrtgbcnPO/GOt6pPMJ3CQyaTItLEu+IoEDxEwhe
         laZAbw2fB4udN44l5u7xRHJ/h2osYCQ0vfVlUDvtwmLIrR3QYCn5NtW/+USn+keJQk0H
         oDCQ==
X-Gm-Message-State: AFqh2kqfFwFV4KIas871tm1VjsNtLY2A+NMHyf7cthSqsJSfRko8oIZq
        mHjyIS0SAwgsFpb1ZTZF/oz0sqweh1g=
X-Google-Smtp-Source: AMrXdXsKlioCnHG+HsP3xNl4il4T9jfpnY+iMovgYnpTy0k+dfBCai7gzJh58/B1/NfR8+zY9FvuHg==
X-Received: by 2002:a17:906:5786:b0:84d:4e79:e7a with SMTP id k6-20020a170906578600b0084d4e790e7amr41671668ejq.74.1674803567502;
        Thu, 26 Jan 2023 23:12:47 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906945000b0084d46461852sm1715868ejx.126.2023.01.26.23.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 23:12:47 -0800 (PST)
Message-ID: <82cfbb3e-cb2c-199c-8833-35498ce894e2@kernel.org>
Date:   Fri, 27 Jan 2023 08:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the kspp tree with the tty tree
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230127155753.1f9b9517@canb.auug.org.au>
 <Y9N3GNBKzOKuSOMJ@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Y9N3GNBKzOKuSOMJ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 01. 23, 8:02, Greg KH wrote:
> On Fri, Jan 27, 2023 at 03:57:53PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the kspp tree got a conflict in:
>>
>>    drivers/tty/vt/vt.c
>>
>> between commit:
>>
>>    feb36abbedea ("tty: vt: remove struct uni_screen")
>>
>> from the tty tree and commit:
>>
>>    19c30ead3938 ("vt: Replace 0-length array with flexible array")
>>
>> from the kspp tree.
> 
> Kees, I was waiting for a new version of your 0-length patch before
> applying it as I thought there were review comments on it.  So you
> should probably drop it from your tree or resend it so I can merge it
> into the tty tree if it's acceptable.

feb36abbedea removes the array completely, so obsoletes 19c30ead3938.

thanks,
-- 
js
suse labs

