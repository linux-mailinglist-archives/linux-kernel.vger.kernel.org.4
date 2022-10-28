Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B0611290
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJ1NXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:23:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40B1D3749;
        Fri, 28 Oct 2022 06:23:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y13so4772763pfp.7;
        Fri, 28 Oct 2022 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpl7Dpc6dCr5vkysAbcVlXIzervVOSX11Lzahbyr4Fk=;
        b=izxXr4gs0lnxLDRUCCY04TTmSgzyW6uos10enxTQFe5DJSnIO+1f+0W0KpzDPViZRx
         fGtBxxn6x783RWlH+MPgzM1CHIvtHtwOji38JEArZiKADRJX2JSd+lnfyW8QPoSCrxFw
         swzxrjnMR8DkxkiaZwQeehUVj5vUdyPSdgeKbdsyhYzyYQ1tVCudDZmPrFQdfiHeLhwZ
         rXLEiWSOlkIWAiMbyjf56ISCssAHaaNqMYXe9XAufCqNzWC7USJ9RIJFfHr9RQ4dZUan
         ewlg0fENvT9MRgOeRQ8hzo9Tnt4o1RV0YWaPmhU2AOIEBy68M14DI+hK4O70AjEjJspc
         haTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpl7Dpc6dCr5vkysAbcVlXIzervVOSX11Lzahbyr4Fk=;
        b=PfUzffY4/e0KhDgNmKdK6wgSOSKOQHzIkeOGM23fwbwGPCTeBfrfemSQtMqmWDkLwJ
         Ve3clPO41BzYmVu+74DC6+MA6ZRMYrQcukEmTBUM4pO7UIQGk6leSvSN+lVLZcOOHJLh
         /RmlMI1tZTpwWeO2h6YrqROislyIyP0GE5v1pKN0ZmUlD16/acJaXZHv/BVMZRLXbq+4
         ACP+WJu5gox9WNFAYsNgCmCVGGmmyckhdyY5h5ffgp3cJJ7v16p6Jm5YGC/aznc1oOaI
         G36CciwbFNRT+Pq9DWZLzojmgOA+ZaA9kEdKs1A+sQOefYipHVyYPM1c0SyoBXSZHfOM
         dq/Q==
X-Gm-Message-State: ACrzQf13xm+qM9IdcW8BMTF+v1SGcZmV9M4uKVA9lWNOfuqR1RCT2EzP
        +m6DPDBJgG3XOE3IqxNlg4Q=
X-Google-Smtp-Source: AMsMyM7JkUIRYvv+ueRZaDieuV0DdqTjnF/0VudbBfT5A8zVx3/jSnvqqMa6MHKm5HCVWsmmbPi9bA==
X-Received: by 2002:a63:fd41:0:b0:438:7670:589a with SMTP id m1-20020a63fd41000000b004387670589amr46399598pgj.148.1666963423705;
        Fri, 28 Oct 2022 06:23:43 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a7bc100b00212d9a06edcsm4206205pjl.42.2022.10.28.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:23:43 -0700 (PDT)
Message-ID: <b65541bf-ad17-b465-0f77-66d9e9c242fb@gmail.com>
Date:   Fri, 28 Oct 2022 20:23:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 05/15] coda: remove CODA_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        codalist@coda.cs.cmu.edu
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <a6eb2dae62abf49b351760a4f55031d1c6f4ea01.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a6eb2dae62abf49b351760a4f55031d1c6f4ea01.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:42, наб wrote:
> We have largely moved away from this approach,
> and we have better debugging tooling nowadays: kill it
> 

Again, see [1] and [2].

[1]: https://lore.kernel.org/linux-doc/47c2bffb-6bfe-7f5d-0d2d-3cbb99d31019@gmail.com/
[2]: https://lore.kernel.org/linux-doc/9d96c96d-dfc7-7749-07d4-2601c00661c2@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

