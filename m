Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E046363089C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiKSBpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiKSBou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:44:50 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2FBDEF4;
        Fri, 18 Nov 2022 17:02:23 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id t14so6336922vsr.9;
        Fri, 18 Nov 2022 17:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlT2eva1Dr7TgqfsYlKAOHQYOBdy4szmlJCNqoMCyFQ=;
        b=VOjf5eujWq+PJS0lBZYTm6+xd/PIrorMDmkkZd2vnoRpD7bMImm+QxBfUzg8df58CD
         HdiUNCD6Wv/nT0Up7oyVv+btfKbd3xEfTbOVRtkaT/2Mc3DdA0SEXH/WCHlsIDCtxyN6
         MvOmXtid5yJLdTuqSinNPUl0bjCSuF6es+Spu2SzrlN541I5MtRLjPAY23Apc1p0yLo2
         otd6nc+6j7/B9CAZS0DOz+EQVLKQjF9/hbSpgJoBwsm5fy1cuoRl3Ui+U/3TCyFLQFfL
         ZtGGdfe63mM+vVZA8ft0AV108A5JaXI58VpooQCtPAzLkAbMHxy61Iz3H8wNpIPFLsYP
         Ml8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlT2eva1Dr7TgqfsYlKAOHQYOBdy4szmlJCNqoMCyFQ=;
        b=hV04WhasQzUZCwHbbEqU6fjPqQ+mYO7D1fFO/+IbnPsGQlmhRXbiEvtxvnQjsDViqv
         KopQvn3yxsVPaESTaeJS8qsFQ3B6fMmisUVhUCDvztEIrKyJu14Nh34odeSt1OIiCCMZ
         7RxNyygMOSXadHdEftbRBZsg/vbvm031rLEuHE17jwCs0C33QnuF+42Zpv5Z7BSub0Ns
         VXRdvCpYzuh5PyUkLMPil547BQzJIvmrLdSZoK04skj6m903QlNdz0Jn6zIBcoZvsde/
         ZClDvCowa8RbqYGouc9EkfXmZjSaWjK+DViIaaR7WFxB5cXeMMQx3JyyMDIH+Mplg3NV
         opzw==
X-Gm-Message-State: ANoB5pkR3JUBisnsuM4hpY88hMOF54ERd9GmOIDf9RMc3KVmNixFd+OS
        aGIv8zA5GhjrpEE6ct0OefwqAx61p+7YxemUjYvzAla5
X-Google-Smtp-Source: AA0mqf7JZLvt89xRFQC5fdCnVMosLV8+a19C4WrKmjhOXDLWFcQN7f4JQk/PbX9heRRrbR1ELCxbXGDIjKudvXoz9WU=
X-Received: by 2002:a05:6102:7ab:b0:3ac:f694:b8c4 with SMTP id
 x11-20020a05610207ab00b003acf694b8c4mr6059445vsg.26.1668819742470; Fri, 18
 Nov 2022 17:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20221114040441.1649940-1-zhangpeng362@huawei.com>
 <CAKFNMomu3Sf4_QHOm=zXM-QiLaVxASpMqpjek0F3SQnXwje4KA@mail.gmail.com> <CAKFNMonXdyMw9mrQeGe_KtSfMDPSC_jNai8FZGceVyV9Nxw8AQ@mail.gmail.com>
In-Reply-To: <CAKFNMonXdyMw9mrQeGe_KtSfMDPSC_jNai8FZGceVyV9Nxw8AQ@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Nov 2022 10:02:05 +0900
Message-ID: <CAKFNMomd9j3o1iQN6kyUoDcEKGwh34CqAjAWeF5g_s8eSEVX5Q@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     ye.xingchen@zte.com.cn, chi.minghao@zte.com.cn,
        vishal.moola@gmail.com, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 9:38 AM Ryusuke Konishi wrote:
> On Tue, Nov 15, 2022 at 3:39 AM Ryusuke Konishi  wrote:
> > On Mon, Nov 14, 2022 at 12:39 PM Peng Zhang wrote:
> What was happening here was complicated.
> There were two state inconsistencies in DAT:
> 1) A virtual block number (vblocknr == 6145) in the report, was used
> twice in a btree.
>     Because of this, nilfs_dat_commit_end() on that address was called twice.
> 2) For the virtual block number (vblocknr == 6145), the DAT bitmap
> status was free (second anomaly), and nilfs_dat_commit_alloc() was
> performed at the same time as the second nilfs_dat_commit_end() above.
>
> As I mentioned, when nilfs_dat_commit_end() frees a virtual block
> number in the bitmap of DAT, nilfs_dat_prepare_end() usually allocates
> buffer heads of the bitmap block and the descriptor block, and sets
> them to the request struct.  But, the above two anomalies overlap, as

> you pointed out, de_block is initialized to 0 by
> nilfs_dat_prepare_alloc() in the middle of "prepare" and "commit", and

I wrote it wrong, this should be ".., de_blocknr is initialized to 0
by nilfs_dat_commit_alloc() ..".

Ryusuke Konishi
