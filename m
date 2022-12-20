Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E02651E52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiLTKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiLTKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:03:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B8140C9;
        Tue, 20 Dec 2022 02:01:32 -0800 (PST)
Received: from [192.168.231.135] (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87C34660000F;
        Tue, 20 Dec 2022 10:01:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671530491;
        bh=flyXusJqODPJKu6TN7Auaug9fZjIJwX+0zuYbQTZJaY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EQV5Zbu8P1X1vzeGTnGT6qRI3PvvMoyNmNH6g8UAfMznKvr/E/zCRb8kbmt/LmSJf
         KoKUIIvHJBDXUGMQKCRBS/rCGOHxAQ+r8Tato4vAdProkDAKHd6gZr5DFBwdZMcHkA
         XXnYXlM6Zbb9IlCkgdun5plMAOpyvXrrtCBQyXzqoLRfCWXIoEZ9lPRdj0GW7wzT3+
         4iOSV5VZSZDYFUtBCv15FKpuR5j0+tFN4JIe6X+5geGxE63rwPTVh7BN1WqWAAo3UH
         4R+SmAs0rP4ydSFXzQoqB59Sgim2Aei4sJJuxLcIUHmlzQS6TwbaQSgdybgyN2jpHp
         frDplvDPRE/4g==
Message-ID: <77e45c9f-d2ec-e4a0-6114-200fa1fdd018@collabora.com>
Date:   Tue, 20 Dec 2022 11:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <c0540d38-090a-abb8-654d-db61ce356349@collabora.com>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <c0540d38-090a-abb8-654d-db61ce356349@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/22 10:48, AngeloGioacchino Del Regno wrote:
> To avoid getting the same warning in the future (developer mistake and/or other
> reasons), what about dropping this instance of "Note:" entirely?
> 
> I think that something like...
> 
> the dev->feature bits if it wants. Note that despite the name....

Thanks for the suggestion, Angelo. Applied in v2.

Cheers,
Ricardo
