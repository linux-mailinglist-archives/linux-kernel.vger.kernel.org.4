Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531D6D9871
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbjDFNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbjDFNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:39:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAB6EAF;
        Thu,  6 Apr 2023 06:39:10 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PsjJq5041z49Q2t;
        Thu,  6 Apr 2023 16:39:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680788348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peirEc1GOmb8qAkun43yYGTNjLWb271GaZHpvAeKqZ8=;
        b=VFq5BGct9PrSOoYPFJcTA+1Hyp7JO8lAq+qCZPusFgE4h2AlRhKFxGwuEfePWFXT719BEa
        /4AoHmM9xxK5rXK5ygWdXdM19ej9fBJNk2GTRnPFmmImLWnJuzo+JvZjf6M9/5ZzxbocY6
        1klTuDCD26x/lzmHw0iXpc/H8ubROnHE3VGeX6wGEPQNrjjj+tB5h+7IAxym0HcNuMeGZ4
        i2xw36YMKkOs2e41nwXCXkq4wXHZbJEU0yPG3OV64F8D7FV3BQSgMow32MPqewG37DNhk6
        9/zfNpH/cqXR5fSlPDobQ02LY+/k/cYGN1LqhvK8e+pChSB18YgKsF9J9nzphQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680788348; a=rsa-sha256;
        cv=none;
        b=snAcvJwgmAwode9IIUT4lVYSG5wR9FfcHDVq0Vc6ZG9Hr/9Isa+utMct/cokoM/nQHKWU2
        9lqg0B70i+PwjfJssZRITFb795szJlf0FvQJXRgvIdxGLROEMBiUSqAq37PkK9LVLliTJu
        4VNpbChbqWseEvi7eLMCJcdrMM3QsVNzac35VBzsZZS35sX9FYHSnXBW+E+tlExkvhd44i
        oIijilkS1YQKMrnk4woTLyGxhBBvtRDW/CsmDknz+DzBNNqkzLGuCHZp9nvqi2ZSSo5x34
        RtGC7V7ongd0LOiHL5ilHq2baMSIBgxgzx1Z3kdMUVWvljLxCzo6LvdnFqNCiw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680788348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peirEc1GOmb8qAkun43yYGTNjLWb271GaZHpvAeKqZ8=;
        b=jKGLgY2OKLMZmMqHjy7MpWhV+sK7F5XvL7j+HXUSCIGGmiZkRE6IkbgUNvPisHGbV0rtnu
        6YE9jtK+/Vd1Gdpw+dy0cbnqOjgZjQCiqFTFsYi8T2GYO0S5agXp9LLyLsQkA7eDzCVHs8
        oDrNeB5bXLpDHJrq8puFnYK0ZDCc5XykOOT8zM2KmN5zu9mSzybaUowjbzLgw3qe+0PHrT
        jr9/UyqXspBkGjcKjNyP3hBdkqQAk673EWnwJKH5pyPlFobMbvXEnHu/3i3JnAEvUEwBtC
        TZUi3vgrzqS5dwuO4BVMLp1mI5YLK2gK6ie/0YXHiy89+t45NWqj4up5yzJQUg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C6FCE634C91;
        Thu,  6 Apr 2023 16:36:25 +0300 (EEST)
Date:   Thu, 6 Apr 2023 16:36:25 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, mchehab@kernel.org,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
Message-ID: <ZC7K2ZdrxR8w7T5r@valkosipuli.retiisi.eu>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-2-martin.kepplinger@puri.sm>
 <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
 <20230406013338.GK9915@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406013338.GK9915@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Apr 06, 2023 at 04:33:38AM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> On Wed, Apr 05, 2023 at 03:52:52PM +0300, Sakari Ailus wrote:
> > On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> > > pm_runtime_get_if_in_use() does not only return nonzero values when
> > > the device is in use, it can return a negative errno too.
> > > 
> > > And especially during resuming from system suspend, when runtime pm
> > > is not yet up again, this can very well happen. And in such a case
> > > the subsequent pm_runtime_put() call would result in a refcount underflow!
> > 
> > I think this issue should have a more generic solution, it's very difficult
> > to address this in drivers only with the current APIs.
> > 
> > pm_runtime_get_if_in_use() will also return an error if runtime PM is
> > disabled, so this patch will break the driver for that configuration.
> 
> I'm increasingly inclined to depend on CONFIG_PM for all camera sensor
> drivers.

For what reason? This is the smallest of all problems related to power
management. Also runtime PM has no-op functions for just this purpose.

(Frankly it'd be great if we could make CONFIG_PM go away. So perhaps
requiring it everywhere is one feasible approach to do that.)

-- 
Regards,

Sakari Ailus
