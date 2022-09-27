Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F45EC039
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiI0K6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiI0K6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:58:12 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752BC6AE97;
        Tue, 27 Sep 2022 03:58:10 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id z6so14430937wrq.1;
        Tue, 27 Sep 2022 03:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EjbYwEB4aUSvoakBSHtMBtNMFeoYUjvUaUSAqImO7JY=;
        b=Lbh/sD85kvQ+4hqW8CXNy1KqgkxXBaQnJoTBdCC41CWDmOkewSBbL8DTX2+8AtThzh
         h9lcBXKWJobmi2GyCcPUE9qPmPAPrH90ihzPZAZQDVtCV/j/9eGfRcugD5Kn6G4PPQqb
         mPZUT6rqew1q6bJiwX+U98ouGdKrUcl/SlEHCsVWZalrOrxpA6ovTCULqsr3hJfxEcNV
         R4XTmPqB5CjU2fHiDo9Zocvb3NlCCZS8Nd91G9GuWqK+eL0Wf9G8WEY5U89dX2ZTQcJ9
         +GwfKfOpxrcOOgV+bThN3ecNRjB7/LrNJwZCdwG2Ry+Y5Ygk09TaAR1fxBP5gPm0h0IT
         +TwQ==
X-Gm-Message-State: ACrzQf0TTS0URZoMn2Tee0xfzweU+8OxzKdY7uOndCr0RQOq1Nmjs8IY
        pe9l9MHUtOo1fYQvPoBwweY=
X-Google-Smtp-Source: AMsMyM4CJmcmicknDIVtF3w0gV2zdBrrF+539QrxrQoQRpbuYMtHtaJKBaiGaGJw6MeMm00BDZJlgQ==
X-Received: by 2002:adf:e9ce:0:b0:22c:ae77:b75c with SMTP id l14-20020adfe9ce000000b0022cae77b75cmr4544603wrn.380.1664276288559;
        Tue, 27 Sep 2022 03:58:08 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm16926995wmq.9.2022.09.27.03.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:58:08 -0700 (PDT)
Message-ID: <f4143edb-cbc2-8b36-c227-b1ca13f3619b@kernel.org>
Date:   Tue, 27 Sep 2022 12:58:07 +0200
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
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -29,11 +29,11 @@ RS485 Serial Communications
>   3. Data Structures Already Available in the Kernel
>   ==================================================
>   
> -   The Linux kernel provides the serial_rs485 structure (see [1]) to handle
> -   RS485 communications. This data structure is used to set and configure RS485
> +   The Linux kernel provides the serial_rs485 structure to handle RS485
> +   communications.  This data structure is used to set and configure RS485
>      parameters in the platform data and in ioctls.
>   
> -   The device tree can also provide RS485 boot time parameters (see [2]
> +   The device tree can also provide RS485 boot time parameters (see [1]
>      for bindings). The driver is in charge of filling this data structure from
>      the values given by the device tree.
>   
> @@ -47,6 +47,9 @@ RS485 Serial Communications
>      for the uart_port. TIOCGRS485 ioctl can be used to read back the
>      serial_rs485 structure matching to the current configuration.
>   
> +.. kernel-doc:: include/uapi/linux/serial.h
> +   :identifiers: serial_rs485
> +
>   4. Usage from user-level
>   ========================
>   
> @@ -126,6 +129,4 @@ RS485 Serial Communications
>   6. References
>   =============
>   
> - [1]	include/uapi/linux/serial.h
> -
> - [2]	Documentation/devicetree/bindings/serial/rs485.txt
> + [1]	Documentation/devicetree/bindings/serial/rs485.txt

BTW could that [1] be converted into proper hyperlink too (separately)?

thanks,
-- 
js
suse labs

