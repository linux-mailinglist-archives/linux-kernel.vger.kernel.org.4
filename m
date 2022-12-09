Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E4E64824F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLIMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:21:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2114219C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:21:21 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so3409417qtb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 04:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqHr86p38/ahhMMntxCit7rBXX2FGTwoGGuYENfxfkw=;
        b=me7hH9eK8xEViajfD3/ge6xV9UYEwjUHb1cxDB5Zx4id5QpJ/ed7BO8baLZ2lHwYiK
         jo53vr8D2Qgda/300i18jmH4WkYm7aZwXv/qXnjpdMdr4+K/qofcUpAwVYgPQg0Ur2d7
         xr/3JIowbb56/gQmJCl+ada34ziC65tLr4UiwX6OytOH9ra+oHiBHQ4C4X/1fRGc6wPW
         g8umbUjB//+sf9D4hhfXDAfZsYYK/vbAa7V0pbTlbjzCtSSkQ5nZEpWqntS/6pAz1pQf
         HceDH/nPI9hd3vzvZiR4NnzUeM/5FmrmTRKMJz1rD2okMA+LciMI7rBBS2MukNJ3fB+u
         hU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqHr86p38/ahhMMntxCit7rBXX2FGTwoGGuYENfxfkw=;
        b=qTpMg5rwvS5inYom7igzh4a261UsEOl2w/uRlVIZRZ/+CL9n+4e2JJqMTMZ934VXm5
         +Cx/UoYD86osGViG52eWK72TdsB640mwWrA8oXIGYkWKwtcwEAjQ+4EG6o++M9QGRxLc
         uFCn164u8BXI9hsstuAbXr4ANf6pluv53HLcdFcCjSKPTzA5pVdRjaU3+GDp/ZuOZI2X
         XaE0ceRJrISJ92MPOe5k9yg8T36UPGCnpHnLcIDh+8JSKBNcEOfG39I2wzOseBK5A80T
         Sr8P4NEDCwCsCuqwCxqRysTK/bnv/LtfwQSgMswMpsZJEc7+dCs4CnLQLOTwBy7Xe8z5
         z28g==
X-Gm-Message-State: ANoB5pn/Ytc2nAz6XtSabk1ejxBEeJH4apxYsyga9w9OwWQOOfFXqmyC
        h/c5Nr5avqWNGS7j5BzoiQew
X-Google-Smtp-Source: AA0mqf6jy5TEadrryrnY9gwsb6bsAL/EY3tPtxte5XewddTH+2WwuTaDxWqGXYssr+ntoNxx7FTEzg==
X-Received: by 2002:a05:622a:4084:b0:3a7:ec9b:e00b with SMTP id cg4-20020a05622a408400b003a7ec9be00bmr8990106qtb.68.1670588480205;
        Fri, 09 Dec 2022 04:21:20 -0800 (PST)
Received: from bruce.bluespec.com ([38.70.11.69])
        by smtp.gmail.com with ESMTPSA id w4-20020ac843c4000000b003a606428a59sm737839qtn.91.2022.12.09.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:21:19 -0800 (PST)
Date:   Fri, 9 Dec 2022 07:21:17 -0500
From:   Darius Rad <darius@bluespec.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Message-ID: <Y5MoPdYimQtqQvkM@bruce.bluespec.com>
Mail-Followup-To: Florian Weimer <fweimer@redhat.com>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, greentime.hu@sifive.com,
        vincent.chen@sifive.com, andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
References: <b1dae947-d52a-d28e-5ddc-c1ad6d29828c@rivosinc.com>
 <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
 <CA++6G0D8RdjgvzQf-gMdakcF-Jj_PMjP=MBtAbSC0Qcu_WrTTQ@mail.gmail.com>
 <877cz0nbce.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cz0nbce.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
> * Andrew Waterman:
> 
> > This suggests that ld.so, early-stage libc, or possibly both will need
> > to make this prctl() call, perhaps by parsing the ELF headers of the
> > binary and each library to determine if the V extension is used.
> 
> If the string functions use the V extension, it will be enabled
> unconditionally.  So I don't see why it's okay for libc to trigger this
> alleged UAPI change, when the kernel can't do it by default.
> 

Because the call to enable can fail and userspace needs to deal with that.

// darius
