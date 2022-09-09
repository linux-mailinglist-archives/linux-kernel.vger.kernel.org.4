Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8A5B38A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIINI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIINIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:08:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD483AF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:08:50 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2903FDD;
        Fri,  9 Sep 2022 15:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662728929;
        bh=95i6pSYo5KId5a16NEEkx8bNHa3xBU953QjVyHVJZlg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=vj3bjLgSQDSA6XAAW28orIxzoaLcPXGmeJ6gVGILFxPoqRQMcI66x+BNQrs8h7QNi
         /vuQ003qmMkuMoce/GqyRmFjQt90uHHBNLThoxVTkrztazJGRRi/1kcImrYM3fGYld
         HSyITzcVp7igtmm/gpJTvFlKaGkZi4dQTNHMMXEY=
Message-ID: <49fba94f-c3b3-d131-2c53-5563675400be@ideasonboard.com>
Date:   Fri, 9 Sep 2022 16:08:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm: omapdrm: Improve check for contiguous buffers
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220825162609.14076-1-afd@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220825162609.14076-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 19:26, Andrew Davis wrote:
> While a scatter-gather table having only 1 entry does imply it is
> contiguous, it is a logic error to assume the inverse. Tables can have
> more than 1 entry and still be contiguous. Use a proper check here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes from v1:
>   - Sent correct version of patch :)

Looks fine to me. But where do you need this? Are contiguous buffers 
with multiple sgt entries handled correctly elsewhere in the driver, 
i.e. do they work? =)

  Tomi
