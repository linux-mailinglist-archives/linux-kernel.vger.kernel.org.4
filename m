Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03E746EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGDK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGDK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:27:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922410FC;
        Tue,  4 Jul 2023 03:27:30 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77EC26606FA4;
        Tue,  4 Jul 2023 11:27:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688466449;
        bh=jBQ/r/u+AM0rCAhryqrH6qIZUfh9m+zpg0u9afPJ/7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I/ICrcE32nz+sM3WWaUJbwX0Q15lgBWVAOXXw0pw1KeOtYQVY27qnGxXDhG/5GcNA
         d8CDYEHBrXeRKFaP/6mlFriNjl/avgL0Pwl9EWta0fnH6V9b4UFEAXbapg9jHH9Vl5
         CIQNjdZ+yQodgkTZ2UVIlHcYqTar3GMlpd0zLb3GBSCqsHFbc4lk18LNF0eJjM6gLm
         YkB3N/WzHt5FVjh3QBrRi3bOEXWZTHy65r9FNhtMY5JHvHYJsusIEgtsCtyzYMM7tr
         Ob+VC8xHu6xIgpkBdb0S8vpARPQlos/DgLM5gNWt0LoZNMHsx7eMNnKaMQko8akKcH
         fMnmS1xA0Nebw==
Message-ID: <7a0a607c-bca7-80e3-4abf-1f368c695d91@collabora.com>
Date:   Tue, 4 Jul 2023 12:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 7/8] soc: mediatek: Add support for
 MTK_SCPD_STRICT_BUS_PROTECTION cap
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-8-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230627131040.3418538-8-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 27/06/23 15:10, Markus Schneider-Pargmann ha scritto:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This adds support for MTK_SCPD_STRICT_BUS_PROTECTION capability. It is a
> strict bus protection policy that requires the bus protection to be
> disabled before accessing the bus.
> This is required by the mt8365, for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


