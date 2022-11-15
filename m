Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B96292E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiKOIFo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 03:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiKOIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:05:41 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D2186FD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:05:40 -0800 (PST)
Received: from [127.0.0.1] (85-237-234-20.dynamic.orange.sk [85.237.234.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 795AD20097;
        Tue, 15 Nov 2022 09:05:37 +0100 (CET)
Date:   Tue, 15 Nov 2022 09:04:39 +0100
From:   Martin Botka <martin.botka@somainline.org>
To:     Samuel Holland <samuel@sholland.org>
CC:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: axp20x: Add support for AXP1530 variant
User-Agent: K-9 Mail for Android
In-Reply-To: <ac450a01-5771-be91-fda4-9b3084c9bff3@sholland.org>
References: <20221114162459.1802174-1-martin.botka@somainline.org> <202211150623.9oWDx9Ec-lkp@intel.com> <X11DLR.YBCMARW947UJ2@somainline.org> <ac450a01-5771-be91-fda4-9b3084c9bff3@sholland.org>
Message-ID: <8973FC7E-F973-4C99-B284-222686FFB670@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 15, 2022 8:02:00 AM GMT+01:00, Samuel Holland <samuel@sholland.org> wrote:
>Hi Martin,
>
>On 11/14/22 16:56, Martin Botka wrote:
>> Patch depends on the MFD driver which introduces also the regulator
>> definitions.
>
>Then you need to either send them together as a series, or wait until
>the MFD portion lands in linux-next.
>
>Regards,
>Samuel
>

Will do.
Regards,
Martin 
