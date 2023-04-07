Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DE6DB2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDGSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:40:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49BA27B;
        Fri,  7 Apr 2023 11:40:47 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PtRyN3GXLz49Q31;
        Fri,  7 Apr 2023 21:40:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680892844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llMZG6Cdrj65bb8EHwDmL5EqSwP3QUX8jIynIyXHYas=;
        b=WLS4pKRDEY7h9Pa6gvv56KsPQJmvx4dNOOPpGL1HmsTz2yGpZJ+cJbo/aFeq9OPjrDQ09d
        uC02+JqZaysNx+zAOQQ/D5X9i3ubsO903AuUf3TUOOXLrHHIYzAuK+vBgnIxHd/RUwkvex
        RbAJXaV39pYftDaS4RCrknY6A6lyyq+2Y9dVGD53ZH6+Tl1bJVa6Q1YmFxDlgucqIZj5Oj
        fafZ3wJEZguZwNE/ZDVkEBH3oexD8PYZQ+AoakhCY2/pCy2sjGPQKYDjn40oceFT5/ZqVX
        a5qZ+DaWhY2I7Esguwd+RimlyvWtjeyY9oximz4qXiaxLX1RJqx+gpDNW4A/bA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680892844; a=rsa-sha256;
        cv=none;
        b=VCYX4w2gyVr27eZHRjga5u5Jz8LcScEXIhd6AHZBgDRzntGUnrSuK323cV5wOXE/Q8a6pS
        bSVrh1L4Y1G/GcN4xZQC0B4lWFSJnqP4b3hHhVV5FA94DozFBpmqRc8p+QoqOkvh/o9fT1
        k0TfVP7dZy1FcPMkSUFTNEwDrGnsqwUZ3fGPW7+ODbu4/Z+GSrY/AF0Zm2c4oPIbSIGnvM
        c1SPq/8BbH7ynC+cOJx+fXSvn1wktZrCFq2u7C93K4n5hfBOXn+HXQynclwmBYJHRG+MIg
        myASDdVa9THfsQfmn0i9+xmyFm3IOs3V8AGASVert+/QnUQNoOjuIogxV8nmoA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680892844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llMZG6Cdrj65bb8EHwDmL5EqSwP3QUX8jIynIyXHYas=;
        b=BeSwG9Ys3zxCEL6i8U1Hpg+ltCtMaaKvGY8ycCQCym59+4pm+bGzDkcUG0uYisyl68Oqs+
        9V5gq4UGzAwLEobwM9gVbUuP/VMFQ5WSlIllgRacllu64Q+QmIrOwg6MD9JVdth5d6G0/1
        VjCeD6msSxaVPtHKJpBc8XL9ZFBdtwgtQDB4FaToDvE4oU3E6/k6hvyIlrCEYqV7clxnSD
        i6I4zUAr/nLfCILmLcDsbvaNgAWArwLm81Y9z+UwcQ6dF6CzlxDQ0kO05OY1xNkXJvYe35
        t//5oTNslhDQCNiKw3Elq9OOOX34oLgW5EFw5rTL2rxwKti6fF4B3Ye+MPKxWQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id E32C1634C91;
        Fri,  7 Apr 2023 21:37:56 +0300 (EEST)
Date:   Fri, 7 Apr 2023 21:37:56 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
Message-ID: <ZDBjBNu6UXksVSwQ@valkosipuli.retiisi.eu>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-2-martin.kepplinger@puri.sm>
 <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
 <cb0c1ad7e00523a43ce6ad73a79e7e396c4b52aa.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0c1ad7e00523a43ce6ad73a79e7e396c4b52aa.camel@puri.sm>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, Apr 07, 2023 at 03:31:02PM +0200, Martin Kepplinger wrote:
> Am Mittwoch, dem 05.04.2023 um 15:52 +0300 schrieb Sakari Ailus:
> > Hi Martin,
> > 
> > On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> > > pm_runtime_get_if_in_use() does not only return nonzero values when
> > > the device is in use, it can return a negative errno too.
> > > 
> > > And especially during resuming from system suspend, when runtime pm
> > > is not yet up again, this can very well happen. And in such a case
> > > the subsequent pm_runtime_put() call would result in a refcount
> > > underflow!
> > 
> > I think this issue should have a more generic solution, it's very
> > difficult
> > to address this in drivers only with the current APIs.
> > 
> > pm_runtime_get_if_in_use() will also return an error if runtime PM is
> > disabled, so this patch will break the driver for that configuration.
> 
> ok but the driver is currently broken for any *other* error returned by
> pm_runtime_get_if_in_use() (than the runtime-PM disabled error).
> 
> The execution-path during system-resume I'm interested in gets -EAGAIN
> here. Would it be ok for you if I'd return early only for that one
> error only here?

I guess... but I think to address this in a way that's reasonable to
drivers, we'll need improvements to runtime PM API. A largish number of
drivers need changes and before doing that we should figure out exactly
what should be done.

I thought you could effectively trigger this issue by calling runtime PM
resume/suspend functions before enabling runtime PM, but this seems to be a
different case.

-- 
Kind regards,

Sakari Ailus
