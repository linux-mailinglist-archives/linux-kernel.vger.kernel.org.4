Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52225666609
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjAKWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjAKWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:10:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD15713F32
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:10:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v6so24368257edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWAq+7S4bzaL37NGYrLUy7knGvmGRAEXn1QIsa1PQRY=;
        b=CUgRp903UFFuaWLUn/a+60HLECCzdq1iDRPTEpWvFFjT0tXI1/zyesxolB+LcIHSTo
         J6aSm2JzR3ttzgLugbarxFvkaNTNrFupFeQu4rDh21lBwOya+ntguVCspgbnWclC+5dy
         sX24s9v5InG7okISzbL9eXULQ+oFTWKfve+eCDx1eIzmdo2wCk//aqTtc5Mfit9fJDnw
         KUGTgscm/iAof31wWPe+g6F5o+1YHQuJ0S9r+ytTI1fD3m67oGi2kwllx9MPBrZeRvdg
         OEOo+MT8Mfq5YYS5l4UxvF93G3FCh0kYJorRwzu8JGwOXbX0WdLqmiCpobQ/qgW1K7qd
         9Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWAq+7S4bzaL37NGYrLUy7knGvmGRAEXn1QIsa1PQRY=;
        b=aoXH/VuUCWwTRUU8oVQ9KAYcBKirKIEe3HlmZpdhaLfdsAghRF6HAF47rE4rHX4tq8
         VwcxjS8Cse0QEMo2iiPjQ8LuWisOQ3veWWoJaAfJMX9RJ+1z3o/cEdNW4EooRYDkTXWE
         nUUXaAwmvXNcmjq9myu2gZN2rc8wClRqL/ciQQYGLuYV7Q6jhal2nfTi9kO+a+ZvbA33
         Orh2WH3H+DjN/Nq7WCn9mzO8Cl/yB0whjSo0OZO1yRvRx1bCT7WsaBDq/DpmnO2YWMCw
         ChDp6lioVvAxv8+nVKteuAhZvcQY+qV2bnitwV5l3DD7BeZyj5H++lKLaDdeBFQKx+E9
         Bwpg==
X-Gm-Message-State: AFqh2krkgjciXsFuxG0klOaGxRUNfnltw1xbo9yox052q8IqRg0UNqTT
        b2qjEzxe7NdG2vGarxrQgWU=
X-Google-Smtp-Source: AMrXdXtvAef1hBS+dF8hlp7VXYkoK3dcpD1BulUM0G4eYmx9a5qBzf1ZttEk5UUGOUwYFYsT95Cl6w==
X-Received: by 2002:a05:6402:207c:b0:490:ff75:7aa with SMTP id bd28-20020a056402207c00b00490ff7507aamr5274351edb.1.1673475027314;
        Wed, 11 Jan 2023 14:10:27 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7c6d4000000b004610899742asm6539866eds.13.2023.01.11.14.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 14:10:26 -0800 (PST)
Message-ID: <8c0502f6-700a-e2f7-5b11-21cb647d6da4@gmail.com>
Date:   Wed, 11 Jan 2023 23:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/20] staging: r8188eu: io cleanup
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230111195640.306748-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230111195640.306748-1-martin@kaiser.cx>
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

On 1/11/23 20:56, Martin Kaiser wrote:
> Clean up structs and function prototypes related to hardware access.
> 
> There's a number of definitions which are not used for usb devices such as
> the r8188eu.
> 
> As usual, this is based on all the previous patches I sent. (I promise to
> send no more patches until the pending ones are merged ;-)
> 
> Martin Kaiser (20):
>    staging: r8188eu: remove struct io_priv
>    staging: r8188eu: remove io function prototypes
>    staging: r8188eu: remove ioreq function prototypes
>    staging: r8188eu: remove async read function prototypes
>    staging: r8188eu: remove async write function prototypes
>    staging: r8188eu: remove struct io_queue
>    staging: r8188eu: remove attrib function prototypes
>    staging: r8188eu: remove rtw_write_scsi function prototype
>    staging: r8188eu: remove dev_power_down function prototype
>    staging: r8188eu: remove struct reg_protocol_rd
>    staging: r8188eu: remove struct reg_protocol_wt
>    staging: r8188eu: remove interface handler prototypes
>    staging: r8188eu: remove readmem and writemem prototypes
>    staging: r8188eu: remove IO defines
>    staging: r8188eu: remove struct io_req
>    staging: r8188eu: remove usb buffer macros
>    staging: r8188eu: pass struct adapter to usb_read
>    staging: r8188eu: pass struct adapter to usb_write
>    staging: r8188eu: remove struct intf_hdl
>    staging: r8188eu: remove struct intf_priv
> 
>   drivers/staging/r8188eu/hal/usb_ops_linux.c  |  34 +--
>   drivers/staging/r8188eu/include/drv_types.h  |   1 -
>   drivers/staging/r8188eu/include/osdep_intf.h |  32 ---
>   drivers/staging/r8188eu/include/rtw_io.h     | 255 -------------------
>   drivers/staging/r8188eu/os_dep/usb_intf.c    |   9 -
>   5 files changed, 9 insertions(+), 322 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

