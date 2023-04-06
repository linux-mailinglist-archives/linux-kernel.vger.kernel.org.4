Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5F6D8EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjDFGAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:00:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F559D8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:00:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsW7w348jz4x1f;
        Thu,  6 Apr 2023 16:00:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680760845;
        bh=YRNkNOtv5CRb7IJxJSjCFFfZ5DdmME38REU3Q+2j574=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n0t34YKydwmH6p+3G/JWUr21t0gHEKDCLoRhw/S23s3mrkeglgnL/c7/4IUb2ikSu
         yxo2NfQYyKRTe5gYBrleIaHx3wlpDO2T72a9naivJ8ppf3zIbYBB8AxA7bsyP4bKxX
         o6EjnTvJZN81DfIO6CYXYCI2CEr1klgZKpL8kJ3YII5g+B8Dg0ypaWorI9e+4qYgM3
         hrk50P1fBCmVVxG0Bk60SUqQut8Qy/gHUGBzVuOl4Suus7Lw+I16758MxIqyQDiJ20
         z23xp12LwTpxgycXthNeYVVmLZgUSUaDuRSaq5d3swb+EQLGssUoOZpCZuYEhTEkY6
         VoMk0CHxN8cKQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use of_address_to_resource()
In-Reply-To: <168074339913.3678997.5583804591970225065.b4-ty@ellerman.id.au>
References: <20230319163154.225597-1-robh@kernel.org>
 <168074339913.3678997.5583804591970225065.b4-ty@ellerman.id.au>
Date:   Thu, 06 Apr 2023 16:00:41 +1000
Message-ID: <878rf5k0s6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Sun, 19 Mar 2023 11:31:53 -0500, Rob Herring wrote:
>> Replace open coded reading of "reg" or of_get_address()/
>> of_translate_address() calls with a single call to
>> of_address_to_resource().
>> 
>> 
>
> Applied to powerpc/next.
>
> [1/1] powerpc: Use of_address_to_resource()
>       https://git.kernel.org/powerpc/c/2500763dd3db37fad94d9b506907c59c2f5e97c6

I actually merged v3, b4 got confused when sending the thanks.

cheers
