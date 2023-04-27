Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE896F0807
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbjD0PP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbjD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:15:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1535A5;
        Thu, 27 Apr 2023 08:15:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EDD7B66032B5;
        Thu, 27 Apr 2023 16:15:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682608522;
        bh=wx4QwWQd9NsnskAEPQUncauUhMSHJCUjAMBurj5VCPw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Jm/XTqkVdeGNCtWpZpEhTDlndoLNfCkYlhVE0tRHH+AnSHsVTPcFlQUYWKu5Q7O2Y
         hpQn5J88h7AS7Aj6hrxV1wJH0yVIBH81FJKTkx/4JEgSD9br9/nP2VIs/Jouzq4+GZ
         +XhVlV4yCgAdpn+yWv6IoqMBabKshxpvQcen9A/Lv0BicMihifmbxjDiUQqL7CQqPx
         q5gu7ZjrTVBE+6HLa/d7p4V+n6cQnigJR3HzoyjvPAMCjihPRFukIkbQzciS8/3Rnv
         OttUxoMFyh7orzPjG2FgdrOVgjsqJHBE88TBNtK25tiRtZZyaTAdt/Dvn8gdxmP4vu
         92WRXZjLmQjBg==
Message-ID: <17525028-80bb-cd03-fbc9-b8ff65378517@collabora.com>
Date:   Thu, 27 Apr 2023 17:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 0/9] Add gamma lut support for mt8195
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
 <c6a12ebc-99f1-855d-e366-e5a4833dc562@collabora.com>
Content-Language: en-US
In-Reply-To: <c6a12ebc-99f1-855d-e366-e5a4833dc562@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/04/23 13:43, AngeloGioacchino Del Regno ha scritto:
> Il 12/09/22 03:29, Jason-JH.Lin ha scritto:
>> Since the gamma_set_common() function for previous SoC,
>> such as  mt8173 and mt8183, is designed for 9bit-to-10bit
>> conversion.
>> mt8195 is using 10bit-to-12bit conversion, which is
>> not compatible with the previous function.
>>
>> Thus, need to update the function to fit the need of mt8195.
> 
> Hello,
> can you please respin and fix this series on the latest linux-next?
> 
> Besides, please test it carefully: as far as I can see, GNOME Night Light
> (or others) are not working on MT8195 (color temperature/ccorr).
> As for gamma itself, that's not working either; you can test it with a tool
> that will create a color profile by applying a new VCGT table, please look
> at [1] if you need tools.
> 
> We can confirm that color correction works on at least MT8192 (colord), so
> it's MT8195 at fault.
> 
> [1]: https://github.com/zb3/gnome-gamma-tool
> 

Nevermind. I've actually fixed this code and refactored it a bit as well.

I'll push my own version soon. No action required.

Regards,
Angelo

