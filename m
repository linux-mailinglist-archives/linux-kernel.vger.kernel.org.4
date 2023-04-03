Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1336D4693
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDCOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjDCOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:11:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278142C9F1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:10:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f22so23999113plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680531049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdH5SytCYu18Erl2+hmHazDSFaLa7orTkkF1JcQxu1k=;
        b=LDhjBozkMLnjU7v1cWqHrIQSxC3UY9ucBinTC9heGnsbd9All6lkEQ0Y3ZEW0CkGXk
         vUBefuaTtbVPnK6z/7bAMPBSHhnEZfpapX/gRJrV2mYqfGcuJOFIauh+Dhp2ZHZnLjH4
         qxfD4JYESPLBL7opNSSK/eeWhU8050XTKQNAUA/ZWPyB/pdLRDJA3+0zsX3/kcwcWSBy
         seGvkdg6yF5fW6gv56OzF7gLVQ5dhwr6YWreS4Z3J/1NMnECHAtMSMCo/xFZOc51DVGA
         xOwJpbuOloD+9l5eZ08WMTPRTK25AalXot8WP/cB3aRCnKgBjEBzJDNyQ5yjf8TcbUCw
         45YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdH5SytCYu18Erl2+hmHazDSFaLa7orTkkF1JcQxu1k=;
        b=S/Slo/U5Eq5BQo9U/hiInXe6eVBl6XmUDgwHMbKht4EJ1QLTWoClmpYhwfNA+FYpdi
         6UtjVCuCJz99akUCeW577q2XWjy1OlDTPkRX54PjpzXDOzBpB7MZgZapt2ksoTG4/Vy3
         SuUH0F8YPzrK66I2ABcPIY5ckOLb8E3v5mBzAXolYtWR0bKoFfvkf0F02tBxCOhsIHKV
         HqGU3nwDFsXr3uZmTHZdXIUnz+pBKbHsr2+h/tWQ1i78Rzi+HQr+10Hm2R1UO251wpBP
         WQyQk9nMr/jKf6FBLbwYGLWp84k5vXN82Pnqmqta39snGOyrD9muoTllp5t8VpGeHeNX
         UkRA==
X-Gm-Message-State: AAQBX9exS61P2u0rQXZD2RovUTRm9V/7GibkKoPIUDbakRcQFIMB9jAP
        FrisPj3kd1nwikrtz0zNRsE=
X-Google-Smtp-Source: AKy350bNnfG9E9czfhxziDy0Le2R53vTud7kVVrlhUdKFBAoPTAaS0ARJTz0rZOL0OnylNCKhtp62g==
X-Received: by 2002:a17:902:f2ca:b0:1a1:c54c:1a36 with SMTP id h10-20020a170902f2ca00b001a1c54c1a36mr29741894plc.63.1680531049224;
        Mon, 03 Apr 2023 07:10:49 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y11-20020a170903010b00b0019a5aa7eab0sm6659001plc.54.2023.04.03.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:10:48 -0700 (PDT)
Message-ID: <357a3ca5-8719-37b8-fd22-657e31a0ce16@gmail.com>
Date:   Mon, 3 Apr 2023 23:10:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 05/14] extcon: Amend kernel documentation of struct
 extcon_dev
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-6-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-6-andriy.shevchenko@linux.intel.com>
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
> First of all, the @lock description is missing. Add it.
> Second, correct the terminator value for the mutual exclusive
> cabling.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 93b5e0306966..15616446140d 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -13,8 +13,8 @@
>   *			are disabled.
>   * @mutually_exclusive:	Array of mutually exclusive set of cables that cannot
>   *			be attached simultaneously. The array should be
> - *			ending with NULL or be NULL (no mutually exclusive
> - *			cables). For example, if it is { 0x7, 0x30, 0}, then,
> + *			ending with 0 or be NULL (no mutually exclusive cables).
> + *			For example, if it is {0x7, 0x30, 0}, then,
>   *			{0, 1}, {0, 1, 2}, {0, 2}, {1, 2}, or {4, 5} cannot
>   *			be attached simulataneously. {0x7, 0} is equivalent to
>   *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
> @@ -27,7 +27,7 @@
>   * @nh:			Notifier for the state change events from this extcon
>   * @entry:		To support list of extcon devices so that users can
>   *			search for extcon devices based on the extcon name.
> - * @lock:
> + * @lock:		Protects device state and serialises device registration
>   * @max_supported:	Internal value to store the number of cables.
>   * @extcon_dev_type:	Device_type struct to provide attribute_groups
>   *			customized for each extcon device.


Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

