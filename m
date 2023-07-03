Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440FB745E56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGCORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGCORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:17:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38604E59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:17:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso43206075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688393829; x=1690985829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7nRTxZW7CzMF8x6L9vlxMSTR8uIT9O6B/vDdhMl41M=;
        b=hymW8IG2ZTFaBo5EHFy2/EKitnCmH2B4pLg91wyqoTI4spEBDa9aP9Ua0u+Im6lqOD
         RaJA8E+nRzxaHQoGd287Kel7lTRyfo07b5Z2e2Vh9tefWUY8eXLEKrcha1L+m8w8gbNv
         IZ9eMfuvD8ol32wybA3RXkpJxgyzpx6lDcV/t9sFAIRpXULQNJ0sTkuFdSLwSqD36E/o
         pwi/vWT9cNI5X8gj5+kpWTJzWc3B6R//bjpHiuKWAq6Bd1IZvn24hw7SNNYRayWR+t19
         1BxFsS6Wy4vRGzJYTPgRC0oitOgSTbDHBQPwINS0rNa4XtRRuudRdfh5q/k0eTMxqbFD
         Rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393829; x=1690985829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7nRTxZW7CzMF8x6L9vlxMSTR8uIT9O6B/vDdhMl41M=;
        b=IHX7nRrAkSfqyjZgYt3rYg+3ZMITWYPJDZTzzd6eIO5OBfJVNma5tk6zUKzTjbbFtz
         +EPhrgUNRn8L1qOftdVWqHSoVidQ7zY0adm8i9tXHCl/fnognntuGsZVJr09hvz+6XHa
         cpsVEsZxzV+Hua3Gly6WoGQWq41dX67PbjDtwnDCll2U7gzN7BBqlvPpg8pDOATNIgJ0
         zNYtdBO8NjBNVeo9iLVys+JYldrmGcmg6QYGLGyjNaK5ym3kZidlKpQZH0qixJbjKUYL
         Y1zDAsmqoMQVwKP3mW0wac4e/iJKu0lAYNz+Z2Zi0u/zOGTQF5a8OH40qLEymcnHhS4p
         g/9Q==
X-Gm-Message-State: AC+VfDwX3ulQNDF/jiqOqRy3ls+FPnQylcVNxFg8GTaZsFmcIYeLD55x
        GqmzY0Z6WrzIBnbWq0JrpDFtfA==
X-Google-Smtp-Source: ACHHUZ4WBI6GLidOS0T1n6SOF6XWQ8OkVbHgTRncLHqekO96nc0/59TNZyymEHq3TfGx1g47smQe5A==
X-Received: by 2002:a05:600c:3799:b0:3fb:a8b0:521b with SMTP id o25-20020a05600c379900b003fba8b0521bmr9109503wmr.27.1688393829531;
        Mon, 03 Jul 2023 07:17:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j8-20020adfff88000000b0031412b685d2sm12148167wrr.32.2023.07.03.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:17:09 -0700 (PDT)
Date:   Mon, 3 Jul 2023 16:17:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230703-6ac90a2de15f1017bc0ced74@orel>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:30:10PM +0800, 运辉崔 wrote:
> Hi drew,
> 
> On Mon, Jul 3, 2023 at 9:01 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> >
> > (This is a reply to a non-existent cover letter.)
> 
> This has been discussed many times with Ard, Please refer to :
> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/

There's nothing in that thread that convinces me this is a good idea.
Indeed, afaict from that thread, Ard nacked this. It was only when it
was suggested that arch/riscv would own the code, that he stopped
complaining about it. I wouldn't call that an endorsement.

Thanks,
drew

> 
> 
> > I'm not a big fan of adding yet another interface. Have you considered
> > doing something like [1]?
> >
> > [1] https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg
> >
> > Thanks,
> > drew
> 
> Thanks,
> Yunhui
