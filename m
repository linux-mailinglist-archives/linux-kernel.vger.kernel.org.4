Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D16EAA37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjDUMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDUMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:21:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1286B0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:21:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so2735007b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682079699; x=1684671699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8vI3H8Vhti9iIXhtM99KOSVknA/KfjkawUfvqnXKUI=;
        b=G01UQBGronyv47AoOs+I8wiWeAcTN8u5fKiZ82ws+CMKZlKlrOvsRMnJg/Oa0RSV9d
         Y875Pt3uO+GiHGmOyWMpcETxMJO6YM13jfPdlkjKziFvzyGegy/bWkZCQtwJvbhUe/W0
         LNPCPd9qth6GTB2PUzpIgFYvckvlyqw9ITEGhoFUrxz0sDGd7vf/nMU/s7C4LfFVXTvW
         b1DkUne8WZy2fFFuXUyA/tCD2cJBZoW8+QX0kqNdv1pnjvtRZiZ30QM0K4gtEazpKdZA
         cQ5mLaQNRCJI9bq5fj7Z3uv+ZVriGVqT/g5sbUjSbTXaFZQgYw2v/UlJ7y89Uelh8etv
         o96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682079699; x=1684671699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8vI3H8Vhti9iIXhtM99KOSVknA/KfjkawUfvqnXKUI=;
        b=dSdcv5G+pRhTdkqX/4ZpfYuG75c0orGT4kvzFfnYoQ1ebNnm02IpYnqRbKXmn+q+Yi
         L1nyJP/UiZg43W7l3+wHhScqeq3jAG3psO2Bqaox14fWDSq/viIDwjgqJ97GaMuOA/D9
         kV0FrTNRz5YwgJikfRqAWNjdAboUhaUxsAoclIbcUOtyslSkc2E8qg1GY47XChn8fYeD
         mywf8dYCl0oeJs0srWKca+qGBljDt1JD3W33z7DTTlMUiFDASSB8nBH7AGWRl8FWLNPk
         I3UM8GSwBInB8V9FHIhDIAFfQSA6eywDtTQ6AmK6aCHU62cmhW+h64kjKUAtnmYrTffB
         DVoA==
X-Gm-Message-State: AAQBX9d389gDDfmSZvWpAeOtrJkKrJMTDASIcdsdP8ai/2TYUGlebpce
        Hm1jBR0r2+FeyE+3TO702sEVLzImG2LTaQ==
X-Google-Smtp-Source: AKy350afJ36qNyVgx+6yn/CP19OhW+FVTDY01l7DQckmce5u7vWq2vjkXi+Vu34oL7vNqI3sRJyylA==
X-Received: by 2002:a05:6a20:158d:b0:f0:ec64:f3db with SMTP id h13-20020a056a20158d00b000f0ec64f3dbmr6923598pzj.24.1682079699289;
        Fri, 21 Apr 2023 05:21:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00218b00b0063b8ada8777sm2916689pfi.112.2023.04.21.05.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 05:21:38 -0700 (PDT)
Message-ID: <bf4ef6ce-8fa9-57b8-7d18-2a4cbb41455b@gmail.com>
Date:   Fri, 21 Apr 2023 19:21:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: strings
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>,
        linux-kernel@vger.kernel.org
References: <8de1912e-8009-3c85-ece5-7ca7f03be42a@gmail.com>
 <ZEIPKhKNz7LnhM/q@debian.me> <ZEIuh80SfDms30dc@1wt.eu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZEIuh80SfDms30dc@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 13:34, Willy Tarreau wrote:

>> Looks like above link is about hex arithmetic implemented using strings,
>> right?
> 
> It looks more like a reinvention of the classical multi-byte string
> processing (memcmp, memcpy, memmove etc).
> 
>> Also, on what use cases can your idea fit the kernel context? Or doesn't the
>> kernel already have the implementation yet?
> 
> Sure it does, look at __crypto_memneq() for example, or more generally
> at any memcmp() or memcpy() implementation from the last 30 years, for
> example in glibc.
> 

Thanks for explanation! I don't have any serious C[++] programming
background, so I was confused when I wrote the original reply.

-- 
An old man doll... just what I always wanted! - Clara

