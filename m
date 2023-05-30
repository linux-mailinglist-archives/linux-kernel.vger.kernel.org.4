Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98B71620D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjE3NeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjE3NeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:34:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29445C7;
        Tue, 30 May 2023 06:33:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso4708395e87.3;
        Tue, 30 May 2023 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685453631; x=1688045631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+IulQIBtirUcThrjAwEkKzSGyWo6/XDwAC+HJ/65/5I=;
        b=kr7OVgrmo/3X1eom8iyxzWkSdXk1ttmznTxQpjpsaFIX1IMUu/yoMOhxprmNhjYsHq
         L8QeSsR+4OMALOpnnXbmDQMeZxF5G50BPboNMn2b6ahBxORavxPGUqhBzLZHMXzrK7j7
         7ogJNB8QCRlYYV0q7bX2j5GhjrI2OjX/bpaFrYLvQQxTq0ThvudhrKqdPCkaj9Ri4MIh
         vm9AIaihyfMh4uhKeh+e/TIHtcJDC8WNHtQbkNW31dT3TQ7QtciJ5pL8iCfZq5GcB/PC
         3YQeetIpZuzO5FX92uRxC1p/rT/K+YAkZA9GBGvHM/0HPlaw8TqZv8gPthXcZGCaIdWd
         Pbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453631; x=1688045631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IulQIBtirUcThrjAwEkKzSGyWo6/XDwAC+HJ/65/5I=;
        b=klDX0yGEU/w3PIauxIo73++VZQuCH84TmmE/ptkhs6ojuQc/hBZqagCyOEV80mCIrP
         dzYZl3hLNGov7zNL/0jebhW8+iSqwl1G4QAns9chGdZ+gUQ528dHeiCStPNtRWNaHIjn
         VSU7AvIFvGoZL/mjs8BPdOK0hWo8J1iG6E90OJbT+DhX91D/OKBRMJzAqtHwq6wZxLwu
         +l9ArvEipyjS6aQ5wqIDVLoKxXtshuxqMio6lwY7E3QnHTU6A6Lr3SmIUAXEXdr468qs
         Tu5ja868i6AMmgHtuWs2HBW23yYIzTs/ooCtYRkfICdhDPZ55CH0KAg2vqK00vJk9/D2
         8xmQ==
X-Gm-Message-State: AC+VfDyQzH0J6foB306obEPXpjvOMgx6NXPOntQSwGxxQL021qYXzep8
        BSaXhwLlbpbTCYl9MTI9eOU=
X-Google-Smtp-Source: ACHHUZ7vuybamP71v69D1Uku+zRrxT2GuYli2lK+3MPym5NsHOPxh0oeql2RkcBEdgWn7s9/m7bWtA==
X-Received: by 2002:ac2:4319:0:b0:4f1:3d9f:1b4f with SMTP id l25-20020ac24319000000b004f13d9f1b4fmr686765lfh.49.1685453631100;
        Tue, 30 May 2023 06:33:51 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id c15-20020a19760f000000b004f24e797c58sm340474lff.217.2023.05.30.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:33:50 -0700 (PDT)
Date:   Tue, 30 May 2023 16:33:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
Message-ID: <20230530133348.2jsrbkh6kixonwbm@mobilestation>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
 <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
 <5CC33034-4AF3-4522-9942-8BCCEF1086AE@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5CC33034-4AF3-4522-9942-8BCCEF1086AE@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:10:04PM +0100, Jiaxun Yang wrote:
> 
> 
> > 2023年5月30日 13:16，Maciej W. Rozycki <macro@orcam.me.uk> 写道：
> > 
> > On Tue, 30 May 2023, Jiaxun Yang wrote:
> > 
> >>> Sure, but this change is not needed for it.  You just need to declare 
> >>> which ISA revisions your platform supports and leave `__get_cpu_type' 
> >>> alone.  It has worked like that for a decade now.
> >> 
> >> I’m afraid it won’t work as you expected.
> >> 
> >> Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is optimised out
> >> by compiler, because the codepath is marked as unreachable.
> > 
> > Maybe there's a bug elsewhere then.  Send me your .config and I'll try to 
> > reproduce it.
> 

> Ok I see the problem, after applying patch 2 the issue is gone.
> So actually only patch 2 is necessary.
> 
> The unreachable mark here leads gcc to generate some confusing code
> and I misread it.
> 
> Sorry for the noise.

Great! Indeed enabling the SYS_HAS_CPU_MIPS32_R5 config is enough to
stop the CPU_P5600 being optimized out. Thanks for your work. Let me
know if you need some tests on another instance of the P5600 hw.

-Serge(y)

> 
> Thanks
> - Jiaxun
> 
> > 
> >  Maciej
> 
