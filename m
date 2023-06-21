Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF163737CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjFUH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFUH6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:58:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893D1712
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:58:08 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDD65660000E;
        Wed, 21 Jun 2023 08:58:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687334286;
        bh=wbEoKbWYhhhgVeRpxk2hZ6u/CPga6SFFXTn2OH3ChCo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=k6BglyF1lU5/n1s+Rw70+F23h8RHTZcM4IoenAX9rUBC9xl4EUJQAF6ILK2D/0oz0
         I9b9Tv9GAeI+pIOFIn+STouQBcl/u7+UDSakR3+Q0p4np77sKmvtlU/sbXveNJv8ME
         8d1qqBLUhD7NAde/qfO3TuFtcC1Aoi6XETIHsEyY2uFfY4EFQGMmZyonLf8Jgcjwvj
         BrFEGM/RxUP1k4dvZHVIDOYpyaTuMNfNeMOcpP0QKh9KWJw2ToR/210Ft1B15KGNeD
         zmLR0ur13HGoPJjgQtFSFcUhFEyNEcL2v/DxmR2TuGe82JWKufp9tNcPwOQRVwAG/T
         NHpXx0veVdBKQ==
Message-ID: <892273c4-82b2-47d5-c03c-2d298424c18f@collabora.com>
Date:   Wed, 21 Jun 2023 10:58:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] AMD Vangogh support for NAU8821/MAX98388
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 01:27, Cristian Ciocaltea wrote:
> This patch series extends the Vangogh machine driver to support a variant based
> on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 Speaker Amplifier.

Please ignore this for the moment, as it depends on a firmware upgrade
and would break the existing devices based on the CS35L41 codec.

I will resend as soon as a proper solution is figured out.

Thanks,
Cristian
