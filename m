Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777456E5E43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDRKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDRKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:09:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A97B659A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:09:22 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C84E86603207;
        Tue, 18 Apr 2023 11:09:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681812561;
        bh=M02j6J00DW4BHPxDoeFFjdunyDui7f39d9NcSUm8Ib0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jOXXUIEYMbEDjlnmc0t56ObEdygXOBIUDBtRtUUPmg7SKEIzjWE9al6/nZqOWddHz
         nXSEcXq2KC7QAu4UwMxBDFkVw+Sb958AX/NFjsRjsB9vvUb/BDBCEQr9gIj6t5BUnR
         O3n+ssPFpMns37Q2Re5dc8nabd7PkLJmJOQHJnx8mTTUj2R71DNFE8mc5ksVD1ASmR
         +PRZW5QjaYV+55Dbm9Yu777ey3G8zbt09UTnkhFmBGe51Nnx/z5lHQRMKKV6jt6bud
         UEUvD/RzALElyuJ7AOd/WYbEAXd+TXMs+JN5kgBnJ87zc2IgH2qATUxM4NUPR+rw4n
         zpJC5VPFUiwkg==
Message-ID: <9bfd1641-3f58-ca6e-1e80-13acea834ea5@collabora.com>
Date:   Tue, 18 Apr 2023 12:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] soc: mdediatek: devapc: use
 devm_platform_ioremap_resource() instead of of_iomap()
Content-Language: en-US
To:     zhengkang huang <zkhuang@hust.edu.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230414092113.64514-1-zkhuang@hust.edu.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230414092113.64514-1-zkhuang@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/23 11:21, zhengkang huang ha scritto:
> In mtk_devapc_probe(), if of_iomap succeeds and any following error occurs,
> it needs to deallocate the resource.
> 
> Fix this by repalcing of_iomap with devm_platform_ioremap_resource, which
> automatically self-manages the resource. This can avoid modifying error
> handling code.
> 
> Signed-off-by: zhengkang huang <zkhuang@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

You haven't tested this patch on any MediaTek SoC, have you?

This will break devapc.

Regards,
Angelo


