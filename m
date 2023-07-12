Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2D74FFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGLGv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGLGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:51:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5D1703;
        Tue, 11 Jul 2023 23:51:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C05B06607014;
        Wed, 12 Jul 2023 07:51:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689144682;
        bh=ZNA3nvg6eJG/Hc6v4LETHxYo8klNpKbEqdasNgN40TM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hz6WfZq/B8W0c8j7bRzhi/YwO458dsPEPQcPLnPptua6XcAvGvof5HL2dCZpCNb/z
         TyFW3UHMcrrXyHj973nADh3nAilMZB0L2GeBWKu9bH8W/PqozAmSgNRgI3xIrgbo0K
         JyzPTzteAlphuBJ4ev+XPXjYmC7E77A8gDNHgUbf/5voO3xx/d/2CWsmkc9lZQDR8T
         kBoyC6Dq7XvkIxA/vBjh/bzThdghSKZOVBqTzBHbPGB/VfyIjRhEFKYamFVAknFjO4
         VMlog89isIKrVpZ/4r40ceTosKKsvFqJ1FRcY5DXS6roseM0+yzBARj8aY2UQSLolG
         A1h8L/Pn0jinw==
Message-ID: <212a4999-eacf-12d9-004c-e47f52022176@collabora.com>
Date:   Wed, 12 Jul 2023 08:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Remove surplus dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, stanley.chu@mediatek.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230712064832.44188-1-yang.lee@linux.alibaba.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230712064832.44188-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/23 08:48, Yang Li ha scritto:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/ufs/host/ufs-mediatek.c:864:3-10: line 864 is redundant because platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5846
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


