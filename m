Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF0634B12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiKVX2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiKVX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:28:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824542338C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:28:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 62so15289473pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cep9qHzjZg3f4iaLsM3kkM66DFzb6ClBNCuqtYxEzSw=;
        b=D5hsYChtC2A9HRVUSRqs43Z7V3rvcKgzDC+6ZfH5rJCPV9p+8emfdhJ1GFl9mwqplR
         NGxdh81XBoQ0z9R/2+L769UXwhxyn1HIP/QlXcnckNBnB0UuDXNn7RPt/Tc/8gwLkNFe
         2GetF+j7P6OSyM5ES34wpc/mafAgBUzYDa36YbiOAd2TUPT9xhriwi4YLig9luEjZ2Li
         UgFT/qLJAcnuzaX5XZuiuE//OXaxEnMMkGOSLBi1hNjHBv1sqaCzJ4lwXyxTZwX75mLU
         egCqRm164ZTSSvkpmq/kv3yb6H4YAC/nv2zUXegBaPfFkW1mgvmdwt+Vd+rcpi272inM
         syCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cep9qHzjZg3f4iaLsM3kkM66DFzb6ClBNCuqtYxEzSw=;
        b=OIPsMlcK4h7ywJ0BGxahLnCPCrtyK4nNy+wI1GvrAZNWsQLdKP1groh7Yih0Y6i4WR
         mzQO76lFeGuQ/d1YXy04OVc2dakCIl2ztOIrJfE3XUJ5C43NMVhbKFPn3b56sh3Ru+Zr
         30TbLOXi3K6gYvrr4KHmKRFMnHm/HJlENjGNHKKH1DrqecsB3VaIiODEKJO3P5vdBo1t
         TW+BgDczFvUcDdFJJkZ1jXTIRdoHbCsQmkuTbi5YI5bLA4hfWKeQzaZEoExZ0IFKH4QR
         bIrUo/7S7fAKyPZYU+8oJzb5RyIS9b+6RpmsXay3QJ+tomoesTwGCLB6IxPO2RLQ4IFx
         RbhQ==
X-Gm-Message-State: ANoB5plV3PewZqkFP7mxv6gVFCJpeMJRofe58yM4f51KijbEqW8vSPzM
        aTpAwFG2Zl33Lx/hThpJR2U=
X-Google-Smtp-Source: AA0mqf5fUU/36LGIEcQw5YFgrOaiSyUgn+K2BtdevKbVpz5AiPV6XYwHGOOa08o/gMgbc5Hy6lwnaQ==
X-Received: by 2002:a63:d946:0:b0:477:af25:38c8 with SMTP id e6-20020a63d946000000b00477af2538c8mr2985366pgj.392.1669159701796;
        Tue, 22 Nov 2022 15:28:21 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b00186b3528a06sm12786899plh.41.2022.11.22.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:28:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 13:28:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix all kernel-doc warnings and multiple typos
Message-ID: <Y31bE3Z1TL4s09Mq@slm.duckdns.org>
References: <20221112031456.22980-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112031456.22980-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 07:14:56PM -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings. Many of these are about a function's
> return value, so use the kernel-doc Return: format to fix those
> 
> Use % prefix on numeric constant values.
> 
> dir.c: fix typos/spellos
> file.c fix typo: s/taret/target/
> 
> Fix all of these kernel-doc warnings:
> 
> dir.c:305: warning: missing initial short description on line:
>  *      kernfs_name_hash
> 
> dir.c:137: warning: No description found for return value of 'kernfs_path_from_node_locked'
> dir.c:196: warning: No description found for return value of 'kernfs_name'
> dir.c:224: warning: No description found for return value of 'kernfs_path_from_node'
> dir.c:292: warning: No description found for return value of 'kernfs_get_parent'
> dir.c:312: warning: No description found for return value of 'kernfs_name_hash'
> dir.c:404: warning: No description found for return value of 'kernfs_unlink_sibling'
> dir.c:588: warning: No description found for return value of 'kernfs_node_from_dentry'
> dir.c:806: warning: No description found for return value of 'kernfs_find_ns'
> dir.c:879: warning: No description found for return value of 'kernfs_find_and_get_ns'
> dir.c:904: warning: No description found for return value of 'kernfs_walk_and_get_ns'
> dir.c:927: warning: No description found for return value of 'kernfs_create_root'
> dir.c:996: warning: No description found for return value of 'kernfs_root_to_node'
> dir.c:1016: warning: No description found for return value of 'kernfs_create_dir_ns'
> dir.c:1048: warning: No description found for return value of 'kernfs_create_empty_dir'
> dir.c:1306: warning: No description found for return value of 'kernfs_next_descendant_post'
> dir.c:1568: warning: No description found for return value of 'kernfs_remove_self'
> dir.c:1630: warning: No description found for return value of 'kernfs_remove_by_name_ns'
> dir.c:1667: warning: No description found for return value of 'kernfs_rename_ns'
> 
> file.c:66: warning: No description found for return value of 'of_on'
> file.c:88: warning: No description found for return value of 'kernfs_deref_open_node_locked'
> file.c:1036: warning: No description found for return value of '__kernfs_create_file'
> 
> inode.c:100: warning: No description found for return value of 'kernfs_setattr'
> 
> mount.c:160: warning: No description found for return value of 'kernfs_root_from_sb'
> mount.c:198: warning: No description found for return value of 'kernfs_node_dentry'
> mount.c:302: warning: No description found for return value of 'kernfs_super_ns'
> mount.c:318: warning: No description found for return value of 'kernfs_get_tree'
> 
> symlink.c:28: warning: No description found for return value of 'kernfs_create_link'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
