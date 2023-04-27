Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CFF6F0361
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbjD0J2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0J2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:28:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579B19AE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:28:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso6507806b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682587689; x=1685179689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSffrdiQPNNJd53oPjULTxIDSQd1IqHIbkRxrZQ6UwM=;
        b=F/zn3ER6A0Q+l5tyEH+ooDZjeuYDIzMGhQDb6TqHt3Pb0O13tyjs1VtHpjpkprGKJC
         /mPpOvw/3pTNKBWqGKjLEVbRI8RPP/Nj4drvC53IPKkG8ev41zKBirpKVNnXLxoMRB9x
         N4I9/LmdwNqmjEa/08JGK62+GkonSU/kkzu5F27X4ZH/dgGROBpCwQoovtDi+cmjaLnV
         0O/ST5MVcjhE++RIXI7y4d72DSrmQ4rmb5Ov98XBD3CXVd3UeFqtsk9EM2XuwNkG4PIv
         PSU/aDUj4zfNd4+hekg0hoGs4VGEhyFLpSNCfFtMQ79ep9TBZYA2xxQFsfX7PCOlSdyn
         O8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587689; x=1685179689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSffrdiQPNNJd53oPjULTxIDSQd1IqHIbkRxrZQ6UwM=;
        b=AeVTuzf8PV09V8Du/KPv2aD0x0d3S7rsyWnNf47JOD1sdICtbTfoiAGINNXzJrpIrb
         1O6dBtbkna3S1cpDgywlNB1LzyZOLt/cE4mzmgBfaw2UstavveBtX22U4zWyMQyqPNYa
         REVX9te7w7y+sUbLaWVdbpP2Nwprm3L0f83qt0DOPNlLfJJgSvgQrYuc+zKD/AMz427I
         UygMpnWeYM40s2aHfqCFlt0drL/z/VKEBHRcKCFaCkd9gRJBTFpVguE9ZXV1L21Yy7Lw
         h2NudpUjYZrk1Y8aGMGbMv/ML2FXU8yq4D83Sc8JfJ8vIgnfyyRtRdz2aynifVTn4Y0f
         BaCQ==
X-Gm-Message-State: AC+VfDzTN25n+hG5uOIZa0SGD8X12OaaJpsLCLRBizr6Wle/PdiFSemp
        keS7mrGZKHgRj0DYEOzqJ9jHWQ==
X-Google-Smtp-Source: ACHHUZ4lU97uublnhxGqgaRZ1mTY/dMxrK9u9MjTcCIsw/70eIIiihIHGNCIkmhyS4LK+caoU6p1+w==
X-Received: by 2002:a05:6a00:1515:b0:640:e12a:3a20 with SMTP id q21-20020a056a00151500b00640e12a3a20mr1786945pfu.1.1682587689567;
        Thu, 27 Apr 2023 02:28:09 -0700 (PDT)
Received: from sunil-laptop ([2409:4071:6e90:4e5:b276:2557:8da6:6c7e])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b00637ca3eada8sm12756319pfl.6.2023.04.27.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 02:28:09 -0700 (PDT)
Date:   Thu, 27 Apr 2023 14:57:57 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V4 05/23] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
Message-ID: <ZEpAHfccImGsJGjk@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-6-sunilvl@ventanamicro.com>
 <87a5yua8vb.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5yua8vb.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Apr 26, 2023 at 06:47:20PM +0200, Björn Töpel wrote:
> Sunil V L <sunilvl@ventanamicro.com> writes:
> 
> > Without this, if the tables are larger than 4K,
> > acpi_map() will fail.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/osl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 3269a888fb7a..f725813d0cce 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
> >  	return NULL;
> >  }
> >  
> > -#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
> > +#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> >  /* ioremap will take care of cache attributes */
> >  #define should_use_kmap(pfn)   0
> 
> An observation, which can be addressed later; The acpi_os_ioremap()
> (called when the config above is enabled for RV), does not have an arch
> specific implementation for RISC-V. The generic one calls
> ioremap_cached(), which on RISC-V defaults to ioremap() -- caching
> disabled/_PAGE_IO.
> 
> That is probably not what we want, but rather something similar that
> arm64 does.
> 
Actually, for RISC-V acpi_os_ioremap() is currently a wrapper around
memremap(). Sure, this can be enhanced in future if required.

Thanks,
Sunil
