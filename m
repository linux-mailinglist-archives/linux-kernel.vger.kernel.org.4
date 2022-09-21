Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C105BFAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIUJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiIUJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680F915C8;
        Wed, 21 Sep 2022 02:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76F72622CA;
        Wed, 21 Sep 2022 09:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1966C433D6;
        Wed, 21 Sep 2022 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663751847;
        bh=U2I2rOq/quTseGcL7DoJKHssxhvKxWZ6qbZ9HMmsUr8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MMANVzFW/zdQo1U0bB0i/Nms58BzOuxVMG+5x1D4ML5Tkw20Vhw0oUVrTQjQAVnpH
         BJ/L64eo/6IyMcffKvO8Ewcdt0PxjXDknoj9Waxlk+YNi9HbxabUvz94AI7Uh/Q2nw
         k+uAwa+VU3/nkKIiJ1s0XMyuVkew6sI3Y6v8oPKyhM9a5Pco0Y+ef4x+B3XMhdlNlQ
         rmJb9lqBFiH1xd+Tx5aEKPKCK4Nc/GREVndzeN117qo4v7GxTA0+mqPAeww3j1TVWa
         XBxIzXWfMs+Z7cJqr5iFuw2dqDzVvFRybbHW0l7vMacU/KyMus14VkOW9nWfJGTygp
         MBf0CaGG0YG2A==
Message-ID: <eec6e8b9-f39f-425a-4217-9c15b52600af@kernel.org>
Date:   Wed, 21 Sep 2022 11:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/3] Add watchdog support for MT8188 Soc
Content-Language: en-US
To:     Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220920105622.25666-1-Runyang.Chen@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220920105622.25666-1-Runyang.Chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 12:56, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Based on tag: next-20220919, linux-next/master
> 
> Refer to the discussion in the link:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/
> The other wdt compatible strings are unchanged.So, won't apply the
> series above
> 
> v3:
> Rebase on 6.0-rc5 and add reviewed-by and acked-by tag.

If you rebased in, then why do you keep Ccing different address than one
in scripts/get_maintainers.pl?

Best regards,
Krzysztof

