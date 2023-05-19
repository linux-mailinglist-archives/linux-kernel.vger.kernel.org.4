Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFF70954D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjESKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjESKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:44:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100510C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:44:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso1059202b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684493050; x=1687085050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vPRMKoBSYwEmSQiIqn8N3h2CJEd2utExeYY2X/5miY=;
        b=UqfkYbM6YPUOA6V5+6XdOFaNW03ZMKOrqlu8r0OjS0HN7OlYvKfz6LvvIhZt3DeJz5
         eNuwsC55Z+78mVEMgQsm9T7ze/42RUpfNspG5OWz8MIUIN1E0wn9BwsiB92eTjM73qEr
         5wP/cOTZVhHeGWmZiqY/R7JKpXCTFN0EUemSonWjNBI1FWWCQdR0LRuDvz9NlXgX828a
         LWebP4DjIs/BpNsaaaveE4/B1U/iem4Ik59DI/nhQ59wrO7Bt3xWA3an4yhb3zCnC6Fn
         b93xZzfZQxpELOHw3MHXXlSGYELyyWPMPokGoz8dlDRSOyIqDG3sE8JJwi8H5P8LHxgP
         fFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684493050; x=1687085050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vPRMKoBSYwEmSQiIqn8N3h2CJEd2utExeYY2X/5miY=;
        b=IWNAvfnUpffZZBi+75viMCtDZXXHrvgcbBQzcYCLz4AJAzEZP2YAcixb6882l8/vJD
         Qi3ARIlYdN0WkPgKiMhIlklVFHni5YDfyisGB5sVOeHAdvhfD8DXAIlXko/ydmcOnbBa
         fuAMggrnDcvBShV8Klv8hd+8DeaX/GkQCtJESfVRwEXkAqE8Stbj/X5m2Kz1hAiwG8PE
         Zg3uVmfxJSqn//5mS7MEQSUXV9YwoCqkxOR6QsalZfTyhe/fnmS9cIHRueAWQozWoyez
         MltZbFChSjMrlZy+cWDx29HwHOdfL/vZ6u1ygeLn/x8JBoyFfK0TPUo3xkh71ASbpMrf
         ljUQ==
X-Gm-Message-State: AC+VfDxhfao4FikJ/v2U0agqOOZserJTt7UsWQFsPHvKmFfG6Zs6jrLV
        y9+Jjyt08Cf28k1cyN8VfbM=
X-Google-Smtp-Source: ACHHUZ7URiaZ3JHO1cHHFrS/y8e4tQiQEVtX+fqk0dWqf4cORzgRPu3IS9Rqm95eodLHbmJYm8viPA==
X-Received: by 2002:a17:902:bb16:b0:1aa:ee36:40a5 with SMTP id im22-20020a170902bb1600b001aaee3640a5mr1824144plb.34.1684493050578;
        Fri, 19 May 2023 03:44:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-22.three.co.id. [116.206.28.22])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090331d700b001ac7af57fd4sm3135743ple.86.2023.05.19.03.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:44:10 -0700 (PDT)
Message-ID: <623529dd-37fb-9706-63f5-a217d3376f86@gmail.com>
Date:   Fri, 19 May 2023 17:44:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] SPDX conversion for UDF
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20230517083344.1090863-1-bagasdotme@gmail.com>
 <ZGWm7oCXr69jGOlp@infradead.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZGWm7oCXr69jGOlp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 11:17, Christoph Hellwig wrote:
> Shouldn't this include a Cc to the linuxx-spdx list, especially for
> a review of the odd ecma_167.h clause?

Oops, I forgot to do that! Will do in v2.

-- 
An old man doll... just what I always wanted! - Clara

