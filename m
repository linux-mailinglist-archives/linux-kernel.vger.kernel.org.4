Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F773F899
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjF0JU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjF0JUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:20:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26088F5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:20:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6689430d803so2334979b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687857646; x=1690449646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XVsJFmdbd/zeX9qSRdmE3bRDD3BvbBKjmT7lzeJYFI=;
        b=OAh7TtzaVO+UlOOQJyJ9xrabLVgSegIz2fL6LaDa4WwjgyzbEb1kcP1FP6O5xnmvI/
         ze5AUKEwvYBZ5EInEFO1Xs8Bz91VCP1CDKxLgvIqq/0vmvSGb3d8ZpsYcfgW95R6NTa0
         Y1LEns9zGjIAP+sQ6yWFwwgsg9wA6DJXmUdw0qipm7cx4OmZ7D+9JBVs737Tu4+kDe3A
         RLiOXGmpaz4da0ZZO0Rd0vSn4R9sf9UP/KHJJjASR7lYQsJjLNwZXohdN1ZRFjTEfQKE
         FSFbda42OutWyZ8vqY04cw93WsQzMewkqFE/RbfWc7KXa2UrdRpTfx/8a3Gw5J61MbSK
         rz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857646; x=1690449646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XVsJFmdbd/zeX9qSRdmE3bRDD3BvbBKjmT7lzeJYFI=;
        b=WeP9BRe32L95xIiCP4xyWi2eDSt1WYiSeWKo2VNqR14w+lOHAenzWakSErccH70L8W
         SVoBDDpUgVfeEp8oZ9LA//7IVETuCBy3+gVOrrz6+BiAc9/7SZfPCJHGcDmko1gR3Lvh
         Kl/3zcU9CdeG0B9w3vJcdDY6IJYxOP1LwfRHCDcRGX4IfQs9rdsy9imvJXxZ0JHrFCZH
         ny9IxI37l5y9kF45+8vgH7DohBWYvhEHoW0OHqk7ZULT0IQoQC2IbAmGahZnlLGUGige
         o+XumgI6R7mLNAAa/4E0i9Pnft7uX6+MwcOXqjkJYvA78j55kbO1Udmuin151OcIt9nm
         3ErA==
X-Gm-Message-State: AC+VfDwVq69SqSzK/h5TD118tMbLSaz3cepfhG7w0Mv7N76yykROt3n6
        3M55yKvXKYdulrF/AonwST5P/A==
X-Google-Smtp-Source: ACHHUZ5vPLufFchNUQw5j9frBzLGgGYE+5r/0tShLekGK+7fzkOQrIPjVM+qxgeIgQnyAqFK34hU9A==
X-Received: by 2002:a05:6a21:6811:b0:ff:8d85:9f24 with SMTP id wr17-20020a056a21681100b000ff8d859f24mr23766079pzb.50.1687857646470;
        Tue, 27 Jun 2023 02:20:46 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b00678afd4824asm2694935pfo.175.2023.06.27.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:20:46 -0700 (PDT)
Date:   Tue, 27 Jun 2023 14:50:38 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <ZJqp5nRx22J9ty6J@sunil-laptop>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-silk-colonize-824390303994@wendy>
 <20230626-e3ea7beb39c584bfbf7ee836@orel>
 <20230626-dragonish-romp-9acf4846ae01@spud>
 <20230626-4fb963235f3ab08383a6d9ab@orel>
 <20230626-ragweed-whenever-5b22e180dcd1@spud>
 <ZJqXj7UdegnRP4mI@sunil-laptop>
 <20230627-gosling-crouch-635c07ae05b3@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-gosling-crouch-635c07ae05b3@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:51:05AM +0100, Conor Dooley wrote:
> On Tue, Jun 27, 2023 at 01:32:23PM +0530, Sunil V L wrote:
> > On Mon, Jun 26, 2023 at 05:16:09PM +0100, Conor Dooley wrote:
> > > On Mon, Jun 26, 2023 at 06:05:40PM +0200, Andrew Jones wrote:
> > > > On Mon, Jun 26, 2023 at 04:51:29PM +0100, Conor Dooley wrote:
> > > > > On Mon, Jun 26, 2023 at 05:14:15PM +0200, Andrew Jones wrote:
> > > > > > On Mon, Jun 26, 2023 at 12:19:39PM +0100, Conor Dooley wrote:
> 
> > > > > One of the few things I know does parsing of /proc/cpuinfo is:
> > > > > https://github.com/google/cpu_features/blob/main/src/impl_riscv_linux.c
> > > > > and that doesn't seem to care about the mmu, but does rely on
> > > > > vendor/uarch ordering.
> > > > > 
> > > > > Makes me wonder, does ACPI break things by leaving out uarch/vendor
> > > > > fields, if there is something that expects them to exist? We should
> > > > > not intentionally break stuff in /proc/cpuinfo, but can't say I feel any
> > > > > sympathy for naively parsing it.
> > > > 
> > > > Yes, it would be nice for ACPI to be consistent. I'm not sure what can be
> > > > done about that.
> > > 
> > > Print "unknown", until there's a way of passing the info?
> > > Speaking of being an eejit, adding new fields to the file would probably
> > > break some really naive parsers & quite frankly that sort of thing can
> > > keep the pieces IMO. Ditto if adding more extensions breaks someone that
> > > expects _zicbom_zicboz that breaks when _zicbop is slid into the middle.
> 
> > Instead of unknown, could you print "risc-v" or "riscv"?
> 
> I don't really see how that is better. "riscv" is not the uarch or
> vendor. If we don't know, we should either say we don't know or omit the
> field IMO.
> 
Okay. Makes sense. In that case, I prefer to skip.
uarch is anyway printed using other ways. Even in DT, this is not
printed for generic cpus having compatible string riscv. So, consumers
should expect it not being printed.

Thanks,
Sunil
