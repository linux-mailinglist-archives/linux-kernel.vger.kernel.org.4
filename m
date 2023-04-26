Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F06EF587
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjDZN3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjDZN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:29:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C2A114;
        Wed, 26 Apr 2023 06:29:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DE192D8;
        Wed, 26 Apr 2023 15:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682515769;
        bh=RI8z4Eo+45ZBt/YIKZ6uFhIQL5StFvtCFGTNDoDxnis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfTKzySPNhs6oxWcOF9m/g3fYAphPf3rA8xMjxZHuFCGchanpXeisroR6VGqJ7r2k
         AKG/jvwBVqDakU0pucABCTZQ3+SOFYJa8pN81qW8eRsJWQHIdj2F02SKYZY8b0Xgcq
         aT+Pq436dAuvt19/85On8T3u1mJTs8TMELwCQ6ZQ=
Date:   Wed, 26 Apr 2023 16:29:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <20230426132949.GD18120@pendragon.ideasonboard.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <57ec90ad-8535-fa7d-d6de-d5c1d06f37d3@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57ec90ad-8535-fa7d-d6de-d5c1d06f37d3@metux.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 03:13:10PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 26.04.23 02:32, Laurent Pinchart wrote:
> 
> > We have homework to do when it comes to maintenance for the media
> > subsystem, we're doing *really* badly at the moment regarding community
> > management and attracting (and retaining) new core contributors. 
> 
> Is this a problem of the subsys (core) itself or individual drivers ?

It's first and foremost a subsystem core issue. Drivers will also have
to be fixed, but the core needs to be handled first.

-- 
Regards,

Laurent Pinchart
