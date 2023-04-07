Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A06DB2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjDGSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGSam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:30:42 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D6A24F;
        Fri,  7 Apr 2023 11:30:41 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1a228ce9731so2028935ad.0;
        Fri, 07 Apr 2023 11:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892241; x=1683484241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHYj5Dya1CjjeKymHTZ2EoH/65pX6/8jhwaV6YI5TKE=;
        b=HUW9hHVwc/UrB8eNOlkFHauCF1JqWIlVdVtGpLRaZK0tO2lvOvZvtuV4VnoQfiqvZi
         6RoQ2XKXPbjguG4B1rv1VSPuNXDajfvv5A0qBdXMHeRqxfGzHtT7mDbE/UhDSfMN51EN
         HNqh8UgeLWYb1LXOHpMo1xC36g3WlDXmwCWTid/sTfFdusg4zEeRkpXGHkUj9yPNHTOY
         DVZY8ZFRkE1O1KPRZ8kZwHf+uG7ecylNkxUWKd6yewFq3t1Gogf/feNgo8oe26TAoFjz
         Pw1RnS9oEzkruTpkJ50FU1o3s0FCbcNAUnShbd6rfNNl3heVnmt+l3AeVOlmULUTBk/k
         JUjQ==
X-Gm-Message-State: AAQBX9dlrJDMh6Zb77m5W/Ba2Ru15wpDLP5snrPWXdoNMCjwLt/Nkcrm
        yW3yKKPhNGY45PWVy+sPEPY=
X-Google-Smtp-Source: AKy350ZAScG42bLQzQL2jWoA5lvazf1V7qSyaUOvjm5DJ8QpUUyfXlstlwidaJXcKb+ZTY88/PD1ug==
X-Received: by 2002:aa7:95af:0:b0:62d:b4b3:621a with SMTP id a15-20020aa795af000000b0062db4b3621amr3369120pfk.10.1680892241290;
        Fri, 07 Apr 2023 11:30:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f2c:4ac2:6000:5900? ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b005d6999eec90sm3331415pfo.120.2023.04.07.11.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:30:40 -0700 (PDT)
Message-ID: <59929dca-6d70-c3a2-292b-91f7274dd12e@acm.org>
Date:   Fri, 7 Apr 2023 11:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ufs: hwmon: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> -static const struct hwmon_channel_info *ufs_hwmon_info[] = {
> +static const struct hwmon_channel_info * const ufs_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LCRIT),
>   	NULL
>   };

A nit: to me the use of whitespace in this patch does not seem to be 
compliant with the Linux kernel coding style.

Thanks,

Bart.
