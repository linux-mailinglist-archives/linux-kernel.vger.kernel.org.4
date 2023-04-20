Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF66E8E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjDTJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:28:15 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7587FC;
        Thu, 20 Apr 2023 02:28:07 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzcv-3yyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4505:1fdc::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Q2C4f2QsLzyRn;
        Thu, 20 Apr 2023 12:28:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1681982883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ckb8t6/WapnglDBmmVksyEjbtPBBshg0TJm9lgZhoFU=;
        b=oJDqzhu2oAmUO9YL6KWANtjrl7uxxhB07r9fvS4ZmvmojcnYUXApvt+PgMnHUh/1fDg6Fi
        /zN+K+ldDjeYZX1EwoVyNezaICdICk9y7jCQyghuFxA/R4jGljC79L8/mlfQ1eGEMHDW/z
        R5vg2Fk44miSSeWpgBSH9YEXtqFUYJU=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1681982883; a=rsa-sha256; cv=none;
        b=cxB7MWsGF/SDUJOGDHaOGRku0863tErIhgR/EvWlRKlwyKy6C0oCj2JuckIJQbzfkpdkQi
        BBXgeg0gFeq2dFbCkviRP73BcP3oyiP0kuT/71iR5h9mQq9LlmnczwHQJkkRRL2AFJLcSV
        9WeacDWcrzaUh1iAJU7wlHVdNNp4c/c=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1681982883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ckb8t6/WapnglDBmmVksyEjbtPBBshg0TJm9lgZhoFU=;
        b=hmO4FVYvTadImZ4riRQJrSSvtvsMwPlXCk4z8hqCsTz6U1TouNpRi6egh64ebBizmBkmQK
        4EkrnD/kCSrc09ZnXKLELZXJQck33/TjIgN9/uugx5XiQ/3tvyWEffeNcu/iHQ4kJMAj39
        DhLU1NSs6iwwpvqAdIDzy6aWwNN7juQ=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 4D411634C91;
        Thu, 20 Apr 2023 12:24:19 +0300 (EEST)
Date:   Thu, 20 Apr 2023 12:24:18 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
Message-ID: <ZEEEwt34bfmNEN99@valkosipuli.retiisi.eu>
References: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
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

On Thu, Apr 20, 2023 at 12:06:55PM +0300, Dmitry Perchanov wrote:
> Intel RealSense UVC Depth cameras produce metadata in a
> vendor-specific format that is already supported by the uvcvideo driver.
> Enable handling of this metadata for 7 additional RealSense devices.
> 
> Co-developed-by: Yu MENG <yu1.meng@intel.com>
> Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>

Thanks for the update.

Is the D4XX format on these devices the same that's documented in
Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst ? I.e. there are
no additional fields or differences, and the version of the format is the
same?

The format documentation doesn't say which version number even the current
devices use (just refers to "xxx").

-- 
Kind regards,

Sakari Ailus
