Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625373E429
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjFZQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFZQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:05:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5AD1B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:05:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991aac97802so185698666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687795542; x=1690387542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeZ2gJ78a8GPVtCoXPkcAEj2A8pLXaEVQFdsULkrHhc=;
        b=jEWUUYrwq+I7qYap8fYbNnhmWuPRYIfZ90Rtqjw5+TT0j7h3+O+JlSrwo/JgaKqr4W
         p3Qc0lIur63SOy/9nVNGESmL8qMzDlfUfeRolhh3ZGgGofF39npPWZTXx/NLSjlFylXy
         OwcxhP2X1HmNyo1lGb9c7ba+as0ILVT3aLJr8kz5yGpQvybGcz0M4nZvMO5dSYvVShlp
         mJpEdNjO8YT3HiHGyScAYstiNItI56E8LEZzhXG9xGuEVa54plRs8mq3CLgHfH4fdsyG
         c3fQpSRDFKCZXUbc2gpQ2bDn6Oa10jBsu1RnUce4zLCCXVu1uwtApMJxK5/El3tzIZUS
         0mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795542; x=1690387542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeZ2gJ78a8GPVtCoXPkcAEj2A8pLXaEVQFdsULkrHhc=;
        b=TfGzlLLEale3SAWmCFeFHXvBT0qsnOYP1dtMRvrALBHFhM172j/YgKWG/eHJQq1Fbu
         SSUNIKg+d2MkvEp26B9gsvSz5MG0lUjVMG8JBdYN8vq01aYu0V+aHJodNc66S52ZiHPX
         8l1euLz/H4xuXihckIFR0lR/TWZzna/IvoDsEKKtCxfIjayKM2Xw/AGjeOn/nM4U8wHa
         MmQgMwM7YTeXV6ZZSSEzil59CIR4InnQ9YGTCCEufZgeu1SAvqufxsoA1kNR64NcRU9q
         rSwLJiNZKzt6NJtiqkqXycRN5hcODifreT22q+JLLa5X4Djv1rE8QByGWXWqCwRbItDu
         Jlhw==
X-Gm-Message-State: AC+VfDyanOrz7ZJ2duKkty/0U8lUB1KhcgzU2W0NJ+w9AeFWodIbs1d9
        ctIzotcKMHQ720aoU7K0TYQDwg==
X-Google-Smtp-Source: ACHHUZ6SnSRadXIWV7VvaW8UyxWKn2ImofeQoznE415eOPemw6zL9MGMc9FMnlWeraLZOM63YoxFyA==
X-Received: by 2002:a17:907:983:b0:94e:2db:533e with SMTP id bf3-20020a170907098300b0094e02db533emr28662335ejc.49.1687795542064;
        Mon, 26 Jun 2023 09:05:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906491500b009828dac8425sm3421335ejq.105.2023.06.26.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:05:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:05:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <20230626-4fb963235f3ab08383a6d9ab@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-silk-colonize-824390303994@wendy>
 <20230626-e3ea7beb39c584bfbf7ee836@orel>
 <20230626-dragonish-romp-9acf4846ae01@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-dragonish-romp-9acf4846ae01@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:51:29PM +0100, Conor Dooley wrote:
> On Mon, Jun 26, 2023 at 05:14:15PM +0200, Andrew Jones wrote:
> > On Mon, Jun 26, 2023 at 12:19:39PM +0100, Conor Dooley wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > @@ -333,8 +335,6 @@ static int c_show(struct seq_file *m, void *v)
> > >  
> > >  		of_node_put(node);
> > >  	} else {
> > > -		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
> > > -			print_isa(m, isa);
> > >  
> > 
> > Extra blank line here to remove. Actually the whole 'else' can be removed
> > because the print_mmu() call can be brought up above the
> > 'if (acpi_disabled)'
> 
> Can it be? I intentionally did not make that change - wasn't sure
> whether re-ordering the fields in there was permissible.

I agree we shouldn't change the order, but moving print_mmu() up won't,
afaict.

> 
> One of the few things I know does parsing of /proc/cpuinfo is:
> https://github.com/google/cpu_features/blob/main/src/impl_riscv_linux.c
> and that doesn't seem to care about the mmu, but does rely on
> vendor/uarch ordering.
> 
> Makes me wonder, does ACPI break things by leaving out uarch/vendor
> fields, if there is something that expects them to exist? We should
> not intentionally break stuff in /proc/cpuinfo, but can't say I feel any
> sympathy for naively parsing it.

Yes, it would be nice for ACPI to be consistent. I'm not sure what can be
done about that.

Thanks,
drew

> 
> > >  		print_mmu(m);
> 


