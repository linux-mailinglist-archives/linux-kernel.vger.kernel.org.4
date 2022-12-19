Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B68650EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiLSPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiLSPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:34:44 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5ED65C3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671464054; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=WXVL5pept0wyAvliElBj4DiD7BB/uHTKTkVP79BIgnfedfw4lABN4ua6dRuTrPCo1fNcTt0QL1ccVRwxeugamxgDjTKRjTneprMjfnAcqB9CcOWC9wz+knkuX00A6S3tqAwDMwEs7CMTzCzJNGoRJ+R8X21DxWvvEGQRryj/THc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671464054; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=O8NG+C2lB2shkfoX7DpHMnoUOQ+RibmnP1poMGg5OA4=; 
        b=d+PHIfs6Tm5CYQSF7k0Da8ZTQ6KR9et4TVQ9CORNtM3VcYKgCo0TxkMsl1er4bFZBbTI8mxu+WlAeMwzEoii+If3uF6ELV6Qe05DFMJQU4oIn+MQhdvYdI1Lg5fFIN7GBBhMrIcQkTIqQ8VMchNaBlfcvQ04ravbKHgsHqMXxvA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671464054;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=O8NG+C2lB2shkfoX7DpHMnoUOQ+RibmnP1poMGg5OA4=;
        b=XJJC4Hl46YEmDPGK8kxrt0TgcCARxCBLIf22/nKqBIkxEjfaNNplODVsWqF2/y42
        CuvpnxtHyzwjlixIhRhe2bRxWYZyWejaU7RVOICet3iiMJYXodkmZT2eenrmgB/xf9B
        56GX1kzadrDlQntFbpg1cF5y3olGm3QAZHEWhL4w=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1671464042539690.9187061987653; Mon, 19 Dec 2022 21:04:02 +0530 (IST)
Date:   Mon, 19 Dec 2022 21:04:02 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>
Cc:     "maarten lankhorst" <maarten.lankhorst@linux.intel.com>,
        "maxime ripard" <mripard@kernel.org>,
        "david airlie" <airlied@gmail.com>,
        "daniel vetter" <daniel@ffwll.ch>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1852b054022.16e87c6b116450.6116081892972417758@siddh.me>
In-Reply-To: <0693327a-4951-6864-12c6-88cfe81abd12@suse.de>
References: <20221219142319.79827-1-code@siddh.me> <0693327a-4951-6864-12c6-88cfe81abd12@suse.de>
Subject: Re: [PATCH] drm: Replace DRM_INFO() with pr_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:27:45 +0530, Thomas Zimmermann wrote:
> Hi
> 
> Am 19.12.22 um 15:23 schrieb Siddh Raman Pant:
> > Line 536 of drm_print.h says DRM_INFO() is deprecated
> > in favor of pr_info().
> 
> That's a misleading comment. DRM_INFO() is deprecated for drm_info(). 
> pr_info() et al is only to be used of you don't have a dev pointer.
> 
> Best regards
> Thomas

Maybe you are confusing it with DRM_DEV_INFO? It takes the dev pointer,
and is indeed told to be deprecated in favour of drm_info() in the
comments (see line 394).

DRM_INFO is a separate macro for printing stuff, and does not take the
dev pointer. They seem to be early wrappers for printk, I guess when
pr_info did not exist. And all they do different from pr_info is to add
DRM_NAME (which seems to be just "drm") in front of the string.

Thanks,
Siddh
