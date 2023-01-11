Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423866541D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAKF7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAKF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:59:18 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE6C05;
        Tue, 10 Jan 2023 21:59:15 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so11796438wms.2;
        Tue, 10 Jan 2023 21:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZAjpSapXmTrSbVYnTnu+ssu4HkFNsRlboMGfc1S5N0=;
        b=NmmQjSxwg3UtqHjXdEIdx8yWkiAmma/APYUsZyvR8QTYNQ66MkZ7n2iLEA6+x+xSrv
         t8uZpAUB26Pm3sjgYoq/Uo8KI0p6gyyteaIOC4Ij4wdJ3JagE4aQMJOoUED68f5r30Ug
         8KfoEEDN+XiLaU8/CB9LquaKNiKM0rjCHN+68l/3QZSI69I/M0o9iZFnX9VdhDIngqAS
         bc2iCZ/IjA0DwvhnnBbaNgXDBXyOmNLR0jgVLOQIQBuMYOUqtGzk2BLrynjqP9EAiUMu
         9FKiMAMZUgMYPyR3GgjUG9RJ6YtYkJrMqF+jLVL3SUsN5EgvL2utvTz+Qb2TsuOKsQ8H
         JHpw==
X-Gm-Message-State: AFqh2kpTT42woOmV3k9QpT5qcCGyrreUq0EtgK5cbFj7td2TGbPkG8Ne
        Cy42Wero1Te38sgGEXQcDY0=
X-Google-Smtp-Source: AMrXdXv5CQoiR6siCpwJR1o3nhLR7yKMN1GTtBK56emAIpjryitTbsCPO8t1l7kp9k3oDgFZa/54+g==
X-Received: by 2002:a05:600c:2318:b0:3c6:e63e:23e9 with SMTP id 24-20020a05600c231800b003c6e63e23e9mr54006112wmo.24.1673416754463;
        Tue, 10 Jan 2023 21:59:14 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003d99fad7511sm16445418wml.22.2023.01.10.21.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 21:59:14 -0800 (PST)
Message-ID: <87dd3dc8-5ac5-1647-cd31-25f2e197e1a8@kernel.org>
Date:   Wed, 11 Jan 2023 06:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 12/13] tty: moxa: Rename dtr/rts parameters/variables
 to active
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
 <20230110120226.14972-13-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230110120226.14972-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 01. 23, 13:02, Ilpo Järvinen wrote:
> Use active consistently for naming parameters and variables.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
...
> @@ -1881,10 +1881,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
>    *      Syntax:
>    *      int  MoxaPortGetLineOut(int port, int *dtrState, int *rtsState);

Hmm, this is wrong too ^^. Not sure what introduced the problem.

>    *           int port           : port number (0 - 127)
> - *           bool * dtrState    : pointer to bool to receive the current DTR
> + *           bool * dtr_active  : pointer to bool to receive the current DTR
>    *                                state. (if NULL, this function will not
>    *                                write to this address)
> - *           bool * rtsState    : pointer to bool to receive the current RTS
> + *           bool * rts_active  : pointer to bool to receive the current RTS
>    *                                state. (if NULL, this function will not
>    *                                write to this address)
>    *


-- 
js
suse labs

