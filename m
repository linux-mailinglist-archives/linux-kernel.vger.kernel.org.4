Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9C620BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiKHJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiKHJLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:11:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE94183AC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:11:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g62so13237236pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRKV49RtI4t06gBNCIkuiW6giDB9Zs5tU0YwgFHAQ9I=;
        b=A5iclJj8bB5EX4XPb6T391tNql9/mwYiP9FSSOlr5xCXDVlY3thYs8+OCJSEqT9KZR
         MFPb9sXi+9QZwIQzUfCOdzv4T7YmF0wiOs8lq/itbPTG//CopLb6SmwPus/f8UhfZr9B
         2dmBKHaeCV9C0Fj/BAVgkS18tVOAJiRb+obpN4WRQIzqVkKNhsYiEhEC2jqqihpljGYf
         ycgxO7UTr3lSd7rQSE2yGek3H7jbxUDkEJZ6W56R5mpQKSg9RwtYYmKqR/MkpHxRv5Ce
         D/FBVpI74ASmNv14BG+zQQdZV2KPTSokJNrxjwygj623vxAInuCydsOvsOdzLQhk01vD
         M1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRKV49RtI4t06gBNCIkuiW6giDB9Zs5tU0YwgFHAQ9I=;
        b=xWHI+nmc3di8zK/3z+wvYBMx25rWkVP2QflbPz7RV8OfqWQ7Ul1kVWOVjo5Kp2sgOU
         M6whM6y7M2jlNu98ZEuxpOFe2LOl37Jc7ZyfQcg1m8s7WhukE9qwb2H69EBrJ+6sBxG8
         OPi1BhkVSrQlxNjzrtnognfmfNtPuUtHmxvogHDLnEIh6qjEqajsSuMunKTrjXrhcJ1s
         SPMgNIb7dgxSbxnk7Lqz2Mubs4pT/VbVOyc9YFFXqzo6J95jMFJzNHb22U0sIg3lJnRa
         +bE4ON5Vqq/ngRcaRyWbBnySl8exqEy2dLwsmxwuAeSFB4U5LbX8NbRybiVTu5oCkaZ7
         EycQ==
X-Gm-Message-State: ACrzQf087mkJT7vkuOvx8ndXfC9sbBCEgYKI/gtyRmLRquxFuomzxgoq
        rM4jb5vIPEec8tZDhuh4xIY/zNS1p4cWLw==
X-Google-Smtp-Source: AMsMyM5v7FKB6HKjO3RYKKttn8DsE+8IkK5A4RYSarKkAG9Favldp3lQ+AFGCI33aMNBAF8GtY9Fog==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr48937524pgc.616.1667898678521;
        Tue, 08 Nov 2022 01:11:18 -0800 (PST)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b00172fad607b3sm6401146plh.207.2022.11.08.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:11:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id BB0E3103FE4; Tue,  8 Nov 2022 16:03:45 +0700 (WIB)
Date:   Tue, 8 Nov 2022 16:03:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dalias@libc.org, ebiederm@xmission.com,
        sam@gentoo.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <Y2obcdsvOE00v8ue@debian.me>
References: <20221108060145.224880-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221108060145.224880-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:01:45AM +0000, Pedro Falcato wrote:
> This patch fixes memsz > filesz handling for elf interpreters
> and refactors interpreter/program BSS clearing into a common
> codepath; it also fixes problems where a segment after a bss
> could overwrite our bss clear.
> 

Please describe your patch in imperative mood (that is, write as "Fix
memsz > filesz handling ...").

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
