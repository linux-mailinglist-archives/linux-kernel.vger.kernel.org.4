Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3A651B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiLTHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiLTHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:15:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347717052;
        Mon, 19 Dec 2022 23:09:27 -0800 (PST)
Received: from [192.168.231.135] (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A9426601810;
        Tue, 20 Dec 2022 07:04:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671519864;
        bh=xGn+8/nr0ZMmrYqa/W8ZhrdrWgKeEjTFd2dNCbdGsT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QQ376SxNm2GMhdQuqmdk7uEga4F+MnytbBrxizLE85NO7xZWPaRumM9OyK1zhQDrM
         +9SlrNRw2rc6sPo+Omh5aDeVhmXd/YNLSuwwnTzoT0NI/JSKc4dXNytQgBDbNFimdC
         J17S6J7/CN8zh30g8mDGpnJvSsygXdsXA1V4duzbF94/OR6iSTeYdWXgOhOZhkpPAi
         zzfKAVAxi2JK3wxbQF9f1CfAD5DrdYz3rQwSWJqnemt/mtm/OCzWYX6/a7g7xFgXv/
         4gvQbXrAKGhXgpBK5xVcEesZ7Zo72Qa6P6ji11dTdgoCi0BlMFAkjjYYev6zpWKhNA
         K9FCmOenTLtIQ==
Message-ID: <bf024c42-89e8-b60e-28c0-1afdd3e0ae53@collabora.com>
Date:   Tue, 20 Dec 2022 08:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: linux-next: build warning after merge of the vhost tree
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221220105956.4786852d@canb.auug.org.au>
 <20221220010040-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <20221220010040-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/22 7:01, Michael S. Tsirkin wrote:
> Ricardo I assume you will fix this? Patch on top is ok.

Yes, I'll take a look.

Cheers,
Ricardo
