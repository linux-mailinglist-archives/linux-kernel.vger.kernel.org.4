Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E86B6851
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCLQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCLQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:38:30 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A252211C2;
        Sun, 12 Mar 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DHqoww1vv8j4XTfx9Ao30Lqqi1EinOaI0Onfdai/x/E=; b=pV6xtOEsP0m+6S+c87wpBas8Jw
        uffNRVAoUu+VAUs4eTvjI3HqBP/RAyA4PixCZy/tXiBr8TbHLNLhoTU905UKff8G+4OOWDEO/ffI2
        tq1JT+fIrFAcb5SDpo2buJ5T/Yp22E4bf7rPjc13ocgFIc5Gvnq2dyjRPmuLzNtHlK9DY2oqZC/yU
        WP2A9IDlBEhcSHGxoEsTRvYWOiVSwmB83oMV8JwjjZ2e8Kl/9MCTyuVYgsSUHU+qzKzyjmO4RdxES
        GSYWPfIoKH0AkvtRdOKxfaFPR7jk03fSnPEp4htnJ8uW18j4NyBC4wvDdzlR4avePyPwWjTtsJEF8
        +pRz/UfQ==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pbOiB-0065qO-Sx; Sun, 12 Mar 2023 17:38:20 +0100
Message-ID: <ff81d5c2-0dc6-0374-f8f4-a8f480634705@igalia.com>
Date:   Sun, 12 Mar 2023 13:38:12 -0300
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
 <68be269c-1b51-e0e2-0c2b-34235983889a@igalia.com>
 <CAK7LNAQ-SuyUC8d+zZbo65mp=wGAC3VawP2Acwp5y6X1P4gsiw@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAK7LNAQ-SuyUC8d+zZbo65mp=wGAC3VawP2Acwp5y6X1P4gsiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 05:15, Masahiro Yamada wrote:
> [...]
> Try this:
> 
> make all -j128 KERNELRELEASE="6.3.0-rc1-gpiccoli"
> 

Worked like a charm! Thanks a lot for the help =)
Cheers,


Guilherme
