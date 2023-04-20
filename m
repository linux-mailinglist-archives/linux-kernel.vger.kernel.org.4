Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B836E92D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjDTLc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjDTLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:32:02 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D5E6;
        Thu, 20 Apr 2023 04:31:36 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Q2Fq82h42zybD;
        Thu, 20 Apr 2023 14:31:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1681990294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zsLinTlvXAXU45xFIxQli/nqVvDOe/04/ylvRuhqZ/0=;
        b=i3NaB9xXUHuQ8f6/NKYnl8A7KcKinYwIGH/LJAMR+X1iXg6DTQ6WciaoQXi2JAcjkEwbUc
        m2sT0pWdNkPfe5vtiAoFocN76Hv8gdmTDBIwSAUe4o59fV+xPyU5ypT24Q4jzv7gdcxP4+
        W6/HXcMxIj3FRAtg5+oFMg8Q8Vnw1iQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1681990294; a=rsa-sha256; cv=none;
        b=S3GwtXKIN/dseSlPdRxnSrGNGA3HkmJZdQqi7FPng080G8oJ/LrGADli1Yf6v2TwFQuWuI
        n+v72xa62H09BM6T2RF3iGXOQEqAodog+jlJfY1k5mg3z3eRiAQ02Ckul0Gibnrkf4+jAF
        TYblEvt3mfLc22MYL84oYc931XkpQb0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1681990294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zsLinTlvXAXU45xFIxQli/nqVvDOe/04/ylvRuhqZ/0=;
        b=Hexr+dlAhwGIYnUonUqtsyk8Yy+LNpcl3FfC1kidHpE6I5LKaDb+KNc7X3EdjZvC4f8qnk
        GO6TmtKY1KaPg5gA2d9bQTCjPC/s+Yh6c2nxy5XTHPoHydubRSH+1jCcC12a6Ki0plwotz
        EqoYV37cENh3dds95D6Nd9QsPRBs2YY=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 15187634C91;
        Thu, 20 Apr 2023 14:27:50 +0300 (EEST)
Date:   Thu, 20 Apr 2023 14:27:49 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
Message-ID: <ZEEhtUH/9Nqm/+n0@valkosipuli.retiisi.eu>
References: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
 <ZEEEwt34bfmNEN99@valkosipuli.retiisi.eu>
 <7fe1b7ab73842ad8ee430cb171b6a59e3d6003bb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe1b7ab73842ad8ee430cb171b6a59e3d6003bb.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Apr 20, 2023 at 02:26:53PM +0300, Dmitry Perchanov wrote:
> Hi Sakari,
> 
> On Thu, 2023-04-20 at 12:24 +0300, Sakari Ailus wrote:
> > Hi Dmitry,
> > 
> > On Thu, Apr 20, 2023 at 12:06:55PM +0300, Dmitry Perchanov wrote:
> > > Intel RealSense UVC Depth cameras produce metadata in a
> > > vendor-specific format that is already supported by the uvcvideo driver.
> > > Enable handling of this metadata for 7 additional RealSense devices.
> > > 
> > > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > 
> > Thanks for the update.
> > 
> > Is the D4XX format on these devices the same that's documented in
> > Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst ? I.e. there are
> > no additional fields or differences, and the version of the format is the
> > same?
> We verified the document and found it generally correct.
> Although, we expanded number of fields and I can update this document.
> > 
> > The format documentation doesn't say which version number even the current
> > devices use (just refers to "xxx").
> The document compatible with all D4xx/D5xx devices so far.
> We dropped all obsolete incompatible cameras from support.
> > 
> 
> Should I submit another patch with extended structures?

Please do.

If some of the fields are only available on certain devices, it'd be good
to document which fields and which devices, or whether it's struct version
dependent (and then what that depends on).

-- 
Regards,

Sakari Ailus
