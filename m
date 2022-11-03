Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76A8617A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:35:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005F2AD3;
        Thu,  3 Nov 2022 02:35:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2zBx69SBz4xHV;
        Thu,  3 Nov 2022 20:35:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1667468137;
        bh=3UpxhbKKGBzORlH6T6FFqXj4UhETFfNxDFVHQGuz6uA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lh9fwvI4+lWUEUlvEm/teesbaj94J+t5ewaa3653xAPHMKlYT0c5/AdjzB4Ul229h
         bUMRYtctuYZE3cm+3CVc48UfH0swBHkyZntXUhqc3ClN0aiQlOgSUwr8aui9j2opwL
         XluAaKjg5U1JSsnSZ7yQ6bn0olfo5czaBYVQRoUWxZ6cSB7MMTaBvKmL6VTfUixvgz
         7xeE+uGLlLAjGKmxE4WCbSfgxybtgmpS6nK5TPr/wymDoHqnKIb1FcoJoArWyAm6RY
         Kd3/AzbIgF9XivVDa/d0S2g/J1mPzCeiygOH+z/FGzpPF3aF37x/xuREaGg1EkWuos
         dCo5IBpJCYyfQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 0/2] powerpc module arch checks
In-Reply-To: <Y2MEw6BruH3FnYL/@bombadil.infradead.org>
References: <20221031120733.3956781-1-npiggin@gmail.com>
 <Y2MEw6BruH3FnYL/@bombadil.infradead.org>
Date:   Thu, 03 Nov 2022 20:35:32 +1100
Message-ID: <87leoss7mj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:
> On Mon, Oct 31, 2022 at 10:07:31PM +1000, Nicholas Piggin wrote:
>> Luis if you would be okay for patch 1 to be merged via powerpc or
>> prefer to take it in the module tree (or maybe you object to the
>> code in the first place).
>
> Looks good to me, and nothing on my radar which would cause a conflict
> so happy for you to take it via powerpc or I can take it and apply it
> right away to tricke / get tested on linux-next by tomorrow.
>
> Let me know.

Thanks. I guess it's mostly a nop on other architectures, so probably
makes sense for me to take it.

cheers
