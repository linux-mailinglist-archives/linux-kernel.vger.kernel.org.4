Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619755F6D31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiJFRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJFRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:44:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95C2A97F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:44:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l22so3886342edj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gNQoC7Wql533/i6PEr6vVJ6voNwKK6BkxbmL0tsbQvs=;
        b=N75m94E+t6OiU5sjq9WXvskIO2PalAI6t1ATsn6e5nLieEigRrduinFUFF8l+ZdBA5
         txCgP0pTXoUiM05Ws11NN/WhnwYwgZd8jaha2PHWl52NDYY4ZM4VzDn0Tz4s/qAttKqu
         K671b2CiVQMtqVfsTrRyzeHvCoa78AIcJA7mRlSKdF3wTv9RVkU2qUZ8gon/Y1+o9a4L
         tAr9rhL1yUqkVx7FOl6J5pt0LNNU7YjJKufUOTcxBLWSbjrBy8PG59MaQi3FvRrpMHEM
         1VKhlGeAr33LpVVdsLVqGvkBB4/dQWO2zIr+4nJ0Fog43UZY0aoBoeJO13Qus2lEXMXZ
         A8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gNQoC7Wql533/i6PEr6vVJ6voNwKK6BkxbmL0tsbQvs=;
        b=W9Zbc/xX7/8byi6l6FdPSu0Pv4JFvACda1kGgJT6CId372aR2F4rudbqHnMcvXf+Di
         PwUTzqLHDCcvlgxmAYPyNKR2AGz5wLc7Zj31l4lEMgj6AP4MS71Is4Gou7iKmtIMC16s
         tStPjbLoSLmnetGTm5mtmjVIGu4W+lNOzFhXEZUd0zjIYp3xHHp1sNoRju5hjU8K2kZ7
         jYYa7XqFTIF9M1u7T///WaS5fGorycMwvh16OtX8EVp2BAnVwVl5PJRF2BLn1TBWKIG+
         9kWyVm/QO+K22oemytYhHLiJ29vk7LPdNOOI9nI33JxbasPhAiZkqENWP/piogdmbMR9
         8WSA==
X-Gm-Message-State: ACrzQf2ZMQMSHOhhY2T0aVIlN13cLqHM4DH9dLAUlGNcHQKueczjW8eG
        IpRcyC+SaGQSBeU6HqbPjUQ=
X-Google-Smtp-Source: AMsMyM5cTnZjCFVqHBG1q1ZYxN5IVqdeUyVIs+7qSpAmSMnf1GR1/u1FY3znGi5TJjC76f52tycygQ==
X-Received: by 2002:a05:6402:70c:b0:459:7b65:fead with SMTP id w12-20020a056402070c00b004597b65feadmr874172edx.209.1665078290885;
        Thu, 06 Oct 2022 10:44:50 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061e5000b0078d46aa3b82sm26457ejj.21.2022.10.06.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:44:50 -0700 (PDT)
Date:   Thu, 6 Oct 2022 19:44:36 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Brent Pappas <pappasbrent@knights.ucf.edu>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: most: net: Replace macros HB and LB with
 static inline functions
Message-ID: <20221006174436.GA8933@nam-dell>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
 <20221005235728.GA118549@nam-dell>
 <Yz7WVCzAviUYstX9@knights.ucf.edu>
 <20221006134230.GA14040@nam-dell>
 <Yz8KKkZ18svZdeec@knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz8KKkZ18svZdeec@knights.ucf.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:02:34PM -0400, Brent Pappas wrote:
> Replace function-like macros "HB" and "LB" with static inline functions
> to comply with preferred Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>
> ---
> Changelog:
> V1 -> V2: Resent diff from a mail client that would not replace tabs
>           with spaces so that patch can be successfully applied.
> 
> diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
> index 1d1fe8bff7ee..8a8fbc274b73 100644
> --- a/drivers/staging/most/net/net.c
> +++ b/drivers/staging/most/net/net.c
> @@ -36,8 +36,8 @@
>  #define PMS_TELID_MASK		0x0F
>  #define PMS_TELID_SHIFT		4
>  
> -#define HB(value)		((u8)((u16)(value) >> 8))
> -#define LB(value)		((u8)(value))
> +static inline u8 HB(unsigned int value)		{ return ((u8)((u16)(value) >> 8)); }
> +static inline u8 LB(unsigned int value)		{ return ((u8)(value)); }
>  
>  #define EXTRACT_BIT_SET(bitset_name, value) \
>  	(((value) >> bitset_name##_SHIFT) & bitset_name##_MASK) 

Sorry but I still can't apply your patch :(. I think you accidentally
added a trailing space character (at the last line).

Perhaps it's a good idea to send the patch to yourself, download the
email and try applying if it works, before sending it out.

Best regards,
Nam
