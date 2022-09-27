Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55885EC034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiI0K4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiI0K4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:56:40 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B874E60C;
        Tue, 27 Sep 2022 03:56:38 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so801849wmb.0;
        Tue, 27 Sep 2022 03:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZA6/sESA6vS/T0n9rI13Hg5wb9So4dy8Uex03wX2SOw=;
        b=o2NvkdWHM54Hv2xht6HdZV2w1OQIbStKtO3vqMJzcOvQERZIEGuWZqKCaPHqXWhkCZ
         v+NaYJA7G5vAeAGGslNxGZSDDbXRXQnBo6TJtWR8YHT7MAau5FouJxfAFh0Cc2cl1mtV
         Vd4gHqW9praBlV992z9EqNOfZJp4gdI1f7gr6OtTX0TMsUW578PbY7jX7KjQ7j2r06j/
         zGsS1AsmcjVpFp9ahsUDJyGuY5XqTrIVEYezH0i3OWaMetFHNQ7Mj+nEBasBfzxctxIk
         uTJBpAUTTBNxzy/tgVXuASAAEgGvXoNxuvMFFBml9OXi8vx5hBoBxDMUpfsGFug8sxnu
         edtw==
X-Gm-Message-State: ACrzQf3xwEe2FBEyakOTxvsmSngudjna42nLfsZHLDVHB9GNH/t/Ly8S
        gRT35nNv7ZLTkoRVRNIBZsNGxFddNf0=
X-Google-Smtp-Source: AMsMyM6PF+pfYUoBgqNtsWC8oBN8jM54GiwHL6Tf0Fphap7uc6CqEntA2LQjF9AbujooEAr/gbHlhA==
X-Received: by 2002:a05:600c:22d6:b0:3b4:9f2e:9e33 with SMTP id 22-20020a05600c22d600b003b49f2e9e33mr2156864wmg.163.1664276197355;
        Tue, 27 Sep 2022 03:56:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm1509897wrb.31.2022.09.27.03.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:56:36 -0700 (PDT)
Message-ID: <d571f4ec-494e-d9fd-70c4-ab96a21abf03@kernel.org>
Date:   Tue, 27 Sep 2022 12:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] serial: Convert serial_rs485 to kernel doc
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1c401476-8f4d-827c-f8e1-b4853988e2@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1c401476-8f4d-827c-f8e1-b4853988e2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 09. 22, 12:47, Ilpo Järvinen wrote:
> For reasons unknown to me, the formatting in the flags doesn't produce the
> effect promised by kerneldoc's documentation:
> 
>    https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#return-values

Returns are special.

>    * Serial interface for controlling RS485 settings on chips with suitable
>    * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
>    * platform. The set function returns the new state, with any unsupported bits
>    * reverted appropriately.
> + *
> + * serial_rs485::flags bits are:

Put one more \n here.

> + * * %SER_RS485_ENABLED		- RS485 enabled.
> + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
> + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
> + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
> + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> + * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
> + * *				  Requires %SER_RS485_ADDRB.

And perhaps remove the second * here?

> + * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).

regards,
-- 
js
suse labs

