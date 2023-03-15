Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE96BB3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCONK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCONKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:10:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808122002
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:10:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13so8713205pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678885850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iM7UqGaYvm7BzQmjPzFTbD+VCi1s05wVU7R+PFPtIQ=;
        b=d2XRh/0jnDbb8BJSVteBA7TvOKV8xbk6pdCqTOQcoOrShowab5iwHiCFFnz0/Pshsz
         vS5a48SIWacvJ8o9s8pgarz8rU7Nk6EQDTx80rj/4iNeASMVgpVtyCttdLykp0wEcbMO
         9ZpYnG0Kd3+JCmpIYNaYbqk+Ms4jtktRfLBDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678885850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iM7UqGaYvm7BzQmjPzFTbD+VCi1s05wVU7R+PFPtIQ=;
        b=b5SxNGhKfq+6RPZVNu9roC+NEUsTpHt7G/ivi9SCX665fZndhPf81F38ynw28pkwkx
         EM1FWxIp6t5ib7mUgfD9/3EG9NZRx2fYH6x42rMuidl58AxyEQyoWn1vEtAGRj6thTDN
         P8Z78bdQ6AzX5QgTPfbCV+Ez4ziQ4/+OfI7MVv2XWU6O2roe6yYw8i3U+Ph6AMKMVUk/
         zcMrs91D481vQ1jiQOvJiRLsHV43mHwSge3iNM2jWXdulTzNjKB0VRKg6HGUYgeagAya
         fVC7i/5jRFfr1QO6ZCcTfXCRz/tK7M1KYoiEyquS55xm89SCyPM1rxqf1FT+2iIosCLc
         cT4Q==
X-Gm-Message-State: AO0yUKUHK1TuZvH7l4q/oaNHsQmg+vhYV8sd0cNFJdjizzW+pI9+a2Qj
        2dsAh1vcikN4Gf30ad0MUbfb1g==
X-Google-Smtp-Source: AK7set9dN3OnjgQ1zJzmAaDS5Ava8qB+TCv5SKJAmAnQ8LoY5y/PvI+b/14sPf9bRAqmxxxgI5nUMw==
X-Received: by 2002:a17:902:e5d0:b0:19e:29bd:8411 with SMTP id u16-20020a170902e5d000b0019e29bd8411mr2794015plf.30.1678885850225;
        Wed, 15 Mar 2023 06:10:50 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902854a00b001a05bc70e97sm3574903plo.189.2023.03.15.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:10:49 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:10:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [mpage] 7d28631786: fio.write_iops 27.8%
 improvement
Message-ID: <20230315131043.GA1927891@google.com>
References: <202303101630.ef282023-yujie.liu@intel.com>
 <20230315075816.GA32694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315075816.GA32694@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/15 08:58), Christoph Hellwig wrote:
> 
> I think this simply accounts for the I/Os now that were skipped
> when using the bdev_read/write path before.

Oh, that would explain it. Otherwise I was slightly surprised (in a good
way) and puzzled.
