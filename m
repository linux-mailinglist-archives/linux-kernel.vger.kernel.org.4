Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8866C595D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCVWSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:18:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E971BCB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:18:00 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:17:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1679523477; bh=1XSQgR6v3e90rBs5bY14hmQ5qe+38CfYiwDX/0EaKO0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=USHkYZAud3KB8uMQTgbwm10E5BipfZ3q7JnCDhziDI1YfTYm7nCQElsvLOqFlPClE
         dQY0yLPYGPTPAUTvIJBzspqut2cJvQQktrBQF+Jr2aPQ9CTWJl6sEmKK1ozafdnnln
         mPs7A48sY1SuxsiyiXRqAOdAvbqrMQatfWwgfHaU=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Message-ID: <038c1035-20fd-4054-984d-524c9a7f390d@t-8ch.de>
In-Reply-To: <ZBsAjPxV8bu7jjEd@8bytes.org>
References: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net> <ZBsAjPxV8bu7jjEd@8bytes.org>
Subject: Re: [PATCH] iommu: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <038c1035-20fd-4054-984d-524c9a7f390d@t-8ch.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,


Mar 22, 2023 08:20:14 Joerg Roedel <joro@8bytes.org>:

> On Tue, Feb 14, 2023 at 03:25:53AM +0000, Thomas Wei=C3=9Fschuh wrote:
>> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
>> the driver core allows the usage of const struct kobj_type.
>>
>> Take advantage of this to constify the structure definition to prevent
>> modification at runtime.
>>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>
> Applied, thanks.

Thanks!

> Btw, b4 reported DKIM errors checking your patch submission. Can you
> check the DKIM setup on you email domain, please?

Should be fixed for some time.
(After this patch, though)

Thanks for the hint!

Thomas
