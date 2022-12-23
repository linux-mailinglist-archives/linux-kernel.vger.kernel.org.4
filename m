Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D36655134
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiLWOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:10:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F04248C2;
        Fri, 23 Dec 2022 06:10:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so826547wms.0;
        Fri, 23 Dec 2022 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrkt2ot3JD+yIheZ+BquTWsj1MB0Lqe52uu/xeIaxHg=;
        b=lI5KuU4mVDOuTLwNWArrptCjqXpIWpvYkJqZcUSoPRyFT6W4M47B3RCqI+yc6WzPK3
         iHSS90uRCXNm/yZbdZiKjCa6zg2SgmvHoLSvZUJFW301oXt9pvfmwisN7OJadA2/eNfy
         fzDXduLscMlHI+wfVAfriIWCvqJttAkBJOnCvsWYWnh385dju9iSzYhPRTBdeQji3FLl
         103VfMGahh2BPhGcfpAdVaj98rMvEZxYJVZ73t1Br3PIklOV7HSfkVppInIJazSgPiDM
         YVCXB+YEabWCftEiQ+lred5nSAPQF8S6Gwm0D7b5HcsAF3GoI0JAhF+q5gNOiKzm3Ukm
         hl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrkt2ot3JD+yIheZ+BquTWsj1MB0Lqe52uu/xeIaxHg=;
        b=aIkqL7e4hHa82LyE60RDCPB4py1llO5pJhIN+1U8+YwHm+S/jfKokG8QM6FFXX0UM+
         HR0RNk01DkGdGbSAW5pOQz2oucjBkavX2sN4+yYd9LL7tih22FSZxlwdH86xo1SoLmQf
         TYg9sF5sZeaCng5ThzoF5/C/IBkTiDflHOgiZ9XHq2A+eLWatHsZ55En5gCqjEm9BjtZ
         RpHC2ogJXfCA4GOMnfqoyEsjQnnKE/Xmwqxc22OkhtFbYQjiA+s/EBUxEU0HT6fb4wbn
         3R3WGysr9B6wHHaDalJtCQ+GQ2vOwO68YDehlsW9MtTaKTGlsMXzkm4/tTHNM4x8m7qv
         LYFA==
X-Gm-Message-State: AFqh2krWiiKRYp2fNsI9fMrOoWFH3zHUUb75o9Qv9Pj1y8LyN4xdupbH
        jgTGPrfT4sQsz9a39lue52g=
X-Google-Smtp-Source: AMrXdXv0AlqKbQolCmoSGD2HjnFBytfXNWEYlwxW+TP+9Wiv2DDOJjTjfmppDXDuI1BEVhEyUGnWzQ==
X-Received: by 2002:a05:600c:3844:b0:3d2:191d:2420 with SMTP id s4-20020a05600c384400b003d2191d2420mr7376196wmr.7.1671804633771;
        Fri, 23 Dec 2022 06:10:33 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:fdcf:52c5:7af:c812])
        by smtp.gmail.com with ESMTPSA id b2-20020adff242000000b0023662245d3csm3236111wrp.95.2022.12.23.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 06:10:32 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:10:32 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <Y6W22EHKwrTztnJR@murray>
References: <20221223092703.61927-1-hch@lst.de>
 <20221223092703.61927-3-hch@lst.de>
 <Y6WB2ZGoL7FaFK+f@lucifer>
 <20221223140312.GA26826@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223140312.GA26826@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:03:12PM +0100, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 10:24:25AM +0000, Lorenzo Stoakes wrote:
> > Might it be worth adding a specific vmap mask that explicitly indicates what
> > flags are permissible on vmap()? Then this could become e.g.:-
> >
> > 	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
> > 		return NULL;
> >
> > And would be self-documenting as to why we are disallowing flags (i.e. they are
> > not part of the permitted vmap mask).
>
> That's probably a good idea.  It might need some time to audit
> for use of all the flags, though.

Perhaps leave that for a later patch (I could take a look as well), but in the
meantime might be worth adding a quick comment here indicating why the flag is
prohibited?
