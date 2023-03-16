Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377616BCA47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCPJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:04:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A29E3BD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:04:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 818A666003B0;
        Thu, 16 Mar 2023 09:04:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678957443;
        bh=RZUD6ZfSGRTeOd8k3yIR1WJ84mfgoTCh6HqZtNF8ZVw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k4dVN9ok+bwTxCcKL4jnqkfTsApX+3UunOfIVkxm2gxfkOLBjz5uW/ngAKsi+ZDIL
         JQusrGsykE6HbEBflLx+QybiHzk93RXpA9ujRGoiBd+ElnUpCYcThfOmmkL2hUbgEt
         IS6C98gDCrU6/otGb+lKr++pKxxK7Ywu6Ahq1Mw2fzWTdlpWCkA4mruAzXo+p/RqSH
         nXtCy4AkvAjQhkbUxSgfG/V67cjFrVicEjb2SAzc7GvF56RQ+IK9UjY3RJiMoWKOFo
         u39JF/GP5JMUD8vRufv4Ew9/i7lgxgV1cOsjGoUKLebiPHXZ+pwnADX/S206Xu4FWN
         5wZuYcxgteZVA==
Message-ID: <4445a2fb-5fab-c12f-c59e-cf1e9d67db21@collabora.com>
Date:   Thu, 16 Mar 2023 10:04:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] spmi: mtk-pmif: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
 <20230306073446.2194048-3-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230306073446.2194048-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/03/23 08:34, Uwe Kleine-König ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


