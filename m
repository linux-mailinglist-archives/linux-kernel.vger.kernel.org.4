Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9225EC07D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiI0LFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiI0LE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:04:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED332122601;
        Tue, 27 Sep 2022 04:04:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B73E6601F41;
        Tue, 27 Sep 2022 12:03:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664276637;
        bh=bOuC85Nc2LJl1a5+ZAIvCRp5wCwoRyVkfdHqWvXVydM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lTL5YDBSzKgOt3xax0YnEmYId5JmVtx7muiUUyRAWCECGJyr7Af2AF6uj2AC6AtCq
         gr4ZxW9l4Q8eSH2tk4n6m+39XfZz+yeERWaJw8IUI60T1YLdMSuu32nWx2PBmtBlNU
         TsBAAgqy0xYWsQEQOzia6t6e6mGZ4VzxSwPyBRz8SNZNmR/q84iUctxxC8sdAsVbfs
         EBO+bnmfZrcpTZ96s+bVk/v91ZcbmFVPqkubj/e0mT1YqJOpcnzGLvP6ojA3hDCNw4
         KTh4lqrYPlNnFAKMy41gvrUnB6w79c2pP4tcSF9tnHrYDHKbBI5GD4Kan0AHe7MTu4
         VgMVfVyVqyZGg==
Message-ID: <da5dcffc-746f-207f-eee7-f47e2550eab0@collabora.com>
Date:   Tue, 27 Sep 2022 13:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-5-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927025606.26673-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 04:55, Tinghan Shen ha scritto:
> The video codec doesn't need to explicitly boot SCP in its flow
> because the SCP remote processor enables auto boot.
> 
> The redundant usage of rproc_boot increases the number of rproc.power
> over 1 and prevents successfully shutting down SCP by rproc_shutdown.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

You should Cc stable on this commit, as it's a quite important fix.

Regards,
Angelo

