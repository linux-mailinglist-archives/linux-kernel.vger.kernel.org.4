Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C773D427
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFYUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFYUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:37:20 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9C11A;
        Sun, 25 Jun 2023 13:37:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D206C6E3;
        Sun, 25 Jun 2023 20:37:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D206C6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687725437; bh=NL7nc1PJA4tL/xVP/nH63eimT7DX249LpQmzMai1+T4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FD/0mnca/xdbEiuoHoPe4iIjjQeUf79moc6KH9AVFpbwOGW+/j3GHWLrAoaLUG0kN
         L5XJMLETu5LQ82VwrKm6xUbRhrw9f9pouqfgfw5QnsI557DbYkyOFMUjW3av2zglfG
         IzDbt3SIq1D928ZqJw1acDo2y3bmDVa22VAd0mxPF4+d5OHV0HVEHMlyLmoltONVC/
         eZ2KONrtgvg10Z/k++zzxiMr5xi71+cZrGamjRdcZtLWoLKAYH+LV9X2amZtOyggYF
         LVA3oPaK/YKOc7QwOJeYoMj3nCEcY4hd6OtX0n5dxETsoneUV3OkrtzDrtLfW5xPtR
         faxGQd+HjeyTA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rong Tao <rtoax@foxmail.com>, martin.petersen@oracle.com
Cc:     rongtao@cestc.cn,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: target: Remove useless tcm_mod_builder.py
In-Reply-To: <tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com>
References: <tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com>
Date:   Sun, 25 Jun 2023 14:37:16 -0600
Message-ID: <87bkh3l1mr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong Tao <rtoax@foxmail.com> writes:

> From: Rong Tao <rongtao@cestc.cn>
>
> This script is not used and requires additional development to sync with
> the SCSI target code.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v2: Remove useless tcm_mod_builder.py
> v1: docs: target: Convert tcm_mod_builder.py print syntax to python3
>     https://lore.kernel.org/lkml/tencent_F3895D0EA868BCCE8C56221619BC093D660A@qq.com/
> ---
>  Documentation/target/tcm_mod_builder.py | 656 ------------------------
>  1 file changed, 656 deletions(-)
>  delete mode 100755 Documentation/target/tcm_mod_builder.py

As can be seen in the note from the test robot, you'll need to remove
the reference in Documentation/target/scripts.rst as well.  I suspect
that file, too, could benefit from a closer look in general.

Thanks,

jon
