Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5626A709F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCAQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCAQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:14:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804338B5B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:14:09 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A9EE9660035A;
        Wed,  1 Mar 2023 16:14:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677687247;
        bh=ibq8tG/Rn3mz7zgxSTf/PU7OalowbC7NBcxP0K+8cTk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UTZoi4Wn4gduV3XJn/CRClcWktCwLpf9/LWFBW6gQoGKffROWQTOYLkfIC/YCioFo
         hfGlfzao1evfor/9EO/Fb9d9av3T1wLNfZj67A2F4613dHrpd4TRr+jPtmPxSW9uci
         xqaauJsPz/4EfIOpyd32i+AJBiDNv60KA4YT95Tf0ZYj2uc3M9BQisY+DbAG6JvOjH
         e5joL64P/qtabF3i9i6Z12GJKs1hK08VFp14DlZRT25uYJMH9SpKpw66/F+qm9/qqY
         JNyZSPyxpl5YMCXIgxnyl7tEeCJIZKKDji0KdfI4d393CedAd+p2mG1O7LP364AQ8J
         HVLqNF7wklocw==
Message-ID: <099945bb-8da6-7a47-5dff-6a1a457fbf7d@collabora.com>
Date:   Wed, 1 Mar 2023 16:14:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230301124447.17672-1-lucas.tanure@collabora.com>
 <Y/9mT2ZVzf/5o4QV@sirena.org.uk>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <Y/9mT2ZVzf/5o4QV@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-2023 14:50, Mark Brown wrote:
> On Wed, Mar 01, 2023 at 12:44:47PM +0000, Lucas Tanure wrote:
>> Add support for Steam Deck bios old properties. If a Steam deck didn't
>> upgrade the BIOS, the driver should be able to handle the previous
>> properties for shared boost types.
> 
> This doesn't build:
> 
> /build/stage/linux/sound/soc/codecs/cs35l41.c: In function ‘cs35l41_handle_pdata’:
> /build/stage/linux/sound/soc/codecs/cs35l41.c:1041:36: error: ‘CS35L41_SHD_BOOST_ACTV’ undeclared (first use in this function); did you mean ‘CS35L41_EXT_BOOST’?
>   1041 |                 hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
>        |                                    ^~~~~~~~~~~~~~~~~~~~~~
>        |                                    CS35L41_EXT_BOOST
> /build/stage/linux/sound/soc/codecs/cs35l41.c:1041:36: note: each undeclared identifier is reported only once for each function it appears in
> /build/stage/linux/sound/soc/codecs/cs35l41.c:1043:36: error: ‘CS35L41_SHD_BOOST_PASS’ undeclared (first use in this function); did you mean ‘CS35L41_EXT_BOOST’?
>   1043 |                 hw_cfg->bst_type = CS35L41_SHD_BOOST_PASS;
>        |                                    ^~~~~~~~~~~~~~~~~~~~~~
>        |                                    CS35L41_EXT_BOOST
> 
My mistake, it seems I checkout the wrong tree here with the Shared 
boost patches already merged.
This patches needed the previous Shared boost series merged.
I will wait for that patches series to be merged.
Sorry About that.
