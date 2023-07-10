Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBE74DC05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGJRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGJRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B410D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71B06102A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B067DC433C8;
        Mon, 10 Jul 2023 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689009161;
        bh=Qtl+hxmukqB8zjd/I8ng8xkRJV7hErdY/DKxeZGpp70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIBPfXFOHz8lPi/2vbyPct1ImRyBxadGsoe7AisEDvJrri4pIIfePYsOkIMufAFBP
         NOkIiw/qIqnVyMe/xgE3OVfNeoiPGQvSgtcyyJ9Z1CT3CvN200dZVCuELDC5uxAKAI
         /E0NC1ZCxauy8rvd/z+7yn0gztm422gtkXxiGnCA=
Date:   Mon, 10 Jul 2023 19:12:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
Message-ID: <2023071029-liqueur-vowel-ab42@gregkh>
References: <20230710170652.473788-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710170652.473788-1-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:06:52AM -0700, Sean Christopherson wrote:
> Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
> instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
> "significant overhead" incurred by debugfs_create_file() is actually
> meaningful, warnings from the script have led to a rash of low-quality
> patches that have sowed confusion and consumed maintainer time for little
> to no benefit.  There have been no less than four attempts to "fix" KVM,
> and a quick search on lore shows that KVM is not alone.
> 
> This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.
> 
> Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
> Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
> Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
> Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
> Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
> Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
