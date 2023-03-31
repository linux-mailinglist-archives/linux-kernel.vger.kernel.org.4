Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAC6D17F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCaHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCaHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:02:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2590B46F;
        Fri, 31 Mar 2023 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680246141; x=1711782141;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yHMOEUPKsjHNBby8lcaub9KEv8oA6ClqWvka4yCdPFo=;
  b=oCPmIZLC5w9ydxtl3q1IxwrMNpZ4ZNVLaWLxSrsGPrT6tKii0lKl1aTa
   TBPpVUkMRYG3M5JkQ6H1rBUOwYivHtVsNk8sO5KKuUhAjD00LBUZsv6Dk
   18i4UmNTIcw2E44EEaSSwCuMs2Lvca3qhrKSrDjwxBM0ij4rsGCA4fs8P
   klKk/NIndct1m9hN0b0F69L5mQINcnpSAsDGDKiBIfnD01j9196Q9SZhY
   OOXWHFiyxxYZaStumKDgyCsycl8WTeXbxckNlYUpXyTHaT2WAyVvGx1gh
   QqwDLO2t4OOZkl0Ys1FHPxLNhrYpaOzInRdYlnbExv/VLovTR13+bdAHE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="321766916"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321766916"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 00:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715347402"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715347402"
Received: from colintro-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 00:02:07 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/uapi: Replace fake flex-array with
 flexible-array member
In-Reply-To: <ef8d083a-a82b-669c-0b0a-959e0f120a26@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ZBSu2QsUJy31kjSE@work>
 <ef8d083a-a82b-669c-0b0a-959e0f120a26@embeddedor.com>
Date:   Fri, 31 Mar 2023 10:02:05 +0300
Message-ID: <87ileh2yky.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> Friendly ping: who can take this, please? =F0=9F=98=84

It's in drm-intel-gt-next.

commit 02abecdeebfcd3848b26b70778dd7f6eb0db65e1
Author:     Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate: Fri Mar 17 12:18:01 2023 -0600
Commit:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
CommitDate: Tue Mar 21 08:41:18 2023 +0000

    drm/i915/uapi: Replace fake flex-array with flexible-array member


--=20
Jani Nikula, Intel Open Source Graphics Center
