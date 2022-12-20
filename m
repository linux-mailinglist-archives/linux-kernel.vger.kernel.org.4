Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25287651FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiLTLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiLTLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:31:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720219027;
        Tue, 20 Dec 2022 03:31:01 -0800 (PST)
Received: from [192.168.231.135] (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8C3A6602C93;
        Tue, 20 Dec 2022 11:30:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671535860;
        bh=7KC4YI1sDz0S6IQfm/3XQMk26kdbVIwgc8Q3poa1r2o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GM2xSuclMOqT50UvTJT4P5UCtApCtyE+Uqp76bWqvdlkqBgk0LwMbmpvORs0EbilB
         SGP6+2tJd5NV+DiFb7EF2PCxWpf5yryVof1NqWfjJiSurcWM0yPgxB3aePSLafXaPb
         cuYAGHSMSL6EfCrMKgHxsKM1r2bpaADAq0eJofyrz9mzSJEsEMcmH+G2PoosIP7omz
         W0WNtpGIgq1kTtPxbbyneiHnk6Zg4ys5eTHQyQus7YaIpTpGZeOBgrta5LChwTu/aW
         /x+2gb8sbwQKFTpFGgdJ6bVemj2coiuHzhZJf4zgejwiEwDKDWPeFaatqhw1rFl/oa
         9J/x/2XYpMYQw==
Message-ID: <c8a55105-7dd4-c90c-33e2-31c4808892c6@collabora.com>
Date:   Tue, 20 Dec 2022 12:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <Y6F8dlRQbOzIvJff@debian.me>
 <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
 <20221220052333-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <20221220052333-mutt-send-email-mst@kernel.org>
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

On 20/12/22 11:25, Michael S. Tsirkin wrote:
> This doesn't matter I think, what Fixes tag does is tell tools
> if you have commit A you want this one on top.

Ok, thanks for clarifying. v3 submitted.

Cheers,
Ricardo
