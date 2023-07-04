Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31361746E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGDKZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGDKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:25:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893013D;
        Tue,  4 Jul 2023 03:25:48 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3275C6606FA5;
        Tue,  4 Jul 2023 11:25:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688466346;
        bh=n6rTyF0RxNuKHDVLla7lXqv7UEx2T/UfN5pF0e9xwuc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BFwc0qKf9q1h1m3IZcMRwGxB381WBLsJY0cmDCp0WVf74bD0Hs1HHYGktHxNoYwr2
         6cp0T/CvlLOjvslVPkl1XijvdcMxdYyNSlnSFpYhcy1LlqhriZVam1sflvKzbzW7bC
         56k6JFWNQtYuQnvdSZZ8zpHFsU1Yp0ucWCpr4SM2ZQJiYWawF5+8ELBjowHcFOrBwS
         vgV+oVEvYNDiCxR+TBXBWw4HqzA2ostB/QnWNTWQoS2qJgFqEPbVcwhV8NnEKwNivz
         yumtIjzHJ0RzIbp7EPeT74xdLJueZ5AAhXfUZnZhIXoSJB8QildOgPSkYJa6xf6Hk+
         Kl/KmpiDWKr/g==
Message-ID: <53e2fa94-6969-fd09-39e5-a354bdbdff66@collabora.com>
Date:   Tue, 4 Jul 2023 12:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/8] soc: mediatek: pm-domains: Move bools to a flags
 field
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
        linux-mediatek@lists.infradead.org
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-3-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230627131040.3418538-3-msp@baylibre.com>
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
> To simplify the macros, use a flags field for simple bools. This is in
> preparation for more flags.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

