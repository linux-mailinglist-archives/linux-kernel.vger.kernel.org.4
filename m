Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F4707CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjERJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjERJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:32:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FA211F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:32:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 689676605944;
        Thu, 18 May 2023 10:32:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684402359;
        bh=BIXBKkT9CpUmrNXRPgedNskmK25Iu4nAwmFpDYjvo/Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WmAsGPklPgFqrUc9WphXkzBmEOclwwubpMzaX1J0525NGxeErtJisbUatXaswTnfY
         5wIDxRQjnA10TDWpmQj9V14PfRbpDIqPf7ygYmU7Ij3ZY2yg8tH36MeZjBIqJAmaa6
         xSZVVGWADYgOWq7cgh32CWaX1NxtpAbmE43RLAt4HCj6WkI/b32/inkb3EBkvnaTzn
         WZGHqK4QXUasesqYU5TUED6pH90fnBlZKF01JYh8hC4/wc3cvkgLVX4CixVksi5xqI
         zTzcMdOHajVHPkzQEvcg4ZSeioG/4KfyoAlkthmJWUXFwv4zTwRSt1VJsnX9DPVrX7
         WjXtB14gZ+G3A==
Message-ID: <b9531c67-ab85-5ba4-6d86-9fc83974df4b@collabora.com>
Date:   Thu, 18 May 2023 11:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] regulator: mt6359: add read check for PMIC MT6359
Content-Language: en-US
To:     Sen Chu <sen.chu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230518040646.8730-1-sen.chu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230518040646.8730-1-sen.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/23 06:06, Sen Chu ha scritto:
> Add hardware version read check for PMIC MT6359
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


