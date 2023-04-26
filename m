Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5086EF951
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjDZR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjDZR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:26:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E08685;
        Wed, 26 Apr 2023 10:25:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A56AD8B;
        Wed, 26 Apr 2023 19:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682529917;
        bh=C0w6HV85tx1i2so4OVKA9mCXsw1kPxaiuII4qstxlfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ0bZVrdpyGZDU/zwyHl+M6Zx/+e0pMdiY38bj+Jy/QSUHufgHVJmaEXFNtNJQvrY
         noZDokVSwQB5cs4wZ0fVCAVsZoc6WyBSTgpsCj8AxQQ5mZmWN+fGU84qhsV0sqcnfO
         plV49hvKeQc44jrsBVsj5g+D8EZ7sFXxeN3VP4KU=
Date:   Wed, 26 Apr 2023 20:25:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <20230426172539.GD2326@pendragon.ideasonboard.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
 <20230426163512.GE18120@pendragon.ideasonboard.com>
 <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 26, 2023 at 06:14:33PM +0100, Daniel Almeida wrote:
> Hi,
> 
> As I said higher up on this thread, I can maintain the Rust bits and 
> help out with the issues around it.
> 
> IMHO, we should at least try this. Who knows, it might work out :)
> 
> Laurent, maybe we can take a piecemeal approach? Right now there are no 
> bindings for MC, but I wouldn't complain about fixing some of the C code 
> when the time comes.

The lifetime issues affect plain V4L2 video nodes too I'm afraid :-)

> Just FYI, I am writing some more bindings, just enough to write a 
> stateless decoder driver. I hope to finish it in time for the media 
> summit. It will give us a more in-depth idea of the pros and cons here.

-- 
Regards,

Laurent Pinchart
