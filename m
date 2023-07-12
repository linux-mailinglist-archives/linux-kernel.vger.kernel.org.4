Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B874FFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGLGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjGLGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:47:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069851BCC;
        Tue, 11 Jul 2023 23:47:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFAA96607014;
        Wed, 12 Jul 2023 07:47:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689144453;
        bh=Low30gJ63IEyEdNBO/LRhxBT/QWObjPCmQcya1NnaVY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GgBlDk3/cMjjM6Bh/5M7ov+twpaWDAeCbvLGegRoMGuXR1+DcC9nZR46j+eJ3I5xt
         dfVNcNBjHX260jvHatHp59o40kz/0tDxsmjdHoXeiB9Y0MZPUtFy0exrAOwAIQsbPi
         i/C//Cezb1esGiyoK1smVfLHu2Gm9Ww0wJib/a8RQnumPH3ePKDq6u1AETmsqLLfkA
         RgcmiRdO6j1/Op7xUTN1cttE9NEXi5R4Oc5RZ55H0q4y8bRz0Tp+T6PhvxOaCLSQFA
         O7boR/9/YTL1+ZsTKYmjWRhcJd4AF3Ne3wGuh+BRtUKwcT8g9Abmc2KTblUVvjMv9Z
         gnvqBOYynZ9MA==
Message-ID: <43e8c258-1913-75bb-cea8-99a432d14859@collabora.com>
Date:   Wed, 12 Jul 2023 08:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: add SATA
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
References: <20230711171330.52535-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230711171330.52535-1-sebastian.reichel@collabora.com>
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

Il 11/07/23 19:13, Sebastian Reichel ha scritto:
> Add support for the SATA0_0 port found on the RK3588 EVB1. The
> second port (SATA0_1) does not work, which matches the downstream
> behaviour.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


