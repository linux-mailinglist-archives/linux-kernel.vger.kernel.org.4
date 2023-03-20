Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D996C0D05
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCTJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCTJTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:19:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91740EB;
        Mon, 20 Mar 2023 02:19:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 758246603094;
        Mon, 20 Mar 2023 09:19:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679303990;
        bh=utAuSiXq9t9asWlSaVXjc3XBcR0qMIczkPYrz6Mqa4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LVwHGguKGFeWIsDZqnn4aC6Ghva6sfTpwAQEo7JbwFP+Cp4DSciwsakPGIPfsDbo1
         k4sBsEKGto6v21Vv4nq8zlbZTpBat/TmZnZU1D5LAhZvaW/qgPupOkAPq2/I27L6iF
         7dDM++r29XEu7AAtpfaluXPot1bdPutATLQ4cDUpNGTo0bmiXKrspBRBreFPFcW055
         Mj6PtRA8VUuTxlQQbI47N8uvWDp+PJRWdGbhnkarP0B7A7zh/gLxszIlDOLUIs+Z1i
         EWEgmEWztrst3Mt7ImuWktfNRk1qQWTR6i42o9zhSmxHtsiwXNB9MpatbOOMz3T8Yl
         N58/sbrz4w4Ng==
Message-ID: <582a4a00-5189-7aa7-f19c-04f006baaf75@collabora.com>
Date:   Mon, 20 Mar 2023 10:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: mediatek: Use of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230319163231.226738-1-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230319163231.226738-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/03/23 17:32, Rob Herring ha scritto:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


