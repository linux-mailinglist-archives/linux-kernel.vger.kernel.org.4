Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF38709148
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjESIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjESID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916519A9;
        Fri, 19 May 2023 01:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52343618D3;
        Fri, 19 May 2023 08:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05839C4339B;
        Fri, 19 May 2023 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684483393;
        bh=3jJWIcZgZvkk6Y5TXMWAviv665TtXazo1GYVATenEgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oOC9D1zeDvY/rgTWO34r/1nK5ramY/l3sd7exY4dWp58CH5VMEAR0FGDjpHZZieHR
         IDNuWiSZ2L4e8OZbrkxxTuiWXURErRCaJJl0eq9o5FJ3Q3IIjXHiEmvU8W84wgKPfG
         DKMsz2BTGy8qzBuNGtZ9snqIRPX4+Qtg2XT5LxND9wj/UdTDsb6pyIUwWfhJjUqmGa
         g0puIgjBjq3j9iFdRG5n+44yxUl/3NhlHHQbv4hYNFE3u/phBToyHzg+bStn20lBXH
         hggvLBWpkKhA10hk8vc7SJXOEQisD6wxjfKt47JbrtFjxGTgHpmS8htn3oOY7RIg8z
         3ELes+8fH63GA==
Date:   Fri, 19 May 2023 09:03:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Athanasios Oikonomou <athoik@gmail.com>,
        linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] media: frontend.h.rst.exceptions: add more dvb define
 exceptions
Message-ID: <20230519090308.0e53eccd@sal.lan>
In-Reply-To: <20230518234735.20289-1-rdunlap@infradead.org>
References: <20230518234735.20289-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Em Thu, 18 May 2023 16:47:35 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Building documentation reports multiple warnings for undefined DVB
> frontend labels:
> 
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'

Thanks for the patch. FYI, I already merged yesterday a fix identical
to your patch:

	https://git.linuxtv.org/media_stage.git/commit/?id=8bc27fa5d7763d376a992a1638475987ed4807e7

Regards,
Mauro


> 
> so add those symbols to the ignore list to prevent the build warnings.
> 
> Fixes: 1825788e2a96 ("media: dvb: add missing DVB-S2X FEC parameter values")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-media/202305162245.wtaLIXf3-lkp@intel.com/
> Cc: Athanasios Oikonomou <athoik@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/userspace-api/media/frontend.h.rst.exceptions |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff -- a/Documentation/userspace-api/media/frontend.h.rst.exceptions b/Documentation/userspace-api/media/frontend.h.rst.exceptions
> --- a/Documentation/userspace-api/media/frontend.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/frontend.h.rst.exceptions
> @@ -142,6 +142,10 @@ ignore symbol FEC_26_45
>  ignore symbol FEC_28_45
>  ignore symbol FEC_32_45
>  ignore symbol FEC_77_90
> +ignore symbol FEC_11_45
> +ignore symbol FEC_4_15
> +ignore symbol FEC_14_45
> +ignore symbol FEC_7_15
>  
>  ignore symbol TRANSMISSION_MODE_AUTO
>  ignore symbol TRANSMISSION_MODE_1K
