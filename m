Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9F735E22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFSUEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFSUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:04:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FDE7B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:04:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3110e74bf3cso827488f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687205083; x=1689797083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utfzAfD9uQaomS9zVilPr/sNC1+E5wKO0nFMJD3LaqM=;
        b=azY1rPn1no8Z//8qYjpF1bROxbf51Ks2JJ4GFxxjK+1Q0K+9t5sAyFPFOXbdcnsptu
         FrdEcCEK343U9K7xcce3t4CZL5t3kbh97q05yFwlKqCAWbb1a1YmnoVFqytfVrU3b6Yk
         zygAgpQtqYxQfsxdMUEttOERaCPwbH4xkxwXpy+mRgJEVBr44HVM5lDGD56IDF2PpURQ
         s/m0B7gVlEjL+cfeNeW3YNsS9U5rLiXb+A6NM2YKYlb/4uSUTS9k1dEjuclfGhiYfqM3
         XAKz3LrQrxSwN0lJIo+lqMwXn4aRgMG/qcHhLRKI58STNJsdINZ4CV5UbDfcGKv6CvjB
         TP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687205083; x=1689797083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utfzAfD9uQaomS9zVilPr/sNC1+E5wKO0nFMJD3LaqM=;
        b=YXXb7IQkKzqmtGcqXG0EPSSebBdHQx3azeB6qPaz/6GAQxRiqNIDhfT7rfgKLlX7Oe
         tEZRlvz+rvDCjthO+OtU6PuM1lEABNABtcu5YURCdvK44+acCfxNyxTZIf1dET4lSaCT
         HzjsFO4fN2cZV02BOaR6++duLtyyeDhtGuo5G4Ds/QaFnWuT72IAldT71YlVJtRDUXwh
         9gJwNuXyfvwodtbE6iV8BGswzYC+unIfWW8eyAGYm4sx0n/EkR6fmtEOpLyQnBz1X34m
         F6BpSrIAocTss1v6ArvHzPPn28E+7in3PCX4f9SUvNr6FTQ+EeFGAWc/A2g1sBzxUqi0
         d5aQ==
X-Gm-Message-State: AC+VfDyygdQ5xhc1cS9cbxu/4mLAWXOcfkDEM4TIL5T1GlI4HOIwdx6Z
        jQK3wcal/6xZ/BItyuC9XBE=
X-Google-Smtp-Source: ACHHUZ6oMBQbOjPAMKwzptasv40n9lbBqGcxTnz7BuepyB5gz8HVSSPxlGX04g1xzgGVU5FykZA1uw==
X-Received: by 2002:adf:e447:0:b0:307:cf5e:28a9 with SMTP id t7-20020adfe447000000b00307cf5e28a9mr8014373wrm.5.1687205082927;
        Mon, 19 Jun 2023 13:04:42 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600011c800b00311339f5b06sm346783wrx.57.2023.06.19.13.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 13:04:42 -0700 (PDT)
Message-ID: <6411c15d-9e22-5a58-0e1b-d18654acc127@gmail.com>
Date:   Mon, 19 Jun 2023 22:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: remove 5G related code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230619155203.6039-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230619155203.6039-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 17:52, Michael Straube wrote:
> In previous patches we removed 5G code since the hardware that uses this
> driver does not support 5G. There is still some 5G related code, remove it.
> All the removed defines are unused and we can safely remove "N-5G" from the
> rtllib_modes array.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> Compile-tested only, due to lack of hardware.
> 
>   drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h     | 1 -
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
>   drivers/staging/rtl8192e/rtllib.h                 | 1 -
>   drivers/staging/rtl8192e/rtllib_wx.c              | 2 +-
>   4 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> index f4d4b01630a2..09f8c76b7e65 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> @@ -159,7 +159,6 @@ enum _RTL8192PCI_HW {
>   	WFCRC2		  = 0x2f8,
>   
>   	BW_OPMODE		= 0x300,
> -#define	BW_OPMODE_5G			BIT1
>   #define	BW_OPMODE_20MHZ			BIT2
>   	IC_VERRSION		= 0x301,
>   	MSR			= 0x303,
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
> index 65365ebe4e85..24fb0ca539ea 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
> @@ -266,7 +266,6 @@
>   #define b3WireAddressLength		0x400
>   #define b3WireRFPowerDown		0x1
>   /*#define bHWSISelect			0x8 */
> -#define b5GPAPEPolarity			0x40000000
>   #define b2GPAPEPolarity			0x80000000
>   #define bRFSW_TxDefaultAnt		0x3
>   #define bRFSW_TxOptionAnt		0x30
> @@ -284,7 +283,6 @@
>   #define bRFSI_ANTSW			0x100
>   #define bRFSI_ANTSWB			0x200
>   #define bRFSI_PAPE			0x400
> -#define bRFSI_PAPE5G			0x800
>   #define bBandSelect			0x1
>   #define bHTSIG2_GI			0x80
>   #define bHTSIG2_Smoothing		0x01
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index dbf78b60dd78..e3ce4431d460 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -427,7 +427,6 @@ enum wireless_mode {
>   	WIRELESS_MODE_G = 0x04,
>   	WIRELESS_MODE_AUTO = 0x08,
>   	WIRELESS_MODE_N_24G = 0x10,
> -	WIRELESS_MODE_N_5G = 0x20
>   };
>   
>   #ifndef ETH_P_PAE
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index 538cedb1dc02..e9469bfef3dd 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -19,7 +19,7 @@
>   #include "rtllib.h"
>   
>   static const char * const rtllib_modes[] = {
> -	"a", "b", "g", "?", "N-24G", "N-5G"
> +	"a", "b", "g", "?", "N-24G"
>   };
>   
>   #define MAX_CUSTOM_LEN 64

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

