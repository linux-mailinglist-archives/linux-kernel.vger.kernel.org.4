Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA9605541
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJTB4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJTB4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:56:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF601C20B5;
        Wed, 19 Oct 2022 18:56:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h185so17895956pgc.10;
        Wed, 19 Oct 2022 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjHLcYUUjhD+PtF02a4WQB8SZ/341O9Yc/tHe2HDPA4=;
        b=F5RH8irn44aJjAZHV3wVq491Nl7s92REmThxweLm4GWBtRUzg4v9r+EoEy9pAru0P7
         K7VvXdWGEDeLvfxiTzkCintYU7h5P2mai4DDSLjIp+T5AyHBHOWjosP24juf1HF8Rk4t
         UM+yTHQzwYjyftCF06T5ggtczDcXdp2FVWjqzKj5GJIgrh7LhA5JavNXMEn0pftwFoRb
         OHvkJZ6Mbjp00tf9ITgPgMLYkLes3k6viq/jMOnPC4HVAEMwkJ/ccdwLMkvFKwEBfj6S
         e8SEizAh+V6sGyQAeUOtduJNkqy+QqQfJcUV8AU0DuFpS+N5TO5v+qRRJ3hdVZx5vi37
         4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjHLcYUUjhD+PtF02a4WQB8SZ/341O9Yc/tHe2HDPA4=;
        b=6TbbwBFPM3Q3UTCFGKO5Et6MC0K4YSu+YR78R+a52bW1lOtaN9+xQwsgmWhLqUuHiw
         /7e/+lims/ynxezpaP/ikI01hn3H5Pr9lnsjyj1TtzxKjuwP/aWsMggFS23QL9FI+07e
         ULKA48QOKLB9TyZCONs2zf233fByHWmlXLVRjKSB/FEdkeVzbeurovNKG2NapX6T6NrQ
         fAUxKIIAJacbxhUuCoFuhih/aAg/4+k3xozDLzTAFKQf7mMvFZyyURVeYR746RoglR+G
         Ko7iJ2LFkzQessjD1UrUqMZQP2r0wF1LeNPfWRzVEP0cG2G6Bj/I782j6/4cUVzVZd1s
         wR+Q==
X-Gm-Message-State: ACrzQf0PaaYq/SETiJXC+hGZrghwsvGqKaWZagb90sst340zvZb3laPx
        mqOUuhDhRcqyEqxzu98vefI=
X-Google-Smtp-Source: AMsMyM4B1uBb8ajk8x/Mn2+V3BSzPBcPMUsMeSaNFcXAAvNysaiNa7XcKIpUbv3aBeb3PaFJ96acJA==
X-Received: by 2002:a05:6a00:805:b0:563:6e88:896 with SMTP id m5-20020a056a00080500b005636e880896mr11466728pfk.57.1666231000780;
        Wed, 19 Oct 2022 18:56:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id y16-20020a63e250000000b0046aff3ce339sm10455823pgj.23.2022.10.19.18.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 18:56:40 -0700 (PDT)
Message-ID: <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
Date:   Thu, 20 Oct 2022 08:56:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V4 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        k-hagio-ab@nec.com, lijiang@redhat.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
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

On 10/19/22 17:36, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, which are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     KERNEL_LINK_ADDR,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
> 
> Document these RISCV64 exports above.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Hi Xianting,

Seems like you forgot to keep carrying my Reviewed-by from v3 [1].
Anyway, here it goes...

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

[1]: https://lore.kernel.org/linux-doc/20221018081755.6214-3-xianting.tian@linux.alibaba.com/

-- 
An old man doll... just what I always wanted! - Clara

