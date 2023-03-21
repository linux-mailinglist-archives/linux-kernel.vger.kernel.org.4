Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97E6C2950
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCUEvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCUEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:51:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2FC311C0;
        Mon, 20 Mar 2023 21:51:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so4136071pjk.2;
        Mon, 20 Mar 2023 21:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374285;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKZP2IQeKZfNceJJqfFFb5gI4In1QhMPjIWGQ5RwEkE=;
        b=SFXLLRhog3LvGvScuULZnc/enXzhQoFExWZNbsG4AYv/4AjaXHjF0RTPQeCprMdDhA
         NEkiLvFCeeI1Gf8e7MoCgclYAqipZ8RttL5tz9EAMgU32OnVqOyeploWGO3/cXrvz5FS
         R9xPL3ZLHDO9b7RySLXic9MdaEbmbBQXw4FRv6iuQkQgcV6SG2GR4fJ9XgUQTatJqAF1
         w32eymlkJg+Qi5sSdcfDYxBaUCfjC1ZL26nNMU8GNUSILO30e132JwALOTtuKNJFtrDa
         yGq2vDOhQcuaexmMjngTAJ/RVXe2+KZckmQpsGV6gjeaJ+9eCr+jJ5zWfVTh+TipxdF8
         pOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374285;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKZP2IQeKZfNceJJqfFFb5gI4In1QhMPjIWGQ5RwEkE=;
        b=sVV9ikk5IrpI2ZqJYmlTEFy3rsd1GrGxlgcERyMzyXYPURdyYa34lfg+msyI94lwXR
         8eibeR0fwIdV0CDVnGiahOnpnC2Vs494r5opZ2diHM/ad7WmSh7IsYcxfPCjdiJnymeY
         NSdOo1Cm859vUED5sgKObEcqi2ReItvLwF5D/uP9KIoHRovSnygmGe7kV0u0GlhfyncD
         v0CeiEZGQS716uAoi8ZXdZ1lnnRRK8HiCOw+5pSuakyedy6JkRVZHbBgp4Umsci2NI4L
         e4I2ycnfrJFXlVUuCWy19OZuw1s187HjJ6XRJZ2GuqCVguNkrMwvjXX5KtYFrpqPZFHn
         XKrA==
X-Gm-Message-State: AO0yUKX5o8ZitR1r4kCHxnFHGnSsrEbn/fUx1awRdsWfqeLI8ott2esn
        NzTbewtRwXAeojDHVTuE10XZaHeDy1Y=
X-Google-Smtp-Source: AK7set8bDzX0n3tWpsGHWVc7Zj7sEWISqlDTyyvnJYoYo2YgNuT9td8Abvmv9Kf6PldxKVxME+uGSA==
X-Received: by 2002:a17:902:e882:b0:19a:b869:f2f8 with SMTP id w2-20020a170902e88200b0019ab869f2f8mr1279683plg.21.1679374285157;
        Mon, 20 Mar 2023 21:51:25 -0700 (PDT)
Received: from localhost (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001a1dc2be791sm1559646plq.259.2023.03.20.21.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 21:51:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Mar 2023 14:51:20 +1000
Message-Id: <CRBSHXMZX79O.ESN0S8V6M644@bobo>
Subject: Re: [RFC PATCH 04/13] powerpc/dexcr: Support userspace ROP
 protection
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-5-bgray@linux.ibm.com>
 <CQZW0SBFI6QM.3FW6O6LJ0PVS1@bobo>
 <eb19afda911f4868ec6ff194738afcfe7050d5c1.camel@linux.ibm.com>
In-Reply-To: <eb19afda911f4868ec6ff194738afcfe7050d5c1.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 7, 2023 at 3:37 PM AEST, Benjamin Gray wrote:
> On Tue, 2023-03-07 at 15:05 +1000, Nicholas Piggin wrote:
> > I think it is not quite per-process? I don't actually know how the
> > user
> > toolchain side is put together, but I'm thinking we can not give it a
> > new
> > salt on fork(), but we could on exec(). I think we could actually
> > give
> > each thread their own salt within a process too, right?
>
> Yeah, the error case is we return further than we called in a given
> execution context. A forked child may return after the fork, meaning it
> needs the same key as the parent for the hashchk to work. Exec can get
> a new key because we can't return with any existing hashes. I haven't
> seen enough of kernel thread support to know if/how we can give threads
> their own key. I believe they go through the fork() call that copies
> the parent key currently.

Could look at possibly doing per-thread keys afterward but what you're
doing makes sense so no problem.

Thanks,
Nick
