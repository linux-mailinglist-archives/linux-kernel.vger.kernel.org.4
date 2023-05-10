Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E089F6FE244
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEJQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:22:00 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62F173D;
        Wed, 10 May 2023 09:21:59 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 08E0E85D1E;
        Wed, 10 May 2023 18:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683735717;
        bh=Dk/OU7wmaNZMLcevPTKhSodBVPmPPaEdH0F0dmzNl2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSkl1dXoZsDv1eX3hF75wsrkCvp7b4/rkOSTIjabE6uuoC7CLLQQQ8iCNJPnF2ASq
         Iir6mJpGphckwT24UkqmYcoKfzsxWTH0NpLPU8nNKII7od7uiPMaZzS79TIYApMb/5
         6bFLCKg9EQznt86htrJTKdxELxWX07SKYnHN1okVOXlnZmXxeSXE3KjNl2zlELE/K9
         83eEAAAwfOBlFoftCYEsg+KjOxmh/gpOKZRR9z9QrwWwCg4SGO0vMCzDVop5xYB+0e
         8f8SReLFliXL5HedAEEGByhAEE2+z7l7pZ+grUHftMTuT9otgoynEkHcNPr1K5DWXh
         CiwG+azR4dAag==
Message-ID: <e26ab6fa-a273-81a6-bb28-356deca07563@denx.de>
Date:   Wed, 10 May 2023 18:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/6] drm: lcdif: Drop unnecessary NULL pointer check on
 lcdif->bridge
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
References: <20230510092450.4024730-1-victor.liu@nxp.com>
 <20230510092450.4024730-3-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230510092450.4024730-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:24, Liu Ying wrote:
> A valid bridge is already found in lcdif_attach_bridge() and set
> to lcdif->bridge, so lcdif->bridge cannot be a NULL pointer. Drop
> the unnecessary NULL pointer check in KMS stage.
> 
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
