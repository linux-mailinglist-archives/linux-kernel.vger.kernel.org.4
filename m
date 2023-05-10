Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B16FD7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjEJG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjEJG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:58:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355055BE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:58:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so28816915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683701903; x=1686293903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ySej+k1OrwGyl4PfPNb9doHlUnZpL4SVS/pqSYTOh0=;
        b=Y3ZUM6/klFrxtnyfnYxwJpiffgTkxBnxOY1lh2I2gVmZW2LJ2A8Sje6gKprk1d78oX
         h0Bt7xX0rWu2sGtU4/WqTFeRSMqoyuyXnpWQ8BG1LfdlOce4w0Mj+5gTMbyWNs3fuu1J
         62yvFCfJMM0xBzIoqyWKMdifnBn2j87DM2Mq5AO5mW0EkgXz6dtgjZO601iJp7mABDDs
         KK05Q/vrCImCX4MK0IAg+VzdznSQ0eO20Ov4lrn9TC9oC6G/CaKoYVApqRp0/yf8UDFB
         EAZOzrTy86klGrFdmTtlL9rxIVArgrtHpgppPltxrPVzEXFbLg7gEIFb5lly/5Hi3a62
         5muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701903; x=1686293903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ySej+k1OrwGyl4PfPNb9doHlUnZpL4SVS/pqSYTOh0=;
        b=L38agLWkJtU7wt1khEfvdr+WGxTLvW78KZrDT4qgVMxSWtJnbRcEiXp8vVGUISmprq
         8CnhVq4wQSVaK3KGJPtcxzZxTqxjHRqeUPFRItKXGQzc0rFit4uYxitltg/6YTbUTXLv
         qq/zDAutGcaICmpkS5pgMhlHP8env8Td0J01UUFWa8pzusCxFlNHlanOVhPpZVj0ousw
         HwglA1o/XRqkGwHIzObg6uO/zX0Cwj9Ns2olH9OE0gsiPNX/Bi62UB7fKfX5wMP4Adfz
         ZXwc34o+/xxq0IRTmzCV55oLShsGYvmSOkCOV63dRboItMlGT1LccdXK9M8ZuHXJqf0y
         MP4A==
X-Gm-Message-State: AC+VfDzVbZ3iItZFYBGR0PxYa/9M9YSWokx06KxtckjGSEyWiUSI/Aw+
        yTp1UP5UVlXcCyZs/gLlwaD3bg==
X-Google-Smtp-Source: ACHHUZ6KTb6byTXGvgEtMzdoJn2BLJMZzTAREtlkqjSN+GSQs8r5cplAd7QJH7ZpD82g4DevcJ3QeA==
X-Received: by 2002:a7b:cb53:0:b0:3f2:53a5:d308 with SMTP id v19-20020a7bcb53000000b003f253a5d308mr10828292wmj.6.1683701903584;
        Tue, 09 May 2023 23:58:23 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003ee5fa61f45sm21779754wmb.3.2023.05.09.23.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:58:22 -0700 (PDT)
Date:   Wed, 10 May 2023 08:58:22 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH] riscv: Optimize memset
Message-ID: <20230510-0adf0b2a2956ca1cd426a2d2@orel>
References: <20230509-b0dc346928ddc8d2b5690f67@orel>
 <20230510035243.8586-1-zhang_fei_0403@163.com>
 <20230510035243.8586-4-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510035243.8586-4-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:52:43AM +0800, zhangfei wrote:
> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> 
> On Tue, May 09, 2023 11:16:33AM +0200, Andrew Jones wrote: 
> > On Tue, May 09, 2023 at 10:22:07AM +0800, zhangfei wrote:
> > > 
> > > Hi,
> > > 
> > > I filled head and tail with minimal branching. Each conditional ensures that 
> > > all the subsequently used offsets are well-defined and in the dest region.
> > 
> > I know. You trimmed my comment, so I'll quote myself, here
> > 
> > """
> > After the check of a2 against 6 above we know that offsets 6(t0)
> > and -7(a3) are safe. Are we trying to avoid too may redundant
> > stores with these additional checks?
> > """
> > 
> > So, again. Why the additional check against 8 above and, the one you
> > trimmed, checking 10?
> 
> Hi,
> 
> These additional checks are to avoid too many redundant stores. 
> 
> Adding a check for more than 8 bytes is because after the loop 
> segment '3' comes out, the remaining bytes are less than 8 bytes, 
> which also avoids redundant stores.

So the benchmarks showed these additional checks were necessary to avoid
making memset worse? Please add comments to the code explaining the
purpose of the checks.

Thanks,
drew
