Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1059C627D87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKNMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiKNMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:19:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4621E;
        Mon, 14 Nov 2022 04:19:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k2so27886572ejr.2;
        Mon, 14 Nov 2022 04:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kyboqkdwv0OhgycEnHtFn4SdfDb9/t65Yq5Z3sJmWv8=;
        b=BacPVNduzXzHiWNKDcrUSJ/GNskhguM7M9Qw6d8zFSxyDyDJkS8FxJKfixfW940QBV
         iVlVX60z3GHCuGxE1WLxHgROt6hxHqqewxyye4P8cU1azburAv9CpxWbDA8MLz/DO1Yq
         ExRc4gSjjK19F4/+L2wtG4e/Sn6MzfcP7bHM4N/lmClTlxYwZ19YqY9aM8P+VjatBZbg
         48zwZlEN9WFO75tGUDi1CdQh/2FSX8F+D27H2I9MeXBq4HeJCXGy52XVRt7zTlm84Rod
         ktGcSu3thGkDyJB55CtqILvHvgkvSWjbHnADHQb4Lr56gesZXTWPXLe0XV8ANuVqrRmQ
         sL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyboqkdwv0OhgycEnHtFn4SdfDb9/t65Yq5Z3sJmWv8=;
        b=E3ReYZf4I2tEEKONmJTWdqC3vBKfngU6cKIIt3yxseBVehFDm297ut+duXxZZ+grPa
         NLbwf/VPlGsfxqYWhYZDYhKnPLPSBmquYxhgoGxgD1xOOwEDdbtRqJr33LZQDGBMwUhb
         LsxADRFFSVEr4nnRLt2pc7oNmWxI1VC5kG0aIoGFdc8ouEKlD5ea3rt5V9MgEQG4yk9K
         ffubB2evXh41cGt59voMa7UrHQhc8m/3lkov+tbh1smsmopbgcXm4qWh14VYUpKsxN+h
         cd5Kkg72P/Zeq6AOXj8eI+UlHBAbE2mwLUS0GeqlZh1H/Y8SdH0h2K5CqrvPLG4UxOPo
         YcjA==
X-Gm-Message-State: ANoB5plRhFbYtSv+5ssU+MhhL3INy6OfhBkQ4Q3t3rc8rPI0EnddHnXE
        7YcQ03eDOiE6bxxeTTRHOp4=
X-Google-Smtp-Source: AA0mqf4DHbD5xi+MRHL67ABY9bt89yn791QAYtS+LhwdkG6DVo9Gm66dL8R0yk3d0BwDyyqMcrJRog==
X-Received: by 2002:a17:906:7c8d:b0:7af:1233:948d with SMTP id w13-20020a1709067c8d00b007af1233948dmr869528ejo.698.1668428370400;
        Mon, 14 Nov 2022 04:19:30 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906768900b0078df26efb7dsm4083201ejm.107.2022.11.14.04.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:19:29 -0800 (PST)
Message-ID: <4e205f57-673f-bd7b-1c04-5f3c8db0b054@gmail.com>
Date:   Mon, 14 Nov 2022 13:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] ufs: core: Remove len parameter from
 ufshcd_set_active_icc_lvl
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1667399353-10228-4-git-send-email-Arthur.Simchaev@wdc.com>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <1667399353-10228-4-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur,

On 02.11.22 3:29 PM, Arthur Simchaev wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index aa46292..9cc3abd 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7386,7 +7386,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
>    * Returns calculated ICC level
>    */
>   static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
> -						const u8 *desc_buf, int len)
> +						const u8 *desc_buf)


'len' description of 'ufshcd_find_max_sup_active_icc_level()' should be 
removed as well.

Kind regards,

Bean

