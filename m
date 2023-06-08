Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7177278E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjFHHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjFHHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:34:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CD1FFA;
        Thu,  8 Jun 2023 00:34:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A9D576606F10;
        Thu,  8 Jun 2023 08:34:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686209676;
        bh=VlzcMt4Fb2IUSQOj1lmUGhufnD5Kd0XdRMKEOvM6z2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JxoKYSTyQEGjwx6KZxhgPuCRSQJzGSA4cGn4WyDKEGQubQN7xPdAdFRrmt6eW02lI
         XbGh7pKY15vhWpxovlkhibj5eCCK6LrpfNGuMCawkt7CNS1LHYbA2el2orwfgb8gT1
         BchP4/LJXlVsQfYaEk9baTx2DfWbYL4LLJLtCjCPrQk6/iqN+OMkiFYCKi9743LGGm
         FAAl2qaRDqQMya3FV5C5pL8wwDaZ/HoPp+v+t5ld54EA9yeuI4Sy0b1/aO2KpmGUCU
         TnGLiEvhB1In5yPKKeq5S6Iv44I5+dias4puCOHqLZkeEpR2D3VypTDJ/oUpfUkX+X
         sm/gU8sl+ZXVw==
Message-ID: <caa38329-71a2-414f-6378-567fa92110b8@collabora.com>
Date:   Thu, 8 Jun 2023 09:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-5-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607205714.510012-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 22:53, Nícolas F. R. A. Prado ha scritto:
> Add the CLK_VDEC_ACTIVE clock to the vdec clock driver. This clock is
> enabled by the VPU once it starts decoding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


