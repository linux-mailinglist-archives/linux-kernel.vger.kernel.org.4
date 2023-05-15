Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD701702D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbjEOMry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbjEOMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:47:45 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62431988;
        Mon, 15 May 2023 05:47:44 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QKfKS5SbSzyPb;
        Mon, 15 May 2023 15:47:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684154861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSA3913DuCO0/eMlMUnC+nc7ji/ix7/NNOwKqmCuNPQ=;
        b=b6iW/CemkILtaAUVqZlsi++gn+TQdLcs/pfSA732LIiLHXBkAOJjp7O4qy3qEEuM1+m3gb
        nWvFPvEyidOBenNH2QvNQyeR50bjJxuhsppZ43lTZWLTzZLepvRFgPbdcj3CQ+ZD6iY6vz
        xmbi/MuFZQ+pUhQUQTUb66+geejF3YA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684154861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSA3913DuCO0/eMlMUnC+nc7ji/ix7/NNOwKqmCuNPQ=;
        b=idIF0JVUo8XxpqArRKS5CeV962mnP1yBd73pJwZtCHz4wdQ19ERQy4daQ+Rn5pl6DmBXJ9
        hYNhC0CWvnI7FgvbmYzsXQF0naz5rvt0OEhry2/pXDZaqtEWcdbMBb9XJXCcFjDyNZhJmp
        uhCQsodg3UuhpchsRw9LV8xKkyLkoN0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684154861; a=rsa-sha256; cv=none;
        b=kFbxI8+smJ4oMXFh4AOFMYWFViaNQ2VXG6FbGB65xs2vwhUgfhD+D6tkIwAP3wEVVkbu0a
        2KzQcDyK1fM4WNtmp/Neg062Iv2yMmbOAB1x/cm5nOI7f9QxJDNEOqpdtF2mOYO1bIjt3v
        ai/PtVm39vxOaYtFGKXDFSXOhbCG3Fo=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3FAB9634C94;
        Mon, 15 May 2023 15:47:40 +0300 (EEST)
Date:   Mon, 15 May 2023 15:47:40 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH v3] media: uapi: v4l: Intel metadata format update
Message-ID: <ZGIp7E94eAW7UFSP@valkosipuli.retiisi.eu>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
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

On Sun, May 14, 2023 at 12:36:50PM +0300, Dmitry Perchanov wrote:
> Update metadata structure for Intel RealSense UVC/MIPI cameras.
> Compliant to Intel Configuration version 3.
> 
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>

Could you reply my comments on v2 and use my @intel.com address going
forward?

Thanks.

-- 
Kind regards,

Sakari Ailus
