Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD06D2D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjDACKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 22:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjDACKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 22:10:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66F9E053;
        Fri, 31 Mar 2023 19:10:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so25335175pjz.1;
        Fri, 31 Mar 2023 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680315035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnyrkYSNqls/jv3SFfexrWS8fA+F90l+8vMjnIu/dDk=;
        b=Zbx/dep8b0wFaQ3ok5UKrG21PvLlbh9WImL3ZchBW30R5/PRXx/buvD7XGh8fSHdAH
         hIIUQv+Nrqf4dM1kpecBU/zS+Aa9wPCOvJdyfT6HaZQsWuE5IkADp/7J17Wh563GZiC9
         yVAHmpHI+qtqVDE64MNHozCweOXEKiKN1ltiknSJK3w4EM/6TW83R8b6KNNb81gfN294
         zLGAGXIAyIkLQngGlR3YHzY4rOvUmnpq94XDrZJ9vRAX9bmXmVGyehyW0WrRuejn4Uhc
         nWiZO4Vwdha5BThGqOwN2RHpdbz0naoOizq7ogefNVxA0p/T8ppIGEVeALfeN1Tb5E8/
         4qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680315035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnyrkYSNqls/jv3SFfexrWS8fA+F90l+8vMjnIu/dDk=;
        b=V9EGAn+lG3gYCVQAx8kbSGurpmxq/w2pBB3M4+sbOWTZIznrGlu07cjbRFySPUfom0
         gSUBScDEJibog6VUVZOD4W6ohXZDxc77uIonZYBUU6myDHZ086IxNq/QI306LIKWXlV9
         ukeZqp7EdkuCuhoIbhcNMufwAC/SbhSOMacecGnqNLaf7exrfoTbpjbl5OFng2iT57gG
         nPfqMLP/bqhQuh9uJf74BzgRkHtX6xgNDuCbTNpMkixOp3Y2EgJDr0px46de9xms/JS8
         C1sksyASfkY0DK3QJRUGEGf5Ep8SuEw9tvjBWaPUHIJ7u+OrUJ/3NG5HI5ZqsAK8b5Kg
         /bvQ==
X-Gm-Message-State: AAQBX9d9qFiaqk30JWf2E3rh5ka48s9LFq6BD+LVUe0XIGeIfZa0YmNZ
        gkh0UNbBHKys/B15Ctl271c=
X-Google-Smtp-Source: AKy350YUq7DoV3rTzX8fP87JGF6Hj6ucie5EV59nAeF8Akr6nPpDbZfLyoj/v+V/DE4bWRR1yjsdJQ==
X-Received: by 2002:a17:902:e546:b0:1a1:cc5a:b04 with SMTP id n6-20020a170902e54600b001a1cc5a0b04mr35087221plf.3.1680315035458;
        Fri, 31 Mar 2023 19:10:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0019f1264c7d7sm2196638plb.103.2023.03.31.19.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 19:10:35 -0700 (PDT)
Message-ID: <f3e29e72-240a-20ba-c301-5b6fe1ec777a@gmail.com>
Date:   Sat, 1 Apr 2023 09:10:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] docs/mm: Physical Memory: Fix grammar
To:     Kim Phillips <kim.phillips@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331165254.207526-1-kim.phillips@amd.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230331165254.207526-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 23:52, Kim Phillips wrote:
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 1bc888d36ea1..df2ed81e3639 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -19,7 +19,7 @@ a bank of memory very suitable for DMA near peripheral devices.
>  
>  Each bank is called a node and the concept is represented under Linux by a
>  ``struct pglist_data`` even if the architecture is UMA. This structure is
> -always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` structure
> +always referenced by its typedef ``pg_data_t``. A ``pg_data_t`` structure
>  for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
>  ``nid`` is the ID of that node.
>  

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

