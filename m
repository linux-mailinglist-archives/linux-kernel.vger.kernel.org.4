Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC399739DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjFVJzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFVJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:54:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CB4C29
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:51:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45e347266so90177741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687427475; x=1690019475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqVvolVX6XyCIA6EHrho/8Di1Zhslj4CW0xijtSTflw=;
        b=KO8OTFERMfa7VRAF6PbiQkqCA7Wl6U6V+dyRhodXQBHXBhWCKc+EVGkXKmb+H7VQtV
         zr0PocKX/yHorQMiZYViTpXI2otedg9f9/hnvxmy/seJOnV5I4IflYlDcbwJO5sa0OBt
         iu+6VU082BC6jQdWFe7sDig2Edmr5Iq32PD1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427475; x=1690019475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqVvolVX6XyCIA6EHrho/8Di1Zhslj4CW0xijtSTflw=;
        b=GMeKXJ2+esCCbLs4TRhc6BfAvd8EsrX3v5zvHpVSCBdsqrl1qOfkkTmwJ8ohUqxaYW
         qp0Bwy53ZfTPrRRpq+FX7kBvdN+Pe58bVejT+CfRtQPrkuxQNz4yuHITWxC4KOm30SHd
         6id8v8zjZRxKetGCWkmDQx+p4BHKvNdqhCNP14NR0IicFpzl3LKex0A/tRXc0pfXq2t/
         Jj4sK4gvpovmvuX+k6y7W/VcHfXponCiKlbPYKZCVTNWUp/yN+EDwNbsoEVRxoHLrFrA
         lngZvXwegBbViR2I3NMwhJVw1fCDokOE9stkGeBewaPDYMYpzoA7I/ww8xSYmXnnr1qY
         6bwQ==
X-Gm-Message-State: AC+VfDyC3KNGNjL6GuHfLs1g+X3IaI2BpqQUXc/XDYyLohj5eej7ziIo
        XpYPC5XhMha7xdxl+dCavHh7sw==
X-Google-Smtp-Source: ACHHUZ6LMKBeeszETT3hkdyBmI2SqM+NqrdyBO12nDC6s7mxmGVZ7FOSEr+uyr7o4DDlyFIkIpgLAQ==
X-Received: by 2002:a2e:9a92:0:b0:2b4:6504:3282 with SMTP id p18-20020a2e9a92000000b002b465043282mr8906027lji.37.1687427475163;
        Thu, 22 Jun 2023 02:51:15 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t26-20020a2e9d1a000000b002b58a904280sm447051lji.120.2023.06.22.02.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:51:14 -0700 (PDT)
Message-ID: <718e195b-8143-8292-ee8b-19b27c1060a7@rasmusvillemoes.dk>
Date:   Thu, 22 Jun 2023 11:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 0/2] bimap API: Add couple of files to MAINTAINERS
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
References: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
 <ZJM8TBQJjR40y9/e@yury-ThinkPad> <ZJQPTcfzxM/9lHqY@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZJQPTcfzxM/9lHqY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 11.07, Andy Shevchenko wrote:
> On Wed, Jun 21, 2023 at 11:07:08AM -0700, Yury Norov wrote:
>>
>> Acked-by: Yury Norov <yury.norov@gmail.com>
> 
> Thank you! I assume you take them.

Yeah, it would make sense for Yury to take them, and then you can
include my ack as well.

Rasmus

