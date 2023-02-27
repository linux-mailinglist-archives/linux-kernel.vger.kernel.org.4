Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105806A3DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjB0JDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjB0JCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:02:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2A1E5FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:53:23 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6EB76602E52;
        Mon, 27 Feb 2023 08:52:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677487941;
        bh=BulOGLOKzlIB0+/bAVSjgDvFC4bHgyqkAhu6rkh31DQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=njnlvTLpOGdWTryKU0CHx0XFsjCMXGGkKJC2DUDrB1Ph1wmQm7+HWX5HKu7J9HVR4
         61d7snZ6nI9f8y85tt6ZUpU9wD/copiLHxIzwsEAWZu+vr/DV4jzG1rWJMLJkM0Ta1
         FYqyoOENA62kKpbVIbYKJ6rSOHTjXE9JyWHn6RNvmyuicVRknNjwikWFnu9m1rd/as
         mYVdDpd8e7/EjS3EiVIUmWOFUGIROow3iBIoROZ0yqMLje3pjeBBqB0JlF7vk7ayrZ
         feZw5r3p4KK1aNlPNpxSx520yKUt9XAGa5AcnFY4YasSWxb9RvN+I8uFLxJBGKRZMj
         ei1fYei9WwLnA==
Message-ID: <b3a31d51-527f-dd77-6e27-6b75d53367e9@collabora.com>
Date:   Mon, 27 Feb 2023 09:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] ASoC: mt8192: Remove spammy log messages
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/02/23 15:03, Mark Brown ha scritto:
> There are a lot of info level log messages in the mt8192 ADDA driver which
> are trivially triggerable from userspace, many in normal operation. Remove
> these to avoid spamming the console.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


