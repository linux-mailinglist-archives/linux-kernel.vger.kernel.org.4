Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF26DA17D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjDFTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDFTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:35:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083BE72
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:35:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-503e71247bbso22193a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680809756; x=1683401756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aMy8PktJ2aJ10teNXP10wqqWlTdBdIzTbHlbEeFkSs=;
        b=jxmUEgB7LiuifZ1IuGoqTcbqrZG/zQqFaoz5BZqs6Jt2jf3yQ1FtaNrYO5nnjHlfjN
         iqhUovts0pfqwWAVzR3Bn8yiBuPg+PYi32niQv30QxDtuOiKSZgnLXCZRg3mh7LUanmw
         KGmuT153qTlYCt/b6lcNgWDKb4jGz85XV0ZaezF/Reun3QbGdr7AA7DRH2aa0QJbQWLB
         //zjYOFA+GII4Gdr8rP9SxDB68ELZj9YEZPe6BAIbURu/R2jrLFzaLwtlbRF7XJeOj8A
         wPK5dw+ZViX1fymgOwYBFf73Ds0yyMYoUvWu8nsAd2hgEP/MXVhNO8/W5tL1erYFzqru
         7bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809756; x=1683401756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aMy8PktJ2aJ10teNXP10wqqWlTdBdIzTbHlbEeFkSs=;
        b=I80Zubd3Qa+2vboSGpYCOnFRPQSzCqP3gVe/2zCuJTE+x57Zra685EHRH7Wyl0vbXh
         lvFAiUGvD/sXTM3/QqAGkY7c//UJk/stwprlJwrroFDFju35uDizYasz8ncsdYsoOFxP
         N1ofKAZWXmUhS4fTxQwqwqjfYHFKWA+L48+z8cMk1H3ady+3Z5d8J7XhQ9KQjUoslIsw
         Ty5XbQ+t2k/lpdBAbjkX0ougndWAWGezUN7zC3XZYcvO0o2UjDPTEXoe0uMu3Rrhza+I
         GZTnKjRRk+uc82NOU+ZnVA52NW8dg1Ycr74KB2QjdG5QNZ1oTNBNwE68WcbEQtcEEnpM
         UJ/A==
X-Gm-Message-State: AAQBX9eynwIWEksfoSJViDBZVjKWd7NjH/qTUzv/GnIrOX4sFwySb6co
        nLS6a8yys35Spg3N88hT90RqGhfluFb2jg==
X-Google-Smtp-Source: AKy350ZZpZ/vAiNw6nyXDZzK94bTzbGCYpglrN1rSNejizwSVBg5Qy17tXKO1AYdUfx7lHMIgJUrOg==
X-Received: by 2002:aa7:9483:0:b0:627:fea9:2060 with SMTP id z3-20020aa79483000000b00627fea92060mr61616pfk.13.1680809756094;
        Thu, 06 Apr 2023 12:35:56 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b0062dd993fdfcsm1718945pfb.105.2023.04.06.12.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:35:55 -0700 (PDT)
Message-ID: <faf0b76d-b7ad-0326-1058-ae879167d6db@gmail.com>
Date:   Fri, 7 Apr 2023 04:35:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/5] extcon: Drop unneeded assignments
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-6-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230405152745.24959-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 4. 6. 00:27, Andy Shevchenko wrote:
> In one case the assignment is duplicative, in the other,
> it's better to move it into the loop — the user of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 50c5fd454488..88ce0656d23c 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -245,7 +245,7 @@ static DEFINE_MUTEX(extcon_dev_list_lock);
>  
>  static int check_mutually_exclusive(struct extcon_dev *edev, u32 new_state)
>  {
> -	int i = 0;
> +	int i;
>  
>  	if (!edev->mutually_exclusive)
>  		return 0;
> @@ -1246,7 +1246,7 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
>   */
>  int extcon_dev_register(struct extcon_dev *edev)
>  {
> -	int ret, index = 0;
> +	int ret, index;
>  
>  	ret = create_extcon_class();
>  	if (ret < 0)
> @@ -1255,7 +1255,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	if (!edev || !edev->supported_cable)
>  		return -EINVAL;
>  
> -	for (; edev->supported_cable[index] != EXTCON_NONE; index++);
> +	for (index = 0; edev->supported_cable[index] != EXTCON_NONE; index++);
>  
>  	edev->max_supported = index;
>  	if (index > SUPPORTED_CABLE_MAX) {


On previous version, I already replied the my ack.
But this version doesn't contain my ack tag.

So that 
Acked-by: Chanwoo Choi <cw00.choi@samsung.com> again.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

