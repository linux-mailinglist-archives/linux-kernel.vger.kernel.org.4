Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048125ECCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiI0T2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiI0T2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:28:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD1FE040
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:28:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u12so2081865pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2vIlmRIaSFKVhbMSXUDbGTwH2ZL5cAhKOprBdk28COM=;
        b=LtBv2hgImbBRE2IHyWvV7U2Vujg6OqGxgmF8zAs4hZ72OrEPuN8NZo+fHCaTxGt1FR
         KLmEIbu0cNNdb6MH2qlAZUlF8ISsYdV0/prhnsC5VeA7tOWio4IzhXtL3o3347bdizLN
         GLkz2IXwvFQKd7zxDEUmcoru7EZHXxYm38jrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2vIlmRIaSFKVhbMSXUDbGTwH2ZL5cAhKOprBdk28COM=;
        b=CRIxGc7oTtXFaS7kdkNWMAk9qpX0tZqdTTtrS+uKHKQetdNMQ+eDIxxouH8Xr1TE2O
         NuF35wPWr4bDvx8I6qK+YuFTPg3efmJRNyLOuLMEr+8Gfqp9TRjsciPL1LOtA13897W0
         ko1KdVaviy1tHBkRpYdrnomcVvqLgoYLHUj9RdNw52FlGzgRx3aRsrq+h8598Ir1/js0
         LcFCo1Jd4TbCuzBbBNJC6bg0jQjTXXGX53J0t4svWspiKGcXDhMYsXIkoUMHFgLbIviD
         ldlsiLtFDmgpFAaTjr9a0kNGZyKxeDcPgfPu/LEHmoTsidAZp2H3nxLU8CixVndwy7eg
         qJ5g==
X-Gm-Message-State: ACrzQf1xV8DSgw1fwhCqc54mTz7bkXYtumHt5nEMKCmsZDGPKTcxuiCz
        3Mbwcgo3aIKVWUKUaZs0zD2iQQ==
X-Google-Smtp-Source: AMsMyM7hdvfrb/03VEy/Sd5wxxecM0ux5EB/mWeA47BvYBAlAuTGnqHb2bTiiru+GYaFeTOTJBK9SQ==
X-Received: by 2002:a17:90b:4c84:b0:203:20a:7afe with SMTP id my4-20020a17090b4c8400b00203020a7afemr6188098pjb.94.1664306895499;
        Tue, 27 Sep 2022 12:28:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a8c8600b00202d1745014sm1713023pjo.31.2022.09.27.12.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:28:14 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:28:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     broonie@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: linux-next: manual merge of the kspp tree with the arm64 tree
Message-ID: <202209271228.00C60FE98@keescook>
References: <20220927185911.512737-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185911.512737-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:59:11PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the kspp tree got a conflict in:
> 
>   arch/arm64/kernel/alternative.c
> 
> between commit:
> 
>   b723edf3a12a2 ("arm64: alternatives: make alt_region const")
> 
> from the arm64 tree and commit:
> 
>   5f20997c194e8 ("arm64: Drop unneeded __nocfi attributes")
> 
> from the kspp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc arch/arm64/kernel/alternative.c
> index 64045e3ef03a9,d2c66507398d7..0000000000000
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@@ -139,9 -133,8 +139,9 @@@ static void clean_dcache_range_nopatch(
>   	} while (cur += d_size, cur < end);
>   }
>   
> - static void __nocfi __apply_alternatives(const struct alt_region *region,
> - 					 bool is_module,
> - 					 unsigned long *feature_mask)
>  -static void __apply_alternatives(struct alt_region *region, bool is_module,
> ++static void __apply_alternatives(const struct alt_region *region,
> ++				 bool is_module,
> + 				 unsigned long *feature_mask)
>   {
>   	struct alt_instr *alt;
>   	__le32 *origptr, *updptr;

Thanks! Yes, this looks correct.

-- 
Kees Cook
