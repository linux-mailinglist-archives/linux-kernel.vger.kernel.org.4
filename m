Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD06BC2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCPAf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCPAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:35:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308B16AE7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:35:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcStb64Qxz4x1d;
        Thu, 16 Mar 2023 11:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678926839;
        bh=tVxoK8hf/XN33P1gUvO+d1PauwkQu5SvlY6VlvvJG+I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=naebMpWVzZnTsDDVDCZvu+loLUFkGB0WVnpnOVf1RrkkzLRr65F2p2HX7qV5gH71O
         bCmEMKta2CEf6yQjYBKBLJ+wsFfECWBBIrieoCou4jcjMP0HgC9/CJlP3lHn6EIv/E
         34i3WR6kWLcP/AGaJrVMo482XbwaZtaUb9Gfh0kKBiti6xZFgEjZ+Op4CqB/6oDLUw
         lWI//uuSQlxAcqcd2n2imIyIpJv22PnSxqnEynqVXhD4X2Ly4ocHgIzGmH8lR+tAti
         L1iOQJnIlam9qUTNGbeP7fJyZ5PPX6sP5s0NjQO5qjtQD9XTbcGiKp8lIC9Wdersg2
         o+F5WIBKg2JWw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: boot regression on ppc64 with linux 6.2
In-Reply-To: <ZBFhUAlL+1ZVKcwQ@righiandr-XPS-13-7390>
References: <ZA7oJr1/Z4vzWy4N@righiandr-XPS-13-7390>
 <878rfyofma.fsf@mpe.ellerman.id.au>
 <ZBFhUAlL+1ZVKcwQ@righiandr-XPS-13-7390>
Date:   Thu, 16 Mar 2023 11:33:59 +1100
Message-ID: <87zg8dmt54.fsf@mpe.ellerman.id.au>
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

Andrea Righi <andrea.righi@canonical.com> writes:
> On Wed, Mar 15, 2023 at 02:30:53PM +1100, Michael Ellerman wrote:
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> > I'm triggering the following bug when booting my qemu powerpc VM:
>> 
>> I'm not seeing that here :/
>> 
>> Can you give a bit more detail?
>>  - qemu version
>>  - qemu command line
>>  - what userspace are you using?
>>  - full dmesg of the failing case
>
> Yeah, ignore this for now, it could be related to another custom patch
> that I had applied (and forgot about it sorry), this one:
> https://lore.kernel.org/lkml/20230119155709.20d87e35.gary@garyguo.net/T/

OK. Did you do the bisect with that patch applied though?

> That is causing other issues on ppc64, so I think it might be related to
> that, I'll do more tests making sure I use a vanilla kernel.

I don't see an obvious connection between the modversions stuff and this
crash, but I guess it's possible.

cheers
