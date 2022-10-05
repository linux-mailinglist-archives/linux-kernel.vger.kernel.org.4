Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE05F54C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJEMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJEMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:55:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6531DC6;
        Wed,  5 Oct 2022 05:55:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so9951732edd.4;
        Wed, 05 Oct 2022 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKnfwKM3GfRfs1GdFXL3EzRBmRr1ntc133LstIFT5HA=;
        b=o8QZPc5baW5MF1RQoJHAZH7Gt6DAVEiyOTNqCpenkZ/Dl5z9UvI5H3fyFiQDIK4bNg
         8cFH0jFD9HXfmdSsw2rB7YnGc0WNCyXNNMiT4zCg69K+sM5KZk00aK/qXiUAhfIGiGw3
         hWg7SpUmZGGt+zhkcT04eN66aKclL0eMvEfnExbzBQDRdstHUV+yiDNhuX/ZaX8x7viZ
         EQflDDyyW8t7y/pPTuicCw/TO2ma7EmB/EFjPgoWOpN3e0+mNrHys146rf7RsHDtSh4z
         mp98Gw8k6GoEv63xjZ1xGnK+DlTVKtX74it0iuHKbYK6XJlp6cyPKivTELOShdhfENpx
         LPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKnfwKM3GfRfs1GdFXL3EzRBmRr1ntc133LstIFT5HA=;
        b=krpFjX5kXNZy3mHZwqwhgq4mHPXtNBoF66+3hAEmsBFUByekYICjpkvLqQr69pqZPE
         8Reuh7q2ZI69n4/JgpAVkLUJMEE7+TdmLs4X9Vak9wlTNEVA4wXJwONLPgpo3WLpU7/K
         k7gi+EfnK3xYmsTel/eSX5faunhToI0avSOu/cF2CIUDBdnPYcNQBVzOH61X6fbpPXG4
         IpXcSw3TAmPN2OgSXn3myB+tL8c3qVGbouF1CEAuEjW+vl4pEM1EVTUqPy7BHNCkLJnA
         KsiQ4I5fW9tLoe58R4LUjuD2wHtQnqN74mzW9F60tgy9P3/M3vEBCv3sttfoivjFXxpW
         yMGw==
X-Gm-Message-State: ACrzQf1ZbhfTdcMPDVQzs14ltx75lcNh3D8pnXuvY/yozZGQX1+UvLIt
        BwRydHjXJXgUPIXCMzMe3In+PiWdCPcv83gsTeZj+IbI05w=
X-Google-Smtp-Source: AMsMyM4mEKd/pYQZ/4I5Ga208z8FXCa8herdyafq8+yOwo59j75Fhorq9MRycpNLUkv7W2+EH3+ORbMqUgxxYATCSmY=
X-Received: by 2002:a05:6402:1356:b0:459:3c9e:81d4 with SMTP id
 y22-20020a056402135600b004593c9e81d4mr10066457edw.148.1664974502908; Wed, 05
 Oct 2022 05:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <Yz1t6rPLOzKT8Id+@debian> <CAAhV-H7FoDEEtqF_ZOwTGPeGK-4wpzsxEqvO+iuq=KpEuDUofQ@mail.gmail.com>
In-Reply-To: <CAAhV-H7FoDEEtqF_ZOwTGPeGK-4wpzsxEqvO+iuq=KpEuDUofQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 5 Oct 2022 13:54:26 +0100
Message-ID: <CADVatmOmtd0jfzNvpyMiQnN0nUn3qZFjLnTjxrn7km3p-grwpQ@mail.gmail.com>
Subject: Re: build failure of next-20221005 due to 4078ec1ef5ed ("LoongArch:
 Use TLB for ioremap()")
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:30 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Sudip,
>
> This seems a false positive. When the implementation of iounmap() is
> empty (but this is completely legal I think), these drivers will cause
> "unused variable error".

And that error will fail the build as allmodconfig will have CONFIG_WERROR=y.

-- 
Regards
Sudip
