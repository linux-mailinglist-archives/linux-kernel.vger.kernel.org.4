Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A81736BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFTMS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:18:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05747128
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:18:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QllzV5cb6z4wgq;
        Tue, 20 Jun 2023 22:18:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1687263527;
        bh=PbLHIaiJwWOuc0fVdNIxbCOnVmMY9JR8H0lS3tr/vmI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nAwkvwSO8o15o+i3GtsKc00hLs52HSnEoaQbcFsFkF565HlED4gbVyyJXdHysvEje
         URXuU70oSpORlG6Ce2eddBR9XMCNHphJphpVBB8NaydckPGzEPaLEJlTPlg6MdnToE
         CsQlA7l3gz2fvU2T9jmoPU1DYhiZeyfkaam4EUBLqifKIm2Yx8eF8xhtaSFrctw3SM
         fvyfN/t+hHCOMy29purWJiadWsthGc2sP1SoaV0NRf0ybGpJe86v4HzULyUCftgafr
         IPdBARIRDtq9P1m8rengrVYETO8o8ma6RHxj4u8CtZVVfVumpewQoUZLkuWg8hUHA2
         kYK/Tz3Z54CRQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     zhumao001@208suo.com, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/ocxl: Possible repeated word
In-Reply-To: <787f5a712a0459bc21d83bb388770b58@208suo.com>
References: <20230618150648.1123-1-dengshaomin@cdjrlc.com>
 <787f5a712a0459bc21d83bb388770b58@208suo.com>
Date:   Tue, 20 Jun 2023 22:18:41 +1000
Message-ID: <87r0q6pbry.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhumao001@208suo.com writes:
> Delete repeated word in comment.
>
> Signed-off-by: Zhu Mao <zhumao001@208suo.com>
> ---
>   drivers/misc/cxl/native.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 50b0c44bb8d7..6957946a6463 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -920,7 +920,7 @@ int cxl_attach_dedicated_process_psl9(struct 
> cxl_context *ctx, u64 wed, u64 amr)
>        * Ideally we should do a wmb() here to make sure the changes to 
> the
>        * PE are visible to the card before we call afu_enable.
>        * On ppc64 though all mmios are preceded by a 'sync' instruction 
> hence
> -     * we dont dont need one here.
> +     * we dont need one here.

I know the rule is to only do one change per patch, but if you're fixing
the wording of a comment you can absolutely fix the spelling at the same
time.

So please send a v2 with "dont" spelt correctly.

cheers
