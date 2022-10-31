Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84E61329D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJaJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJaJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:21:36 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FB3DFA7;
        Mon, 31 Oct 2022 02:21:08 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 8F74B1B0015E;
        Mon, 31 Oct 2022 11:21:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1667208064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xi2LqfmPyqAuYmKOi0uMJR0fV3RpMiXwbUnj7X50foM=;
        b=CzM0I37uH8aBIdp1du82IVsQlaFFKrX6mtL8U71a8qxilBGEl6818/BqvqOCtw/sD6vpAM
        uSl1EiJmdN8Ja07NKmw4QtbNTQBL38s3bbvkxSMT34rDuRMP0dp3vWZcPMVfe+oKEfSvPM
        krXi2QDwJBzLwNq0yNMjgufQmDWzGNkZUqAkf9o8L38c9k9aOmG4hi9UiVHv/dTaWwM+NN
        83FgBeF3sLF4XxTxi0F00ieiNTbxjgpy/Thf0kmOngvy/cza1ilbC5Ivvq1q9Fg/5JVViI
        nryV1W32WRuQDKyxC7cvCxhtyXft03d24yr20ZVLx9JnB5ajjVTJs1AIk9sPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1667208064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xi2LqfmPyqAuYmKOi0uMJR0fV3RpMiXwbUnj7X50foM=;
        b=XX+/sig8tcfGjuKohEFV7sq/UoTMAQx5UfIN9WM8PNOfWi26J+MUWViIFRbbLy+LQwcmyo
        qvR+hoDga9ItyHmSObHqPV3hRNppaYPyDPnEpkpJpenvOFH/LyHI2KHWB08pn87Bb4bN5n
        mFE4HVNyEUorZHW+Cyv0aYOz7fl9G6fCCLjy9sLOnnePa7H3FxDcG8DC1qt4KWxiYt3jkj
        fyNt7MkBrL4l+hinOlUd/c0Se2LGdQN47s9rn388T9fLVMOOkjiJSNgR5yq+KTrxhqCGYO
        mi0Oyp4Zebgj1hkoOmEnFlvages1tpEYkbRLzuKg/8/IjvyjMqLqi96OI1PgQQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1667208064; a=rsa-sha256;
        cv=none;
        b=j9H6gaD1i4wUV+/NnvBIEnLISmT47vTfIIj8YsnIRPSSzyWVI2axa90KgAd3FuhWBez8s4
        aaGpnZHZcxXKvf+bbvAuQpfqNs/eD+YTJ8wrmYk0IRDSuERnnRV8CG5dTUHfSUg4WnI3P/
        S8wyxmQ7Hf9TCKUaoHBX9JGM+cQt8yLgKWlnay1SlgfVR7yFW/5N7vACRHg+woJynSeFpl
        HuVlXaQsDv/8jC1Bpz9tKEeZEXlX5OGiH4HwCQRHC1nKki8bp4ozGEPGEyQXRaGsSTicCG
        RJ/R9XMBhFA/t8nTikZZluH/HWqeBsmxln9k7wPCLsEy2xQUVkoIY2ODiDsS4w==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id DDCB9634CBD;
        Mon, 31 Oct 2022 11:21:03 +0200 (EET)
Date:   Mon, 31 Oct 2022 11:21:03 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 00/43] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI
 Rework
Message-ID: <Y1+Tf3xfV+T4q91Q@valkosipuli.retiisi.eu>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
 <Y1Ko+rNREvM2QClC@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Ko+rNREvM2QClC@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Oct 21, 2022 at 04:13:14PM +0200, Paul Kocialkowski wrote:
> Hi everyone,
> 
> On Fri 26 Aug 22, 20:31, Paul Kocialkowski wrote:
> > This part only concerns the rework of the CSI driver to support the MIPI CSI-2
> > and ISP workflows.
> > 
> > Very few patches have not received any review at this point and the whole
> > thing looks good to go. Since this multi-part series has been going on for a
> > while, it would be great to see it merged soon!
> 
> Could this series be considered for merging soon? It would be great to see it
> in Linux 6.2.
> 
> A few patches are still in need of review but I don't think anything
> stands in the way at this point.

The current set doesn't apply cleanly to media master anymore --- after the
15 merged patches, patch 17 is the first to conflict. I suppose it's Tomi's
patches changing how drivers work with media pipelines.

Could you rebase this and cc me, please?

-- 
Kind regards,

Sakari Ailus
