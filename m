Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBFB73F11A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF0DAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0DA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:00:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73851BE4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b7dfb95761so5910195ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687834786; x=1690426786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeTs2x7FuNxv9o3OBIy1/YYpxTDNDnMo15MSc7SpQnw=;
        b=AnpQ1fZw9c1pRqwYx1AVGzSUxagUrOUA6Xqbrwaw71ngDcJL2I07B6LjUuf3vb4oFi
         9bszs4UpLXHLpjM10Vy67mJf0XaoD0wrff/DWf8dJJTrj6W67Qgj8XriWleKnjPb50ZX
         BJqrp2PTIu/k6Ug6Sl6NOYFUN+JKp+y7/x8FINP2OcFNpui/YOMmI/L8iq2U4fOJl4XS
         r7/3zKZOTnbFbuzhMJ1PTlqO6O+5dtjiiL+7m8CH5AGIepoejxOL38mMsn1sX7vWQCo7
         +jI2ldRsrL78rxw++OO6euxUnZjZxFxLCXOogFUKAz5NI2zjeEZs6wa1gEIyvdMO32G+
         utQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834786; x=1690426786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeTs2x7FuNxv9o3OBIy1/YYpxTDNDnMo15MSc7SpQnw=;
        b=NfwUNYn5VmPQPoHxxJJ2qBM7kWG5yyiIn2aUfcn3YkSv2DdQ4ON156Nc7qI6wK96XX
         +GUCIu+WrpqLHnvAqfnf4XKX1mHToRLZLXZYGfbaY0wyIZl8enkep8EcJl+kRpRLWm3X
         dbN2ucs8NjX4gVYcTk1OsZrMXOWfO3TBA9a+evW4Gdc7Q1JbSBTx7eELbaRkmEPnq40H
         +QZJAhAeov21hNPJgGqGm6FRVXClcDvWAdW6/NeSbr5yuNdbyyTRY7/KW0KJFXfgi/TM
         NSkWz9HAN77zUREJ5RXvs+m6p5B828vshkBSh7tVj4iODRjcH3ST8Hqe08K/X1DYIaAD
         1VGg==
X-Gm-Message-State: AC+VfDxugMx4d5YzZPxbPJcFHD38TNY2uvKOSdeEIntKQI1c2mc7vL0p
        rN7pWEC07uZ2kJ+/s0UXHhlZ1g==
X-Google-Smtp-Source: ACHHUZ4d7XvDYPH3zVtn9vzYg6hQnpjpNIaPRZYnulEQKGPmJjOA+f4681uFVeHVXNE/cpSL3lFNsQ==
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id n5-20020a170903110500b001b3ebda654emr36428950plh.5.1687834786221;
        Mon, 26 Jun 2023 19:59:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001b7fad412f9sm3126839plb.226.2023.06.26.19.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:59:45 -0700 (PDT)
Message-ID: <784c3e6a-75bd-e6ca-535a-43b3e1daf643@kernel.dk>
Date:   Mon, 26 Jun 2023 20:59:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627023337.dordpfdxaad56hdn@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230627023337.dordpfdxaad56hdn@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 8:33?PM, Kent Overstreet wrote:
> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
>> fs/bcachefs/alloc_background.c: In function ?bch2_check_alloc_info?:
>> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  1526 | }
>>       | ^
>> fs/bcachefs/reflink.c: In function ?bch2_remap_range?:
>> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>   388 | }
>>       | ^
> 
> What version of gcc are you using? I'm not seeing either of those
> warnings - I'm wondering if gcc recently got better about stack usage
> when inlining.

Using:

gcc (Debian 13.1.0-6) 13.1.0

and it's on arm64, fwiw.

-- 
Jens Axboe

