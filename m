Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CFC613835
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiJaNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJaNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:41:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D96101CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:41:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29C146602040;
        Mon, 31 Oct 2022 13:41:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667223688;
        bh=2dz1M+B8TIpl43v5vd4vjUv91V2N3rN90HT3YVMZ6Do=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YJCX/qGjDqMSKn7g/SEhQmVycMgs11cemi9QciV8uD1hy2D1p+d5tDx7TUncfpGU+
         7m7Ls95h/Fsp682coUMlyVzdoVD8ETmVgMX+x2C0xqBKJi7mZ10MWOChbDGLd0Uika
         VTexgi78Nn70zLD6vffC55VoW9yJXNNy1su1fgCiCY+6oPPU2nXIWYvMCBrVZ6NNi3
         49nfnElNQKgbaZh4QTgJ/94TEH5DjWzHOhXnUw7Xnc5nEu71zeTUxSoHB33MIYVGL3
         8XB3ACUe1BcJ6ibOdYNWIOIlMViU6HXNqYiQ7SAmaWtEAK/MgJrc+70s6K7a+RGuCP
         Lq/w60prWCAMg==
Message-ID: <9599f3d0-670e-f971-f5be-96061ab0531c@collabora.com>
Date:   Mon, 31 Oct 2022 14:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
 <Y1/JCN+mtlT0r/rw@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y1/JCN+mtlT0r/rw@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/10/22 14:09, Mark Brown ha scritto:
> On Fri, Oct 28, 2022 at 04:55:38PM -0400, Nícolas F. R. A. Prado wrote:
> 
>> @@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
>>   	"AVDD",
>>   	"MICVDD",
>>   	"VBAT",
>> +	"dbvdd",
>> +	"ldo1-in",
> 
> Why are we making these inconsistent in style with the other supplies?

Right. That would be the same for rt5682s, and for the entire series. :\

Cheers,
angelo
