Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D66E7F85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjDSQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjDSQYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:24:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20010C1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:24:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a34c299d8so154368766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681921480; x=1684513480;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7K6w5OJikldhmL61pOlJnxVZUu5lcwwyjI/qw2nrEo=;
        b=LaTBy49SBwoj4h+oT2GlGpoG1ho4XJx59PLABgeoGZbb55L3JUnyITzH/tFRPmCWF0
         kvH3KOzJ9K63ateEneekFbTU883T5/jyYUikhOREIArW5o9vhGDMXkfqtOAEjLuk6JX4
         FMoaBRBM6Gitpy4VKbUwrJ3bzmUlte6CZRibo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921480; x=1684513480;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7K6w5OJikldhmL61pOlJnxVZUu5lcwwyjI/qw2nrEo=;
        b=B7OhiADda7mgDDsfRkthLIsEZUScmGvVmIPTyuzGcTgTAjuRK/uLiZKEAtgm644TWj
         P4YUVx7eiDsb4pAHg17Jf1plhrbOVbB3YF19BlHiwVsC7qqPGfuT9HvjEtQBWbuK9Ich
         TrHy3TfmIHLYGIXqeYwB1+qHdeuPjfKt95cbkQOC4O6AOo0/R8P+Rs8YI/mdiX/yLUpr
         VUlk+hPt7Xj1teTkHoBYDkUUSOBRwThf2klwTIgiFRYakKVmvySCzGMu8AseLsbbzbb3
         1hfwti3Bkj2kg4Ae+swdQfdTGdVWIZyQCw5+vZ+/XSBiIERjPwrxoibSrcKE0z2kjdyZ
         GYdA==
X-Gm-Message-State: AAQBX9dyncS8A7RWk7INgzB/MW46RJJrwc3Sgbxze/8RIM4j/g6gZ5JI
        HUh8pxTWwwCK9+dxeVut1RE+YA==
X-Google-Smtp-Source: AKy350bL0zGlce4TfTMYhL1LQuXzF7N1ZDTAjWo9P3ioMSAVLzb74mKMm7PgVSCTxsUSN/WDSq+9MQ==
X-Received: by 2002:a17:906:86:b0:94f:4ec3:f0e7 with SMTP id 6-20020a170906008600b0094f4ec3f0e7mr12463889ejc.2.1681921480400;
        Wed, 19 Apr 2023 09:24:40 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id qm5-20020a170907674500b0094e3ddcf153sm9387130ejc.115.2023.04.19.09.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:24:39 -0700 (PDT)
Date:   Wed, 19 Apr 2023 18:24:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@gmail.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <ZEAVxeIEOny81EGY@phenom.ffwll.local>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230414125913.851920-1-broonie@kernel.org>
 <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
 <8c90b4db-3075-4275-bea8-01f501b00885@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c90b4db-3075-4275-bea8-01f501b00885@sirena.org.uk>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:34:44PM +0100, Mark Brown wrote:
> On Sun, Apr 16, 2023 at 09:58:50AM +0200, Daniel Vetter wrote:
> 
> > Note there was a ppc compile fail, which is why we pushed the ttm revert.
> > That /should/ be fixed now, but would be good if you can confirm?
> 
> According to Nathan (CCed) there's still issues with the interaction
> with the PowerPC tree.

So this revert was supposed to fix this: 56e51681246e ("drm/ttm: revert
"Reduce the number of used allocation orders for TTM pages"")

If there's anything left then I need to chase that asap since the merge
window will open soon.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
