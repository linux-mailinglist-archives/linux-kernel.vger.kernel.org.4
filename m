Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9474FDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGLDcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGLDcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:32:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4F910D2;
        Tue, 11 Jul 2023 20:32:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63770af327fso43876896d6.2;
        Tue, 11 Jul 2023 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689132734; x=1691724734;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvf0nF5ZRGZZqWs6AfvhMZd8lPGLYxeXrzMNbCUatcI=;
        b=SxWs7+NhmtFmcBIYeyB0DJkbyihTJ/eJTVplhF1PBnu+7xoaTjCtrLQrHuwdLeFQ78
         I3V+0ZV93yvXSyymfW23KSm49bdG2+cDQerjn3yUo7EY7/0mneaPnyICynnwfA41jpPA
         naFsV9h5672637AMbpuI5rKyDIB3JNrSXE1gmfIjsGRnHmGmIJya6kl1cK7Au5vlJ+o0
         qZ4wu7MQKjX1Qw9kEVfq2Uud8SykO3pPpDbkvH9aneGl/oxs8a+Tgu/ldl1ny5gWRfIK
         X1leUhBEIbA2PIMJjep3EInbKA1GWE9b1EsAy8+gD8hJkhSi7o6o9657r4Mm0u2QiaZh
         LL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689132734; x=1691724734;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvf0nF5ZRGZZqWs6AfvhMZd8lPGLYxeXrzMNbCUatcI=;
        b=O4yaN+EFP8AdfLOxS577hf0VSk7KISRInzAPBLrsjKBVlopLyYyenNcetoGrdYAIrv
         TavCEIiCURr6qJ3OFa0BiSbD2NPEMN7Ekr7H9oYXFfjSC3iEo/rSBOtx8830LTV7jHSK
         XKbGVVU/B9o2aB9LrWaISIg9GcYotdwu2mMGt5VTCyNGXUeuEgacU46v8udLmgMv4Ws7
         U7ri0rHlWTly9a4M4xbVyfYrCem0Gg1nQAZUWXFA5U+7CRF7T3yS7H4q9evk3eCjI8Ik
         9oq7Q3e7qU/4PLRKfXV68RtU8pSVFBGFXUSzMzQJs7831hbqJ6pOi1tKvTywKGkXUwHV
         gOXA==
X-Gm-Message-State: ABy/qLbaLPQVgpT3Tt4zlntZkxDMt/wmxlpgDJxfiJ0OS6556jfpN+Vm
        VZUT0fL7mziTsiTd1/nJiiGDyAgv/ck=
X-Google-Smtp-Source: APBJJlEi9cxhyg3FYQSwltq1b2CBfAz1F+0jG2fDBkJz+XscIpuisGIVjUha+zJXqw5Cv3MbLPDerw==
X-Received: by 2002:ac8:5cc8:0:b0:403:a770:e15a with SMTP id s8-20020ac85cc8000000b00403a770e15amr17034785qta.56.1689132733918;
        Tue, 11 Jul 2023 20:32:13 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0067ea048cf83sm2419276pfn.186.2023.07.11.20.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 20:32:13 -0700 (PDT)
Message-ID: <0475d177-4c01-0988-0b34-3099dd703498@gmail.com>
Date:   Wed, 12 Jul 2023 12:32:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     rdunlap@infradead.org
Cc:     amd-gfx@lists.freedesktop.org, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org>
Subject: Re: scripts/kernel-doc does not handle duplicate struct & function
 names (e.g., in amdgpu)
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> [just documenting this for posterity or in case someone wants to fix it.]
> 
> In drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, one can find both
> 
> struct amdgpu_vm_tlb_seq_cb {...};
> 
> and
> static void amdgpu_vm_tlb_seq_cb(...)
> 
> Of course C has no problem with this, but kernel-doc reports:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:833: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/driver-core:115.
> 
> And of course, if the name of one of them is changed, kernel-doc is all happy...
> not that I am suggesting that one of them should be changed.
> 
> I just want to make people aware of this. (or maybe people are already aware of this?)

The duplicate warning is emitted from Sphinx, not kernel-doc.

This is a bug of Sphinx >=3.1, first reported by Mauro back in September 2020 at:

    https://github.com/sphinx-doc/sphinx/issues/8241

It was closed when a local fix was presented.  Unfortunately, it was not
merged at the time and a subsequent pull request was opened at:

    https://github.com/sphinx-doc/sphinx/pull/8313

It is not merged yet and carries a milestone of Sphinx 7.x.

Looks like we need to wait patiently.

        Thanks, Akira

> 
> -- 
> ~Randy

