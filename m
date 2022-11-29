Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B663B9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiK2GcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2GcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:32:18 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F64FFA9;
        Mon, 28 Nov 2022 22:32:15 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso430813wmb.0;
        Mon, 28 Nov 2022 22:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGouC9aHtzSXLihgGalVY3YwbBFH6yJ0O83fDRF8rsU=;
        b=RGlhOIKqcnat4s5xdnvEJsJHyhylyFWzFur7lnRrCFEJrvIK+pDcNiZ1PuQujEpAXC
         E+Ro5wy2/8OftafsxpoUnszlKbCv/pVAEiX+4x3wyHkLh/ZsGTjAAFSrXVyzL/PAGVVF
         zd5T934hpJoQurpq5dOrLK8wVQFzq5XY6X4QQf4YQYA//N/mkBb65sTG1AsHZ38OAR9q
         vv8g7ADqBK7tW6HY9oN3+NWTg+0qmgAqPXQJUo1aNiZuCaLMrB1q11K1yBld/YhA4IwP
         zX/xL+SfGZUhD4hz6oJgr8LCC4p7LJrH4OWCN+1hwY2BjeUf8WLZA6FqML2GcV6VFIhZ
         2c3g==
X-Gm-Message-State: ANoB5pmbl5SpiOmIZgKOHEsPdKtl4mGoDSyEzL7+Cv2ApYCxbhgF/1Ex
        dT/1ZMEfsZvIPXzticUNH8M=
X-Google-Smtp-Source: AA0mqf5cUNXgY52ua04z8ynuvEJc/3a/cDcljqCZ4LVhYaDNw5WQ9o4CB6eG3RGA4un7Bt6ynmedTQ==
X-Received: by 2002:a05:600c:5408:b0:3d0:1c3f:e3ae with SMTP id he8-20020a05600c540800b003d01c3fe3aemr31016843wmb.27.1669703533886;
        Mon, 28 Nov 2022 22:32:13 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm881201wmq.31.2022.11.28.22.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 22:32:13 -0800 (PST)
Message-ID: <2b020f4c-5c2b-f905-27e9-a3f603a2568a@kernel.org>
Date:   Tue, 29 Nov 2022 07:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/9] serial: bflb_uart: add Bouffalolab UART Driver
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-3-jszhang@kernel.org>
 <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org> <Y4TD48v84CJcMS+S@xhacker>
 <e1f689d2-d337-5a42-e4c9-91c1d338b42b@linux.intel.com>
 <Y4VCKeeTS2zV1xcZ@xhacker>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Y4VCKeeTS2zV1xcZ@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 11. 22, 0:20, Jisheng Zhang wrote:
> On Mon, Nov 28, 2022 at 06:01:28PM +0200, Ilpo Järvinen wrote:
>> On Mon, 28 Nov 2022, Jisheng Zhang wrote:
>>
>>> On Mon, Nov 28, 2022 at 07:10:41AM +0100, Jiri Slaby wrote:
>>>> On 27. 11. 22, 14:24, Jisheng Zhang wrote:
>>>>> +static void bflb_uart_tx_chars(struct uart_port *port)
>>>>
>>>> Again:
>>>>
>>>> Are you unable to use the TX helper? If so:
>>>
>>> You know serial subsystem better than me, may I ask for more
>>> details? For example,
>>> Besides uart_xmit_advance(), do you expect other TX helpers? If yes,
>>> can you please list them?
>>
>> Please take on look on commit 8275b48b278096edc1e3ea5aa9cf946a10022f79.
>> The changes following that commit convert some drivers to use the tx
>> helper so you can look into them to see examples.
> 
> Thanks a lot for the hint. Will those tx helpers(uart_port_tx,
> uart_port_tx_limited etc.) be in v6.2-rc1? Or I need to patch
> based on Jiri's devel branch?

It's in tty-next and so in -next. You should base on either of those 
anyway ;). And yes, the plan is to have them in v6.2-rc1.

thanks,
-- 
js

