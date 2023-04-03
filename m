Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3146D4639
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjDCNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjDCNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:51:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC12B0E5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:51:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f22so23935562plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680529877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PBCwK3H3PgRN6ZUpfJDFkBOvLMUdAaTBUcVVih+LYI=;
        b=Fkd+YKQCkwCiI0nXtGOBiTrVcgAV2LaqtP8hDWsfLcLXAIPPly1rxn5/QI6Ee7P1Lq
         jJHxpv1K4K6rYWGU3KBcoZ5Z1NwsiMzRVZVdI7KZDuWsWgpjFDb+YUHmRQOlnLMz7F1C
         nTRdIShmud4pcUkFJAX/+Uj4+iMhC6MAoAj3GmjkK3B8WC2eC+21g/j/w32DSLyjxwwC
         7J6yjWRjCqAJ3IVGuhMz/sTvpdQNGlD+O8Dk+3ZURrGztMS0IuZwoi/nRM5sHteweP3B
         s4etAGTnxAs235af5scyocy0i8tlJe9kuZtuKoYpip9NyyKHPIce2YmCUHYwtVexnojw
         TLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PBCwK3H3PgRN6ZUpfJDFkBOvLMUdAaTBUcVVih+LYI=;
        b=xxrebGcJmQegt8dGa7135B1Wbs2+obQ/APsI+awXNP+hEr50bdn1WuIg6ed+u0frcg
         OG//bPLWKmU3BFYDm01aMJ5EkAmDZ1gbw9V4bAWNZIYI79mNjNhyvaDZZZdWnVGoGtQD
         XzHHEnIQDN+6Roz3ECynlbP3UiA0foo90wnU1WVGKqZuVK0eaKnF5AW9x2yup3sp8X/V
         +MipuuJ+4sm4K/ZHj96hS3aevXHhXbf8wXnNdlr1j/mUrp9jAh1taOzZaTEGpGkXfNY+
         oCFfKdCuKn/q68+S6RLrBf3JuoUkDv/a3lBtaFd5fkdpfWptweMR1HZCqGykaYg1JxEg
         LP0w==
X-Gm-Message-State: AAQBX9eYk4qmxEGQtaTJxvETaiLilwVFjQWY6NVS0LWmtXh/DWsL5POh
        MDTp1qGWz5TMF5uZfMTJtAw=
X-Google-Smtp-Source: AKy350ZJDcJNgWfx6zMB4Az5yU5sjzAAay3jyekmFEJteKU9tNspRNKR3wAyCkiOfKq/78Y2GNuPug==
X-Received: by 2002:a17:903:283:b0:1a2:1922:9850 with SMTP id j3-20020a170903028300b001a219229850mr42326862plr.67.1680529877258;
        Mon, 03 Apr 2023 06:51:17 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id jk24-20020a170903331800b001a19bac463fsm6677797plb.42.2023.04.03.06.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:51:16 -0700 (PDT)
Message-ID: <1dc44741-2fa3-79b0-e618-cfa80d3694c8@gmail.com>
Date:   Mon, 3 Apr 2023 22:51:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 02/14] extcon: Fix kernel doc of property capability
 fields to avoid warnings
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-3-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> Kernel documentation has to be synchronized with a code, otherwise
> the validator is not happy:
> 
>      Function parameter or member 'usb_bits' not described in 'extcon_cable'
>      Function parameter or member 'chg_bits' not described in 'extcon_cable'
>      Function parameter or member 'jack_bits' not described in 'extcon_cable'
>      Function parameter or member 'disp_bits' not described in 'extcon_cable'
> 
> Describe the fields added in the past.
> 
> Fixes: ceaa98f442cf ("extcon: Add the support for the capability of each property")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 1bc2639704c2..79006ab5334b 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -210,6 +210,10 @@ static const struct __extcon_info {
>   * @chg_propval:	the array of charger connector properties
>   * @jack_propval:	the array of jack connector properties
>   * @disp_propval:	the array of display connector properties
> + * @usb_bits:		the bit array of the USB connector property capabilities
> + * @chg_bits:		the bit array of the charger connector property capabilities
> + * @jack_bits:		the bit array of the jack connector property capabilities
> + * @disp_bits:		the bit array of the display connector property capabilities
>   */
>  struct extcon_cable {
>  	struct extcon_dev *edev;

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

