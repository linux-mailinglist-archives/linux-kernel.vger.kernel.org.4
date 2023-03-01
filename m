Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EF6A671C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCAEve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCAEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:51:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6709757
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:51:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so49100762edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677646290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf+wA0QmNX744Y/lqGbk5s8jA/7sYEQ3hy7TeNz4kew=;
        b=pCA6Ljh4YKyIGCpT1BNzuO9x2bh11eBXyZyOsb9ptC6dh/5VcgqCTWi7qpMGikNF08
         YsPEe+hpHlUlz18KRgKLq1YJFNnEYmTJuAGD/SHyiT9KphbG6S0wXokENQLD4deb/Jwk
         hdUSwPhM25zLgT2xAONeORenH6Nijgr2iBW8EckgSKSSZmf6NzIp8VBFdJEjOSj2TJi6
         Sr3WqYrlsPqFZlrH3eDR0jNqv5gRTcnp8CcTbNCfNS0It6LEZV1uh+IPFWkQC5J2/7bx
         qkqQrZN/8MxE6i/judZvVCC1VJKfj6uJzYC2+M2B19JGub2sf4Jxd7Pf59mUXZcMTjrJ
         6VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677646290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf+wA0QmNX744Y/lqGbk5s8jA/7sYEQ3hy7TeNz4kew=;
        b=PQ0Sgba1yFI97V7nCzuoT/79imrZYYof1LimK/FvJCVMiKAVmoCgoHl8Dm3G1Fj3R7
         mvg7dJh82zflxLZlI8p6ZmbBL/6KhpzNBpCD+F5Of2jI88LOnbn5K9xHxJekxdJdr5pt
         5CtflZdAaCccyKcI4C61l+SRTyT0cLCf6pYolzfpCBNMb+0se7fh6AJUYZL18pA4G+Y7
         yG1rYBpwBuOW79mIX3Zf6VG/UJ7Xc8u+N4nRTyTi3GjvVeYEAvOFlkwJeKMS4pegDwys
         nQOUf4eirCB7GhPn9rUA8tJOJSXdKwnhKMUBzz3jBPjKa8LrbiIRwprtQkcw7nCO4KdR
         9G0Q==
X-Gm-Message-State: AO0yUKWrrOGXLSROUoTjnrmPvRHxIdtihC5z+VhMsg33JFTawf0dO/Bu
        RoMu8pnZruhIfrLxGplLgbo=
X-Google-Smtp-Source: AK7set9HU0yaQDE1GWWPN+7uNOH/F5KxOowwGZT0/tEUbJRb+E+f1nW5HWpeHLPT1xS9R24T482TTA==
X-Received: by 2002:a17:906:85cb:b0:8b2:3e72:1022 with SMTP id i11-20020a17090685cb00b008b23e721022mr4520088ejy.29.1677646289960;
        Tue, 28 Feb 2023 20:51:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u11-20020a1709064acb00b008f767c69421sm5205731ejt.44.2023.02.28.20.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:51:29 -0800 (PST)
Date:   Wed, 1 Mar 2023 07:51:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from
 restricted pci_channel_state_t
Message-ID: <Y/7ZzYyisv1ylrho@kadam>
References: <202303010454.jI5Jg2sT-lkp@intel.com>
 <20230228213325.GA21769@wunner.de>
 <Y/7YN7U9Q2iqNDFo@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7YN7U9Q2iqNDFo@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:44:39AM +0300, Dan Carpenter wrote:
> > It seems they are only reported for architectures whose arch_xchg()
> > and arch_cmpxchg() macros cast the argument to an unsigned long.
> > Archictures such as x86 don't do that, but a number of others do.
> > The 0-day report, reproduced below in full, is for loongarch.
> > 
> > I'm wondering why the cast is necessary at all.  Digging in the
> > git history, I noticed that it has existed at least on arm since
> > forever.  I suspect that its use on newer arches such as loongarch
> > may be due to cargo-culting.
> > 
> 
> Speaking as an absolutely newbie and ignoramous, I can't see any point
> to the cast in arch_xchg().  But I am also surprised that silences the
> warning.  I would have thought that removing the cast would change the
> warning from "warning: cast from restricted my_type_t" to
> "warning: incorrect type in argument 1 (different base types)".

Your other option would be to add a __force to the cast.  I don't know
if this is a good option.  I guess first figure out if the __bit_wise
is really required.

regards,
dan carpenter

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 497acf134d99..387c6af01941 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -93,7 +93,7 @@ __XCHG_GEN(_mb)
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__ret = (__typeof__(*(ptr)))					\
-		__xchg##sfx((unsigned long)(x), (ptr), sizeof(*(ptr))); \
+		__xchg##sfx((__force unsigned long)(x), (ptr), sizeof(*(ptr))); \
 	__ret;								\
 })
 
