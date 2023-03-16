Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7096A6BC992
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCPIpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCPIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DFF7D09A;
        Thu, 16 Mar 2023 01:44:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68693660309D;
        Thu, 16 Mar 2023 08:44:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678956297;
        bh=mBF272Uv22RD+C2JSIo/V6wQ2xTMSJyHuJQJDxdUJzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f7flbqQBE9G9uumXYQRgci8KZQqZU6MrjKG2KPRb+fg59r0zjrylsv823wlDdKNvI
         iDJ58VV25/+9JpQ6KVmViHZ8ZLoyM8a31oantlSNzqHD7wQx8dxiA0xlj3jmqs5dfG
         nU8TJAJ+S7n1RyySAfA6pqf2/9LgxwOBdCHHzWfIdMCmunD4/HSulF8Jwr+imVXRdJ
         e/N474YFsBS6yilSUvXqHVt+m6flIaiDnkhea51PApoWeg2Ix5h0PsWsAIDLMH0BlG
         +pIb+EzxGNRt3mUcUcMt+ucLGGbRtHIRBRdIt95+Eq4SbMZZjphsuPgHci1KncN819
         DtI3ScwVipU5Q==
Message-ID: <7d3f2789-2282-9d6e-87b0-d1effe2be7fa@collabora.com>
Date:   Thu, 16 Mar 2023 09:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next] remoteproc/mtk_scp: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, andersson@kernel.org
Cc:     mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
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

Il 16/03/23 09:40, Yang Li ha scritto:
> Fixs the function name in kernel-doc comments to clear the below
> warning:
> 
> drivers/remoteproc/mtk_scp_ipi.c:136: warning: expecting prototype for scp_ipi_lock(). Prototype was for scp_ipi_unlock() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4544
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


