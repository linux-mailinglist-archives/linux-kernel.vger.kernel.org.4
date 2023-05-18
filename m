Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2A707CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjERJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjERJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:32:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8B2681
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:32:51 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F84E6605944;
        Thu, 18 May 2023 10:32:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684402369;
        bh=8CEs8jg1IBDKZGJzbEMInnqFtur20E0UOFQ/JDCj71c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A+0O3uUdkdzVVDXjDbLdPzKOXPoRj+YP+NsGJcElW54MqQ6451xj/ruGpYOZ8q+28
         VWaIAiSVAksZjPxGEqNIIXc5sWfkTyQqubo+K2WmU/A7CkUIS4JrWzcvCbgr7+ufqv
         uR1Nd8YB5pQP0DKv2QnICNCPGRAY0IjYXx7Pyqj9X6on0k3KWntxDniIqc1m2P/vSo
         U7iQuY5pjeW3c7OJYgwNd0zJ5e9SlFksTfsfzBPXhhs4B4cy8E027tlGvtAr3Hyh1m
         40ilNyp/qVUE8YE/t1eMSS9Dxo6gQ1JYVwrzJV1cxhveJn+1K8QkHcwXiIkqojcczm
         jV4ARWX1y9Nkw==
Message-ID: <795845ce-e32e-f503-198d-69e0a21c6f19@collabora.com>
Date:   Thu, 18 May 2023 11:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] spmi: mediatek: add device id check
Content-Language: en-US
To:     Sen Chu <sen.chu@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230518040729.8789-1-sen.chu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230518040729.8789-1-sen.chu@mediatek.com>
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

Il 18/05/23 06:07, Sen Chu ha scritto:
> Add device id check for spmi write API.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


