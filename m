Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02C6AD637
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCGE2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCGE2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:28:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2F32CC4;
        Mon,  6 Mar 2023 20:28:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so15366045pjb.1;
        Mon, 06 Mar 2023 20:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678163326;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp9R6vPlKnj/ILvnBD3pKbQA35hbCkoBxOAhDB5hqKo=;
        b=fyIzTEhBz1mQ8ft2bA/ZOMCA8Gtuj0t/ia4tsMxWGXX0X1UbNw3hA0LuAZsN/6AtAL
         m611u35Lk8ixB39pGiK1zyUUCpuMX8ulBZiDRCKnIX4g0LHjgdB1yrDyc4KYgDiba+hQ
         EfR5IiIGpX8g8SkPJ6+inj3fNgQSGf4H9ZDFjcVkd7b+4blE//8FR/cnbI8ZwjkZwepP
         I8xzCcyB2i5KExRwPB+XsiitnXddxCAHXGILHdP2MjBJFYYRJw/NURVjj8+Adm+59Uvc
         jdYFrwB3psWPk+1xW5nqE8o5AC6AcqhamSPeG/+Q3wpzBgO45SdUAutZJku0/Jllaoxq
         VWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678163326;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hp9R6vPlKnj/ILvnBD3pKbQA35hbCkoBxOAhDB5hqKo=;
        b=RVn+yxaCxiGxMPL73Zx17Q2UgcoWxQTT3iONDsSzdf5BuGdLsSP721sLsNpWCK92+v
         2rwOufFLoqk2nYx59dsd/m8wPBeOm810IKHWkKd1ugUKxbGuTn/+V9MLcT9fbZT9/hv3
         TYt/hBTyQpeX7POIUdM069erflFCEReF7oJSKZKEMeQQ7mUFTShxR90BrqusFWQbnB2L
         zJxK4N8fSQEdYqYJDY6nxv7fUfkUe6qxdyjyn/BixEprDxFU65qmXFNNXYbXyOt/Sv/x
         fE7WE4RF4S2F+n+/UKpHJLaxMjjZ5W0i/NwmtGoahSNvCOlxs3JQzPl0NOv/RJx1JKye
         NkGg==
X-Gm-Message-State: AO0yUKV2RThfFsWVyxsZd0mDsAOMIa6M/8fE94z3m5AhYHwelx0/Libd
        UluTrf7KdRF94BvuflhffqTeG0eRk90=
X-Google-Smtp-Source: AK7set+ZoCXFRxmw3xfg33gXM2P3tsLEJa9DJEocvO6lGYXdWADo1YI5Lmv+//q2f/ncJIF4ss17GQ==
X-Received: by 2002:a17:90b:4d0a:b0:23a:87d1:9586 with SMTP id mw10-20020a17090b4d0a00b0023a87d19586mr12039984pjb.23.1678163326158;
        Mon, 06 Mar 2023 20:28:46 -0800 (PST)
Received: from localhost ([203.220.77.23])
        by smtp.gmail.com with ESMTPSA id r3-20020a17090aa08300b00230befd3b2csm8767326pjp.6.2023.03.06.20.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 20:28:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 14:28:39 +1000
Message-Id: <CQZV8XYSLJEU.PYMU50J2TDQH@bobo>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
Subject: Re: [RFC PATCH 01/13] powerpc/book3s: Add missing <linux/sched.h>
 include
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-2-bgray@linux.ibm.com>
In-Reply-To: <20221128024458.46121-2-bgray@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> The functions here use struct thread_struct fields, so need to import
> the full definition from <linux/sched.h>. The <asm/current.h> header
> that defines current only forward declares struct thread_struct.
>
> Failing to include this <linux/sched.h> header leads to a compilation
> error when a translation unit does not also include <linux/sched.h>
> indirectly.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/book3s/64/kup.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/incl=
ude/asm/book3s/64/kup.h
> index 54cf46808157..84c09e546115 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup.h
> @@ -194,6 +194,7 @@
>  #else /* !__ASSEMBLY__ */
> =20
>  #include <linux/jump_label.h>
> +#include <linux/sched.h>
> =20
>  DECLARE_STATIC_KEY_FALSE(uaccess_flush_key);
> =20
> --=20
> 2.38.1

