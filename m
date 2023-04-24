Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB09C6EC8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDXJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjDXJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:21:05 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92C211D;
        Mon, 24 Apr 2023 02:20:50 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-958bb7731a9so304315066b.0;
        Mon, 24 Apr 2023 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682328048; x=1684920048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA6jSt5gQmRcw1KPPidEx6UfEGnWKcs24u88lBvdmFQ=;
        b=ZxR/h5iBTJ0MLTmY9fzuwPRroPSkHpVuhOb2Kju5rYDFaDIJxcE6MfinGPp8n5mikX
         jrOhx2+5gjfNa9NgzXGtJP1ZlAp1rr+EQju0bj5scSTXTPnQ1R3trwn7keu5g1TFhYiW
         FXUE2Cxf64pJM/PpsY6xaVfWIWMTGQCrUAMz36kXZ4BMO7OAhm4ttRO6xIneNYs9qsB2
         Ikza2kkH/iCUIQbdTrZ/DfFo5fRFb9z3UvA4I2JzSvv1DIzdiNH0LoqrzsKC7kkuXZuV
         WL4QigIYur0VcAo66WTuFy2Xd+AvxjCuuulLPZshvXjz4EQ8iMNT5dj4+7b+ck8pXV/U
         mkjQ==
X-Gm-Message-State: AAQBX9fbj9XJaiZWdmznCDFD5Fd5iWzaKnhM1yhsC7M1NLWvW7jt0ovy
        Rk0LWgGMzrWpdLBlTMUVtdvCd4V8OXw=
X-Google-Smtp-Source: AKy350ZS7ohYuDvxcs3eJSlQ8UgKSMbR7vddFPaKhmUbmEKlSuNL05qiNE9VZNVNCJ0SDz7Z3DMopQ==
X-Received: by 2002:a17:906:3698:b0:958:5c21:3fa7 with SMTP id a24-20020a170906369800b009585c213fa7mr4384903ejc.25.1682328048284;
        Mon, 24 Apr 2023 02:20:48 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b0094e62aa8bcesm5315525ejb.29.2023.04.24.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:20:47 -0700 (PDT)
Message-ID: <e87f6675-283b-652a-4d5e-b1d41371efd7@kernel.org>
Date:   Mon, 24 Apr 2023 11:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] serial: 8250: Document termios parameter of
 serial8250_em485_config()
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2bd1e62be1d5d33333002910372feecc6d52e78f.1682071013.git.geert+renesas@glider.be>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2bd1e62be1d5d33333002910372feecc6d52e78f.1682071013.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 23, 11:58, Geert Uytterhoeven wrote:
> With W=1:
> 
>      drivers/tty/serial/8250/8250_port.c:679: warning: Function parameter or member 'termios' not described in 'serial8250_em485_config'
> 
> Fix this by documenting the parameter.
> 
> Fixes: ae50bb2752836277 ("serial: take termios_rwsem for ->rs485_config() & pass termios as param")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

