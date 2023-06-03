Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F2720EE7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFCJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFCJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:22:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325241BB
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 02:22:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso21915905e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685784174; x=1688376174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZZccEjOJDauUyUc86UqVR1EPzXqg2YfD93ZA1ljqc=;
        b=qI0nJsNWcHPPAlmCysrUhMrmWKr27qMxZO5HMUxwnyK+gpI+LPc6MlMrzrSyF3ZCtk
         1Hft1SoBsmWFRXSmyJaSjpGBY1iimxIJH/04hSrN4Th377wHgQseNGGv/rWbfnir1d1b
         rJS2HdlJfYGXG8kTkozPEzTSIv6nc/5+/qD4Zt2zJbW/b8PzbGyxeDutsZa65rtWK1mB
         wF6dbclJzCRVzB6/vtbHfCHojqL3dxpFyi4bePqUmEHNfPWGwjMVzXviopAkC0UeA1zb
         u8SQESCLxYrVytCtxsfz9subGlJKQtTgJptNGa8pProfb38gx8d1k1L625HFWncg2VZ4
         Mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685784174; x=1688376174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZZccEjOJDauUyUc86UqVR1EPzXqg2YfD93ZA1ljqc=;
        b=b/lJtdDP+YrHYI+CO3JPYDpnV0raP0BhC6Z4pvZuLE076X/bfLcE5VfJkalHexgWbf
         pG3mZ7g5BJmtd4zteDVjh7Iu+HTrpiffjNHQZm86K60Y9f6LA9ghN0i4OQx3nwNNLs0J
         mR+pjbvQfsttdDNGOm9fEHte4D+iUXzDlNFIOHkuMIcc792nATRYEYYIZx8Ca4LRsGZy
         +epPsW2dqOUyCU0ytVYIN5uCrT7DpGaP7QIjy+JtTJlGdbRUfDq74PswsiqDZVdG0+lo
         RLUIuMU2xPVpPQUivScdmsY6SwhZEoObzlHwdhM7lBCIoOGdDeXoQKKOeAHHLd0xYsT5
         1VkQ==
X-Gm-Message-State: AC+VfDxIAYJw6XX0jZNRUDhqLF8C5jjRdsb+xLOXoUb9nZ/4RmSNU1XL
        hwLBt6nQ9nySQ3LrnYzLhTI=
X-Google-Smtp-Source: ACHHUZ7HrvGXynuCfe2Du1bVfjOvawLJSng9RyiQMVVgL2YM1NZ+L20ZQXh+OzK3OYRVGFQ/PlzrPQ==
X-Received: by 2002:a1c:4c0d:0:b0:3f7:5e1:f3fd with SMTP id z13-20020a1c4c0d000000b003f705e1f3fdmr4008232wmf.5.1685784174328;
        Sat, 03 Jun 2023 02:22:54 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003f6042d6da0sm4431638wmi.16.2023.06.03.02.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 02:22:53 -0700 (PDT)
Message-ID: <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
Date:   Sat, 3 Jun 2023 11:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, dm-devel@redhat.com,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20230602213452.GC628@quark.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 23:34, Eric Biggers wrote:
> On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
> 
> The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
> happens to use.  But LUKS is a userspace concept.
> 
> This is a kernel patchset, so why does it make sense for it to be talking about
> LUKS at all?  Perhaps you mean dm-crypt?

Exactly.

I had the same comment almost a year ago... and it still applies:
https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/

  Anyway, please fix the naming before this patchset can be read or reviewed!

  LUKS is user-space key management only (on-disk metadata); the kernel has
  no idea how the key is derived or what LUKS is - dm-crypt only knows the key
  (either through keyring or directly in the mapping table).

  Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
  is used in many other mappings (plain, bitlocker, veracrypt, ...)
  Just use the dm-crypt key, do not reference LUKS at all.

Milan
