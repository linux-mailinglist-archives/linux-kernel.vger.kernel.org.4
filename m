Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BCD61ECE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKGIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKGIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:30:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFCC14035;
        Mon,  7 Nov 2022 00:30:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EEACE7B;
        Mon,  7 Nov 2022 09:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1667809840;
        bh=9+acuw0uGpqBknK+eIp6YcQOb9yS0i7BzwLPRSmgJWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkOd0Z4p852fY8LMxdlv51zeEYQNPCDkJQWArsoW/Nk/sxoKhCdUYQdYvMlMn1Hrl
         s7HIbqqTWIb0lZYWQA3JNSehUy+pl9mTHCuqimAsHJZo05iDRfKxFqfQGJ6gA02CND
         YSS8VWpQ+IBUyAbQMxfhe0E0LlAfxY86IRikcGfE=
Date:   Mon, 7 Nov 2022 10:30:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Helen Koike <helen.koike@collabora.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        nicolas@ndufresne.ca, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Message-ID: <Y2jCHofGnLSaE5nk@pendragon.ideasonboard.com>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:11:32AM +0300, Dmitry Osipenko wrote:
> On 11/5/22 18:19, Hsia-Jun Li wrote:
> > Hello Helen
> > 
> > I didn't see any updates from V6 and V7-WIP in your repo. That is what I
> > need to for our complex tile formats in our platform.
> > 
> > Any future plane here?
> > 
> > Besides I have some ideas on these patches.
> 
> I was looking into updating this patchset few months ago and the biggest
> blocker was the absence of immediate upstream user for this new UAPI.
> What your platform is? Is the driver stack completely opensource?

libcamera could be a good place to test (part of) this API in userspace.
We could really do with the data offset feature for instance.

-- 
Regards,

Laurent Pinchart
