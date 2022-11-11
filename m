Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17897625822
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiKKKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiKKKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:41 -0500
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCAEA4;
        Fri, 11 Nov 2022 02:21:37 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id E37FD2070D;
        Fri, 11 Nov 2022 12:21:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1668162095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4K1Zr9Nd9xjqasmHb1Oi3vEJFEf/Rl2t4cMnoUhyi8=;
        b=MeJPv5HYsv8Kwy5VGGktQdQ9wA1pwUJlNCJYFL4j4wRjXZIiaAkI6nXJx4+psWX9ZiMtQR
        WTgmnFKCNbzMGnJ63ouZUUsEoSPVKRJtjtyjnEpHr0zu4zOFXPGNsNg63ApLWi/vwf1000
        QtQYFUKMHhkeO3CF0+mBbdegKYq8y0E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1668162095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4K1Zr9Nd9xjqasmHb1Oi3vEJFEf/Rl2t4cMnoUhyi8=;
        b=tI6XIgJpnJmo1ZaEbil4cop5fay0jxqg0ACX3dC9RiBk6omBhIzurOfAgLNi/xB2cY4aOZ
        XSn39lbal3Zzx0NrqsAytBBEJv9j55OjCsrL93kOm0q6JjhSOhRKVRgkEbIdDaX+app8N8
        I8UCQxH11QfRPCd2gCqvafVRFRG6KQ4=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1668162095; a=rsa-sha256; cv=none;
        b=YX9mI5+JQNAalqyYlLg/+VcGCfkNyyuPQugRgGo9OKZmdkLaQPWf/uu0SZRNfBHRfaGQmQ
        j4Wsgsxq874q4NyN6zvjCuJhsnKnUt3aOwj+dsvKJ40Z+h+pC1Sf98sLSjADU/+1i5K5wT
        3rPj4mTa8B+c4SrKVh06p5B77OBab1k=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 74346634C99;
        Fri, 11 Nov 2022 12:21:34 +0200 (EET)
Date:   Fri, 11 Nov 2022 12:21:34 +0200
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
Subject: Re: [PATCH v7 18/28] media: sun6i-csi: Introduce format match
 structure, list and helper
Message-ID: <Y24iLrBzM5BvnaqT@valkosipuli.retiisi.eu>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
 <20221103163113.245462-19-paul.kocialkowski@bootlin.com>
 <Y24hZjkRp0rBpzTZ@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y24hZjkRp0rBpzTZ@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:18:14PM +0200, Sakari Ailus wrote:
> Hi Paul,
> 
> On Thu, Nov 03, 2022 at 05:31:03PM +0100, Paul Kocialkowski wrote:
> > Introduce a list of mbus/pixel format combinations that need an exact
> > match between the two sides. This is the case when using raw input
> > configuration. The list will be used to replace the
> > sun6i_csi_is_format_supported combinatory helper.
> 
> This patch introduces an unused function which generates a compiler warning
> that is now treated as an error.
> 
> I'll squash this to the following patch that uses the function. I think the
> commit message will do as-is.

Ok, maybe the helper actually should be mentioned. I used this:

Rework the capture link validate implementation with actual logic that
reflects the possibilities of the device instead of the combinatory helper
functions, using the added match list helper
sun6i_csi_is_format_supported() when needed. Remove the previous dedicated
helper.

-- 
Sakari Ailus
