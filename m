Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B905E90D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 05:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIYDST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 23:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIYDSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 23:18:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D33FA1D;
        Sat, 24 Sep 2022 20:18:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so3439283plz.7;
        Sat, 24 Sep 2022 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kuz/GOrMapxuXyB0qQ7jVy9p2TUC338A3EQIQqE+Dbo=;
        b=NR9uaVLnX9nSCXWW5kWcWKgSToZGto5dMmSXiu9RyAJvzLyLQik7XHMrbCZwAQ4jZE
         xvJ56juHMTOwES1t47WJA+6ljFK1aCMZPPk16LTN/ciZmjO3QU8WmUj6K9Nam6pQF73n
         C8hKseiqJ/0xCzMsRcGKY2EEPIKAqMvIKIiFg0vmzuniBDMxWv+ADLR9sJKmKz4eJWlW
         gezM4zatWLg+/elQI50V6SWX4tRlx1CIehhiCJgUs85GDpvPOpPA9y0TPUKozEVcnZ7A
         46Ku/3mQWcDJLnreRXGEj9If7dCUbPaA8n5W8lYKHTCGFsViCT1BXEejIwIETKLRXQj5
         EDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kuz/GOrMapxuXyB0qQ7jVy9p2TUC338A3EQIQqE+Dbo=;
        b=JS9hkxrkrE/6JmMNfdEhOCn6QAtJVMVZQoHOzgrBvXROff4lDGdpFNYlNzswB2lUzS
         Zzyuir69t4hQwincUiNPGPpvtwmVGfDakmqRYtKkl8f+dXbbk5Zs6ShrwO8qftngg7Uq
         56G5835X/OuOE+EKhbLte1EIZeXqjQZZ3pPvM+Bh34Apmi0vGTq8JUrhwu7pTGApN5Uj
         JkQqbg0Y8jrtUzo3Z6gMuCHhYkbCRp3P2BDW2SyW09+pDeWYHIetCTla0IWAZyDYpN9+
         E1H8/D98CtcFG9gvnC8Gn/1kWiDiZ85FxtGWxNlG6g31pqpXa0uQK6wGgI77Ap+c2fdz
         4SkA==
X-Gm-Message-State: ACrzQf1r3TQVDwH0W0zqe+W21MSPFiRvgO28+49DEBPhRlHBB/oTDA2s
        dN8dIj+chgpIOaB6mvZsDdx4DqEqX5k=
X-Google-Smtp-Source: AMsMyM5wHNqyZdqMvLRG2v1Z6fI+OMjV17jTpCCBJ6bItYI953tauphD3ULVbl8pAx3mH6nFDpge+Q==
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id j6-20020a170903024600b0017996b51ad2mr15545473plh.37.1664075887845;
        Sat, 24 Sep 2022 20:18:07 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b0053e7293be0bsm9075020pfb.121.2022.09.24.20.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 20:18:07 -0700 (PDT)
Message-ID: <e97ff5c9-6ffb-08b0-0da0-8035fe2dc877@gmail.com>
Date:   Sun, 25 Sep 2022 10:18:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into
 the core-api book
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
 <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
 <87a66qp5vn.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87a66qp5vn.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 20:39, Jonathan Corbet wrote:
>> Shouldn't warning like "This documentation isn't in RST format and included
>> as literal block" be added?
> 
> Why?  Who needs that information and what will they do with it?

At least readers will not be surprised with the anomaly...

But anyway, for consistency, I'd like to see these *.txt docs be converted
to proper RST.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
