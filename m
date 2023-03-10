Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33806B4B99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjCJPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCJPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:47:03 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4268618BC;
        Fri, 10 Mar 2023 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=322B1m2G3BcD2sssoION+5o34zLT/+xp7riwNA/mVhQ=; b=jdxP56uRGPDoSItYG1+uqvDtmZ
        Y7niNUGMnLSrNMsZhK8E5w+eipM0QWp3NSGZqKM3SNThd0f4wcwC891994DZcSr+iw06DV72DAThX
        LSixnthuXFaS1Pt7k7MKPntS3VC8kyRtNe4GDoSUWlGaUFWY3fb6XW6kQn0Z0+0xVFwuMZAE5JAr3
        EU2A/F73QzaZKyMtmX76GuHgoAuTiybYMdQ27fLB4lB0Ov6b5udIWFy5ZdK2azk83Wvx6PBHbFOk9
        J5SZI8ZD7MpDfLe2mo/URemXFiCsvcGEaY7mm4Md14OnpobGu2VISmDHheqLO/TpwKaAoOej2e1F3
        Qi4Wag1g==;
Received: from 201-68-164-191.dsl.telesp.net.br ([201.68.164.191] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1paenx-002uoM-1B; Fri, 10 Mar 2023 16:37:13 +0100
Message-ID: <68be269c-1b51-e0e2-0c2b-34235983889a@igalia.com>
Date:   Fri, 10 Mar 2023 12:37:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: About the .scmversion removal (commit f6e09b07cc12)
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, nathan@kernel.org,
        rasmus.villemoes@prevas.dk,
        Nick Desaulniers <ndesaulniers@google.com>, nicolas@fjasle.eu,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <a10e1319-b631-6d3b-5e1d-b07223350502@igalia.com>
 <CAK7LNAQmXwpEpY84-fdLiwALSFLUEkfsOHejbqy33c6ceM=4Tw@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAK7LNAQmXwpEpY84-fdLiwALSFLUEkfsOHejbqy33c6ceM=4Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 21:51, Masahiro Yamada wrote:
> [...]
> Not a silly question, but .scmversion was intended for source
> package creation (deb, rpm) in my understanding.
> 
> If you want to use a fixed string for the UTS version,
> please pass KERNELRELEASE=<some-string> to the build command line.
> 

Thanks! It seems..it didn't work for me, probably I'm doing something wrong.

KERNELRELEASE="6.3.0-rc1-gpiccoli" make all -j128
Does it make sense for you? It gets me:


$ file arch/x86/boot/bzImage

arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version
6.3.0-rc1-gpiccoli-00003-gb6224c91dbaa (gpiccoli@buildbox2) [...]


Thanks in advance,


Guilherme
