Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD45B3817
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIIMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIIMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:45:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842C9C21F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:45:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d17so246492qko.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9n2P/V0qMRp60trOn8fWRWZ5ONtMehtmhUiJY/W8E7Q=;
        b=Cn/KKbjRO+76npDKoSZGF9UrXkJQ2Ups0Dn/yStFA88yala4f/vxTCZEvWLTA2dNSA
         rmLasIbqsSyGHDFWBw5T9PBigBkt1NQOt1rcDE2UdmaZmNWRXxmNEJMU6YApNMpWCHgw
         E+bOiC1LORDvpD00N58G06hiAHRl3Nd8U8HcJD/4Gep27qWBFCwhVq9/njfi0VOmUyCW
         a1mj82CcY3/xGcm2QmC/DV7CY2qocTQXhaypm+wWo1vL5QWDE0i9TdLzwLIgf1pl3Xjn
         kivTQp8MlXr+GOVBgtMtP2MSogWj6IUv7ClX5iFauM8k+5fNAs7xDa/Mj1Cxk7YHO3n6
         H/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9n2P/V0qMRp60trOn8fWRWZ5ONtMehtmhUiJY/W8E7Q=;
        b=kB5Nc+4BDjRKYbYtzvBgtq2Sge0d+WR6IXoVRVfY1I7GnHQFJT+VACLc81HfVIzYDQ
         uiUdAaRSmuSyYDR0ZzIMD9idLzJBEd4bM+M3TOD3wclzf2SvQ9yVQFBn6rwJ9o0Brr2Y
         L2wavVXVtC+aqCFuPfDFnAfbSE8t6aUfdY2+160KC3iOIsFMj5iAPXplmfXG97Pk2mZw
         A0l/e7+ZJRwfDVM93DYsonCa5Ozf/tDGjHwPONCeLY7quPqGRigVSthybsKYG9wwX5WV
         QrHSJEtmxnmVDyyfRNCwfffl7i/GkqNyj1OEhUBsZcqjzADNnmUQi5OTrWlqMtPpkZxL
         ogtQ==
X-Gm-Message-State: ACgBeo2HBB1003M8DPWtEYd2K8qbVSe16dfIPk1nP77kzjoqtMz4O7Dk
        Q8DGq+kKIYUv3ZKZx4Wje73YIw==
X-Google-Smtp-Source: AA6agR6AN3ffZUQyISPIYSoubV7zDUdJJurC8ZF2d5WzAfp9RlS5YsC9AQlqU3juST0vtAjiiDVjSw==
X-Received: by 2002:a37:691:0:b0:6cb:cee5:a7e2 with SMTP id 139-20020a370691000000b006cbcee5a7e2mr5098915qkg.650.1662727516991;
        Fri, 09 Sep 2022 05:45:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006bb83e2e65fsm390559qko.42.2022.09.09.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:45:16 -0700 (PDT)
Date:   Fri, 9 Sep 2022 08:45:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     clm@fb.com, dsterba@suse.com, chris.mason@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_bit_radix_cachep declaration
Message-ID: <Yxs1WpoG9q4R0EGv@localhost.localdomain>
References: <20220909065451.1155969-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909065451.1155969-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:54:51PM +0800, Gaosheng Cui wrote:
> btrfs_bit_radix_cachep has been removed since
> commit 45c06543afe2 ("Btrfs: remove unused btrfs_bit_radix slab"),
> so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
