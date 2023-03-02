Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11A76A7BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCBHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBHJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:09:18 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE3193D0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:09:17 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q15so12798590oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677740957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVxK4BPgAsT0uTtcvd1OH3/3ZfA2cQPLiNpDo/mOoSc=;
        b=Ljm3CQge1WYcGrb6JauClAAC7NViBD0HbImUXAUuhRFfMNnD8ooAMHRwMHJlRjJm5k
         wsK1G/ywOIrRAJtcvH6w0TMjYSxnr8b4+DAcPsGKsZcM/CCCEoSFuDgohhsd4N3w3a7c
         ARFVyCjCorzHgfjk8qCAzJUdd9s0urBU2KLA89EBo0pj+RyikKT2mE1iQtx3DPSUVAx3
         CG3mJtzNwky3N6G2LdUAE/7mVJovQcrejmh2xksVMcl98dKfOROTd1kHDMqXbmks2eqL
         wKMiQzc2VjM2a1zpyAsEJUHWEsiZxPQJ2nBH39QdUoK0EZ4b48mwSo1OTFoSsbtrIOxO
         tI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677740957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVxK4BPgAsT0uTtcvd1OH3/3ZfA2cQPLiNpDo/mOoSc=;
        b=T5PfqiWCC56AXAyJJ0yOnscay0/SFamkkYFWSMCrywTxTnZkqq8FhOShckhBORxgXw
         NW+ujgDCyuDXJnPH5UiB1K8ZaHZi1g45u0nmA0b9VrJdm21cnQ2doJIuaL8Giqp8U8Sj
         xwVfh2ddx4SrbTf7NFxWCxrhJFeZlSJgSdiSaJsAqYBub/5SBVIyHjaPxd49nvUoDt2f
         IAa6s8nLPbmBzmMPJViAoVatXXEj/5EkpmjofBtcQskk+LhGeYP6w6RM9gTegVMkM4C9
         t9iLBTUQVBsi5BjB11UOzlwR/AsYGSSt0KrLoBqx6MkPzQAfRUs3SlnodnMEf1w/+QAF
         BLJg==
X-Gm-Message-State: AO0yUKXv9UOapBbOqKuheDmG0LVs+7HYuMwu2IT5RDkO5IzAmtRKjT5z
        fVL+ERL8ff+d3woMcYmceWw=
X-Google-Smtp-Source: AK7set+bAMO/ye8Z4AVnz02wxyQHMT9KO8ysu8610AaQeGoxs2iRQBZwmhMj2z6vN7kQvkSyrQ0uiw==
X-Received: by 2002:a54:4888:0:b0:37f:b1d6:9f3c with SMTP id r8-20020a544888000000b0037fb1d69f3cmr4696760oic.46.1677740956688;
        Wed, 01 Mar 2023 23:09:16 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id sc15-20020a056871220f00b0016e9308e17bsm1724132oab.52.2023.03.01.23.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:09:16 -0800 (PST)
Date:   Wed, 1 Mar 2023 23:09:14 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: fix function description kernel-doc notation
Message-ID: <ZABLmnRB3nWzNV8f@yury-laptop>
References: <20230102211830.2674-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102211830.2674-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:18:30PM -0800, Randy Dunlap wrote:
> Use kernel-doc notation for the function description to prevent
> a warning:
> 
> lib/cpumask.c:160: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Returns an arbitrary cpu within srcp1 & srcp2.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.
