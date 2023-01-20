Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D367605F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjATWra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjATWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:47:28 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9113DC3;
        Fri, 20 Jan 2023 14:47:27 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15085b8a2f7so7943746fac.2;
        Fri, 20 Jan 2023 14:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=59oaZrwvRXnY14aWAU9sGn0E+D4u2rUhDobBE4hDS1Y=;
        b=CqJW+re5K/hTICdUE3StSMjZhP8NNoHYCP8iwRSNLPVDyRfxpTZZ7XZpCgZOxJTc+P
         cArBxHgii50uDpzNbzEKELbIH0N5JcGvDLp8E95ny8qHD+XCY8G+YYK03yZAlv8ZZYPK
         LTC4pbLWqODJamjET6gAmFbsRpAMbiDFqxPjnkTYd44S5HiK8znqVq+m57ojk2VdsSU9
         Z93fqQQaQTQ94fO9lAX6IaPR0x51DQ2dltBFYEjU5ProGlfE6aDzSziQ8fj6Dy1dYo9Y
         E+J1YfuSfyS+tXut4W67jIMhdUF65OxlQSIB/y8oioBriAZPJpybDzkupNWF36OyJAhc
         DkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59oaZrwvRXnY14aWAU9sGn0E+D4u2rUhDobBE4hDS1Y=;
        b=pxD5mLCZ5hzluxTCW3JkvQ8oA6m5PePI/BMHBpNNNisU2ezcnaw1vyia+M3Fk/yVuT
         EtRF2jgNzYSg0+i2tJM3vzqx76YW5Miyoin9InzO7tk/sDI0Gv3jc8mnR3KmZAxHUlas
         rYb4acz+kbOhf2+D1v5PBHjnIik8yU2YPq+PKCrD8Lo1uUQs8F4XC55Iu1sCiEzDIbGi
         mLsHhqg7s72ZygC29B7r44yzxw+cA6KsiuAlrRrCq9gLLKg0dZzAdQxMPv8afwtsB90W
         kM1/AFknUyL/2JftAsZKC5xEh90RY3pkJrK8y4Q6m6Z0EbPm96Kxc2pzzqReEekCImm6
         d9qg==
X-Gm-Message-State: AFqh2ko6qaJdV2Uo+X6zvXqWuU8ZhdzWGHhLOfbGN6EFIlZdGhekKXxk
        RMAGdIJfP3eAc0oG1AT4IuY=
X-Google-Smtp-Source: AMrXdXs/ezA2tIeKmtjy82vPGkbLujUocFXfVY/wwoMonyD1aNhoHhE9z1ph69xv3Ro4wUGt/wz7qw==
X-Received: by 2002:a05:6870:668f:b0:15e:ff37:6fda with SMTP id ge15-20020a056870668f00b0015eff376fdamr14277677oab.14.1674254846899;
        Fri, 20 Jan 2023 14:47:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11-20020a056870310b00b00144e6ffe9e5sm5912665oaa.47.2023.01.20.14.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 14:47:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <78e1cc2d-eb67-cf78-bb84-95cdab2bfcf0@roeck-us.net>
Date:   Fri, 20 Jan 2023 14:47:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] usb: typec: tcpm: Remove altmode active state
 updates
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
References: <20230120205827.740900-1-pmalani@chromium.org>
 <20230120205827.740900-2-pmalani@chromium.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230120205827.740900-2-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 12:58, Prashant Malani wrote:
> Since the "active" state for partner altmodes is now being taken care of
> by the altmode driver itself (specifically, DisplayPort altmode), we
> no longer need to do so from the port driver. So remove the calls to
> typec_altmode_update_active() from TCPM.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> - Patch first introduced in v2.
> 
>   drivers/usb/typec/tcpm/tcpm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 904c7b4ce2f0..0f5a9d4db105 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1693,14 +1693,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>   			}
>   			break;
>   		case CMD_ENTER_MODE:
> -			if (adev && pdev) {
> -				typec_altmode_update_active(pdev, true);
> +			if (adev && pdev)
>   				*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
> -			}
>   			return 0;
>   		case CMD_EXIT_MODE:
>   			if (adev && pdev) {
> -				typec_altmode_update_active(pdev, false);
>   				/* Back to USB Operation */
>   				*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
>   				return 0;

