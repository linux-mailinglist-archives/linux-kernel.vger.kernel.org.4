Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8461E8B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKGCzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:55:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DDDF10;
        Sun,  6 Nov 2022 18:55:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k5so9303555pjo.5;
        Sun, 06 Nov 2022 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWOoCPraIwKfT3TJ2UGqA8BagIEiXV7VcCLfAdgHcas=;
        b=h5CuqOt9UMbb8pINbacScKFwgI4Ki3Ph8JYaNPx52uZwSKkj6zmSJoWfBasg9PZN/y
         AvHz7nbYC1DsbeUpFs/cgkfHaCBsW9iHbZ4pRMWI0K0snMMtFoDgtjpQvvOrCY79HMcH
         clHQhYqiSrPbqDUqDai7SWgYVbChL6dcUearVCGuPinzZKT5TDUWO52kbGJYqGTCiWKQ
         8zr+vGYFkY6K6tTrDMDktCPxTRcLpMvRZ4GO5g4UtQ/2shNCq5uyFxomNXoCeFKbhsEg
         w8zi78RKDrpnWwvTtP/NFyWtA2BuEr06V9OuuMo92LdyOj8wBRvpACMtbzKRzkSntv3L
         zs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWOoCPraIwKfT3TJ2UGqA8BagIEiXV7VcCLfAdgHcas=;
        b=34i5EOIUj0SacUV+CcnKPQyMT+8edJDQrEDMLQq6CzOt4u1ShBSqoN9PLfw53uX8jR
         lsIV2LaUnp6SJ/TMBnEWWfkcpbolXFZ62R46s/o/OmD7BjKPQh5O+M6jXFntv8t1vZbV
         Zm+RlM610q0pDA5WLEn9vqI8T7oPinHAmQU0QThwmQVscpksH9CWkgxKJi9AEMT0rnwA
         amjGr9aEnSBItDa6h5JNrrLTPIZ5wB3jboKz8YnTHO5nMBNCqYs7Fg+k5vNnVNiAm8AH
         gL57tt6mq68VyMFYWtyfV22lZ9uUFOYpcW9cu8sqkuqXMoq8odNKQvV3QbrZSau1OUl7
         ISGw==
X-Gm-Message-State: ANoB5pnkrYDi12+mLLquCyE1iob7a7+TnTd5pZbx8DPk6TYnfWxIjLAI
        RFbs3Yd6O5sr58TYJnYDf4w=
X-Google-Smtp-Source: AA0mqf5jDapJui4VBzarerUQi6R4XZ5/ZzYjPi4B3w2KuxTJKcAjPn9b+PpNdbqfiFQ2iY9N1B0xCA==
X-Received: by 2002:a17:902:bc49:b0:188:760f:d843 with SMTP id t9-20020a170902bc4900b00188760fd843mr8958398plz.111.1667789736161;
        Sun, 06 Nov 2022 18:55:36 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id v126-20020a626184000000b00565cf8c52c8sm3315179pfb.174.2022.11.06.18.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 18:55:35 -0800 (PST)
Message-ID: <aebae1eb-ed56-00a9-101f-c4e5ab0af91a@gmail.com>
Date:   Mon, 7 Nov 2022 09:55:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Documentation: riscv: tableize memory layout
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
References: <20221106100239.53704-1-bagasdotme@gmail.com>
 <Y2eY+LulWaKm7MHl@spud>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y2eY+LulWaKm7MHl@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 18:22, Conor Dooley wrote:
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>> +   |    Start addr    | Offset  |     End addr     |  Size   | VM area description                                      |
>> +   +==================+=========+==================+=========+==========================================================+
>> +   | 0000000000000000 |    0    | 0000003fffffffff | 256 GB  | user-space virtual memory, different per mm              |
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>> +   | 0000004000000000 | +256 GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical      |
>> +   |                  |         |                  |         | virtual memory addresses up to the -256 GB               |
>> +   |                  |         |                  |         | starting offset of kernel mappings.                      |
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>> +   |                             Kernel-space virtual memory, shared between all processes:                             |
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>> +   | ffffffc6fee00000 | -228 GB | ffffffc6feffffff | 2 MB    | fixmap                                                   |
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>> +   | ffffffc6ff000000 | -228 GB | ffffffc6ffffffff | 16 MB   | PCI io                                                   |
>> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>                                                         ^
> Will these numbers remain right-aligned in the formatted doc? They were
> aligned before in the text form & no longer appear to be.
> 

These numbers also become wrapped in their cells.

However, in order to fix alignment of these, custom CSS is needed, similar
to one in StackOverflow [1].

[1]: https://stackoverflow.com/a/7351383

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

