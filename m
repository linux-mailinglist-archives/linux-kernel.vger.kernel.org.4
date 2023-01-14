Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032966A7DE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjANBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjANBDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:03:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4987EC9C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:03:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bj3so20813301pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGRtEnP8tCYPsc7mH3xQrT0Rqmj2jXGGXr5AGL9dWMM=;
        b=GxOk4Aiam9pT06oQtTdFqY0rxHZiNQ/naEpmnmM1Y1hZQoj+8cEB1YKzkuxCTiCW2v
         B8HTSohUMsqDgCAoO2QuesIX2ZrrdxuC/TbX5rFVLswsBxkxoz1zCTQsRLraoi4+wJPh
         IoTShqqVw+Jq/Knx97925a8ZKmWIgQw/OjLZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGRtEnP8tCYPsc7mH3xQrT0Rqmj2jXGGXr5AGL9dWMM=;
        b=R3MnzMM8VdER61OD1Ic66BWGBt4KFImdI5nnk38soTD7Djyblr7HqSXQuMqvaG7xoP
         mmhtf4mGUuBcuUg0DeeK3HhTkCyBYx7Ai0AiU2MdcvVrnQBvHIFOn+vsMcA4G4ZBMVAx
         FrQrPLH5KvOBTfFQ8Y8/6mt69+nYUzetCunZt7AFhwfcNSDyU1CV/WS+aQzxrJOxEOls
         5TBiMXyVyRH2+8blDACrQXOBpKeTMtJq8amlP+DG5dhisZOsT26JILby7i70JBPEWSrW
         DhrVKcN9KkvIi95Jbp9eU5Rp4EHbf1aaRO5sYgk9Jb6GM4cgBh/A7jGmW/Dotk/eAXRW
         YAKw==
X-Gm-Message-State: AFqh2kqH5foGwr3vLomql0C0MxToq2FEn9D23C0D+KsNnBgoWYPB7bfF
        8x3IPDAgYqT5X2tOkWmpKzFjPw==
X-Google-Smtp-Source: AMrXdXsQ15weg+BBNoYTK6oAg/z4nml3AmlK0p8s/PWTWUa7VhmDn/CgRSMUeuLCGABxFNqJXIdyhA==
X-Received: by 2002:a17:903:550:b0:194:7a42:2d33 with SMTP id jo16-20020a170903055000b001947a422d33mr1440160plb.28.1673658229632;
        Fri, 13 Jan 2023 17:03:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm1659469pli.309.2023.01.13.17.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:03:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 17:03:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Replace 0-length arrays with flexible arrays
Message-ID: <202301131703.D2D667E3@keescook>
References: <20230105223225.never.252-kees@kernel.org>
 <Y7qyVPlNBQaGbInf@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7qyVPlNBQaGbInf@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 02:08:52PM +0200, Leon Romanovsky wrote:
> On Thu, Jan 05, 2023 at 02:32:32PM -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace all remaining
> > 0-length arrays with flexible arrays. Detected with GCC 13, using
> > -fstrict-flex-arrays=3:
> > 
> > In function 'build_rdma_write',
> >     inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:
> > ../drivers/infiniband/hw/cxgb4/qp.c:597:38: warning: array subscript 0 is outside array bounds of 'struct fw_ri_immd[0]' [-Warray-bounds=]
> >   597 |                 wqe->write.u.immd_src[0].r2 = 0;
> >       |                 ~~~~~~~~~~~~~~~~~~~~~^~~
> > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h: In function 'c4iw_post_send':
> > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:567:35: note: while referencing 'immd_src'
> >   567 |                 struct fw_ri_immd immd_src[0];
> >       |                                   ^~~~~~~~
> > 
> > Additionally drop the unused C99_NOT_SUPPORTED ifndef lines.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > 
> > Cc: Potnuri Bharat Teja <bharat@chelsio.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/infiniband/hw/cxgb4/t4fw_ri_api.h | 26 ++++++-----------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> <...>
> 
> >  #define FW_RI_SEND_WR_SENDOP_S		0
> > @@ -618,12 +606,10 @@ struct fw_ri_rdma_write_cmpl_wr {
> >  		struct fw_ri_isgl isgl_src;
> >  	} u_cmpl;
> >  	__be64 r3;
> > -#ifndef C99_NOT_SUPPORTED
> >  	union fw_ri_write {
> > -		struct fw_ri_immd immd_src[0];
> > -		struct fw_ri_isgl isgl_src[0];
> > +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> > +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
> 
> smatch built from commit 40351132df3b ("strlen: add __builtin and
> __fortify functions") produces the following warning:
> drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:575:17: warning: array of flexible structures
> 
> Is it expected? What will prevent from getting this warning from 0-day
> build bots?

Err, I'm not sure I understand? Does smatch define "C99_NOT_SUPPORTED"?

-- 
Kees Cook
