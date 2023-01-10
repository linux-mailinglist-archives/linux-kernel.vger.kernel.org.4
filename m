Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB8664C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjAJTMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbjAJTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:12:27 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605EFCCA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673377902; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bF1xE5FDoH7Jt/Ak6iIGzZTLM48ugq7uBJEWLMTkfAh/eLbMYQH2RXcWFDPY+VXVHQK8kAF+/FhdKgjB8bbZyVum6BN+A/yIu6CoPXTyr4+UhxxEYc4EPb3uINQjpFIqzbc/XLvVwss3iMLgzqNzAviPNaS7KWiNB7l1+KIOVT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673377902; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=O+Xx6AH9eZ1dSlEhacGjCX8gd4rXEbBE5hUVfekqav0=; 
        b=Hm4YuVz6EOnwfrTUcYmeUgaWlmchKiZ6H2wu6RnkFiL4SyuWxd8zgV4AFfylxaJvMZHtL52k2xRoeSzr/45E6TTN0h/Q/8h+1pCWTWwQva05AkflCCbArjEmxZCu1TFil70BavpsCvPkgAs+d147YG/qvM5VCAOO4Ya4Tws/A1c=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673377902;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=O+Xx6AH9eZ1dSlEhacGjCX8gd4rXEbBE5hUVfekqav0=;
        b=VkMiJ9aF2jpNeeCbOVR6li2BaHXfw523DOa5j0iCTukZ4F3RkpTG1L3rje4CdXWr
        um5sAIKaDOJZIqVE3gpcy56KmLAU2vNnm9nmOIBCNF0judz2WXMwcLMtEuML25zsqNv
        Lf9n1ilXnKEZIia/EQoQEeM4k6Lu+jAsTS/kqg8s=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1673377890224944.9758733104535; Wed, 11 Jan 2023 00:41:30 +0530 (IST)
Date:   Wed, 11 Jan 2023 00:41:30 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Simon Ser" <contact@emersion.fr>
Cc:     "maarten lankhorst" <maarten.lankhorst@linux.intel.com>,
        "maxime ripard" <mripard@kernel.org>,
        "thomas zimmermann" <tzimmermann@suse.de>,
        "david airlie" <airlied@gmail.com>,
        "daniel vetter" <daniel@ffwll.ch>,
        "jim cromie" <jim.cromie@gmail.com>,
        "sam ravnborg" <sam@ravnborg.org>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1859d183fa6.859b5b89421607.8806421513207042042@siddh.me>
In-Reply-To: <C6RlXueyDNu9t4z9O_S7mx1gZbmzjCcHqbarn7w6QZcNVuBLUAKwyzGZQXk2dIQSxcauzlHqtkFwPveNglu8ZDtU875E7X4pS9zQsYyfMPA=@emersion.fr>
References: <cover.1673269059.git.code@siddh.me> <C6RlXueyDNu9t4z9O_S7mx1gZbmzjCcHqbarn7w6QZcNVuBLUAKwyzGZQXk2dIQSxcauzlHqtkFwPveNglu8ZDtU875E7X4pS9zQsYyfMPA=@emersion.fr>
Subject: Re: [PATCH v6 00/10] drm: Remove usage of deprecated DRM_* macros
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

On Tue, 10 Jan 2023 20:45:54 +0530, Simon Ser wrote:
> I pushed the last 3 patches to drm-misc-next.
  
Thank you!
