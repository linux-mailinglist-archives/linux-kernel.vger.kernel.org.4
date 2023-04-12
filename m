Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94206DF86E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDLO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjDLO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:28:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A659F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:28:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f0769b0699so763875e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681309682;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0llp1hVKLIkBR+eiPxuvVpVypjNa13pXHpHX4ojYOSk=;
        b=LEtup2zI+Go27zuQCeKXbwPgSnBpl7LgzN5Uup8JIkSKwTIfHXF4Qfs0o2ElhQI/lF
         edS86zXQQ0EUz+9Z4snngUTGfNfkuzCPWVNTBkdujpcpLSCNeNK2zHpc7oaepmetXJOO
         t83iEh/K3JyRtYgZuGN4zk+vCIq7ckQHq3kwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309682;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0llp1hVKLIkBR+eiPxuvVpVypjNa13pXHpHX4ojYOSk=;
        b=CsmRFR5o2xnoQB6k7xiaIl10P5niPe5hg/lDxDi7svcX3SnZhcjnulTvVSqLJc62sL
         CM0riwDWqKgwUHKPjz8aL8vXuptvD1+V0D+rC6j3Bq94uogXjy61B+Cdysn+wfin2HhM
         LPvjGrLf6pIVluJ/6L1qP8D7W8/ciHPtn6THHFI2kIa9wQb7odgZ3/1Pv10pr0mWZi2o
         abm8UmwwV/zAIzCgFSv0e8COdV0e8FKW1yDO18fZk/Fyo+HphEzsGopwCgXmvYIc9CpJ
         J9R5dGR5fong58FgaTpLncGw62ZYUglNgBg1M0ycMWpTBlVkiZ79ftvp/RsKGybl8s3J
         cnKg==
X-Gm-Message-State: AAQBX9d0sLBRqWWWppEY3nrH/VLUWqi/rIvC2TXBxK+nmfXEkmI51Ui1
        Opg2/QllZ6hxXfMWp9s1Cp5N5w==
X-Google-Smtp-Source: AKy350a6TSz2oFDMVECGAL4J0n7ZUey5qJ91v7kVdXBaS8nJuOpQQSUiRgtRoHEURnjxfLnkHH3MNg==
X-Received: by 2002:a05:6000:1148:b0:2f4:a2b3:3ea6 with SMTP id d8-20020a056000114800b002f4a2b33ea6mr1273515wrx.6.1681309681941;
        Wed, 12 Apr 2023 07:28:01 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id f4-20020adff8c4000000b002cff06039d7sm17313882wrq.39.2023.04.12.07.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:28:01 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:27:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     daniel@ffwll.ch, sfr@canb.auug.org.au, greg@kroah.com,
        ogabbay@kernel.org, jacek.lawrynowicz@linux.intel.com,
        quic_pkanojiy@quicinc.com, mani@kernel.org, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] Revert "accel/qaic: Add mhi_qaic_cntl"
Message-ID: <ZDa/77pcZyr+W2Be@phenom.ffwll.local>
Mail-Followup-To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        sfr@canb.auug.org.au, greg@kroah.com, ogabbay@kernel.org,
        jacek.lawrynowicz@linux.intel.com, quic_pkanojiy@quicinc.com,
        mani@kernel.org, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <1681307864-3782-1-git-send-email-quic_jhugo@quicinc.com>
 <4e81bfdc-c20a-9e54-7d1f-40bd9f91c758@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e81bfdc-c20a-9e54-7d1f-40bd9f91c758@quicinc.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 08:00:33AM -0600, Jeffrey Hugo wrote:
> On 4/12/2023 7:57 AM, Jeffrey Hugo wrote:
> > This reverts commit 566fc96198b4bb07ca6806386956669881225271.
> > 
> > This exposes a userspace API that is still under debate.  Revert the
> > change before the uAPI gets exposed to avoid making a mistake.  QAIC is
> > otherwise still functional.
> > 
> > Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > ---
> 
> Daniel,
> 
> Assuming you find this acceptable, would you please merge it?
> 
> Sorry, but I'm still working through an internal process for my drm-misc
> commit access.  I anticipate having that resolved prior to future changes.

It should be pushed to drm-misc-next-fixes (but that's not yet ready, I
pinged Maarten).

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Ack from Greg/Oded would be good too for completeness.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
