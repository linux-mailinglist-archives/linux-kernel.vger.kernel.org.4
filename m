Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5424F5E5E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIVJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIVJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:25:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01801AA365
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99555B82759
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1F0C433C1;
        Thu, 22 Sep 2022 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663838744;
        bh=x9vdgttExkjV7T6N0P/+kIRGf8m3mwiWn87Z26KdTsk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tr7km3Aj7G9vGv0PNURT0d2Qy39DlZdd3DrPD18cTJP9+bT3ppHNSqNorXg2fkqrz
         1wx/kj8wqP4bLiiFxE7jsL0yQGE1SLGC6nFEbQvtDCZJfrSYsbdrPKIYZHUtNlmYDO
         A86ais2krzvXgzA9NlhhFalotk3LuLJJuwAA1iLqIJtQYI3PTAdeKpYrqAA9iuDQfT
         Fuw9iKlILDBo9L1EklKnDRLC7vJ1eSiZbVYFhZEsatHUodCjW8IZQH6LqLYTEM3EBG
         cBeDbApytq6Wm7OeTkQBFMlQXrENcm7MX2u41DBUZbX5RwqgMO45tERKP1T3pIDTVF
         PiEvwDIJL+Pgw==
Message-ID: <d0c8336b-bdaa-8e57-38fa-f570c3d696b8@kernel.org>
Date:   Thu, 22 Sep 2022 11:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] rv/monitor: add __init/__exit annotations to module
 init/exit funcs
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
References: <20220911030418.94609-1-xiujianfeng@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220911030418.94609-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu

The first char after the subsys: must be capital, i.e.,

[PATCH] rv/monitor: Add __init/__exit annotations to module init/exit funcs

On 9/11/22 05:04, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.

Please, also add these tags to the monitor templates here:


tools/verification/dot2/dot2k_templates/main_global.c
tools/verification/dot2/dot2k_templates/main_per_cpu.c
tools/verification/dot2/dot2k_templates/main_per_task.c

So the fix is propagated to future monitors.

Thanks
-- Daniel
