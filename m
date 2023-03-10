Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91C6B5065
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCJS5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCJS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:57:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303D12B661
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:57:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r18so5985745wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678474622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xugmdf/oZmpN9857V6uOJEN0w+i6nHXgW1nzaaohj7I=;
        b=KyRYnDgaE7ug7RfVbN4Sj+G9HlPufbymI80TX3dqIdZsia4zR2YWVryAF3/vJLIoo+
         MzaL+LEdcmw4ln2AVcA9xi2P9M4me+T9UdrljPcS2jY1CUVhxvz0PHCkn+Oghiy7BzIK
         WqB+u6fc+Wg8qsdn8ol5Hm8m09K0sDlS3j959Iz8T8Ao3l+bkjh7g0KiiCNuc66jQ7j/
         9+p0BAZ2RRtw2LUtFOU+T1KDL7Geua7mJE8Zaknn1qYkHAETE8G6nfGOK9NjOdoGMlzo
         JUvn1xReRp8ZK62n/uZwHJfywPn+28tem70XFb6JTrq0Ep5a3WeBw5dLN6czj6Xy8dUH
         zmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678474622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xugmdf/oZmpN9857V6uOJEN0w+i6nHXgW1nzaaohj7I=;
        b=K8I/kzJCMu0jQ+tmj1agqAi2TADZx2U7rLGLy5lBnsBUQ96cYyzCO4lF3OosgsdY2X
         gn+lB6Uas0UUsI7BgDV8WYzXnaYsNKNuD9mroqP4mUuPueya7+PqMCH40eXp8jXixW4O
         KT//Y03SRf4gQLtziKm1Uyb/Pw79AzcSr23rlfQ5k/gxwSs+qb1vB2p3dw/Yce+inX/z
         V0ZHuQNq5JBbYPr4+qeaXIaSirQMtQmHC282fOIJXlhFxewnKv7/xKzNc+owBVBkD3qW
         6YZUSSFSU8IRSK5UHDO9177n9ZBQ4CIZzrPR5g+89Pk3LRmQfTkVJ87qeS08rTGnHnM+
         F9jg==
X-Gm-Message-State: AO0yUKXP8iKneMlwBcYJzqa0hTusIKnjR4jy3Z4RESPlBfjvtaOI/e1p
        QdLQ4bJ6h9JcHrFbsf/AHRO3YD0G/Wcr1LL3
X-Google-Smtp-Source: AK7set8ItTkGY1zTJ3K89fvGwJVi7Zn5bez9za14NnHtH9BdEacxpSzMlFz7gL1XJA3+5OUaYlq9Zg==
X-Received: by 2002:a05:6000:1d2:b0:2c5:48ed:d258 with SMTP id t18-20020a05600001d200b002c548edd258mr17299800wrx.35.1678474621784;
        Fri, 10 Mar 2023 10:57:01 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c559626a50sm492153wrq.13.2023.03.10.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:57:01 -0800 (PST)
Date:   Fri, 10 Mar 2023 23:56:59 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <ZAt9e8Xnd4wAnjPn@khadija-virtual-machine>
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
 <ZAt4irZnVJW4zQNb@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAt4irZnVJW4zQNb@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:05:54AM +0530, Deepak R Varma wrote:
> On Fri, Mar 10, 2023 at 10:09:47PM +0500, Khadija Kamran wrote:
> > Length of line 182 exceeds 100 columns in file
> > drivers/staging/grebus/arche-platform.c, fix by removing tabs from the
> > line.
> 
> Hi Khadija,
> I think if you also include merging the if condition and the call to
> spin_unlock...() on single lines, it should make the code more human. 
Hi Deepak! Sorry I am unable to understand how to merge the if condition
and spin_unlock...() together. Can you please elaborate. 
Thank you
