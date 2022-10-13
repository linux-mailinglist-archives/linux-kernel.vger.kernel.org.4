Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BD5FDEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJMRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJMRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:23:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89ADAC6C;
        Thu, 13 Oct 2022 10:23:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A57F27DE;
        Thu, 13 Oct 2022 17:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A57F27DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665681821; bh=YfVxkzWgQwMadw3tc3QeuLFM0aAlOhRBywN64Fts+GY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mB+pXPIj4cwfQzhOvAmOa65ajJItOGeoawtorldkzCdervD4CLFrww85Zw9HSFIGl
         IAsW/ue90Hu16bOdmbivkV6KKD3wRdlKx0sqMVe48tqVCz+YBAFCoHCzgduyjUTiDU
         U4PQ2qaV5ge0qBWidQcMeH4EtwHR0C+hV0nkqKL+7URej6iNV6GwmKcUob/v/mhai4
         vTlaM0YWNeTsHP1wgQP2fX0YaCN13j1dOtrkLrWoj47Q2carCrDW2SeZhv4nAtYcgt
         QwVnKlrfhGC5aRWOvL2VK9lsfdaRg+5la4uYTGDBEGi8Yeqo/sL53rx6Mt85p1ErO8
         9pA7EFSJBvEHg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     bagasdotme@gmail.com, jani.nikula@linux.intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
In-Reply-To: <89120a24-f622-eb9b-fde9-635caaabb67f@gmail.com>
References: <87h709md2c.fsf@meer.lwn.net>
 <89120a24-f622-eb9b-fde9-635caaabb67f@gmail.com>
Date:   Thu, 13 Oct 2022 11:23:41 -0600
Message-ID: <87a65ziqn6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Actually, I can't apply 1/6 cleanly on docs-next, either.
> As I have your tree in my local repo, "git am -3" worked and pointed
> out there is a merge conflict.
>
> It turns out that one of the hunks in 1/6 doesn't match what could be
> applied cleanly.

OK, apologies...the branch that stuff is on was split out some time ago,
and I had to perform surgery on docs-next in the meantime.  I should
have rebased it.  I've done so now and will send a v3 to the list; I'll
try to avoid copying everybody again because there are no other changes.

Thanks,

jon
