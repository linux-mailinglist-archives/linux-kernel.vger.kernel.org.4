Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8C628B63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiKNVeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiKNVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:34:13 -0500
Received: from outbound-ip19a.ess.barracuda.com (outbound-ip19a.ess.barracuda.com [209.222.82.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DC260F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:34:11 -0800 (PST)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72]) by mx-outbound11-0.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 14 Nov 2022 21:34:10 +0000
Received: by mail-ot1-f72.google.com with SMTP id j20-20020a9d7f14000000b0066c532b53eeso6798908otq.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWDd/MBzZEtsCg8lCXMYeDNkXSIMpUqiJyLusf/wE8M=;
        b=Ek62IgRUOn87cEM3WfVw1pK1ghk2aB7owmZWSRIM7Uau+O0vfJ2Nu60LMH4uYxOTLF
         qQnEdN276IgPrfGuThCIpYAstIbJSOeXdhYL2ECHyv9WHOZdAFgLrQdR5QKYeX0BgIgu
         4RrWUmLSd5FOeiMen5fS5N8ptn/eH9zKkYEnrbt84+ND6s/YRuNjAlC12yR4V/gbE0Ll
         vRXThrHWj85cfKQZvY73n726NhuNZThoPy7LsHsXiZze+QdBX3a36wGZZgO6KVYjXuoZ
         2KtS7tGO5F0C2jZsLZtzxr1Zj69LNZJuKFimHrCb1ixfktOm+969aFkdR9ETGHqfDVk8
         4REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWDd/MBzZEtsCg8lCXMYeDNkXSIMpUqiJyLusf/wE8M=;
        b=F/oWtYP8g23CDB+XTLv1NYpHNDb6k6Pn38S21+rdfymDnzqOwERPusSUrxvnsZj6AY
         POAqPpyk0dfgIhVaGHLStq3JI5O1GcBH6HHDzpyXQdePfMR+9FKHgDFgEQ74hKsiwM0B
         qotLxg8p7efDFdx7iszEmbfJ1qw0gsOmVfGSzdatMiHql0kS/juy4IyE6Wl6Q6NUZcIz
         G3hcW4cRYFoPsDaSP06uOnIlhHcQL2CT5gzQ5omjn5SuICzIsaxpbQtx/2b86f6WKc3U
         pvkqONzWYT7pHBuHCq5jn8gyFI7SJagexxfYt7I3en6+vkCwdRwOKtYq2f4EKY/PSRCQ
         x5tA==
X-Gm-Message-State: ANoB5plEC8Gwc7gGhZzNAGLqlo3wsWGro+svL9TOUPLOQ7KfauAV8yk8
        zNUfGcqMjHy8oS7olBoZdXMA5vgTqKo3q60nlhjdzY/ItvrMdPGHQ5H+gnT6XLFR5STmhnXIy7K
        ZvmhG1i8W/nLh3CkqPPgXMcwqZI9KSW19fUfST95kfkMQlF0T3wAInNPxtRQVfRxzxHAzZ19a
X-Received: by 2002:a17:90a:8008:b0:211:906a:f8ef with SMTP id b8-20020a17090a800800b00211906af8efmr15292378pjn.71.1668459973241;
        Mon, 14 Nov 2022 13:06:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf54TK9/wMXk1YqcBX6lX0AbuQzvLTAAcG++rlznAG6MtbzAwLLlIeMlYRitwx0z9El5SS8Av+acp9alxzg+Ams=
X-Received: by 2002:a17:90a:8008:b0:211:906a:f8ef with SMTP id
 b8-20020a17090a800800b00211906af8efmr15292355pjn.71.1668459972936; Mon, 14
 Nov 2022 13:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20221114124448.729235104@linuxfoundation.org>
In-Reply-To: <20221114124448.729235104@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 14 Nov 2022 16:06:00 -0500
Message-ID: <CA+pv=HMzyBA8UeC_NEbe85-EWfsLHL4G+fUiursk0Z7P14ukRQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/131] 5.15.79-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-SWM-External: yes
X-SWM-IntToExt-Scanning: swmout (swm-pri11-itoemail0-scan.leviathan.sladewatkins.net)
X-SWM-Sent-by: swmPRISMgateway (swm-prismgateway-pri02-mail8-scan.leviathan.sladewatkins.net)
X-SWM-Antivirus-Version: 1.1.0
X-SWM-ite-Primary-Server: swm-pri12-item.leviathan.sladewatkins.net
X-BESS-ID: 1668461650-102816-5374-1558-1
X-BESS-VER: 2019.1_20221114.2026
X-BESS-Apparent-Source-IP: 209.85.210.72
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244150 [from 
        cloudscan11-144.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS162129 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.15.79 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.

5.15.79-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-srw
