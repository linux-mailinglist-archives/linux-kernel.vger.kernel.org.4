Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26495E83FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiIWUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiIWUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:39:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1305147A39;
        Fri, 23 Sep 2022 13:34:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dv25so2939637ejb.12;
        Fri, 23 Sep 2022 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VmgX+fjoMHC6FBj30b+WDagqCD2u5DEqG7CNMTWsUaw=;
        b=aylNBietlRzBDmOfNaKORFCIktnF6XHELj6WTNK/b6hLMlRfP2tjETvNiEjqhYz+Ip
         0f1PGttQB9rxTnjpQSBITsWn5KYzAnLO94nOKSMJjnLbpi8fg8zMEGRH9u7YX+0aIOjh
         FzIN4hdvqXHPvwYwtFycR9iQppF7eu/dyVy0Pj57NUou2iK2Dq9Re2/jMoF4MThLf9xl
         zEp6SadgMZ3iEZHKBivJppNHghiYH5AYCMQXtoWYx1Ke8Qhxrz5TpDWzNTIPSHcZT62T
         7Eb2HTVJxdM3yqUu0Kipb4kFE9o2I2U4u/UEv0nxQ/OdwmJgGxDmsOTtwd0aYXVWhS8z
         AA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VmgX+fjoMHC6FBj30b+WDagqCD2u5DEqG7CNMTWsUaw=;
        b=B5ZsxYSGWq6p4uaOAuV7Mvqm/T7xZw+9/6O8/zrLiX4aUMyJ4UCZ/bNERKYDvNFNZl
         gouKjzCTzekQx42YlfUz0fKo/lm6FarER9hqPF/pyv4HApW3JBNg1vURVVgvAjD6qOCy
         jPLcjSDFLhhPdSv7EpDvB1NHp+DhaG+3OWVQ3aR8A3Xar7t7LKHdjFez9PHplAHsaRt5
         BDspgrsu/9ZYH5UKd473sYZT6qwhfDXQAP07cxn+/jyurNJT6nPswBUfXza2BfCJvsX3
         +fglR5awZ/t1PkhDAdMSJQZZiEma/Rua3YT9W5Sq65JqEzwaO7Jbr2CgXjjKagY9uBOd
         S/GQ==
X-Gm-Message-State: ACrzQf11Iu/LRwKzeN2A5APtMkimCi5Sn2UmP22UMcJ4ZIXnnkEq8vSN
        42MFLRz+7HGio+syAZde6pg=
X-Google-Smtp-Source: AMsMyM4szMWjJgeYev5x2W8PW+olmJI3ESPL6MQSfEJbctdC//+dQuKYMl1Werl1OoDiWi42gg4Riw==
X-Received: by 2002:a17:907:9714:b0:782:6cb6:f53d with SMTP id jg20-20020a170907971400b007826cb6f53dmr6853035ejc.567.1663965259827;
        Fri, 23 Sep 2022 13:34:19 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:aa4d:dfcb:6827:51a9? (2a02-a466-68ed-1-aa4d-dfcb-6827-51a9.fixed6.kpn.net. [2a02:a466:68ed:1:aa4d:dfcb:6827:51a9])
        by smtp.gmail.com with ESMTPSA id y88-20020a50bb61000000b0044dbecdcd29sm6081603ede.12.2022.09.23.13.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:34:19 -0700 (PDT)
Message-ID: <98ab696f-c3fe-c44c-b731-6a3f8e76721c@gmail.com>
Date:   Fri, 23 Sep 2022 22:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>
References: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
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

Hi

Op 23-09-2022 om 18:30 schreef Andy Shevchenko:
> It's late in the cycle, that's why I send these reverts, so we will have a
> full new cycle for testing a better solution if any.
>
> So this is just a proactive move if we have no solution in the nearest days.
>
> Andy Shevchenko (2):
>    Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG
>      -> peripheral if extcon is present""
>    Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is
>      present"
>
>   drivers/usb/dwc3/core.c | 50 +----------------------------------------
>   drivers/usb/dwc3/drd.c  | 50 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+), 49 deletions(-)
>
For the series:

Tested-by: Ferry Toth <fntoth@gmail.com> # for Merrifield

