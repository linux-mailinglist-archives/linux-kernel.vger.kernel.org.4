Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB169C2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBSVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjBSVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:25:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D114491
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:25:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKdr13zMPz4x4p;
        Mon, 20 Feb 2023 08:25:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676841921;
        bh=Va+sBtwMUiEp1wvvO6yhVupMG23TdQy367pr2KPb0Ds=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kEGohGHVZ0Xp3ryJAtRg+a2nI2GUzno+R075VEQXgMIvUh88nEE5Qejch42xk/Zwn
         wnVLfID/+NmFAJsPQwNM4oJJhaDSe0jPIkUkiRo+b03KzDXu+zD3IekSqU7Qo4b4mF
         +zt9zXNGg2O/csWh2wZh8lcBtKwVYi6BsnGwdEnOJq9LJKUbFGmLk5nZF2lcH2gqwB
         bxkr9fSsCjI7nOLH1HPvjo8OPiAcI4iNloAfi8YfSsnoC3m619cqsNeq1PrkPyNHIh
         VKA6D+Fulv0yuMLWy1hk+MzfCKbWkGpstNdBYgRDWk0PY5jr6CZqlrRIDg7FFIhp2p
         plrNr4k9/hQ0g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bgray@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-6 tag
In-Reply-To: <CAHk-=wh=m4sr1iLbt_PMmbrWsjLmkCAbz=NkKZmfTYFWv-RA7Q@mail.gmail.com>
References: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
 <CAHk-=wh=m4sr1iLbt_PMmbrWsjLmkCAbz=NkKZmfTYFWv-RA7Q@mail.gmail.com>
Date:   Mon, 20 Feb 2023 08:25:20 +1100
Message-ID: <87edqlz6tb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Feb 17, 2023 at 2:40 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Thanks to: Benjamin Gray, "Erhard F.".
>
> That just looks _odd_.

Yeah true. My scripts just take it verbatim from the From: line of the
email.

> It's not like the full name wasn't already elsewhere in the kernel
> logs as a reporter (and at least once as patch author), so I just
> fixed it up ;)

Thanks.

cheers
