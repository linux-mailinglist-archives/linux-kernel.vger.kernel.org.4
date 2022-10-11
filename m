Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA0B5FBC34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJKUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJKUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:36:13 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7D1B78D;
        Tue, 11 Oct 2022 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WYpblXeqgH5l2vWWxUISGGhQDP6GQt/mv4HUK04XBbI=; b=cupYyh77e5T5swv28go4kCSCgP
        T5HLCgrdjFI60AWfds81KGnNRDQqFq3C1fdcppz03j0bhBlpzN+nCqvkYkeZ55aq+4J6yA5C6vMl2
        QMGViALEpTagxueG3YqQ/ay8MBLOSIHFaPp5bOVrkntXMrglnCzsMp1QGTYOFk6jjSBqshbaJAuju
        NU1/GP1iEtG2w3Ph/u/zp75JsmqYf8jgWObvfSXNyVsBsMmUutK1yx56Jpj6asRzkd+OHZvstC022
        q8GijfJy/49vozwhX47VX/N8+j4tFX31syZxTEsoSNVN0fJ8NFOcEX4viiCuPZC0uqVOkfHlpVPDX
        Wje3RaOA==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oiLys-00HOn1-BD; Tue, 11 Oct 2022 22:36:02 +0200
Message-ID: <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
Date:   Tue, 11 Oct 2022 17:35:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-6-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> Update pstore to better reflect reality of active contributors:
> 
> - Remove Anton and Colin (thank you for your help through the years!)
> - Move Tony to Reviewer
> - Add Guilherme as Reviewer
> - Add mailing list
> - Upgrade to Supported
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..bb18a6c91c4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16458,10 +16458,10 @@ F:	net/psample
>  
>  PSTORE FILESYSTEM
>  M:	Kees Cook <keescook@chromium.org>
> -M:	Anton Vorontsov <anton@enomsg.org>
> -M:	Colin Cross <ccross@android.com>
> -M:	Tony Luck <tony.luck@intel.com>
> -S:	Maintained
> +R:	Tony Luck <tony.luck@intel.com>
> +R:	Guilherme G. Piccoli <gpiccoli@igalia.com>
> +L:	linux-hardening@vger.kernel.org
> +S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
>  F:	Documentation/admin-guide/ramoops.rst
>  F:	Documentation/admin-guide/pstore-blk.rst

Thanks Kees!
Acked-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


Just curious, why linux-hardening was the picked list?
Cheers,


Guilherme
