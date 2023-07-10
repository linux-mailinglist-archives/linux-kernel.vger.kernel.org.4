Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2A74CC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGJGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:07:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E032FA;
        Sun,  9 Jul 2023 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=oQXhVgQTx4b3mAE87s7NVQgHdTImNKK5z7OVmcPMPtQ=; b=wyEQOWD9CFXAOkEDUI4Y7RxG8L
        to0lJ6ZmjBsFi+0INaycSZ945WRcaUUyPwvjA8hrZ+Um5PAbQOeLxlPFkscPfhgJGjA6aAHtDefx/
        4BGZVVgh+xwge5z/3bao0saP5flIc9JAWHEs5u70UPz43DXylCFnL/T7doVZivibhV8Id7mexDGUG
        VQfN+Q5FfPWMsVxRcKvJXeXGT5081JRHsuLnjLlDNLnNKu7VoNNrvXFcuwTLRki1cGkfnSCKAFFyH
        gCtTzaxQqctcTMPr2VjLLDaFEINOG7rks2+d7xuSM6B0aF/UA1bymy/GwLaD/Ous5IsvkndDvFuNt
        pXn4VR9w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIk3c-00AXVy-1J;
        Mon, 10 Jul 2023 06:07:36 +0000
Message-ID: <e7747626-bc77-6142-4fa7-f9fc0f719432@infradead.org>
Date:   Sun, 9 Jul 2023 23:07:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Content-Language: en-US
To:     Maria Yu <quic_aiquny@quicinc.com>, will@kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com
Cc:     maz@kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_satyap@quicinc.com,
        quic_shashim@quicinc.com, quic_songxue@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710055955.36551-1-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/9/23 22:59, Maria Yu wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 85fb0fa5d091..6ad754549f1d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -433,6 +433,8 @@
>  	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
>  			Set instructions support
>  
> +	arm64.nolse_atomic [ARM64] Unconditionally disable LSE Atomic support
> +

These entries should remain in alphabetical order, so arm64.nolse_atomic
should be just after arm64.nobti.

Yes, these are not quite in the correct order. :(

Thanks.

>  	ataflop=	[HW,M68k]
>  
>  	atarimouse=	[HW,MOUSE] Atari Mouse

-- 
~Randy
