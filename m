Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBA5F4AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJDVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDVMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:12:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBC5F7C5;
        Tue,  4 Oct 2022 14:12:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l22so19064820edj.5;
        Tue, 04 Oct 2022 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ek0YcmYCHx5SGFTNcMBDbhOgrCmQLd482qHy+VkjZ7c=;
        b=DmH6gGKzxeEi1nDjvicR7wZqCweWulq1P/JZZ1CapyIkUYXRemmo91ltJZXJtR2Jdw
         jmOo5NEitzjpFMZMMER4j+dHI/0lh3ySkX8v3Bmieij/pv87iVamWRXLhTvpMPvmAHxU
         JMqRxV+rUURi+VFLE5FfjlamHJWnE7ry6lom2TqHezeADm5Dl81/t3nr1xnchPGhNt1h
         cnZCxOHtwveH/fjsxprsiOzlqN3kNbaXm1OXOt4Ij390UDSVgFKX33QZSWiQhIZ2WMy0
         WnZqFWdzZqX9ReU+aGuKhdDBFjSUNhyuAeZZd4V2YDvStFd8hHtqQfs1lqa4tonwkwNY
         48bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ek0YcmYCHx5SGFTNcMBDbhOgrCmQLd482qHy+VkjZ7c=;
        b=c8y7v/OULRQ2+cTQp/02yiytNFSbJaIh5QGo//41Nr1kPW2dJIbfL4SL/Sqdpsg8XZ
         BZmwV4lW1iwX1k/2KNCa39GflmeiCIMZeVFcYfrKWSdhx7kBoyWeOUIanfuBevjTe5T8
         dWG/Ln/VwzlcJf9Np5EuDWg9UCyqBpnk75PyVfb/w0B8QiPgdCSoLvq026/kuAyEHlPx
         tJZbavFJgljuxaNaOi6W4RgM24PBzZL/lpvMMXKWE8cAEphPYJLkvaxo8BBFtfKI1xBs
         dBbqfrpWBZjfzsn+DZqvhF+SXMHCuPQ/mcvLh0qOwu0C6kTfGyVDpfMjvNShrWdeZb/K
         PESg==
X-Gm-Message-State: ACrzQf2JejP+FbFiveqZwXaSCNPU/T3tCUYkbCEI6XP8jfXl2b9/SbrZ
        jhK6pP5lXjnTymjmttFV0EI=
X-Google-Smtp-Source: AMsMyM5iGOsddvtBCJeMBPxs7ofxnSK5HXPdj2k2Qo9gJwsmlRzWcbn3jgiaKX7GsmuFtTo6tohPwA==
X-Received: by 2002:a05:6402:414f:b0:456:c2c1:23ec with SMTP id x15-20020a056402414f00b00456c2c123ecmr26233787eda.420.1664917936245;
        Tue, 04 Oct 2022 14:12:16 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a06:125d:3a8d:82a2:428d? (p200300c78f3e6a06125d3a8d82a2428d.dip0.t-ipconnect.de. [2003:c7:8f3e:6a06:125d:3a8d:82a2:428d])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b00734bfab4d59sm427380ejc.170.2022.10.04.14.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:12:15 -0700 (PDT)
Message-ID: <b82e784d-f4c5-10df-2bcb-ee69b0f4a317@gmail.com>
Date:   Tue, 4 Oct 2022 23:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8723bs: Remove redundant initialization of
 variable efuseValue
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004153539.150867-1-colin.i.king@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221004153539.150867-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 17:35, Colin Ian King wrote:
> The variable efuseValue is being initialized with a value that is never
> read. The variable is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up warning:
> drivers/staging/rtl8723bs/core/rtw_efuse.c:285:6: warning: variable
> 'efuseValue' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/staging/rtl8723bs/core/rtw_efuse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index 06e727ce9cc2..eb848f9bbf2c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -282,7 +282,7 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
>   {
>   	u8 tmpidx = 0;
>   	u8 bResult = false;
> -	u32 efuseValue = 0;
> +	u32 efuseValue;
>   
>   	if (bPseudoTest)
>   		return Efuse_Write1ByteToFakeContent(addr, data);


I propose to remove all lines with efuseValue as it is dead code.

Make a v2 of this patch with version history below the ---

Thanks for your support.

Bye Philipp


