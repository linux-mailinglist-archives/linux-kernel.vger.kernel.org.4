Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E162C015
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKPNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKPNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:50:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6FAE47
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:50:32 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so16734425pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vE2pgiW5yR6p6FUmDp41b9OlcBb789zbwYHvSxU9Vds=;
        b=tbYFWwWqpttGWffvBY1TGZ6Ypk1QKWFGVHHjq+40SX3MsspLXIuBefdSUXakBDYr83
         KmJyIS7WaZDJtAxxRICxQMVAB9YF7aM6NJ6AhzzfO8R2TC2pyGf10+HHnnSVteZRy5fE
         6dxIcA4ZUhiE0zN1bJrCUQMd66htm9p2Ryr67WZZWdd57BkJrGiiI948AFvN6Bt2gi4q
         3/5zqI+maPaOJhjD1F8FDPcxpFHxDtm80VS+eyhkrLqXzzMeD+BnO2O9m3rSIQRLXQGK
         fQpxQc+4t0IaSoWFETwyaGWOpw9nH9QAE251QeNstPg6D65kx5ZgHXbAUR5I41OxEDb4
         teTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE2pgiW5yR6p6FUmDp41b9OlcBb789zbwYHvSxU9Vds=;
        b=1z0xajg2YrVZ49mnP3ROrlAl08/l6Tb7u3eG6jGbdiw5Krenv6v5WL/t3cRurcRq9E
         JLSEjPBLtoat1eiO3EpKFNpeBHZTGRye6lUwBREJoZRIhaUuFbZMj7iUKP6XxAANyFMc
         51889J5LEALP0MDlHwcO0dMw0du458ECY3KSrDdTKk5uUU9xPdycluQEKDv0SrHsEmSI
         WgBi4oWxvFZ/tvYFKVmGbs0YnJPpJkHjCdGixEOtsiKjgB1mwZJN1AUK9fTasQcagSk6
         dm0GXk0BTCkUrRTjf5Tiq10IXfQ2+6+iAHUrzuz6xbVjhFZdrLbUYy/6co8UUySEkNKj
         i03g==
X-Gm-Message-State: ANoB5pkyg/xJ7tquTGQ2YiFXqoP0YI9QWIEyey3dV2sMqVZ/CM6Nd5VL
        NHYypEkA7CgFETLY0SdMCbwKQg==
X-Google-Smtp-Source: AA0mqf6ax7f66rumBFOa4MH74BP1EpT6b5Wp2Md7xd30Kk4aHVxOCt4hjrZ4y2G1WpZx16+qtL/J/A==
X-Received: by 2002:a63:1a23:0:b0:476:c8c5:ba85 with SMTP id a35-20020a631a23000000b00476c8c5ba85mr5686067pga.182.1668606631486;
        Wed, 16 Nov 2022 05:50:31 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0017a032d7ae4sm12346931plg.104.2022.11.16.05.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:50:31 -0800 (PST)
Message-ID: <fe9b695d-7d64-9894-b142-2228f4ba7ae5@kernel.dk>
Date:   Wed, 16 Nov 2022 06:50:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: (subset) [PATCH v1 0/2] io_uring uapi updates
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Metzmacher <metze@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221115212614.1308132-1-ammar.faizi@intel.com>
 <166855408973.7702.1716032255757220554.b4-ty@kernel.dk>
 <61293423-8541-cb8b-32b4-9a4decb3544f@gnuweeb.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <61293423-8541-cb8b-32b4-9a4decb3544f@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 11:34 PM, Ammar Faizi wrote:
> On 11/16/22 6:14 AM, Jens Axboe wrote:
>> On Wed, 16 Nov 2022 04:29:51 +0700, Ammar Faizi wrote:
>>> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>>>
>>> Hi Jens,
>>>
>>> io_uring uapi updates:
>>>
>>> 1) Don't force linux/time_types.h for userspace. Linux's io_uring.h is
>>>     synced 1:1 into liburing's io_uring.h. liburing has a configure
>>>     check to detect the need for linux/time_types.h (Stefan).
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] io_uring: uapi: Don't force linux/time_types.h for userspace
>>        commit: 958bfdd734b6074ba88ee3abc69d0053e26b7b9c
> 
> Jens, please drop this commit. It breaks the build:

Dropped - please actually build your patches, or make it clear that
they were not built at all. None of these 2 patches were any good.

-- 
Jens Axboe


