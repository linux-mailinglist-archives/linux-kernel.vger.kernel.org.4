Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD805E64C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIVOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIVOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:11:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A6F393D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:10:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E089D6602226;
        Thu, 22 Sep 2022 15:10:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663855851;
        bh=TRFbPqxLjzBnnRuOCvs2z9tXxp7atOEkeLU6sHlD8YU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CxncZmHMmvJEFr47r1L2iLmzqZ6K/ReKW1iYT8vOzF88RAlJRHAyRpucfkUqZlCU4
         Ajpzu48dd3cJyhGPrAOdgwv2dzeLBjo/+/+6JnZZivUPaCXlPetWhYa+SzYcR0OXgw
         ozNqeBeszz/ytO+5hUT00f6rUJNoWC2tCV1/V19Uu9tosPk7Ok7AmxDStWcSiWuRxK
         MStKSKGriOOaQ2bW6lR9Eu0IkLM8swgd+emBPBN8EVDGV5i/8TQ1PA5i0ouOGbOq3l
         37kypuWk60yKQz10gaVkiIUX8hd+2aR31u/a8FYLH84+vtQVtTn6TGySpqMCW4k37u
         bYz0fknrWd5Bg==
Message-ID: <ce4a6e7f-dee3-c260-bd42-bc77927916e8@collabora.com>
Date:   Thu, 22 Sep 2022 16:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead
 of custom ops
To:     Mark Brown <broonie@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
 <YyxGXXSp2JD9a6ah@google.com> <YyxjZ9nCBdVovkVs@sirena.org.uk>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YyxjZ9nCBdVovkVs@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/09/22 15:30, Mark Brown ha scritto:
> On Thu, Sep 22, 2022 at 07:26:21PM +0800, Tzung-Bi Shih wrote:
> 
>> snd_soc_pm_ops[1] sets some more fields.  I'm not quite sure whether
>> it would introduce any side effect or not.  Perhaps Trevor could
>> provide some suggestions.
> 
> If it does it should be to fix isues rather than introduce new
> problems - I suspect the other operations just don't work
> currently.

 From my upstream tests, this didn't introduce any issues, that's why I've
sent this patch.

In any case, let's check with Trevor, just as to be extremely sure, but please
use an upstream kernel for eventual tests, as there are quite a bit of changes
between 5.10 and current upstream.

Cheers,
Angelo
