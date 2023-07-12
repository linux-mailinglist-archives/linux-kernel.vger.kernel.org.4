Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B665750C21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjGLPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGLPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:16:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5531BDC;
        Wed, 12 Jul 2023 08:16:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e64e97e2so4009449b3a.1;
        Wed, 12 Jul 2023 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689175002; x=1691767002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PAhy3IB4is5+53Cfgz4S3Ovfr+OJ4+hbHoYpYABgHdE=;
        b=RylKbdAUXmcCQa+90CeWC/IM/RY2Pbxdu5zkYXRdJljnel320X9SqmKsDlWuRMuXIk
         QA+PRvI8BxW4tsJ43MrOcGrIDwtjPPVXiQ0j3dQ9YBUDl6t+enLp79Jpb0D8V9r3i9og
         IvaSfeollIyJlHAxipeoJ5LedcY9wEytLk5UQPhW8uAPqp46UNLoKlrYbeINCIQCkCw3
         txsEoSYkbo6/rrfGAdiKdU24t+cE4HtIF3msr6LsrCUiMaoaS4r2ItbHE2e3myXo0+pS
         D+qXlV9EAzB6aBrD7Ac/qJcgaCmzMSUry2ePWZxAPZHz4eV2B/oFab7YQ/+GHFBqb2bI
         nlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175002; x=1691767002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAhy3IB4is5+53Cfgz4S3Ovfr+OJ4+hbHoYpYABgHdE=;
        b=fcTab1/d1IrMClehXcZXaVvmlpZUHNEEE153Py62IPEgQKs7cLyrCyxesNySnZ3feG
         zcoyjqk6dAvUuxHLFw01b3Xfk6owrwo04vxxW6u6PiWqAC51WFrdRCATX/oDAkF34L8n
         OBYoAFWc00rOAtoJa44uAFQ9PzIh00MP7NT57t5UinocnrV26bfzDii2HelsGYMnyPWN
         CZFOI5Y0tUzSIczk+gIay152b5CIZ6T7VI05s/WoD+DHAxWiwRBz9j6SmTwF1/zla+/q
         CWMeQ262mgnkYexIKtwGyIXKO+eDt41iJAcB5zmSRRSxbV9b+XrryWtK8W9E+xp40Eie
         aPyA==
X-Gm-Message-State: ABy/qLZ6FO4R7mim/DTxGYFhW/jTmao5c5cf1TnQKlx8IHp6QLLiqxUt
        cWSnw3pku3B2Vjep1diH7FeREnHEg8M=
X-Google-Smtp-Source: APBJJlF2DIK4lShlq1EwSfEqG8LaHBv7UCF/L0LJXieSJjIfg1uOo8L7E5uL/zwzT832MbthaJ7MvA==
X-Received: by 2002:a05:6a00:1a0b:b0:67a:31b7:456c with SMTP id g11-20020a056a001a0b00b0067a31b7456cmr16435226pfv.9.1689175001922;
        Wed, 12 Jul 2023 08:16:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b0067a50223e44sm3764796pfo.74.2023.07.12.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:16:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3034082b-4ec8-2a8d-35a2-2551e9feef34@roeck-us.net>
Date:   Wed, 12 Jul 2023 08:16:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: Remove strlcpy occurences
Content-Language: en-US
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Kees Cook <keescook@chromium.org>
References: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 07:44, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with direct assignment.
> 
> strlcpy in this file is used to copy fixed-length strings which can be
> completely avoided by direct assignment and is safe to do so. strlen()
> is used to return the length of @tbuf.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>   drivers/hwmon/pmbus/max20730.c |   64 +++++++++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index 7bcf27995033..f5ba23f0fed5 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -113,7 +113,8 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
>   	const struct pmbus_driver_info *info;
>   	const struct max20730_data *data;
> -	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
> +	char tbuf[DEBUG_FS_DATA_MAX] = {};

Unrelated change.

> +	char *result = tbuf;
>   	u16 val;
> 
>   	info = pmbus_get_driver_info(psu->client);
> @@ -148,13 +149,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
> 
>   		if (val == 0)
> -			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
> +			result = "2000\n";
>   		else if (val == 1)
> -			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
> +			result = "125\n";
>   		else if (val == 2)
> -			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
> +			result = "62.5\n";
>   		else
> -			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
> +			result = "32\n";
>   		break;
>   	case MAX20730_DEBUGFS_INTERNAL_GAIN:
>   		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
> @@ -163,35 +164,35 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   		if (data->id == max20734) {
>   			/* AN6209 */
>   			if (val == 0)
> -				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
> +				result = "0.8\n";
>   			else if (val == 1)
> -				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
> +				result = "3.2\n";
>   			else if (val == 2)
> -				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
> +				result = "1.6\n";
>   			else
> -				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
> +				result = "6.4\n";
>   		} else if (data->id == max20730 || data->id == max20710) {
>   			/* AN6042 or AN6140 */
>   			if (val == 0)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				result = "0.9\n";
>   			else if (val == 1)
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				result = "3.6\n";
>   			else if (val == 2)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				result = "1.8\n";
>   			else
> -				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
> +				result = "7.2\n";
>   		} else if (data->id == max20743) {
>   			/* AN6042 */
>   			if (val == 0)
> -				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
> +				result = "0.45\n";
>   			else if (val == 1)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				result = "1.8\n";
>   			else if (val == 2)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				result = "0.9\n";
>   			else
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				result = "3.6\n";
>   		} else {
> -			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
> +			result = "Not supported\n";
>   		}
>   		break;
>   	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
> @@ -199,26 +200,26 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
> 
>   		if (val == 0)
> -			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
> +			result = "0.6484\n";
>   		else if (val == 1)
> -			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
> +			result = "0.8984\n";
>   		else if (val == 2)
> -			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
> +			result = "1.0\n";
>   		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			result = "Invalid\n";
>   		break;
>   	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
>   		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
>   			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
> 
>   		if (val == 0)
> -			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
> +			result = "4\n";
>   		else if (val == 1)
> -			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
> +			result = "2\n";
>   		else if (val == 2)
> -			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
> +			result = "1\n";
>   		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			result = "Invalid\n";
>   		break;
>   	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
>   		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
> @@ -230,13 +231,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
> 
>   		if (val == 0)
> -			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
> +			result = "0.75\n";
>   		else if (val == 1)
> -			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
> +			result = "1.5\n";
>   		else if (val == 2)
> -			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
> +			result = "3\n";
>   		else
> -			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
> +			result = "6\n";
>   		break;
>   	case MAX20730_DEBUGFS_IMAX:
>   		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
> @@ -287,9 +288,10 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>   				"%d.%d\n", ret / 10000, ret % 10000);
>   		break;
>   	default:
> -		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +		result = "Invalid\n";
>   	}
> 
> +	len = strlen(result);
>   	return simple_read_from_buffer(buf, count, ppos, tbuf, len);

This still copies tbuf, meaning all those constant strings won't actually
be reported.


>   }
> 
> --
> 2.41.0.255.g8b1d071c50-goog
> 
> 

