Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D66DC51B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDJJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDJJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:28:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29541FE2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:28:04 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id ixU22900W1C8whw06xU2r7; Mon, 10 Apr 2023 11:28:03 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1plnog-00GSzz-R6;
        Mon, 10 Apr 2023 11:28:02 +0200
Date:   Mon, 10 Apr 2023 11:28:02 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     amd-gfx@lists.freedesktop.org, linux-um@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc6
Message-ID: <3aa83a95-a755-416d-d8fd-8363bbd0edf6@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resend with the right subject)

On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
> On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.3-rc6[1] to v6.3-rc5[3], the summaries are:
>>  - build errors: +2/-0
>
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 
> 'struct cpuinfo_um' has no member named 'apicid': 2157:48 => 2157:48, 2157:41
>
> um-x86_64/um-allmodconfig
> um-x86_64-gcc12/um-all{yes,mod}config
>
> seen before
>
>  + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 
> 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]: 
> => 6163:45
>
> v6.3-rc6/sh4-gcc11/sh-allmodconfig
>
> seen before
>
>> [1] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ 
>> (all 152 configs)
>> [3] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e364e56293bb98cae1b55fd835f5991c4e96e7d/ 
>> (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
