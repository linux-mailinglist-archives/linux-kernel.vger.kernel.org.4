Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A46D3CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDCFsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:47:58 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8426212A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:47:57 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id h8so112545873ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 22:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680500876; x=1683092876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vPToei9N6LUQ8UzrqVcorfU2LeCJxqpeXeeHhlRfwA=;
        b=H3+oIRJialVejapeE8VT8ITxIA+D4DyLgBZi7PP1gtbprYdnlIm26kJHh+2R9TtB0J
         xmukzcNeuCdrgUQnfLRtwEDSdmpG+4MUos0suckmRT7NRAQgyJ1weL8PrILMAK3LWSP7
         R0OZ+jU/PrUB/HD2dZ3l3BaB0u6rxmPz8VD9+LGlWV2tiNXiwiK/nrfecI2tGAPa5AjF
         vnkiIF2V1dvDXSRHwYs1Y+gZAdZHUwRUvSzWtEC/BPza+Jg/mDcphRyC5bAHaFns1N89
         0/40AHy0nEHsuLYOuCmFhf1zGGhtTwgttR1aNLVaGy9molyvbEPp8h5v1KNphvdaMDAR
         OO4Q==
X-Gm-Message-State: AAQBX9fS+AyiwB22QIOzUsUw9/C50GG5T2VBIrM8M4KN/Y0F363qaqkl
        GHTRK9PGV4S3+jpvO8luY9V5ceSFM+Kr4g==
X-Google-Smtp-Source: AKy350adHV5nIZ93TvGOnjBZR0RErQQb6gDB8ZNHuMpYXlsReHP/tLZJrQRvL4J/zAN03ANGWlMcRg==
X-Received: by 2002:a17:907:8e93:b0:948:aac6:7def with SMTP id tx19-20020a1709078e9300b00948aac67defmr922364ejc.19.1680500876155;
        Sun, 02 Apr 2023 22:47:56 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id rv27-20020a17090710db00b008d606b1bbb1sm4030218ejb.9.2023.04.02.22.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 22:47:55 -0700 (PDT)
Message-ID: <00c3f7a5-6948-995a-9254-115f57cddbcb@kernel.org>
Date:   Mon, 3 Apr 2023 07:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/5] tty: make tty_class a static const structure
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <2023040244-duffel-pushpin-f738@gregkh>
 <2023040250-landowner-unfitted-11f4@gregkh>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2023040250-landowner-unfitted-11f4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 04. 23, 19:58, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the tty_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Jiri and Ilpo, this is part of the larger driver-core changes to make it
> possible to move struct class into read-only memory and is used as proof
> that this all works properly.  I'll take it throught the driver-core
> tree as it shoudn't conflict with any tty.git changes.

FWIW

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

