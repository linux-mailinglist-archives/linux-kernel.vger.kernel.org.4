Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E6930FE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBKMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:31:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845340F3;
        Sat, 11 Feb 2023 04:31:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mg23so1397599pjb.0;
        Sat, 11 Feb 2023 04:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzV/h2LPj+erhuBwIIveKlwCI4XSowTiTi/LF2t7bV4=;
        b=XdZ6wcFY6Z02Ikues0Gp5r5ngSWXyfpnW4STW1dSrWf8Q8u7e4KSVaUkGs/mn5yZSb
         vRpCCYVRr5MHffxT5gG8/fkC5SCqNCKoMr7Zyvx2dhnyc+POKkffY4TZh1iVVzOc6NBv
         3nu8l1WOBIhYtmwdWLKSvqeajEFJY6WExA3IP3aGwJocwfmdjMd8fTLXZo6Drmp+pv7P
         ldRE+Hob7iyKbJEtvshG1qL7gB0f+4/cPvHvDvryJYvtpVXQ3KpG0VLakl8A7wHAavrx
         K5gKn0aWt1axZMzoY+3atLdTf//5rPDxEYw6YePrNW/qDNt51t8gCt7Qy2+XElgnRVeh
         T2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzV/h2LPj+erhuBwIIveKlwCI4XSowTiTi/LF2t7bV4=;
        b=h4q75yw0K1PgQO1nE2oQP28CI1L9dfPXpKkQtmFAfEd9hMOnP81OmITxCDTQqseB76
         KB2XtX3lel7wPPBILbLyULI02Yy+t3quA/YclMTMOmkUcH+Cn5piX1++58L83JiTb8i1
         ZIWYZbJ72w5lt12X5I2rPZZsEdQ9BwRiDScrqltL0QBlHFNvyeBk+jwdSOckR7NKPcbu
         4QujlfE/CZTHlcZpTJzjCpCRzv8sml2AYrM26eIxNPM9CxVoHEde1V8brf0MCiDthyXU
         EGpKaOJLsxAqDduMAWaKmk86hCgtGGOD33EZJIMB8OCk0U8ThqfzUqGYBq1If/GVY5ld
         CCmA==
X-Gm-Message-State: AO0yUKVcPy121tyXBAQ0VJ81w7RWuZ95pGEawL5+9b00sN852qUiTERA
        IpY4in0ddatDcTqZxdogEvg=
X-Google-Smtp-Source: AK7set+gYb4CBRC0/6qb0fktw5IRCez4KTh9C0cIyazGd8szreYFMh3We6GLy8hJE7YaX7pSqviVvA==
X-Received: by 2002:a17:903:1207:b0:196:5f75:66f9 with SMTP id l7-20020a170903120700b001965f7566f9mr22853279plh.63.1676118685016;
        Sat, 11 Feb 2023 04:31:25 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709029b8e00b00198e6409d17sm4887986plp.116.2023.02.11.04.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 04:31:24 -0800 (PST)
Message-ID: <330367aa-6d34-2341-9d24-5f2e09aecfdf@gmail.com>
Date:   Sat, 11 Feb 2023 19:31:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs/mm: Physical Memory: add example of interleaving
 nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230211102207.1267058-1-rppt@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230211102207.1267058-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 17:22, Mike Rapoport wrote:
> +Note, that memory banks may belong to interleaving nodes. In the example
> +below an x86 machine has 16Gbytes or RAM in 4 memory banks, even banks
> +belong to node 0 and odd banks belong to node 1::
> +
> +
> +  0              4G              8G             12G            16G
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +
> +  0   16M      4G
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +
> +In such case node 0 will span from 0 to 12 Gbytes and node 1 will span from
> +4 Gbytes to 16 Gbytes.
> +

What about "... and node 1 will span from 4 to 16 Gbytes"?

-- 
An old man doll... just what I always wanted! - Clara

