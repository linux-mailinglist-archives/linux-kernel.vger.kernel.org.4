Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D26B8335
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCMU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCMU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:57:29 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642018236C;
        Mon, 13 Mar 2023 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m3KRKIIxdQGzDnfQbP1Rf414m0PFZ7Oc2osrdxzJBmk=; b=mOvcffLPKSHMzp5msUiTRSnf6M
        GACFCJHb1oFRC8NQpHSfAxYCgkrg/YW4MaAikPTySg4VabWqIWcicuLikA5eGcoft5ayR7AEHZV6O
        AqOMLj6RRJpOM9Z9SjqeVev1BjlPqhNi3gSfEdVD4z9cbj1RWcbFnwEXDMDozw0N6D8GgA4Dw7bOH
        9gJ0xIw1nJQE2TlmURapIZMFBKDKw691LB5Lv54I1HNxuvPy26M9okKO7EOVpwOz+p3K70QegGPjL
        klhC7WHA6YkPNA9jNSN8xFBGQthVjwrCS8y0++66L2bx40qUFjWm3N1IPzSSf6iERzHXxRqAH3eqJ
        JuhuUCvg==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pbpEQ-008SEj-0N; Mon, 13 Mar 2023 21:57:22 +0100
Message-ID: <522c745a-4e4c-8c6c-cca5-0d4ebc76ace3@igalia.com>
Date:   Mon, 13 Mar 2023 17:57:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] alpha: Clean-up the panic notifier code
Content-Language: en-US
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Petr Mladek <pmladek@suse.com>
References: <20230220212245.153554-1-gpiccoli@igalia.com>
 <ba225af5-3729-32a4-318a-c1c4b8e8b37a@igalia.com>
 <CAEdQ38HS=V9QJsdSoccos02HGn4=QKobkci=BTP9tc3=RyzUFQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAEdQ38HS=V9QJsdSoccos02HGn4=QKobkci=BTP9tc3=RyzUFQ@mail.gmail.com>
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

On 13/03/2023 17:39, Matt Turner wrote:
> [...]
> My apologies. I meant to include this in my last pull request.
> 
> I'll take it through my tree.
> 
> Thanks,
> Matt

Hi Matt, no need for apologies - thanks for including!
Cheers,


Guilherme
