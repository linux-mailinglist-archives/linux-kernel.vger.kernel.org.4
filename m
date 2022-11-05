Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B461A636
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 01:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKEABV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKEABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 20:01:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D4842983
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 17:01:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p12so787128plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKl6alRuyxYj1V9fsCihyhQ/9yoLUbWIO6qNGczpw5I=;
        b=kPOAfsmUPRckxdGsMryHVCdI+i5mRK2N4CvPwf9k6b+dP0GTSUDo5j7Jht029vCu6F
         CwhhdUrC42mrZ9hc4VyqcZfhFdjB0dXqwib4zZ0a3UGFqvLLdtDWUs5abyuegj0QC/Lb
         Z5L5EI23W+gGVgvk7m3o3LTgJulpaekyzrMPU95pzyvjAwi5Z6/APLz9WggDqtbTUbD1
         zswLciRPaoh/NnWI+vfBO19i0+yS7b6dvHX50OFvvxMZH37NfqDH5Zf7aKpDDsKsUMJ8
         n5v1uGEvnLCTnWwVYyp4xw9+Rti9Y2RkYQAtw9wrlp6BvJAdIKQU4uJ3VwIJ+SttaNdR
         KUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKl6alRuyxYj1V9fsCihyhQ/9yoLUbWIO6qNGczpw5I=;
        b=j3WjPDf0MFRN20HYH/jlZN5sRfrJ9lsMdGj2tS1JhtlCKuYzIvvEZ5ceviJGW2Xe11
         N7CG9uPSmdVMsMmnnc4V7cyeT5AA/83Lnbfg9kslIyTitdpyT2uJUVeeMOyQowp21L1P
         xaL9axXkat0OpjqpxB1lIYG+TGlLriqd+iA/DB03q2nR5zG39r8CCMFusY0nTS7Mbtez
         Ac9vioWuO8S1whhBY2d9hjZQbHgkyXD8RBHNZUCMWA8MNPGRvcxI+wk9WMSRvIbAkwXU
         Wqc3JLTD3zSQF2h1dgSevdmcvn4wXA697BmdILsYLj+1QIRCERMw/NCSEACqJ1x4yqCg
         yEhg==
X-Gm-Message-State: ACrzQf0S0ltOTBP9LkpPyghDtjYlMViInoL6h/lVEI1vK4R5dEc4rqNj
        IeV5fgb89vBxPAilcJWsw5Y=
X-Google-Smtp-Source: AMsMyM5XZKt4Bd02vGWDE7A30rUCFf19kcpmhQ1f+4dKKTnbWRWeQuKLJSxAl0q/1zDhu9SQCFfP/Q==
X-Received: by 2002:a17:903:2348:b0:186:970e:739e with SMTP id c8-20020a170903234800b00186970e739emr38652063plh.115.1667606477564;
        Fri, 04 Nov 2022 17:01:17 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id e63-20020a621e42000000b005385e2e86eesm188005pfe.18.2022.11.04.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:01:17 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 17:01:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2Wny/cKaLuFbm8E@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
 <Y2WjMQeS2DihvPQF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WjMQeS2DihvPQF@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 08:41:37AM +0900, Sergey Senozhatsky wrote:
> On (22/11/04 10:43), Minchan Kim wrote:
> > > > Configure 2 alternative algos, with priority 1 and 2
> > > > 
> > > > 	echo "name=lz4 priority=1" > recomp_algo
> > > > 	echo "name=lz5 priority=2" > recomp_algo
> > > > 
> > > > Recompress pages using algo 1 and algo 2
> > > > 
> > > > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > > > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > > > 
> > > > Maybe we can even pass algo name instead of idx.
> > > 
> > > Or pass priority= so that interface that uses algorithms has the
> > > same keyword that the interface that configures those algorithms.
> > 
> > Hmm, why do we need algo_idx here if we already set up every
> > fields at algorithm setup time?
> > 
> > My understaind(assuming default(i.e., primary) algo is lzo) is
> > 
> >     echo "name=lz4 priority=1" > recomp_algo
> >     echo "name=lz5 priority=2" > recomp_algo
> > 
> >     echo "type=huge threshold=3000" > recompress
> > 
> > It will try compress every objects which greater than 3000B with lz4 first
> > and then lz5 if it's stillgreater or equal than 3000(or same size class).
> 
> One can be SW one can be HW. So I thought about having flexibility here.
> Instead of doing
> 
> 	for (idx = 1; idx < MAX_IDX; idx++) {
> 		len = zcomp_compress(zram->comps[idx]);
> 		if (len <= threshold)
> 			break;
> 	}
> 
> We would just directly use the suggested algo.
> 
> But we probably don't need that param at all and can use
> the loop instead?

I don't understand what param you are saying. I expected
the zram->comps array already has sorted algoritm based on the
priority so the loop will try compression as expected so loop is fine.
Are we on same page?

> 
> [..]
> >     echo "name=lz4 priority=1" > recomp_algo
> >     echo "name=lz5 priority=2" > recomp_algo
> >
> >     # or I realized to change lz5 to lz7 so
> >     echo "name=lz6 priority=2" > recomp_algo
> 
> So the latter should delete lz5 at idx 2 and put lz6 there?
> I can add that.

Yub.
