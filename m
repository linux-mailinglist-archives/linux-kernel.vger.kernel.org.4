Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45376727AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjFHJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFHJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:00:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166D9E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:00:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30adc51b65cso368888f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686214856; x=1688806856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iob3eSoU4CsxfFKQ1GYZP4iOpsAcEYonBR1Gc08+llU=;
        b=Fjn4Yl3dmXI4VjFBQOQFr41m55z/IFEceS/hOsBpHTqM6pjdsoxhYbabAlVKgto1FB
         5mrdGIWFS8vjc5sviKP47eEtqfXALpLD87ZwVqWXARJc9JgN00GkT5ZxBaPmLJyx2MW+
         rqPZKJF7Tv9KqyjOjDNRjETASfsOXngsmkIFucrA6Rt93dJvG6jp81g3oFSxKOfblt1h
         xD0J+nqca7LENDM41xZxUS54dHJiiRtZyGmMUvuIWo4Ag1dBTEFxMS3hg65LKNhVurvq
         zlnqcXdRvGbiGTq+R3lySzHLuvA98dg5e2rwhpzkfYJLNipogFpGgNQ6D3HJCwoKO3BD
         XMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214856; x=1688806856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iob3eSoU4CsxfFKQ1GYZP4iOpsAcEYonBR1Gc08+llU=;
        b=FL3+xY7TEWZYPqRpgfWwciqwgb9zWKX64FnZNCyt4TVTN/wEErdQS3wPHBwOXBfiNC
         BiMC3GsnPcvmmzGqDnAnT/xFy+zvolDIPIolArfnsLojubgVEEkqbc4+nmHFY6TVC4j5
         RsQe+S3ym7TRFymUQ505JfGXZsODyJ4Zn0b3SqPBZtan24rrebVJwVMmdbD6JBV5tCJn
         cS0ASmKV8riiIoJb+065Fz2F0Gt6sXmksrslyvYfGFT9L4XzNq8D0hQMIU2sZvz/0LUF
         +hjHwQZbXfG0mBLwPXW0YDBMaD0A7NB00EQ69oYKhiK9+IqwAReDa/147yUOdCkbVD5j
         OeBg==
X-Gm-Message-State: AC+VfDymjFOKddVqySYM4SbzopxKuHHE6jlcoIogWUGE4xrc8Z+xQ1W9
        eBjom2JjqTRpwdKJ+tyJnXR5Xg==
X-Google-Smtp-Source: ACHHUZ4nDfPyBwWzeuff/DbHEhEWHZgfZxEonVLOFCynIzQ/dwZfXLNwWbK1gaqyHMA5Ii8TJa4pjA==
X-Received: by 2002:a05:6000:1964:b0:30a:f36e:72a3 with SMTP id da4-20020a056000196400b0030af36e72a3mr9785639wrb.0.1686214856392;
        Thu, 08 Jun 2023 02:00:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c024400b003f4248dcfcbsm4540554wmj.30.2023.06.08.02.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:00:54 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:00:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Message-ID: <c298a819-9d0e-459f-aa53-04634f28231c@kadam.mountain>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
 <01a162c5-f0de-47b1-97e7-8a451a89df80@kadam.mountain>
 <90813181-02a1-b54f-132b-c68e7b797bb6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90813181-02a1-b54f-132b-c68e7b797bb6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:18:28PM +0200, Philipp Hortmann wrote:
> On 6/7/23 17:07, Dan Carpenter wrote:
> > On Wed, Jun 07, 2023 at 08:31:41PM +0530, Yogesh Hegde wrote:
> > > The variable SetWirelessMode is set in only one place throughout the
> > > driver. This patch removes the variable and calls the real function
> > > directly instead, eliminating the unnecessary indirection.
> > > Additionally, the removal of the variable aligns with the checkpatch
> > > guidelines by removing the use of CamelCase.
> > > 
> > > Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> > > ---
> > > 
> > > v2: Removed the variable and called the function direction instead of
> > >      just renaming the variable as suggested by Greg Kroah-Hartman
> > >      <gregkh@linuxfoundation.org>.
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > regards,
> > dan carpenter
> > 
> > 
> 
> Hi Dan,
> 
> thanks for all the work you do. I always appreciate your comments.
> 

No need to butter me up.  :P


> But I think it does not work because this driver is divided into two
> modules.
> 

Yeah, you're right.  I'm wrong.  We can't break the compile.

regards,
dan carpenter

