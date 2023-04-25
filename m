Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291946EE4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDYP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjDYP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:29:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A141B467;
        Tue, 25 Apr 2023 08:29:43 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:29:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682436581; bh=IOG78c7OJGwj6Yd8Ch8wH9TBjkdzSUpcWZzC4T0aTCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aft1PU2Eh19Cz6UMYqd253WTTTI9YNcNjgPrB+WVttysNNsgDGzty5vqCwQswNo0K
         2FpBkW1MxdHtISKVd6wcTBovc7flg85iZJ11u8/pFFOEjYYkD7Rgw/ndCP8q0GpzNS
         anlMQq0N19ZeI2pNs5pWS7rlw67IFyDkEEFhKIfw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
> Some touchscreens are shipped with a physical layer on top of them where
> a number of buttons and a resized touchscreen surface might be available.
> 
> In order to generate proper key events by overlay buttons and adjust the
> touch events to a clipped surface, these patches offer a documented,
> device-tree-based solution by means of helper functions.
> An implementation for a specific touchscreen driver is also included.
> 
> The functions in ts-virtobj provide a simple workflow to acquire
> physical objects from the device tree, map them into the device driver
> structures as virtual objects and generate events according to
> the object descriptions.
> 
> This solution has been tested with a JT240MHQS-E3 display, which uses
> the st1624 as a touchscreen and provides two overly buttons and a frame
> that clips its effective surface.

There are quite a few of notebooks from Asus that feature a printed
numpad on their touchpad [0]. The mapping from the touch events to the
numpad events needs to happen in software.

Do you think your solution is general enough to also support this
usecase?

The differences I see are
* not device-tree based
* touchpads instead of touchscreens

> [..]

[0] https://unix.stackexchange.com/q/494400
