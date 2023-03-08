Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC766B043E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCHK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCHK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:28:22 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9EF5A6CB;
        Wed,  8 Mar 2023 02:28:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f16so16040328ljq.10;
        Wed, 08 Mar 2023 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678271298;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PM2e55u2rWAuFlB5GNjH23zKw43jDtkXtVhBxiEPjU=;
        b=g+Hr/wgHRNzChCV24AI87kc2NpZiOoXZNV8xwq4nZS5w56+FWkliUVb2RqVfDS4BZO
         8x5l0Ne9KSE1YeSpAMXf/491XGTZahDnyW+OF5LSNzI5P98JJbrwTWwfYPkRUkJnNeYG
         +Af4TOowwCL7ySTkuPfVFuQI9vE59oQX0amxznbGlObVhB3aflB05fCLlhpTh9pOPUYo
         0S0n17rkTC5qj5uHyqfKtLzKQ/i6yu4fUE+qtMDqUU7wrL3re2zabAbBUYtG4f9jP4lA
         +Id0Qo3BBgOChEz65poiurixsfaAMv26bybmGJgCbzh5Wl976+6C+RnfEkesg1CKRqI3
         BgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271298;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PM2e55u2rWAuFlB5GNjH23zKw43jDtkXtVhBxiEPjU=;
        b=aDAtSaJA5VsJ6Hh8JRz4tDeuudSivcwUJNLQbOnrPyxhO/oadvfRiOtMJmzi/etjgy
         XQo43S6kz6kPTtIWh6gnnOcvlldf95VUX6F4kFJfAcI7EJDNjT8o+KFj9a9PbePqTxLu
         AIk+kVLBE+JdCHwc4addFBjLMQboavehqHn/da6a0h6XwK+aQytSx69QiajZAMYPmumU
         scAylwRwxHjQK/lm1kLrmZGiOdxh72L3PA3yp9s8hjLZPIUYMT4ra10BSlIu2jFz1Bfw
         S/ub0AjQoDLQrOyiqjLfXP9axQCCqSIYHvdXe/0XuYi11PiBaAdtUyvdQ5T++5LD8SsM
         iPBQ==
X-Gm-Message-State: AO0yUKUzcYHDzHKYJwfdzzUACyjB7V+w0tIEVMOIz/fwEsKMLh8maVwd
        e0ie5sKqUf+pLjYTlFALKvuZ305mMNE=
X-Google-Smtp-Source: AK7set8zAN1JLxIDiwx7Z116PrzNfWnAFx+agVATcvYLkaabN8CSjIG2PJjJvw3vurZMUwS7F9nxvA==
X-Received: by 2002:a2e:7004:0:b0:295:b0f0:cc6d with SMTP id l4-20020a2e7004000000b00295b0f0cc6dmr4752590ljc.4.1678271298052;
        Wed, 08 Mar 2023 02:28:18 -0800 (PST)
Received: from [192.168.1.103] ([31.173.83.210])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e91ce000000b0029597ebacd0sm2450020ljg.64.2023.03.08.02.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:28:17 -0800 (PST)
Subject: Re: [PATCH 01/32] pata_parport-bpck6: remove useless defines
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk>
 <20230307224627.28011-2-linux@zary.sk>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <da4e2244-30ae-a518-997f-726ea3222154@gmail.com>
Date:   Wed, 8 Mar 2023 13:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230307224627.28011-2-linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  (Sending via my Gmail account, as the OMP SMTP server rejects mails...) 

On 3/8/23 1:45 AM, Ondrej Zary wrote:

> Almost all the ATAPI_ defines are unused. Remove them and use
> ATA_REG_DATA instead of ATAPI_DATA.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
