Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1335B7124AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbjEZK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbjEZK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:29:47 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C501A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:29:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjW43MX_1685096980;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjW43MX_1685096980)
          by smtp.aliyun-inc.com;
          Fri, 26 May 2023 18:29:41 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     gscrivan@redhat.com
Cc:     agk@redhat.com, alexl@redhat.com, dm-devel@redhat.com,
        durui@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        linux-kernel@vger.kernel.org, snitzer@kernel.org
Subject: Re: Re: dm overlaybd: targets mapping OverlayBD image
Date:   Fri, 26 May 2023 18:28:56 +0800
Message-Id: <20230526102855.36774-1-durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <87r0r6ywri.fsf@redhat.com>
References: <87r0r6ywri.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giuseppe,

> The current OCI format, with some tweaks like (e)stargz or zstd:chunked,
> already make its content addressable and a client can retrieve only the
> subset of the files that are needed.  At the same time we maintain the
> simplicity of a tarball and it won't break existing clients.

Yes, I believe backward compatibility is very important. That's why we
have another design called foci (fast oci). It realize a virtual block
device from gzip image blobs. See the following link for details if interested.
https://github.com/containerd/accelerated-container-image/blob/main/docs/FASTOCI.md
