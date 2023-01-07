Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434A661191
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAGU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:27:12 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC934D62
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673123224; bh=ROZ9pnsepk1j38nhEjI/IvMoppQGZa557ZdPMNDI5Kg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Jz9bYQZ4/JxOD9PsSvQ3ifoahe5GQo8NayN2nHwORR5cEDjIGY8t6cVvM1WSG2wLj
         zanH95YcDOCj85Jl2pbAxXEua2nHFkNUoCR6AJFPHW4ycGs8gSpOaNTtzED0QWa9/m
         b5EF9YJfaiOPoqXuEMjgZgfNbLuzP8Mg5j4K9PPY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:27:04 +0100 (CET)
X-EA-Auth: ChZckfM5iG3viFbLvzT/xcNn46JA7HWZAA1+SeFdhrWztjEgKvaXU1PHfwuv2tA8HORvuQvHwJqJPJ/eKHCaQxEJw7gzpLKw
Date:   Sun, 8 Jan 2023 01:56:55 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/nouveau/hwmon: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y7nVcGWAEmhCJ6G4@ubun2204.myguest.virtualbox.org>
References: <Y6gRkFnEgPO4avrs@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6gRkFnEgPO4avrs@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 02:32:08PM +0530, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit() instead
> of sprintf() family functions. So, make this change.
> Issue identified using the coccinelle device_attr_show.cocci script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback on this patch proposal.

Thank you,
./drv



